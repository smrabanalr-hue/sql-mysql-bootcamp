-- ==============================================================================
-- INSERCIÓN DE DATOS: Tienda Retail
-- ==============================================================================
USE tienda_retail;

-- Categorías
INSERT INTO categorias (categoria_id, nombre, descripcion) VALUES
(1, 'Tecnología', 'Laptops, smartphones, periféricos y accesorios'),
(2, 'Electrohogar', 'Refrigeradoras, microondas, lavadoras y licuadoras'),
(3, 'Moda y Calzado', 'Ropa para damas, caballeros y calzado deportivo'),
(4, 'Muebles y Hogar', 'Sillones, escritorios, camas y comedores'),
(5, 'Deportes y Fitness', 'Mancuernas, bicicletas, colchonetas y suplementos');

-- Clientes
INSERT INTO clientes (cliente_id, nombre, apellido, email, telefono, ciudad, pais, fecha_registro, segmento) VALUES
(1, 'Carlos', 'Mendoza', 'carlos.mendoza@email.com', '+51 987654321', 'Lima', 'Perú', '2024-01-15', 'Premium'),
(2, 'Ana', 'Ramos', 'ana.ramos@email.com', '+51 912345678', 'Arequipa', 'Perú', '2024-02-10', 'Básico'),
(3, 'Luis', 'Salazar', 'luis.salazar@email.com', '+51 923456789', 'Trujillo', 'Perú', '2024-02-28', 'Corporativo'),
(4, 'María', 'Fernández', 'maria.fernandez@email.com', '+51 934567890', 'Lima', 'Perú', '2024-03-05', 'Premium'),
(5, 'Jorge', 'Pérez', 'jorge.perez@email.com', '+51 945678901', 'Cusco', 'Perú', '2024-03-20', 'Básico'),
(6, 'Lucía', 'Gómez', 'lucia.gomez@email.com', '+51 956789012', 'Lima', 'Perú', '2024-04-12', 'Básico'),
(7, 'Diego', 'Vargas', 'diego.vargas@email.com', '+51 967890123', 'Chiclayo', 'Perú', '2024-05-01', 'Corporativo'),
(8, 'Elena', 'Castro', 'elena.castro@email.com', '+51 978901234', 'Arequipa', 'Perú', '2024-05-18', 'Premium'),
(9, 'Roberto', 'Navarro', 'roberto.navarro@email.com', '+51 989012345', 'Piura', 'Perú', '2024-06-22', 'Básico'),
(10, 'Valeria', 'Quispe', 'valeria.quispe@email.com', '+51 990123456', 'Lima', 'Perú', '2024-07-04', 'Premium');

-- Productos
INSERT INTO productos (producto_id, sku, nombre, categoria_id, precio, costo, stock_actual) VALUES
(1, 'TEC-LAP-001', 'Laptop Dell XPS 15 32GB RAM 1TB SSD', 1, 1899.99, 1350.00, 15),
(2, 'TEC-PHN-002', 'Smartphone Galaxy S24 Ultra 256GB', 1, 1299.99, 920.00, 25),
(3, 'TEC-AUD-003', 'Audífonos Bluetooth Cancelación Ruido Sony', 1, 299.99, 170.00, 50),
(4, 'ELE-MIC-001', 'Horno Microondas Inverter 32L Acero', 2, 189.50, 110.00, 30),
(5, 'ELE-REF-002', 'Refrigeradora No Frost 400L Inverter', 2, 799.00, 520.00, 12),
(6, 'MOD-POL-001', 'Polo Pima Peruano Manga Corta Negro L', 3, 35.00, 14.50, 120),
(7, 'MOD-ZAP-002', 'Zapatillas Running Pro Cushion 42', 3, 120.00, 65.00, 40),
(8, 'MUE-ESC-001', 'Escritorio Ergonómico Altura Regulable', 4, 349.00, 210.00, 18),
(9, 'MUE-SIL-002', 'Silla de Oficina Ergonómica Malla Pro', 4, 199.99, 115.00, 35),
(10, 'DEP-BIC-001', 'Bicicleta Montañera Rin 29 Aluminio 21v', 5, 450.00, 280.00, 8),
(11, 'DEP-PES-002', 'Set de Mancuernas Ajustables 20kg', 5, 89.90, 48.00, 60);

-- Pedidos
INSERT INTO pedidos (pedido_id, codigo_pedido, cliente_id, fecha_pedido, estado, canal_venta, total_bruto, descuento, total_neto) VALUES
(1, 'PED-2024-001', 1, '2024-01-20 10:30:00', 'Entregado', 'Web', 2199.98, 100.00, 2099.98),
(2, 'PED-2024-002', 2, '2024-02-15 14:15:00', 'Entregado', 'App Móvil', 189.50, 0.00, 189.50),
(3, 'PED-2024-003', 3, '2024-03-01 09:00:00', 'Entregado', 'Tienda Física', 3799.98, 250.00, 3549.98),
(4, 'PED-2024-004', 4, '2024-03-15 16:45:00', 'Entregado', 'Web', 548.99, 20.00, 528.99),
(5, 'PED-2024-005', 1, '2024-04-05 11:20:00', 'Entregado', 'Web', 299.99, 15.00, 284.99),
(6, 'PED-2024-006', 5, '2024-04-22 18:30:00', 'Cancelado', 'App Móvil', 120.00, 0.00, 120.00),
(7, 'PED-2024-007', 7, '2024-05-10 13:10:00', 'Entregado', 'Web', 1449.00, 50.00, 1399.00),
(8, 'PED-2024-008', 8, '2024-06-02 12:00:00', 'Entregado', 'App Móvil', 1299.99, 100.00, 1199.99),
(9, 'PED-2024-009', 4, '2024-06-25 15:40:00', 'Procesando', 'Web', 89.90, 0.00, 89.90),
(10, 'PED-2024-010', 10, '2024-07-10 17:05:00', 'Enviado', 'Web', 450.00, 30.00, 420.00),
(11, 'PED-2024-011', 2, '2024-07-28 10:15:00', 'Entregado', 'Tienda Física', 70.00, 0.00, 70.00),
(12, 'PED-2024-012', 3, '2024-08-05 08:50:00', 'Entregado', 'Web', 199.99, 10.00, 189.99);

-- Detalle Pedidos
INSERT INTO detalle_pedidos (pedido_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 1, 1899.99, 1899.99),
(1, 3, 1, 299.99, 299.99),
(2, 4, 1, 189.50, 189.50),
(3, 1, 2, 1899.99, 3799.98),
(4, 9, 1, 199.99, 199.99),
(4, 8, 1, 349.00, 349.00),
(5, 3, 1, 299.99, 299.99),
(6, 7, 1, 120.00, 120.00),
(7, 5, 1, 799.00, 799.00),
(7, 10, 1, 450.00, 450.00),
(7, 9, 1, 199.99, 199.99),
(8, 2, 1, 1299.99, 1299.99),
(9, 11, 1, 89.90, 89.90),
(10, 10, 1, 450.00, 450.00),
(11, 6, 2, 35.00, 70.00),
(12, 9, 1, 199.99, 199.99);
