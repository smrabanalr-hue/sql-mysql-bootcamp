-- ==============================================================================
-- Soluciones: Módulo 9
-- ==============================================================================
USE tienda_retail;

-- Reto 9.1: Función clasificadora
DELIMITER //
CREATE FUNCTION fn_categoria_cliente(p_monto DECIMAL(12,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE v_categoria VARCHAR(20);
    IF p_monto >= 3000 THEN
        SET v_categoria = 'PLATINUM';
    ELSEIF p_monto >= 1000 THEN
        SET v_categoria = 'GOLD';
    ELSEIF p_monto >= 300 THEN
        SET v_categoria = 'SILVER';
    ELSE
        SET v_categoria = 'BRONZE';
    END IF;
    RETURN v_categoria;
END //
DELIMITER ;

-- Reto 9.2: Stored Procedure transaccional
DELIMITER //
CREATE PROCEDURE sp_registrar_pedido_express(
    IN p_cliente_id INT,
    IN p_producto_id INT,
    IN p_cantidad INT,
    IN p_canal ENUM('Web', 'App Móvil', 'Tienda Física')
)
BEGIN
    DECLARE v_stock_actual INT;
    DECLARE v_precio DECIMAL(10,2);
    DECLARE v_subtotal DECIMAL(12,2);
    DECLARE v_pedido_id INT;
    DECLARE v_codigo VARCHAR(30);

    -- 1. Obtener precio y validar stock
    SELECT stock_actual, precio INTO v_stock_actual, v_precio
    FROM productos
    WHERE producto_id = p_producto_id;

    IF v_stock_actual IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El producto especificado no existe.';
    END IF;

    IF v_stock_actual < p_cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente para procesar la compra.';
    END IF;

    SET v_subtotal = v_precio * p_cantidad;
    SET v_codigo = CONCAT('EXP-', UNIX_TIMESTAMP());

    -- 2. Insertar Cabecera
    INSERT INTO pedidos (codigo_pedido, cliente_id, fecha_pedido, estado, canal_venta, total_bruto, descuento, total_neto)
    VALUES (v_codigo, p_cliente_id, NOW(), 'Procesando', p_canal, v_subtotal, 0.00, v_subtotal);
    
    SET v_pedido_id = LAST_INSERT_ID();

    -- 3. Insertar Detalle
    INSERT INTO detalle_pedidos (pedido_id, producto_id, cantidad, precio_unitario, subtotal)
    VALUES (v_pedido_id, p_producto_id, p_cantidad, v_precio, v_subtotal);

    -- 4. Actualizar Stock
    UPDATE productos
    SET stock_actual = stock_actual - p_cantidad
    WHERE producto_id = p_producto_id;
END //
DELIMITER ;

-- Reto 9.3: Trigger de validación defensiva
DELIMITER //
CREATE TRIGGER trg_evitar_precio_negativo
BEFORE UPDATE ON productos
FOR EACH ROW
BEGIN
    IF NEW.precio < 0.01 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: El precio del producto no puede ser inferior a 0.01';
    END IF;
    IF NEW.costo < 0.00 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: El costo del producto no puede ser negativo.';
    END IF;
END //
DELIMITER ;
