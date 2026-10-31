-- ==============================================================================
-- Ejercicios: Módulo 5
-- ==============================================================================
USE tienda_retail;

-- Reto 5.1:
-- Calcular las métricas de inventario por categoría de producto:
-- - Total de productos únicos por categoría.
-- - Stock físico total (`SUM(stock_actual)`).
-- - Valor económico total del inventario a precio de venta (`SUM(precio * stock_actual)`).
-- - Margen bruto potencial en dinero (`SUM((precio - costo) * stock_actual)`).

-- Reto 5.2:
-- Encontrar a los clientes más valiosos (VIPs):
-- Agrupar por `cliente_id` y obtener la cantidad de pedidos entregados y la suma total gastada.
-- Filtrar únicamente aquellos clientes que tengan al menos 2 pedidos entregados
-- y cuyo gasto total acumulado sea superior a 500.00.

-- Reto 5.3:
-- Generar un resumen de ventas por canal_venta usando `WITH ROLLUP` que muestre:
-- - Canal de venta
-- - Cantidad total de pedidos procesados
-- - Total neto facturado
-- Manejar los nulos del ROLLUP con `COALESCE(canal_venta, '--- TOTAL CONSOLIDADO ---')`.
