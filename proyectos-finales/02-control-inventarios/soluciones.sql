-- ==============================================================================
-- Soluciones: Proyecto Logística y Kardex
-- ==============================================================================
USE operaciones_logistica;

-- Reto Logística 1: Detección de Quiebre de Stock
SELECT 
    a.codigo_sku,
    a.descripcion,
    COALESCE(SUM(s.cantidad_disponible), 0) AS stock_total_cadena,
    a.punto_reorden,
    a.stock_minimo,
    GREATEST((a.punto_reorden * 2) - COALESCE(SUM(s.cantidad_disponible), 0), 0) AS sugerido_compra
FROM articulos a
LEFT JOIN stock_almacen s ON a.articulo_id = s.articulo_id
GROUP BY a.articulo_id, a.codigo_sku, a.descripcion, a.punto_reorden, a.stock_minimo
HAVING stock_total_cadena <= a.punto_reorden
ORDER BY stock_total_cadena ASC;

-- Reto Logística 2: Desempeño OTD de Transportistas
SELECT 
    t.razon_social AS transportista,
    t.tipo_flota,
    COUNT(e.envio_id) AS total_envios_entregados,
    SUM(CASE WHEN e.fecha_entrega_real <= e.fecha_entrega_estimada THEN 1 ELSE 0 END) AS entregados_a_tiempo,
    SUM(CASE WHEN e.fecha_entrega_real > e.fecha_entrega_estimada THEN 1 ELSE 0 END) AS entregados_con_retraso,
    ROUND(
        (SUM(CASE WHEN e.fecha_entrega_real <= e.fecha_entrega_estimada THEN 1 ELSE 0 END) / COUNT(e.envio_id)) * 100, 2
    ) AS tasa_otd_pct
FROM transportistas t
INNER JOIN envios e ON t.transportista_id = e.transportista_id
WHERE e.estado = 'Entregado' AND e.fecha_entrega_real IS NOT NULL
GROUP BY t.transportista_id, t.razon_social, t.tipo_flota
ORDER BY tasa_otd_pct DESC;
