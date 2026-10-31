# Módulo 8: Funciones de Ventana (Window Functions - MySQL 8.0+)

## 8.1 Anatomía de una Función de Ventana
A diferencia de `GROUP BY` (que colapsa las filas en un único valor agregado), las **Window Functions** realizan cálculos sobre un conjunto de filas relacionadas pero **conservan la identidad y detalle de cada fila individual**.
```sql
FUNCTION(...) OVER (
    [PARTITION BY col1, col2]
    [ORDER BY col3 ASC|DESC]
    [ROWS|RANGE BETWEEN ...]
)
```

## 8.2 Funciones de Ranking
- `ROW_NUMBER()`: Asigna un número secuencial único (1, 2, 3, 4...).
- `RANK()`: Asigna rangos idénticos ante empates y salta posiciones (1, 2, 2, 4...).
- `DENSE_RANK()`: Asigna rangos idénticos ante empates sin saltar números (1, 2, 2, 3...).
- `NTILE(n)`: Divide las filas particionadas en `n` cubos o cuantiles equilibrados (cuartiles, percentiles).

## 8.3 Funciones de Valor Relativo
- `LAG(col, offset, default)`: Obtiene el valor de una fila anterior (ideal para calcular crecimiento mes a mes MoM o año a año YoY).
- `LEAD(col, offset, default)`: Obtiene el valor de una fila posterior.
- `FIRST_VALUE(col)` / `LAST_VALUE(col)`: Primer y último valor dentro del marco de la ventana.

## 8.4 Acumulados y Marcos de Ventana (Window Frames)
- `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`: Acumula desde el inicio de la partición hasta la fila actual.
- `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW`: Medias móviles o acumulados de 3 períodos.
