# Módulo 11: Optimización, Indexación y Rendimiento

## 11.1 Plan de Ejecución (EXPLAIN y EXPLAIN ANALYZE)
- `EXPLAIN [FORMAT=TREE] SELECT ...`: Permite al motor detallar cómo piensa resolver la consulta sin ejecutarla.
- `EXPLAIN ANALYZE SELECT ...` (MySQL 8.0.18+): Ejecuta realmente la consulta e informa tiempos exactos de iteración, conteo de filas y costo estimado vs real.
- **Tipos de Acceso (`type`) de mejor a peor**:
  1. `system` / `const`: Búsqueda por Primary Key o Unique Index con valor constante (1 lectura).
  2. `eq_ref`: 1 fila leída por cada fila externa en joins sobre clave primaria/única.
  3. `ref`: Coincidencias en índice no único.
  4. `range`: Búsqueda por rangos (`BETWEEN`, `<`, `>`, `IN`) sobre un índice.
  5. `index`: Escaneo completo del árbol del índice (Full Index Scan).
  6. `ALL`: Escaneo secuencial de toda la tabla en disco (Full Table Scan - ¡Alerta de lentitud!).

## 11.2 Tipos de Índices
- **B-Tree**: Estructura de árbol balanceado por defecto. Búsquedas $O(\log N)$.
- **Índices Compuestos (Composite Indexes)**:
  - Regla del **prefijo más a la izquierda** (*Leftmost Prefix Rule*): Un índice en `(A, B, C)` solo puede optimizar filtros en `(A)`, `(A, B)` o `(A, B, C)`. Si filtras por `(B)` o `(C)`, el índice es inútil.
- **Índices Full-Text**: Búsqueda especializada en texto libre con `MATCH(...) AGAINST(...)`.

## 11.3 Antipatrones de Rendimiento
1. **Funciones en el WHERE sobre la columna indexada**:
   `WHERE YEAR(fecha_pedido) = 2024` -> Invalida el índice (obliga a escanear toda la tabla).
   *Solución:* `WHERE fecha_pedido >= '2024-01-01' AND fecha_pedido < '2025-01-01'`.
2. **Comodín inicial en LIKE**:
   `WHERE nombre LIKE '%laptop'` -> No puede usar B-Tree.
3. **SELECT ***: Sobrecarga memoria de red e impide índices cubrientes (*Covering Indexes*).

## 11.4 Particionamiento de Tablas
- Fragmentación física de una tabla lógica en múltiples archivos de almacenamiento:
  - `PARTITION BY RANGE (YEAR(fecha))`
  - `PARTITION BY LIST`
  - `PARTITION BY HASH`
- **Partition Pruning**: El motor descarta automáticamente particiones no relevantes en el query.
