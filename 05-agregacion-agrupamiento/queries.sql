-- ==============================================================================
-- Módulo 5: Queries de Agregación
-- ==============================================================================
USE tienda_retail;

-- 1. Resumen global de métricas del negocio
SELECT 
    COUNT(*) AS total_pedidos,
    SUM(total_neto) AS facturacion_total,
    ROUND(AVG(total_neto), 2) AS ticket_promedio,
    MIN(total_neto) AS pedido_minimo,
    MAX(total_neto) AS pedido_maximo
FROM pedidos
WHERE estado != 'Cancelado';

-- 2. Ventas por Canal y Estado con HAVING
SELECT 
    canal_venta,
    estado,
    COUNT(*) AS cantidad_pedidos,
    SUM(total_neto) AS venta_neta_total,
    ROUND(AVG(descuento), 2) AS descuento_promedio
FROM pedidos
WHERE fecha_pedido >= '2024-01-01'
GROUP BY canal_venta, estado
HAVING SUM(total_neto) > 200.00
ORDER BY canal_venta, venta_neta_total DESC;

-- 3. Agrupación avanzada con GROUP_CONCAT y WITH ROLLUP
SELECT 
    IFNULL(ciudad, 'TOTAL PAÍS') AS ciudad,
    COUNT(*) AS total_clientes,
    GROUP_CONCAT(nombre ORDER BY nombre SEPARATOR ' | ') AS nombres_clientes
FROM clientes
GROUP BY ciudad WITH ROLLUP;
