-- ==============================================================================
-- PROYECTO FINAL 2: CONTROL DE INVENTARIOS CON KARDEX AUTOMATIZADO
-- ==============================================================================
USE operaciones_logistica;

-- 1. Trigger de Actualización Automática de Stock desde el Kardex
DELIMITER //
CREATE TRIGGER trg_actualizar_stock_desde_kardex
AFTER INSERT ON kardex_movimientos
FOR EACH ROW
BEGIN
    DECLARE delta INT DEFAULT 0;

    -- Calcular delta según el tipo de movimiento
    IF NEW.tipo_movimiento IN ('ENTRADA_COMPRA', 'TRANSFERENCIA_IN', 'AJUSTE_POSITIVO') THEN
        SET delta = NEW.cantidad;
    ELSEIF NEW.tipo_movimiento IN ('SALIDA_VENTA', 'TRANSFERENCIA_OUT', 'AJUSTE_NEGATIVO') THEN
        SET delta = -NEW.cantidad;
    END IF;

    -- Upsert en stock_almacen
    INSERT INTO stock_almacen (almacen_id, articulo_id, cantidad_disponible, cantidad_reservada)
    VALUES (NEW.almacen_id, NEW.articulo_id, delta, 0)
    ON DUPLICATE KEY UPDATE
        cantidad_disponible = cantidad_disponible + delta;
END //
DELIMITER ;

-- 2. Procedimiento Almacenado de Transferencia Segura entre Almacenes
DELIMITER //
CREATE PROCEDURE sp_transferir_articulos(
    IN p_almacen_origen INT,
    IN p_almacen_destino INT,
    IN p_articulo_id INT,
    IN p_cantidad INT,
    IN p_usuario VARCHAR(50)
)
BEGIN
    DECLARE v_stock_origen INT;
    DECLARE v_costo DECIMAL(12,4);

    START TRANSACTION;

    -- Bloqueo pesimista de stock de origen
    SELECT cantidad_disponible INTO v_stock_origen
    FROM stock_almacen
    WHERE almacen_id = p_almacen_origen AND articulo_id = p_articulo_id
    FOR UPDATE;

    SELECT costo_promedio INTO v_costo
    FROM articulos
    WHERE articulo_id = p_articulo_id;

    IF v_stock_origen IS NULL OR v_stock_origen < p_cantidad THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Stock insuficiente en almacén de origen para transferir.';
    ELSE
        -- 1. Registrar Kardex OUT
        INSERT INTO kardex_movimientos (
            fecha_hora, tipo_movimiento, almacen_id, articulo_id, cantidad, 
            costo_unitario, saldo_anterior_cantidad, saldo_nuevo_cantidad, 
            saldo_anterior_costo_prom, saldo_nuevo_costo_prom, documento_referencia, usuario
        ) VALUES (
            NOW(), 'TRANSFERENCIA_OUT', p_almacen_origen, p_articulo_id, p_cantidad,
            v_costo, v_stock_origen, v_stock_origen - p_cantidad, v_costo, v_costo,
            CONCAT('TRANSF-', UNIX_TIMESTAMP()), p_usuario
        );

        -- 2. Registrar Kardex IN
        INSERT INTO kardex_movimientos (
            fecha_hora, tipo_movimiento, almacen_id, articulo_id, cantidad, 
            costo_unitario, saldo_anterior_cantidad, saldo_nuevo_cantidad, 
            saldo_anterior_costo_prom, saldo_nuevo_costo_prom, documento_referencia, usuario
        ) VALUES (
            NOW(), 'TRANSFERENCIA_IN', p_almacen_destino, p_articulo_id, p_cantidad,
            v_costo, 0, p_cantidad, v_costo, v_costo,
            CONCAT('TRANSF-', UNIX_TIMESTAMP()), p_usuario
        );

        COMMIT;
    END IF;
END //
DELIMITER ;
