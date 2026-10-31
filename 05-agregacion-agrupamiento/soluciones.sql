-- ==============================================================================
-- Soluciones: Módulo 5
-- ==============================================================================
USE tienda_retail;

-- Reto 5.1: Valorización de Inventario por Categoría
SELECT 
    categoria_id,
    COUNT(*) AS items_distintos,
    SUM(stock_actual) AS unidades_stock_total,
    SUM(precio * stock_actual) AS valor_venta_inventario,
    SUM((precio - costo) * stock_actual) AS ganancia_potencial
FROM productos
GROUP BY categoria_id
ORDER BY valor_venta_inventario DESC;

-- Reto 5.2: Clientes recurrentes de alto valor
SELECT 
    cliente_id,
    COUNT(*) AS pedidos_entregados,
    SUM(total_neto) AS monto_total_gastado,
    ROUND(AVG(total_neto), 2) AS ticket_promedio
FROM pedidos
WHERE estado = 'Entregado'
GROUP BY cliente_id
HAVING COUNT(*) >= 2 AND SUM(total_neto) > 500.00
ORDER BY monto_total_gastado DESC;

-- Reto 5.3: Consolidado con ROLLUP
SELECT 
    COALESCE(canal_venta, '--- TOTAL CONSOLIDADO ---') AS canal,
    COUNT(*) AS total_pedidos,
    SUM(total_neto) AS facturacion_total
FROM pedidos
WHERE estado != 'Cancelado'
GROUP BY canal_venta WITH ROLLUP;
