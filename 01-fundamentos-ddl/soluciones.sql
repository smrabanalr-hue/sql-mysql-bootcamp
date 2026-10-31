-- ==============================================================================
-- Soluciones: Módulo 1
-- ==============================================================================

DROP DATABASE IF EXISTS hospital_db;
CREATE DATABASE hospital_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE hospital_db;

-- Solución 1: Tabla Médicos
CREATE TABLE medicos (
    medico_id INT AUTO_INCREMENT PRIMARY KEY,
    colegiatura_cmp VARCHAR(10) NOT NULL UNIQUE,
    nombres VARCHAR(60) NOT NULL,
    apellidos VARCHAR(60) NOT NULL,
    especialidad ENUM('Cardiología', 'Pediatría', 'Neurología', 'Medicina General') NOT NULL,
    sueldo_base DECIMAL(10,2) NOT NULL CHECK (sueldo_base >= 1025.00),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Solución 2: Tabla Pacientes
CREATE TABLE pacientes (
    paciente_id INT AUTO_INCREMENT PRIMARY KEY,
    dni CHAR(8) NOT NULL UNIQUE,
    nombres VARCHAR(60) NOT NULL,
    apellidos VARCHAR(60) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    seguro_activo BOOLEAN NOT NULL DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Solución 3: Tabla Citas Médicas
CREATE TABLE citas_medicas (
    cita_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    medico_id INT NOT NULL,
    paciente_id INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    costo_consulta DECIMAL(8,2) NOT NULL DEFAULT 50.00 CHECK (costo_consulta >= 0),
    estado ENUM('Programada', 'Atendida', 'Cancelada', 'No Asistió') NOT NULL DEFAULT 'Programada',
    CONSTRAINT fk_citas_medico FOREIGN KEY (medico_id)
        REFERENCES medicos(medico_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_citas_paciente FOREIGN KEY (paciente_id)
        REFERENCES pacientes(paciente_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;
