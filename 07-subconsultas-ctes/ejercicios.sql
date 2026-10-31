-- ==============================================================================
-- Ejercicios: Módulo 7
-- ==============================================================================
USE tienda_retail;

-- Reto 7.1:
-- Obtener los pedidos cuyo total_neto sea superior al promedio de ventas
-- de los pedidos realizados en el mismo canal de venta (Subconsulta correlacionada).
-- Mostrar: pedido_id, canal_venta, total_neto y el promedio del canal correspondiente.

-- Reto 7.2:
-- Usando una CTE, calcular:
-- 1. El total de ventas por cliente.
-- 2. El promedio general de compras por cliente en la base de datos.
-- 3. Listar a los clientes cuyo gasto acumulado supere dicho promedio general.

-- Reto 7.3:
-- Usando CTEs Recursivas, generar una tabla virtual con los primeros 12 meses
-- del año 2024 y cruzarla con un LEFT JOIN hacia los pedidos para mostrar la facturación
-- de cada mes (mostrando 0 si no hubo ventas).
