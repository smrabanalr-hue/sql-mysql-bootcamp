-- ==============================================================================
-- Módulo 8: Window Functions en MySQL 8.0+
-- ==============================================================================
USE tienda_retail;

-- 1. Ranking de productos más caros dentro de cada categoría
SELECT 
    cat.nombre AS categoria,
    pr.nombre AS producto,
    pr.precio,
    ROW_NUMBER() OVER (PARTITION BY pr.categoria_id ORDER BY pr.precio DESC) AS fila_num,
    RANK() OVER (PARTITION BY pr.categoria_id ORDER BY pr.precio DESC) AS ranking,
    DENSE_RANK() OVER (PARTITION BY pr.categoria_id ORDER BY pr.precio DESC) AS dense_ranking
FROM productos pr
INNER JOIN categorias cat ON pr.categoria_id = cat.categoria_id;

-- 2. Análisis temporal con LAG y cálculo de variaciones
WITH ventas_diarias AS (
    SELECT 
        DATE(fecha_pedido) AS fecha,
        SUM(total_neto) AS venta_dia
    FROM pedidos
    WHERE estado != 'Cancelado'
    GROUP BY DATE(fecha_pedido)
)
SELECT 
    fecha,
    venta_dia,
    LAG(venta_dia, 1, 0) OVER (ORDER BY fecha) AS venta_dia_anterior,
    ROUND(venta_dia - LAG(venta_dia, 1, 0) OVER (ORDER BY fecha), 2) AS delta_monto,
    ROUND(((venta_dia - LAG(venta_dia, 1, 0) OVER (ORDER BY fecha)) / NULLIF(LAG(venta_dia, 1, 0) OVER (ORDER BY fecha), 0)) * 100, 2) AS variacion_pct
FROM ventas_diarias;

-- 3. Suma acumulada progresiva y porcentaje del total
SELECT 
    pedido_id,
    fecha_pedido,
    total_neto,
    SUM(total_neto) OVER (ORDER BY fecha_pedido) AS total_acumulado_historico,
    ROUND((total_neto / SUM(total_neto) OVER ()) * 100, 2) AS pct_aporte_al_total
FROM pedidos
ORDER BY fecha_pedido;
