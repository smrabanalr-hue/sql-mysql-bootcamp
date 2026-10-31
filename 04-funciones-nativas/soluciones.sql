-- ==============================================================================
-- Soluciones: Módulo 4
-- ==============================================================================
USE tienda_retail;

-- Reto 4.1: Formateo y saneamiento de teléfono
SELECT 
    cliente_id,
    CONCAT(nombre, ' ', apellido) AS cliente,
    COALESCE(
        CONCAT('Cod: ', TRIM(REPLACE(SUBSTRING(telefono, 1, 4), '+', '')), ' - Num: ', TRIM(SUBSTRING(telefono, 5))),
        'SIN_TELEFONO_REGISTRADO'
    ) AS telefono_formateado
FROM clientes;

-- Reto 4.2: Estimación de entrega según canal
SELECT 
    codigo_pedido,
    fecha_pedido,
    canal_venta,
    CASE 
        WHEN canal_venta = 'Tienda Física' THEN fecha_pedido
        WHEN canal_venta = 'Web' THEN DATE_ADD(fecha_pedido, INTERVAL 48 HOUR)
        WHEN canal_venta = 'App Móvil' THEN DATE_ADD(fecha_pedido, INTERVAL 24 HOUR)
        ELSE DATE_ADD(fecha_pedido, INTERVAL 72 HOUR)
    END AS fecha_estimada_entrega
FROM pedidos;

-- Reto 4.3: Clasificación de márgenes
SELECT 
    sku,
    nombre,
    precio,
    costo,
    ROUND(((precio - costo) / precio) * 100, 1) AS margen_pct,
    CASE 
        WHEN ((precio - costo) / precio) * 100 >= 40 THEN 'Alta Rentabilidad'
        WHEN ((precio - costo) / precio) * 100 >= 20 THEN 'Rentabilidad Moderada'
        ELSE 'Margen Crítico'
    END AS categoria_margen
FROM productos
ORDER BY margen_pct DESC;
