# 📑 MySQL 8.0 & SQL Professional Cheat Sheet (Guía de Bolsillo)

Guía condensada y de alta densidad para tener abierta en una pestaña mientras resuelves los ejercicios o consultas de producción.

---

## 1. Orden Lógico de Ejecución
```text
(1) FROM & JOIN  ==>  (2) WHERE  ==>  (3) GROUP BY  ==>  (4) HAVING  
      ==>  (5) SELECT  ==>  (6) DISTINCT  ==>  (7) ORDER BY  ==>  (8) LIMIT
```

---

## 2. Tipos de JOIN en un Vistazo
```text
INNER JOIN:               LEFT JOIN:                ANTI-JOIN (Solo en A):
A ∩ B (Solo comunes)      Todo A + (B o NULL)       Todo A donde B.id IS NULL
```
```sql
-- Sintaxis moderna con alias
SELECT c.nombre, p.total_neto
FROM clientes c
LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id
WHERE p.pedido_id IS NULL; -- Anti-join: Clientes sin compras
```

---

## 3. Funciones de Ventana (Window Functions)
```sql
FUNCTION(...) OVER (
    PARTITION BY columna_agrupadora
    ORDER BY columna_ordenamiento [ASC|DESC]
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW -- Acumulado total
)
```
- `ROW_NUMBER()`: Conteo secuencial `1, 2, 3, 4`.
- `RANK()`: Empates idénticos con salto: `1, 2, 2, 4`.
- `DENSE_RANK()`: Empates idénticos sin saltar número: `1, 2, 2, 3`.
- `LAG(col, 1)`: Valor de la fila previa (Cálculo MoM / YoY).
- `LEAD(col, 1)`: Valor de la fila siguiente.

---

## 4. Common Table Expressions (CTEs)
```sql
WITH ventas_2024 AS (
    SELECT cliente_id, SUM(total_neto) AS total
    FROM pedidos
    WHERE fecha_pedido >= '2024-01-01'
    GROUP BY cliente_id
),
clientes_vip AS (
    SELECT cliente_id FROM ventas_2024 WHERE total > 1000
)
SELECT c.* FROM clientes c INNER JOIN clientes_vip v ON c.cliente_id = v.cliente_id;
```

---

## 5. Manejo Defensivo de Nulos y Condicionales
| Expresión | Comportamiento |
| :--- | :--- |
| `COALESCE(a, b, c)` | Retorna el primer argumento que NO sea nulo. |
| `IFNULL(a, reemplazo)` | Retorna `reemplazo` si `a` es NULL. |
| `NULLIF(a, b)` | Retorna NULL si $a = b$ (Evita errores de división por cero: `total / NULLIF(qty, 0)`). |
| `CASE WHEN ... THEN ... ELSE ... END` | Lógica de bifurcación condicional estándar. |

---

## 6. Comandos de Supervivencia en Docker
```bash
# Levantar el entorno
docker compose up -d

# Conectarse a MySQL CLI
docker compose exec mysql-bootcamp mysql -u root -proot

# Ver logs del contenedor
docker compose logs -f

# Destruir volumen y empezar de cero
docker compose down -v
```

---

## 7. Atajos de Teclado Esenciales (DBeaver / VS Code)
- `Ctrl + Enter`: Ejecutar la consulta donde está el cursor.
- `Ctrl + Shift + F`: Autoformatear código SQL.
- `Ctrl + /`: Comentar / descomentar línea.
- `Ctrl + Espacio`: Autocompletado inteligente de tablas y columnas.
