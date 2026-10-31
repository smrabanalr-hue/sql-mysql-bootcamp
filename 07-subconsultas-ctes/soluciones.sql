-- ==============================================================================
-- Soluciones: Módulo 7
-- ==============================================================================
USE tienda_retail;

-- Reto 7.1: Pedidos por encima del promedio de su canal
SELECT 
    p1.pedido_id,
    p1.codigo_pedido,
    p1.canal_venta,
    p1.total_neto,
    ROUND((
        SELECT AVG(p2.total_neto) 
        FROM pedidos p2 
        WHERE p2.canal_venta = p1.canal_venta
    ), 2) AS promedio_canal
FROM pedidos p1
WHERE p1.total_neto > (
    SELECT AVG(p2.total_neto) 
    FROM pedidos p2 
    WHERE p2.canal_venta = p1.canal_venta
);

-- Reto 7.2: Clientes sobre el promedio global mediante CTE
WITH gasto_por_cliente AS (
    SELECT 
        cliente_id,
        SUM(total_neto) AS gasto_total
    FROM pedidos
    WHERE estado != 'Cancelado'
    GROUP BY cliente_id
),
benchmark_general AS (
    SELECT AVG(gasto_total) AS gasto_promedio_general
    FROM gasto_por_cliente
)
SELECT 
    c.cliente_id,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    g.gasto_total,
    ROUND(b.gasto_promedio_general, 2) AS umbral_promedio
FROM gasto_por_cliente g
CROSS JOIN benchmark_general b
INNER JOIN clientes c ON g.cliente_id = c.cliente_id
WHERE g.gasto_total > b.gasto_promedio_general
ORDER BY g.gasto_total DESC;

-- Reto 7.3: Calendario mensual y facturación con CTE Recursiva
WITH RECURSIVE meses_2024 AS (
    SELECT 1 AS mes_num, '2024-01-01' AS fecha_inicio
    UNION ALL
    SELECT mes_num + 1, DATE_ADD(fecha_inicio, INTERVAL 1 MONTH)
    FROM meses_2024
    WHERE mes_num < 12
)
SELECT 
    m.mes_num,
    MONTHNAME(m.fecha_inicio) AS nombre_mes,
    COALESCE(SUM(p.total_neto), 0.00) AS ventas_totales
FROM meses_2024 m
LEFT JOIN pedidos p ON MONTH(p.fecha_pedido) = m.mes_num 
                    AND YEAR(p.fecha_pedido) = 2024
                    AND p.estado != 'Cancelado'
GROUP BY m.mes_num, nombre_mes
ORDER BY m.mes_num;
