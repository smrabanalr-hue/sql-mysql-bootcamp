-- ==============================================================================
-- Soluciones: Módulo 10
-- ==============================================================================
USE operaciones_logistica;

-- Reto 10.1: Transferencia interalmacén atómica
START TRANSACTION;

-- Descontar en origen
UPDATE stock_almacen
SET cantidad_disponible = cantidad_disponible - 10
WHERE almacen_id = 1 AND articulo_id = 1 AND cantidad_disponible >= 10;

-- Aumentar en destino
UPDATE stock_almacen
SET cantidad_disponible = cantidad_disponible + 10
WHERE almacen_id = 2 AND articulo_id = 1;

-- Registro Kardex de Salida
INSERT INTO kardex_movimientos (fecha_hora, tipo_movimiento, almacen_id, articulo_id, cantidad, costo_unitario, saldo_anterior_cantidad, saldo_nuevo_cantidad, saldo_anterior_costo_prom, saldo_nuevo_costo_prom, documento_referencia, usuario)
VALUES (NOW(), 'TRANSFERENCIA_OUT', 1, 1, 10, 15.0000, 240, 230, 15.0000, 15.0000, 'GUIA-TRANS-RETO1', 'supervisor_log');

-- Registro Kardex de Entrada
INSERT INTO kardex_movimientos (fecha_hora, tipo_movimiento, almacen_id, articulo_id, cantidad, costo_unitario, saldo_anterior_cantidad, saldo_nuevo_cantidad, saldo_anterior_costo_prom, saldo_nuevo_costo_prom, documento_referencia, usuario)
VALUES (NOW(), 'TRANSFERENCIA_IN', 2, 1, 10, 15.0000, 80, 90, 15.0000, 15.0000, 'GUIA-TRANS-RETO1', 'supervisor_log');

COMMIT;

-- Reto 10.2: Bloqueo Pesimista
START TRANSACTION;

SELECT cantidad_disponible, cantidad_reservada
FROM stock_almacen
WHERE almacen_id = 1 AND articulo_id = 2
FOR UPDATE;

-- Si la cantidad_disponible es suficiente:
UPDATE stock_almacen
SET cantidad_disponible = cantidad_disponible - 5,
    cantidad_reservada = cantidad_reservada + 5
WHERE almacen_id = 1 AND articulo_id = 2;

COMMIT;
