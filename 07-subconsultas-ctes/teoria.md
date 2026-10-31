# Módulo 7: Subconsultas y Common Table Expressions (CTEs)

## 7.1 Subconsultas Básicas
- **Subconsulta Escalar**: Devuelve exactamente un valor (1 fila, 1 columna). Puede ubicarse en `SELECT`, `WHERE`, `HAVING`.
- **Subconsulta de Columna**: Devuelve una lista de valores para operadores como `IN`, `NOT IN`, `ANY`, `ALL`.
- **Tablas Derivadas (FROM)**: Subconsultas en el `FROM`. En MySQL **es obligatorio asignarles un alias** (`FROM (SELECT ...) AS t`).

## 7.2 Subconsultas Correlacionadas
- La subconsulta interna hace referencia a una columna de la tabla en la consulta externa (`WHERE t1.col = t2.col`).
- Se evalúa fila por fila.
- **EXISTS / NOT EXISTS**: Evalúan existencia booleana. El optimizador de MySQL se detiene en cuanto encuentra el primer match, haciéndolo sumamente eficiente frente a `IN` con grandes volúmenes.

## 7.3 Common Table Expressions (CTEs)
- Sintaxis estándar:
  ```sql
  WITH resumen_ventas AS (
      SELECT cliente_id, SUM(total_neto) AS total
      FROM pedidos
      GROUP BY cliente_id
  ),
  clientes_top AS (
      SELECT cliente_id FROM resumen_ventas WHERE total > 1000
  )
  SELECT c.* FROM clientes c JOIN clientes_top ct ON c.cliente_id = ct.cliente_id;
  ```
- **CTEs Recursivas (`WITH RECURSIVE`)**:
  Permiten recorrer grafos, organigramas o secuencias numéricas.
  - Constan de un término ancla (`Anchor`), un operador `UNION ALL` y un término recursivo que se autollama con condición de parada.
