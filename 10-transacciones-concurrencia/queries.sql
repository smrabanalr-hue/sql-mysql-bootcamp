-- ==============================================================================
-- Módulo 10: Demostración de Transacciones
-- ==============================================================================
USE tienda_retail;

-- 1. Inspeccionar nivel de aislamiento actual
SELECT @@transaction_isolation;

-- 2. Transacción básica con validación y Commit
START TRANSACTION;

UPDATE productos
SET stock_actual = stock_actual - 1
WHERE producto_id = 3;

INSERT INTO pedidos (codigo_pedido, cliente_id, fecha_pedido, estado, canal_venta, total_bruto, descuento, total_neto)
VALUES ('PED-TEST-TX1', 1, NOW(), 'Procesando', 'Web', 299.99, 0.00, 299.99);

COMMIT;

-- 3. Transacción con Savepoint y Rollback parcial
START TRANSACTION;

INSERT INTO clientes (nombre, apellido, email, ciudad, fecha_registro)
VALUES ('Test1', 'User1', 'test1@email.com', 'Lima', CURDATE());

SAVEPOINT punto_cliente_uno;

INSERT INTO clientes (nombre, apellido, email, ciudad, fecha_registro)
VALUES ('Test2', 'User2', 'test2@email.com', 'Lima', CURDATE());

-- Deshacer solo el segundo usuario
ROLLBACK TO SAVEPOINT punto_cliente_uno;

-- Confirmar únicamente el primer usuario
COMMIT;

-- Limpieza
DELETE FROM clientes WHERE email IN ('test1@email.com', 'test2@email.com');
DELETE FROM pedidos WHERE codigo_pedido = 'PED-TEST-TX1';
