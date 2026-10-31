-- ==============================================================================
-- Módulo 9: Vistas, Procedimientos, Funciones y Triggers
-- ==============================================================================
USE tienda_retail;

-- 1. Vista de Rendimiento Comercial
CREATE OR REPLACE VIEW vw_resumen_pedidos_clientes AS
SELECT 
    p.pedido_id,
    p.codigo_pedido,
    p.fecha_pedido,
    p.estado,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    c.ciudad,
    p.canal_venta,
    p.total_neto
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.cliente_id;

-- 2. Función UDF para calcular el IGV/Impuesto (18%)
DELIMITER //
CREATE FUNCTION fn_calcular_impuesto(monto DECIMAL(12,2), tasa_pct DECIMAL(5,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    RETURN ROUND(monto * (tasa_pct / 100), 2);
END //
DELIMITER ;

-- Probar UDF
SELECT fn_calcular_impuesto(100.00, 18.00) AS impuesto_calculado;

-- 3. Stored Procedure con Parámetros IN y OUT
DELIMITER //
CREATE PROCEDURE sp_obtener_estadisticas_cliente(
    IN p_cliente_id INT,
    OUT p_total_compras DECIMAL(12,2),
    OUT p_pedidos_totales INT
)
BEGIN
    SELECT 
        COALESCE(SUM(total_neto), 0.00),
        COUNT(*)
    INTO p_total_compras, p_pedidos_totales
    FROM pedidos
    WHERE cliente_id = p_cliente_id AND estado != 'Cancelado';
END //
DELIMITER ;

-- Invocar procedimiento
CALL sp_obtener_estadisticas_cliente(1, @gasto, @num_pedidos);
SELECT @gasto AS total_gastado, @num_pedidos AS cantidad_compras;

-- 4. Trigger de Auditoría de Precios
CREATE TABLE IF NOT EXISTS auditoria_precios_productos (
    auditoria_id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    precio_anterior DECIMAL(10,2) NOT NULL,
    precio_nuevo DECIMAL(10,2) NOT NULL,
    usuario VARCHAR(50) DEFAULT (CURRENT_USER()),
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER trg_auditoria_precio_producto
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO auditoria_precios_productos (producto_id, precio_anterior, precio_nuevo)
        VALUES (OLD.producto_id, OLD.precio, NEW.precio);
    END IF;
END //
DELIMITER ;
