-- ==============================================================================
-- Soluciones: Módulo 8
-- ==============================================================================
USE tienda_retail;

-- Reto 8.1: Top 2 por categoría
WITH productos_rankeados AS (
    SELECT 
        categoria_id,
        nombre,
        precio,
        DENSE_RANK() OVER (PARTITION BY categoria_id ORDER BY precio DESC) AS rnk
    FROM productos
)
SELECT categoria_id, nombre, precio, rnk
FROM productos_rankeados
WHERE rnk <= 2
ORDER BY categoria_id, rnk;

-- Reto 8.2: Recencia entre compras por cliente
SELECT 
    cliente_id,
    pedido_id,
    fecha_pedido,
    total_neto,
    LAG(fecha_pedido) OVER (PARTITION BY cliente_id ORDER BY fecha_pedido) AS fecha_compra_previa,
    DATEDIFF(
        fecha_pedido, 
        LAG(fecha_pedido) OVER (PARTITION BY cliente_id ORDER BY fecha_pedido)
    ) AS dias_desde_ultima_compra
FROM pedidos
ORDER BY cliente_id, fecha_pedido;

-- Reto 8.3: Media móvil de 3 pedidos
SELECT 
    pedido_id,
    fecha_pedido,
    total_neto,
    ROUND(
        AVG(total_neto) OVER (
            ORDER BY fecha_pedido 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS media_movil_3_pedidos
FROM pedidos;
