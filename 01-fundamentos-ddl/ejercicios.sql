-- ==============================================================================
-- Ejercicios: Módulo 1
-- ==============================================================================

-- Contexto: Sistema de Gestión Hospitalaria.
-- Base de datos a crear: `hospital_db`.

-- Enunciado 1:
-- Crear la tabla `medicos` con:
-- - `medico_id`: INT AUTO_INCREMENT PK.
-- - `colegiatura_cmp`: VARCHAR(10) no nulo y único.
-- - `nombres`: VARCHAR(60) no nulo.
-- - `apellidos`: VARCHAR(60) no nulo.
-- - `especialidad`: ENUM con ('Cardiología', 'Pediatría', 'Neurología', 'Medicina General').
-- - `sueldo_base`: DECIMAL(10,2) que no sea inferior al sueldo mínimo (1025.00).

-- Enunciado 2:
-- Crear la tabla `pacientes` con:
-- - `paciente_id`: INT AUTO_INCREMENT PK.
-- - `dni`: CHAR(8) no nulo y único.
-- - `fecha_nacimiento`: DATE no nula.
-- - `email`: VARCHAR(100) único.
-- - `seguro_activo`: BOOLEAN por defecto TRUE.

-- Enunciado 3:
-- Crear la tabla `citas_medicas`:
-- - `cita_id`: BIGINT AUTO_INCREMENT PK.
-- - `medico_id`: FK hacia medicos.
-- - `paciente_id`: FK hacia pacientes.
-- - `fecha_hora`: DATETIME no nula.
-- - `costo_consulta`: DECIMAL(8,2) con valor por defecto 50.00.
-- - `estado`: ENUM('Programada', 'Atendida', 'Cancelada', 'No Asistió') DEFAULT 'Programada'.
-- Restricciones:
-- Si se borra un médico, NO se debe permitir si tiene citas asociadas (RESTRICT).
-- Si se borra un paciente, sus citas deben eliminarse en cascada (CASCADE).
