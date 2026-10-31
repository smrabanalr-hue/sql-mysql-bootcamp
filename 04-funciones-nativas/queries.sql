-- ==============================================================================
-- Módulo 4: Queries Demostrativas
-- ==============================================================================
USE tienda_retail;

-- 1. Transformación de Cadenas y Nombres Completos
SELECT 
    cliente_id,
    CONCAT(UPPER(apellido), ', ', nombre) AS cliente_formato_oficial,
    LOWER(CONCAT(SUBSTRING(nombre, 1, 1), '.', apellido, '@empresa.pe')) AS correo_corporativo_sugerido,
    CHAR_LENGTH(CONCAT(nombre, apellido)) AS longitud_nombre
FROM clientes;

-- 2. Manipulación de Fechas y Antigüedad
SELECT 
    pedido_id,
    fecha_pedido,
    DATE_FORMAT(fecha_pedido, '%d/%m/%Y a las %H:%i hrs') AS fecha_legible,
    DATEDIFF(NOW(), fecha_pedido) AS dias_transcurridos,
    DATE_ADD(fecha_pedido, INTERVAL 3 DAY) AS fecha_limite_entrega,
    DAYNAME(fecha_pedido) AS dia_semana_compra
FROM pedidos;

-- 3. Lógica Condicional (Segmentación por Ticket de Compra)
SELECT 
    codigo_pedido,
    total_neto,
    CASE 
        WHEN total_neto >= 2000.00 THEN 'Ticket Platino'
        WHEN total_neto >= 500.00 THEN 'Ticket Oro'
        WHEN total_neto >= 100.00 THEN 'Ticket Estándar'
        ELSE 'Microticket'
    END AS clasificacion_ticket,
    IF(descuento > 0, 'Con Descuento', 'Precio Regular') AS tipo_promocion,
    COALESCE(canal_venta, 'Canal No Especificado') AS canal_normalizado
FROM pedidos;
