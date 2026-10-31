-- ==============================================================================
-- Retos de Práctica Interactiva: Módulo 0
-- ==============================================================================

-- Reto 0.1:
-- Diagnosticar el tamaño de memoria asignado al InnoDB Buffer Pool en Megabytes (MB).
-- Salida Esperada:
-- +----------------+
-- | buffer_pool_mb |
-- +----------------+
-- |       128.0000 |  (o el valor configurado en tu servidor)
-- +----------------+

-- Reto 0.2:
-- Inspeccionar el estado de `sql_safe_updates`. Demostrar cómo desactivarlo
-- para la sesión de trabajo y volver a activarlo.
-- Salida Esperada:
-- +--------------------+
-- | safe_updates_status|
-- +--------------------+
-- |                  1 |
-- +--------------------+

-- Reto 0.3:
-- Consultar el catálogo del sistema (`mysql.user`) mostrando el usuario, el host
-- y el plugin de autenticación utilizado (ej. caching_sha2_password o mysql_native_password).
