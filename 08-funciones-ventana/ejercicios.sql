-- ==============================================================================
-- Ejercicios: Módulo 8
-- ==============================================================================
USE tienda_retail;

-- Reto 8.1:
-- Obtener el Top 2 de productos más costosos de cada categoría.
-- Usar una CTE con DENSE_RANK() y filtrar únicamente los rangos <= 2.

-- Reto 8.2:
-- Para cada pedido realizado por los clientes, mostrar:
-- - cliente_id
-- - fecha_pedido
-- - total_neto
-- - fecha del pedido anterior del mismo cliente (`LAG`)
-- - días transcurridos desde su última compra (`DATEDIFF`)

-- Reto 8.3:
-- Calcular una media móvil (Moving Average) de 3 pedidos para el `total_neto`,
-- ordenado cronológicamente por `fecha_pedido`.
