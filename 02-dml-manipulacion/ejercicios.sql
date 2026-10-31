-- ==============================================================================
-- Ejercicios: Módulo 2
-- ==============================================================================
USE tienda_retail;

-- Reto 2.1:
-- Registrar 3 nuevos productos de la categoría 'Tecnología' (categoria_id = 1)
-- en una sola instrucción `INSERT`. Garantizar precios > costo y stock > 0.

-- Reto 2.2:
-- La empresa decide otorgar un 10% de descuento adicional a todos los pedidos
-- cuyo total_bruto sea superior a 1000.00 y su canal de venta haya sido 'Web'.
-- Actualizar `descuento` y recalcular `total_neto` (total_bruto - descuento).

-- Reto 2.3:
-- Aplicar una estrategia de Upsert: Registrar el producto con sku 'ACC-MOU-099'.
-- Si ya existe por SKU, actualizar su stock sumándole 15 unidades y rebajar su precio en 5%.
