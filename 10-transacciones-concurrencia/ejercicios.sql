-- ==============================================================================
-- Ejercicios: Módulo 10
-- ==============================================================================
USE operaciones_logistica;

-- Reto 10.1:
-- Simular una transferencia inter-almacén transaccional y atómica:
-- Mover 10 unidades del artículo 1 desde el Almacén 1 al Almacén 2:
-- 1. Verificar y restar 10 unidades de stock_almacen donde almacen_id = 1.
-- 2. Sumar 10 unidades en stock_almacen donde almacen_id = 2.
-- 3. Registrar los dos movimientos correspondientes en `kardex_movimientos` (TRANSFERENCIA_OUT y TRANSFERENCIA_IN).
-- Si ocurre algún error, ejecutar ROLLBACK completo.

-- Reto 10.2:
-- Escribir una consulta con bloqueo pesimista (`FOR UPDATE`) para reservar
-- 5 unidades de un artículo antes de despacharlo, garantizando que ninguna otra sesión concurrente
-- pueda venderlas al mismo tiempo.
