-- ==============================================================================
-- INSERCIÓN DE DATOS: Operaciones y Logística
-- ==============================================================================
USE operaciones_logistica;

INSERT INTO almacenes (almacen_id, codigo, nombre, ciudad, direccion, capacidad_m3) VALUES
(1, 'ALM-LUR-01', 'Centro de Distribución Lurín', 'Lima', 'Av. Industrial 1450', 15000.00),
(2, 'ALM-AQP-02', 'Almacén Regional Sur', 'Arequipa', 'Parque Industrial B-12', 4500.00),
(3, 'ALM-TRU-03', 'Almacén Regional Norte', 'Trujillo', 'Carretera Panamericana Km 560', 3800.00);

INSERT INTO articulos (articulo_id, codigo_sku, descripcion, unidad_medida, peso_kg, costo_promedio, punto_reorden, stock_minimo) VALUES
(1, 'PAL-001', 'Pallet Europeo Madera Tratada 1200x800', 'UND', 22.500, 15.0000, 50, 20),
(2, 'CAJ-COR-002', 'Caja Cartón Corrugado Doble 60x40x40', 'PAQx25', 12.000, 24.5000, 100, 30),
(3, 'FLE-STR-003', 'Film Stretch Embalaje Manual 50cm 20mic', 'ROLLO', 2.300, 8.5000, 80, 25),
(4, 'CIN-ADH-004', 'Cinta Adhesiva Industrial Canela 2x100m', 'PAQx6', 1.800, 11.2000, 60, 15),
(5, 'ZAP-SEG-005', 'Zapato de Seguridad Punta de Acero T-42', 'PAR', 1.450, 42.0000, 15, 5);

INSERT INTO transportistas (transportista_id, ruc, razon_social, tipo_flota) VALUES
(1, '20506070801', 'Transportes Rápidos del Perú SAC', 'Tercerizada'),
(2, '20608090102', 'Logística y Carga Andina Express SA', 'Tercerizada'),
(3, '20102030403', 'Flota Corporativa FlotaPropia EIRL', 'Propia');

INSERT INTO stock_almacen (almacen_id, articulo_id, cantidad_disponible, cantidad_reservada) VALUES
(1, 1, 240, 40),
(1, 2, 450, 50),
(1, 3, 310, 20),
(1, 4, 180, 15),
(1, 5, 45, 5),
(2, 1, 80, 10),
(2, 2, 120, 0),
(2, 3, 90, 5),
(3, 1, 60, 5),
(3, 2, 110, 10);

INSERT INTO kardex_movimientos (fecha_hora, tipo_movimiento, almacen_id, articulo_id, cantidad, costo_unitario, saldo_anterior_cantidad, saldo_nuevo_cantidad, saldo_anterior_costo_prom, saldo_nuevo_costo_prom, documento_referencia, usuario) VALUES
('2024-01-10 08:30:00', 'ENTRADA_COMPRA', 1, 1, 300, 15.0000, 0, 300, 0.0000, 15.0000, 'FAC-001-4589', 'operador_lurin'),
('2024-01-12 11:00:00', 'SALIDA_VENTA', 1, 1, 20, 15.0000, 300, 280, 15.0000, 15.0000, 'GR-001-0120', 'operador_lurin'),
('2024-01-15 14:00:00', 'ENTRADA_COMPRA', 1, 2, 500, 24.5000, 0, 500, 0.0000, 24.5000, 'FAC-002-8901', 'operador_lurin'),
('2024-01-18 09:30:00', 'TRANSFERENCIA_OUT', 1, 1, 40, 15.0000, 280, 240, 15.0000, 15.0000, 'GUIA-TRANS-01', 'admin_central'),
('2024-01-19 16:00:00', 'TRANSFERENCIA_IN', 2, 1, 40, 15.0000, 40, 80, 15.0000, 15.0000, 'GUIA-TRANS-01', 'operador_sur');

INSERT INTO envios (envio_id, guia_remision, almacen_origen_id, transportista_id, destino_ciudad, fecha_despacho, fecha_entrega_estimada, fecha_entrega_real, estado, peso_total_kg, costo_flete) VALUES
(1, 'GR-LUR-2024-001', 1, 1, 'Arequipa', '2024-01-18 10:00:00', '2024-01-19 18:00:00', '2024-01-19 16:30:00', 'Entregado', 900.00, 480.00),
(2, 'GR-LUR-2024-002', 1, 2, 'Trujillo', '2024-01-22 08:30:00', '2024-01-23 12:00:00', '2024-01-23 11:15:00', 'Entregado', 650.00, 350.00),
(3, 'GR-LUR-2024-003', 1, 1, 'Cusco', '2024-02-05 14:00:00', '2024-02-07 10:00:00', '2024-02-07 15:45:00', 'Entregado', 1120.00, 720.00),
(4, 'GR-LUR-2024-004', 1, 3, 'Lima', '2024-02-10 09:00:00', '2024-02-10 17:00:00', '2024-02-10 16:00:00', 'Entregado', 180.00, 95.00),
(5, 'GR-AQP-2024-001', 2, 2, 'Puno', '2024-02-15 11:30:00', '2024-02-16 12:00:00', NULL, 'En Tránsito', 420.00, 260.00);
