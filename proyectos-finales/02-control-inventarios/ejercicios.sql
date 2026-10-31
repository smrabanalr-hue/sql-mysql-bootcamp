-- ==============================================================================
-- Retos Prácticos: Proyecto Logística y Kardex
-- ==============================================================================
USE operaciones_logistica;

-- Reto Logística 1:
-- Generar un reporte de artículos en riesgo de Quiebre de Stock:
-- Listar aquellos artículos donde la suma de su stock disponible en todos los almacenes
-- sea menor o igual a su `punto_reorden`.
-- Proyectar: sku, descripción, stock_total_disponible, punto_reorden y unidades_a_pedir sugeridas.

-- Reto Logística 2:
-- Indicador OTD (On-Time Delivery) por Transportista:
-- Para cada empresa transportista, calcular:
-- - Cantidad total de envíos entregados
-- - Cantidad de envíos entregados a tiempo (`fecha_entrega_real <= fecha_entrega_estimada`)
-- - Cantidad de envíos con retraso
-- - Porcentaje de efectividad OTD (Envíos a tiempo / Totales * 100)
