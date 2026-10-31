-- ==============================================================================
-- Módulo 2: Consultas y Scripts DML
-- ==============================================================================
USE tienda_retail;

-- 1. Insert masivo
INSERT INTO categorias (nombre, descripcion) VALUES
('Jardinería y Exteriores', 'Herramientas, macetas y plantas'),
('Librería y Papelería', 'Cuadernos, bolígrafos y libros de consulta');

-- 2. Insert con retorno del ID generado
INSERT INTO clientes (nombre, apellido, email, ciudad, fecha_registro, segmento)
VALUES ('Manuel', 'Paredes', 'manuel.p@demo.com', 'Trujillo', CURDATE(), 'Básico');

SELECT LAST_INSERT_ID() AS id_nuevo_cliente;

-- 3. Upsert con ON DUPLICATE KEY UPDATE
-- Supongamos que actualizamos el precio y reabastecemos stock de un producto
INSERT INTO productos (producto_id, sku, nombre, categoria_id, precio, costo, stock_actual)
VALUES (1, 'TEC-LAP-001', 'Laptop Dell XPS 15 32GB RAM 1TB SSD', 1, 1949.99, 1350.00, 20)
ON DUPLICATE KEY UPDATE
    precio = VALUES(precio),
    stock_actual = stock_actual + 5;

-- 4. Actualización condicional con subconsulta o cálculo
UPDATE pedidos
SET total_neto = total_bruto - descuento
WHERE pedido_id = 1;

-- 5. Eliminación controlada
DELETE FROM detalle_pedidos
WHERE pedido_id = 6 AND cantidad = 0;
