-- ==============================================================================
-- Retos de Práctica Interactiva: Módulo 6
-- ==============================================================================
USE tienda_retail;

-- Reto 6.1:
-- Anti-Join: Encontrar productos que NUNCA se han vendido.
-- Salida Esperada:
-- +-------------+------------------------------------+--------+--------------------+
-- | sku         | producto                           | precio | categoria          |
-- +-------------+------------------------------------+--------+--------------------+
-- | ELE-REF-002 | Refrigeradora No Frost 400L...     | 799.00 | Electrohogar       |
-- | MOD-POL-001 | Polo Pima Peruano Manga Corta...   |  35.00 | Moda y Calzado     |
-- | DEP-BIC-001 | Bicicleta Montañera Rin 29...      | 450.00 | Deportes y Fitness |
-- +-------------+------------------------------------+--------+--------------------+

-- Reto 6.2:
-- Desempeño consolidado por categoría incluyendo las de 0 ventas.
-- Salida Esperada:
-- +--------------------+-------------------+------------------+
-- | categoria          | unidades_vendidas | ingresos_totales |
-- +--------------------+-------------------+------------------+
-- | Tecnología         |                 5 |          7899.95 |
-- | Muebles y Hogar    |                 3 |           748.98 |
-- | Electrohogar       |                 1 |           189.50 |
-- | Deportes y Fitness |                 1 |            89.90 |
-- | Moda y Calzado     |                 0 |             0.00 |
-- +--------------------+-------------------+------------------+
