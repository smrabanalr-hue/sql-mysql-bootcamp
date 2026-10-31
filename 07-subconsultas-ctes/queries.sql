-- ==============================================================================
-- Módulo 7: Queries con Subconsultas y CTEs
-- ==============================================================================
USE tienda_retail;

-- 1. Subconsulta Escalar: Productos con precio superior al promedio
SELECT 
    producto_id,
    nombre,
    precio,
    ROUND((SELECT AVG(precio) FROM productos), 2) AS precio_promedio_general,
    ROUND(precio - (SELECT AVG(precio) FROM productos), 2) AS diferencia_vs_promedio
FROM productos
WHERE precio > (SELECT AVG(precio) FROM productos)
ORDER BY precio DESC;

-- 2. Subconsulta Correlacionada con EXISTS: Clientes con pedidos de ticket alto
SELECT c.cliente_id, c.nombre, c.apellido, c.ciudad
FROM clientes c
WHERE EXISTS (
    SELECT 1 
    FROM pedidos p 
    WHERE p.cliente_id = c.cliente_id 
      AND p.total_neto >= 1000.00
);

-- 3. CTE Analítica Multi-Nivel: Gasto por cliente y clasificación
WITH metricas_cliente AS (
    SELECT 
        cliente_id,
        COUNT(pedido_id) AS total_pedidos,
        SUM(total_neto) AS inversion_acumulada,
        AVG(total_neto) AS ticket_promedio
    FROM pedidos
    WHERE estado != 'Cancelado'
    GROUP BY cliente_id
)
SELECT 
    c.nombre,
    c.apellido,
    c.ciudad,
    m.total_pedidos,
    m.inversion_acumulada,
    ROUND(m.ticket_promedio, 2) AS ticket_promedio
FROM metricas_cliente m
INNER JOIN clientes c ON m.cliente_id = c.cliente_id
ORDER BY m.inversion_acumulada DESC;

-- 4. CTE Recursiva: Generador de serie temporal de días
WITH RECURSIVE calendario_semanal AS (
    SELECT CAST('2024-01-01' AS DATE) AS fecha
    UNION ALL
    SELECT DATE_ADD(fecha, INTERVAL 1 DAY)
    FROM calendario_semanal
    WHERE fecha < '2024-01-07'
)
SELECT fecha, DAYNAME(fecha) AS dia_semana FROM calendario_semanal;
