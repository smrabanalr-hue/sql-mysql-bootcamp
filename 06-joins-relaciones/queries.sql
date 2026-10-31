-- ==============================================================================
-- Módulo 6: Queries con Relaciones y Joins
-- ==============================================================================
USE tienda_retail;

-- 1. INNER JOIN con 4 tablas para auditoría completa de ventas
SELECT 
    p.codigo_pedido,
    p.fecha_pedido,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    c.ciudad,
    pr.nombre AS producto,
    cat.nombre AS categoria,
    dp.cantidad,
    dp.precio_unitario,
    dp.subtotal
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.cliente_id
INNER JOIN detalle_pedidos dp ON p.pedido_id = dp.pedido_id
INNER JOIN productos pr ON dp.producto_id = pr.producto_id
INNER JOIN categorias cat ON pr.categoria_id = cat.categoria_id
ORDER BY p.pedido_id, dp.detalle_id;

-- 2. LEFT JOIN para identificar clientes inactivos (sin compras)
SELECT 
    c.cliente_id,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id
WHERE p.pedido_id IS NULL;

-- 3. CROSS JOIN para matriz de cobertura categoría x ciudad
SELECT 
    ciudades.ciudad,
    cat.nombre AS categoria
FROM (SELECT DISTINCT ciudad FROM clientes) AS ciudades
CROSS JOIN categorias cat
ORDER BY ciudades.ciudad, cat.nombre;
