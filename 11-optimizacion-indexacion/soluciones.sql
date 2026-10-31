-- ==============================================================================
-- Soluciones: Módulo 11
-- ==============================================================================
USE tienda_retail;

-- Reto 11.1: Optimización de búsqueda por nombre
EXPLAIN SELECT * FROM productos WHERE nombre = 'Zapatillas Running Pro Cushion 42';
-- Resultado previo: type = ALL (Full Table Scan)

CREATE INDEX idx_productos_nombre ON productos (nombre);

EXPLAIN SELECT * FROM productos WHERE nombre = 'Zapatillas Running Pro Cushion 42';
-- Resultado posterior: type = ref (Index Lookup)

-- Reto 11.2: Consulta SARGable
-- Dado que la collation utf8mb4_unicode_ci es case-insensitive por naturaleza,
-- no se debe aplicar UPPER() ni LOWER() sobre la columna en la cláusula WHERE:
EXPLAIN SELECT * FROM clientes WHERE ciudad = 'Lima';

-- Reto 11.3: Tabla Particionada por Rango de Años
CREATE TABLE logs_sistema (
    log_id BIGINT NOT NULL AUTO_INCREMENT,
    evento VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_suceso DATETIME NOT NULL,
    PRIMARY KEY (log_id, fecha_suceso)
) ENGINE=InnoDB
PARTITION BY RANGE (YEAR(fecha_suceso)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p_futuro VALUES LESS THAN MAXVALUE
);
