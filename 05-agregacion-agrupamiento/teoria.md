# Módulo 5: Agregación y Agrupamiento (El Core de Analítica)

## 5.1 Funciones de Agregación
- `COUNT(*)`: Cuenta todas las filas que cumplen la condición (incluye nulos).
- `COUNT(columna)`: Cuenta únicamente valores no nulos en esa columna.
- `SUM(columna)`: Sumatoria de valores numéricos.
- `AVG(columna)`: Promedio aritmético ignorando nulos.
- `MIN(col)` / `MAX(col)`: Valor mínimo y máximo.

## 5.2 Cláusula GROUP BY y Orden de Ejecución Lógica
El motor SQL ejecuta las instrucciones en un orden muy diferente a como se escriben:
1. `FROM` & `JOIN` (reunión de tablas y producto cartesiano filtrado)
2. `WHERE` (filtra filas antes de agrupar)
3. `GROUP BY` (crea los grupos o buckets de agregación)
4. `HAVING` (filtra los grupos resultantes)
5. `SELECT` (evalúa expresiones, alias y funciones)
6. `DISTINCT` (elimina duplicados)
7. `ORDER BY` (ordena el resultado final)
8. `LIMIT / OFFSET` (recorta el resultado devuelto al cliente)

## 5.3 WHERE vs HAVING (Diferencia Técnica Estricta)
- `WHERE`: Opera sobre **filas individuales** antes de que ocurra la agregación. No puede contener funciones de agregación como `SUM()` o `COUNT()`.
- `HAVING`: Opera sobre los **grupos ya agregados**. Solo evalúa agregaciones o columnas presentes en el `GROUP BY`.

## 5.4 Agregaciones Avanzadas
- `GROUP_CONCAT([DISTINCT] col SEPARATOR ', ')`: Concatena valores de un grupo en una sola cadena.
- `WITH ROLLUP`: Agrega filas de subtotales y total general al pie de las agrupaciones jerárquicas.
