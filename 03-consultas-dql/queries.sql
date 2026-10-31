-- ==============================================================================
-- Módulo 3: Consultas DQL Listas para Ejecución
-- ==============================================================================
USE tienda_retail;

-- 1. Proyección con cálculos y alias
SELECT 
    producto_id,
    nombre AS producto,
    precio,
    costo,
    (precio - costo) AS margen_unitario,
    ROUND(((precio - costo) / precio) * 100, 2) AS margen_porcentaje
FROM productos
WHERE activo = 1;

-- 2. Filtrado compuesto con rangos y conjuntos
SELECT pedido_id, codigo_pedido, fecha_pedido, total_neto, canal_venta
FROM pedidos
WHERE fecha_pedido BETWEEN '2024-01-01' AND '2024-04-30 23:59:59'
  AND canal_venta IN ('Web', 'App Móvil')
  AND total_neto >= 200.00;

-- 3. Búsqueda por patrones (LIKE y REGEXP)
SELECT cliente_id, nombre, apellido, email
FROM clientes
WHERE email LIKE '%@email.com'
  AND (apellido LIKE 'M%' OR apellido LIKE 'R%');

-- 4. Paginación ordenada
SELECT producto_id, nombre, precio, stock_actual
FROM productos
ORDER BY precio DESC, stock_actual ASC
LIMIT 5 OFFSET 0; -- Primera página de 5 registros más caros
