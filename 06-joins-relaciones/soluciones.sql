-- ==============================================================================
-- Soluciones: Módulo 6
-- ==============================================================================
USE tienda_retail;

-- Reto 6.1: Productos nunca vendidos (Anti-Join)
SELECT 
    pr.sku,
    pr.nombre AS producto,
    pr.precio,
    cat.nombre AS categoria
FROM productos pr
INNER JOIN categorias cat ON pr.categoria_id = cat.categoria_id
LEFT JOIN detalle_pedidos dp ON pr.producto_id = dp.producto_id
WHERE dp.detalle_id IS NULL;

-- Reto 6.2: Desempeño por categoría con LEFT JOIN
SELECT 
    cat.nombre AS categoria,
    COALESCE(SUM(dp.cantidad), 0) AS unidades_vendidas,
    COALESCE(SUM(dp.subtotal), 0.00) AS ingresos_totales
FROM categorias cat
LEFT JOIN productos pr ON cat.categoria_id = pr.categoria_id
LEFT JOIN detalle_pedidos dp ON pr.producto_id = dp.producto_id
GROUP BY cat.categoria_id, cat.nombre
ORDER BY ingresos_totales DESC;

-- Reto 6.3: Detalle consolidado por pedido
SELECT 
    p.codigo_pedido,
    p.fecha_pedido,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    c.email,
    COUNT(dp.producto_id) AS items_distintos,
    p.total_neto
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.cliente_id
INNER JOIN detalle_pedidos dp ON p.pedido_id = dp.pedido_id
GROUP BY p.pedido_id, p.codigo_pedido, p.fecha_pedido, c.nombre, c.apellido, c.email, p.total_neto
ORDER BY p.total_neto DESC;
