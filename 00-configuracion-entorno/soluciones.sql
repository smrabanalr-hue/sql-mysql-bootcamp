-- ==============================================================================
-- Soluciones: Módulo 0
-- ==============================================================================

-- Reto 0.1: Tamaño de Buffer Pool en MB
SELECT @@innodb_buffer_pool_size / (1024 * 1024) AS buffer_pool_mb;

-- Reto 0.2: Consulta y modificación de sql_safe_updates
SELECT @@sql_safe_updates AS safe_updates_status;
SET SESSION sql_safe_updates = 0; -- Desactivar en sesión
SET SESSION sql_safe_updates = 1; -- Volver a activar

-- Reto 0.3: Usuarios y mecanismos de autenticación
SELECT user, host, plugin 
FROM mysql.user
ORDER BY user;
