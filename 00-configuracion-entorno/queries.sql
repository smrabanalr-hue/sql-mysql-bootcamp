-- ==============================================================================
-- Módulo 0: Consultas de Diagnóstico y Exploración del Servidor
-- ==============================================================================

-- 1. Verificar versión exacta y motor por defecto
SELECT VERSION() AS version_mysql, @@default_storage_engine AS motor_predeterminado;

-- 2. Inspeccionar motores de almacenamiento disponibles y soporte de transacciones
SHOW ENGINES;

-- 3. Ver variables clave del sistema
SHOW VARIABLES LIKE 'version%';
SHOW VARIABLES LIKE 'character_set_%';
SHOW VARIABLES LIKE 'collation_%';
SHOW VARIABLES LIKE 'sql_safe_updates';

-- 4. Monitoreo de hilos y conexiones activas
SHOW PROCESSLIST;
SHOW STATUS LIKE 'Threads_connected';
SHOW STATUS LIKE 'Uptime';

-- 5. Listar bases de datos en la instancia
SHOW DATABASES;
