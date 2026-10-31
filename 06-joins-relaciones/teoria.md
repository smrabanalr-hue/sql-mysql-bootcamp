# Módulo 6: Relaciones y Joins Multitabla

## 6.1 Teoría de Conjuntos y Diagramas de Venn
- Operan emparejando tuplas bajo predicados lógicos definidos en la cláusula `ON` (o `USING(col)` si comparten nombre).

## 6.2 Tipos de Joins
- **INNER JOIN**: Retorna solo las filas que tienen coincidencia exacta en ambas tablas (intersección $A \cap B$).
- **LEFT JOIN (LEFT OUTER JOIN)**: Retorna todas las filas de la tabla izquierda ($A$). Si no hay coincidencia en la derecha ($B$), rellena con `NULL`.
  - *Detección de Huérfanos:* `WHERE b.id IS NULL` filtra los registros de $A$ que NO tienen relación en $B$.
- **RIGHT JOIN**: Inverso al LEFT JOIN (preserva tabla derecha).
- **CROSS JOIN**: Producto cartesiano ($|A| \times |B|$ filas). Útil para generar combinaciones maestras de fechas, tallas y colores.
- **FULL OUTER JOIN en MySQL**:
  MySQL no soporta nativamente la sintaxis `FULL OUTER JOIN`. Se simula mediante la unión de un `LEFT JOIN` y un `RIGHT JOIN` con `UNION`:
  ```sql
  SELECT a.*, b.* FROM tabla_a a LEFT JOIN tabla_b b ON a.id = b.id
  UNION
  SELECT a.*, b.* FROM tabla_a a RIGHT JOIN tabla_b b ON a.id = b.id;
  ```

## 6.3 Self Joins
- Unión de una tabla consigo misma usando alias diferentes (`e` para empleado, `j` para jefe). Clave para jerarquías organizacionales o árboles de categorías.

## 6.4 Joins Complejos (3+ Tablas)
- Buenas prácticas:
  1. Partir siempre de la tabla transaccional o central.
  2. Usar alias nemotécnicos cortos (`c` para clientes, `p` para pedidos, `dp` para detalle).
  3. Asegurar que las columnas del `ON` estén indexadas para evitar Nested Loops destructivos.

## 6.5 UNION vs UNION ALL
- `UNION`: Concatena resultados eliminando duplicados mediante un paso implícito de `DISTINCT` / ordenamiento en memoria temporal.
- `UNION ALL`: Concatena directamente sin validar duplicados (mucho más rápido y con menor consumo de RAM).
