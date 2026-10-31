-- ==============================================================================
-- Retos de Práctica Interactiva: Módulo 3
-- ==============================================================================
USE tienda_retail;

-- Reto 3.1:
-- Encontrar todos los clientes de 'Lima' o 'Arequipa', cuyo apellido NO contenga
-- la letra 'z' y cuya fecha de registro sea posterior al 1 de febrero de 2024.
-- Salida Esperada:
-- +------------+--------+----------+----------+----------------+
-- | cliente_id | nombre | apellido | ciudad   | fecha_registro |
-- +------------+--------+----------+----------+----------------+
-- |          8 | Elena  | Castro   | Arequipa | 2024-05-18     |
-- |          4 | María  | Fernández| Lima     | 2024-03-05     |
-- |          2 | Ana    | Ramos    | Arequipa | 2024-02-10     |
-- +------------+--------+----------+----------+----------------+

-- Reto 3.2:
-- Listar productos con stock entre 15 y 50 unidades, precio < 500.00
-- y SKU con prefijo 'TEC-' o 'MOD-'.
-- Salida Esperada:
-- +-------------+-------------+-------------------------------------------+--------------+--------+--------------+
-- | producto_id | sku         | nombre                                    | categoria_id | precio | stock_actual |
-- +-------------+-------------+-------------------------------------------+--------------+--------+--------------+
-- |           3 | TEC-AUD-003 | Audífonos Bluetooth Cancelación Ruido... |            1 | 299.99 |           50 |
-- |           7 | MOD-ZAP-002 | Zapatillas Running Pro Cushion 42         |            3 | 120.00 |           40 |
-- +-------------+-------------+-------------------------------------------+--------------+--------+--------------+

-- Reto 3.3:
-- Paginación Top 3 pedidos entregados o enviados con total_neto > 300
-- ordenados por mayor descuento otorgado.
