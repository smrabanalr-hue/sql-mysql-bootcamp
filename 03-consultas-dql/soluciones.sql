-- ==============================================================================
-- Soluciones: Módulo 3
-- ==============================================================================
USE tienda_retail;

-- Reto 3.1: Clientes con filtros lógicos y fechas
SELECT cliente_id, nombre, apellido, ciudad, fecha_registro
FROM clientes
WHERE ciudad IN ('Lima', 'Arequipa')
  AND apellido NOT LIKE '%z%'
  AND fecha_registro > '2024-02-01'
ORDER BY fecha_registro DESC;

-- Reto 3.2: Filtrado por SKU y rango de stock
SELECT producto_id, sku, nombre, categoria_id, precio, stock_actual
FROM productos
WHERE stock_actual BETWEEN 15 AND 50
  AND precio < 500.00
  AND (sku LIKE 'TEC-%' OR sku LIKE 'MOD-%')
ORDER BY categoria_id ASC, precio DESC;

-- Reto 3.3: Top 3 pedidos con mayor descuento
SELECT pedido_id, codigo_pedido, estado, total_bruto, descuento, total_neto
FROM pedidos
WHERE estado IN ('Entregado', 'Enviado')
  AND total_neto > 300.00
ORDER BY descuento DESC
LIMIT 3;
