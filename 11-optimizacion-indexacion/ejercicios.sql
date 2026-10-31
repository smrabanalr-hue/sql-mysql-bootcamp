-- ==============================================================================
-- Ejercicios: Módulo 11
-- ==============================================================================
USE tienda_retail;

-- Reto 11.1:
-- Ejecutar EXPLAIN sobre una consulta que busque productos filtrando por nombre:
-- `SELECT * FROM productos WHERE nombre = 'Zapatillas Running Pro Cushion 42';`
-- Identificar el tipo de acceso (`type`). Luego, crear el índice adecuado
-- y volver a correr el EXPLAIN para comprobar que el tipo de acceso mejoró a `ref`.

-- Reto 11.2:
-- Refactorizar la siguiente consulta anti-patrón para volverla SARGable:
-- `SELECT * FROM clientes WHERE UPPER(ciudad) = 'LIMA';`

-- Reto 11.3:
-- Diseñar una tabla de historial de auditoría particionada por RANGOS de AÑO
-- (`PARTITION BY RANGE`) usando una columna de fecha `fecha_suceso`.
