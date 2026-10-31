# Módulo 3: Consultas Esenciales (DQL - Data Query Language)

## 3.1 Proyección y Selección Básica
- `SELECT col1, col2`: Define qué atributos retornar.
- `AS alias`: Asigna nombres de negocio legibles o renombra columnas calculadas.
- `DISTINCT`: Elimina filas idénticas en el resultado proyectado. Actúa sobre la combinación de todas las columnas del SELECT.

## 3.2 Filtrado Condicional (WHERE)
- **Operadores de comparación**: `=`, `<>`, `!=`, `<`, `<=`, `>`, `>=`.
- **Operadores lógicos**: `AND`, `OR`, `NOT`. Precedencia: `NOT` > `AND` > `OR`. Use paréntesis para evitar ambigüedad.
- **Rango (`BETWEEN`)**: `BETWEEN val1 AND val2` es inclusivo (`>= val1 AND <= val2`).
- **Pertenencia a conjuntos (`IN`)**: `col IN ('A', 'B', 'C')` es más eficiente y legible que múltiples `OR`.
- **Manejo de nulos**: `IS NULL` y `IS NOT NULL`. **Advertencia:** `col = NULL` siempre evalúa a `UNKNOWN` (falso en filtros WHERE).

## 3.3 Coincidencia de Patrones (LIKE y REGEXP)
- `LIKE`:
  - `%`: Cero o más caracteres.
  - `_`: Exactamente un caracter.
- `REGEXP / RLIKE`:
  - `^`: Inicio de cadena.
  - `$`: Fin de cadena.
  - `[0-9]+`: Uno o más números.

## 3.4 Ordenamiento y Paginación (ORDER BY, LIMIT, OFFSET)
- `ORDER BY col1 ASC, col2 DESC`: Ordena el conjunto resultado.
- **Paginación para APIs**:
  `LIMIT [cantidad] OFFSET [desplazamiento]` (o la sintaxis simplificada `LIMIT offset, cantidad`).
  - Ejemplo: Página 3 con 10 items por página -> `LIMIT 10 OFFSET 20`.
