-- ==============================================================================
-- Ejercicios: Módulo 9
-- ==============================================================================
USE tienda_retail;

-- Reto 9.1:
-- Crear una función llamada `fn_categoria_cliente(p_monto DECIMAL(12,2))` que reciba un monto
-- acumulado de gasto y retorne un VARCHAR(20):
-- - Si monto >= 3000 -> 'PLATINUM'
-- - Si monto >= 1000 -> 'GOLD'
-- - Si monto >= 300  -> 'SILVER'
-- - Caso contrario   -> 'BRONZE'

-- Reto 9.2:
-- Diseñar un Stored Procedure `sp_registrar_pedido_express` que reciba:
-- `p_cliente_id`, `p_producto_id`, `p_cantidad`, `p_canal`.
-- Dentro de una transacción lógica:
-- 1. Validar que haya suficiente stock en la tabla `productos`. Si no hay suficiente, lanzar SIGNAL.
-- 2. Insertar la cabecera en `pedidos` con código generado.
-- 3. Insertar el detalle en `detalle_pedidos`.
-- 4. Descontar el stock en `productos`.

-- Reto 9.3:
-- Crear un Trigger `trg_evitar_precio_negativo` BEFORE UPDATE en `productos`
-- que impida que el precio o el costo sea menor a 0.01, disparando un error mediante `SIGNAL SQLSTATE '45000'`.
