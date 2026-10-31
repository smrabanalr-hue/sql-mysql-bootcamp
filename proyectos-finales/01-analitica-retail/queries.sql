-- ==============================================================================
-- PROYECTO FINAL 1: ANALÍTICA DE NEGOCIO Y BI (RETAIL)
-- ==============================================================================
USE tienda_retail;

-- ==============================================================================
-- 1. ANÁLISIS RFM (Recency, Frequency, Monetary)
-- ==============================================================================
WITH rfm_base AS (
    SELECT 
        c.cliente_id,
        CONCAT(c.nombre, ' ', c.apellido) AS cliente,
        DATEDIFF('2024-08-31', MAX(p.fecha_pedido)) AS recencia_dias,
        COUNT(p.pedido_id) AS frecuencia,
        SUM(p.total_neto) AS valor_monetario
    FROM clientes c
    INNER JOIN pedidos p ON c.cliente_id = p.cliente_id
    WHERE p.estado != 'Cancelado'
    GROUP BY c.cliente_id, c.nombre, c.apellido
),
rfm_scores AS (
    SELECT 
        cliente_id,
        cliente,
        recencia_dias,
        frecuencia,
        valor_monetario,
        NTILE(4) OVER (ORDER BY recencia_dias DESC) AS r_score,   -- Menos días = mejor score
        NTILE(4) OVER (ORDER BY frecuencia ASC) AS f_score,        -- Más frecuencia = mejor score
        NTILE(4) OVER (ORDER BY valor_monetario ASC) AS m_score    -- Más gasto = mejor score
    FROM rfm_base
)
SELECT 
    cliente_id,
    cliente,
    recencia_dias,
    frecuencia,
    valor_monetario,
    r_score,
    f_score,
    m_score,
    CASE 
        WHEN r_score >= 3 AND f_score >= 3 AND m_score >= 3 THEN 'Campeón / VIP'
        WHEN f_score >= 3 AND m_score >= 2 THEN 'Cliente Frecuente Fiel'
        WHEN r_score <= 2 AND f_score >= 2 THEN 'En Riesgo de Abandono'
        WHEN r_score = 1 THEN 'Cliente Inactivo / Hibernando'
        ELSE 'Cliente Promedio / Ocasional'
    END AS segmento_rfm
FROM rfm_scores
ORDER BY valor_monetario DESC;

-- ==============================================================================
-- 2. VENTAS MES CONTRA MES (MoM - Month over Month Growth)
-- ==============================================================================
WITH ventas_mensuales AS (
    SELECT 
        DATE_FORMAT(fecha_pedido, '%Y-%m') AS anio_mes,
        COUNT(pedido_id) AS total_pedidos,
        SUM(total_neto) AS facturacion_mensual
    FROM pedidos
    WHERE estado != 'Cancelado'
    GROUP BY DATE_FORMAT(fecha_pedido, '%Y-%m')
)
SELECT 
    anio_mes,
    total_pedidos,
    facturacion_mensual,
    LAG(facturacion_mensual, 1) OVER (ORDER BY anio_mes) AS mes_previo_facturacion,
    ROUND(
        facturacion_mensual - LAG(facturacion_mensual, 1) OVER (ORDER BY anio_mes), 2
    ) AS delta_monto,
    ROUND(
        ((facturacion_mensual - LAG(facturacion_mensual, 1) OVER (ORDER BY anio_mes)) / 
        NULLIF(LAG(facturacion_mensual, 1) OVER (ORDER BY anio_mes), 0)) * 100, 2
    ) AS crecimiento_mom_pct
FROM ventas_mensuales
ORDER BY anio_mes;

-- ==============================================================================
-- 3. ANÁLISIS DE COHORTES (Primera Compra vs Recompra)
-- ==============================================================================
WITH primera_compra AS (
    SELECT 
        cliente_id,
        MIN(DATE_FORMAT(fecha_pedido, '%Y-%m')) AS mes_cohorte
    FROM pedidos
    WHERE estado != 'Cancelado'
    GROUP BY cliente_id
),
actividad_pedidos AS (
    SELECT 
        p.cliente_id,
        pc.mes_cohorte,
        DATE_FORMAT(p.fecha_pedido, '%Y-%m') AS mes_actividad,
        TIMESTAMPDIFF(MONTH, STR_TO_DATE(CONCAT(pc.mes_cohorte, '-01'), '%Y-%m-%d'), STR_TO_DATE(CONCAT(DATE_FORMAT(p.fecha_pedido, '%Y-%m'), '-01'), '%Y-%m-%d')) AS periodo_meses
    FROM pedidos p
    INNER JOIN primera_compra pc ON p.cliente_id = pc.cliente_id
    WHERE p.estado != 'Cancelado'
)
SELECT 
    mes_cohorte,
    COUNT(DISTINCT cliente_id) AS clientes_totales_cohorte,
    COUNT(DISTINCT CASE WHEN periodo_meses = 0 THEN cliente_id END) AS mes_0,
    COUNT(DISTINCT CASE WHEN periodo_meses = 1 THEN cliente_id END) AS mes_1,
    COUNT(DISTINCT CASE WHEN periodo_meses = 2 THEN cliente_id END) AS mes_2,
    COUNT(DISTINCT CASE WHEN periodo_meses = 3 THEN cliente_id END) AS mes_3
FROM actividad_pedidos
GROUP BY mes_cohorte
ORDER BY mes_cohorte;
