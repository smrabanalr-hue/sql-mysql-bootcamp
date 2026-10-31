-- ==============================================================================
-- Retos de Práctica Interactiva: Módulo 1
-- ==============================================================================
-- Contexto: Módulo Hospitalario (Base de datos hospital_db)

-- Reto 1.1:
-- Crear la tabla `medicos`.
-- Requisitos estrictos de integridad:
-- - `medico_id`: Identificador autoincremental PK.
-- - `colegiatura_cmp`: VARCHAR(10) único y no nulo.
-- - `nombres` y `apellidos`: VARCHAR(60) no nulos.
-- - `especialidad`: ENUM('Cardiología', 'Pediatría', 'Neurología', 'Medicina General').
-- - `sueldo_base`: DECIMAL(10,2) con restricción CHECK >= 1025.00.

-- Caso de prueba esperado:
-- El siguiente INSERT debe fallar por violar la restricción CHECK:
-- INSERT INTO medicos (colegiatura_cmp, nombres, apellidos, especialidad, sueldo_base)
-- VALUES ('CMP-999', 'Juan', 'Perez', 'Pediatría', 800.00); 
-- ERROR 3819 (HY000): Check constraint 'chk_sueldo' is violated.

-- Reto 1.2:
-- Crear la tabla `citas_medicas` vinculada a `medicos` y `pacientes`:
-- Si un médico es borrado, NO permitir la eliminación si tiene citas (RESTRICT).
-- Si un paciente es eliminado, borrar todas sus citas históricas (CASCADE).
