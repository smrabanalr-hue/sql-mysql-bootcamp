-- ==============================================================================
-- Soluciones: Módulo 2
-- ==============================================================================
USE tienda_retail;

-- Reto 2.1: Inserción múltiple
INSERT INTO productos (sku, nombre, categoria_id, precio, costo, stock_actual) VALUES
('TEC-MOU-010', 'Mouse Inalámbrico Ergonómico Pro', 1, 49.90, 22.00, 75),
('TEC-TEC-011', 'Teclado Mecánico RGB Switch Red', 1, 89.90, 45.00, 40),
('TEC-WEB-012', 'Cámara Web Full HD 1080p con Mic', 1, 59.00, 28.00, 30);

-- Reto 2.2: Actualización con cálculo condicional
UPDATE pedidos
SET descuento = descuento + (total_bruto * 0.10),
    total_neto = total_bruto - (descuento + (total_bruto * 0.10))
WHERE total_bruto > 1000.00 AND canal_venta = 'Web';

-- Reto 2.3: Upsert por SKU
INSERT INTO productos (sku, nombre, categoria_id, precio, costo, stock_actual)
VALUES ('ACC-MOU-099', 'Mouse Pad Gamer XL Anti-Deslizante', 1, 29.90, 12.00, 15)
ON DUPLICATE KEY UPDATE
    stock_actual = stock_actual + 15,
    precio = precio * 0.95;
