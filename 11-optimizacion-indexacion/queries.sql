-- ==============================================================================
-- Módulo 11: Profiling, EXPLAIN y Estrategias de Indexación
-- ==============================================================================
USE tienda_retail;

-- 1. Análisis del plan de ejecución con EXPLAIN estándar
EXPLAIN SELECT p.codigo_pedido, p.total_neto, c.nombre
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.cliente_id
WHERE p.fecha_pedido >= '2024-01-01';

-- 2. Análisis con EXPLAIN ANALYZE (MySQL 8.0+)
EXPLAIN ANALYZE SELECT * FROM productos WHERE precio > 500.00;

-- 3. Creación de un Índice Compuesto para optimizar filtros frecuentes
CREATE INDEX idx_pedidos_cliente_fecha_estado 
ON pedidos (cliente_id, fecha_pedido, estado);

-- 4. Demostración de Índice Cubriente (Covering Index - 'Using index')
EXPLAIN SELECT cliente_id, fecha_pedido, estado
FROM pedidos
WHERE cliente_id = 1;

-- 5. Consulta optimizada evitando funciones sobre columnas indexadas
-- INEFICIENTE:
-- SELECT * FROM pedidos WHERE MONTH(fecha_pedido) = 3 AND YEAR(fecha_pedido) = 2024;
-- EFICIENTE SARGABLE:
EXPLAIN SELECT pedido_id, codigo_pedido, total_neto
FROM pedidos
WHERE fecha_pedido >= '2024-03-01 00:00:00' 
  AND fecha_pedido < '2024-04-01 00:00:00';
