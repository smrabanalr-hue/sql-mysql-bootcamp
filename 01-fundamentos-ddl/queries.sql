-- ==============================================================================
-- Módulo 1: Scripts DDL Listos para Correr
-- ==============================================================================

DROP DATABASE IF EXISTS campus_tecnologico;
CREATE DATABASE campus_tecnologico CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE campus_tecnologico;

-- Tabla Departamentos
CREATE TABLE departamentos (
    depto_id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(10) NOT NULL UNIQUE,
    nombre VARCHAR(80) NOT NULL,
    presupuesto_anual DECIMAL(12,2) NOT NULL DEFAULT 0.00 CHECK (presupuesto_anual >= 0),
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabla Cursos
CREATE TABLE cursos (
    curso_id INT AUTO_INCREMENT PRIMARY KEY,
    depto_id INT NOT NULL,
    codigo_curso VARCHAR(20) NOT NULL UNIQUE,
    titulo VARCHAR(120) NOT NULL,
    creditos TINYINT UNSIGNED NOT NULL CHECK (creditos BETWEEN 1 AND 10),
    modalidad ENUM('Presencial', 'Virtual', 'Hibrido') DEFAULT 'Presencial',
    CONSTRAINT fk_cursos_depto FOREIGN KEY (depto_id)
        REFERENCES departamentos(depto_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Alterar tabla para agregar una columna de prerrequisito
ALTER TABLE cursos
    ADD COLUMN horas_practica TINYINT UNSIGNED DEFAULT 0 AFTER creditos,
    ADD CONSTRAINT chk_horas CHECK (horas_practica <= 40);

-- Renombrar columna
ALTER TABLE departamentos
    RENAME COLUMN nombre TO nombre_oficial;

-- Ver estructura
DESCRIBE cursos;
SHOW CREATE TABLE cursos;
