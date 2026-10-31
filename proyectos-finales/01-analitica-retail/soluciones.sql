-- ==============================================================================
-- Soluciones: Proyecto Analítica Retail
-- ==============================================================================
USE tienda_retail;

-- Reto BI 1: Penetración de Categorías
WITH pedidos_por_categoria AS (
    SELECT 
        pr.categoria_id,
        cat.nombre AS categoria,
        COUNT(DISTINCT dp.pedido_id) AS pedidos_con_esta_cat
    FROM detalle_pedidos dp
    INNER JOIN productos pr ON dp.producto_id = pr.producto_id
    INNER JOIN categorias cat ON pr.categoria_id = cat.categoria_id
    GROUP BY pr.categoria_id, cat.nombre
),
total_pedidos_global AS (
    SELECT COUNT(*) AS total_pedidos FROM pedidos WHERE estado != 'Cancelado'
)
SELECT 
    c.categoria,
    c.pedidos_con_esta_cat,
    g.total_pedidos,
    ROUND((c.pedidos_con_esta_cat / g.total_pedidos) * 100, 2) AS tasa_penetracion_pct
FROM pedidos_por_categoria c
CROSS JOIN total_pedidos_global g
ORDER BY tasa_penetracion_pct DESC;

-- Reto BI 2: Rentabilidad y Margen Neto por Canal
SELECT 
    p.canal_venta,
    SUM(p.total_bruto) AS total_bruto,
    SUM(p.descuento) AS total_descuentos_otorgados,
    SUM(p.total_neto) AS facturacion_neta,
    SUM(dp.cantidad * pr.costo) AS costo_mercancia_vendida,
    SUM(p.total_neto) - SUM(dp.cantidad * pr.costo) AS margen_bruto_ganancia,
    ROUND(
        ((SUM(p.total_neto) - SUM(dp.cantidad * pr.costo)) / SUM(p.total_neto)) * 100, 2
    ) AS margen_rentabilidad_pct
FROM pedidos p
INNER JOIN detalle_pedidos dp ON p.pedido_id = dp.pedido_id
INNER JOIN productos pr ON dp.producto_id = pr.producto_id
WHERE p.estado != 'Cancelado'
GROUP BY p.canal_venta
ORDER BY facturacion_neta DESC;
