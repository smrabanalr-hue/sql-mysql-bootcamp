# Módulo 8: Funciones de Ventana (Window Functions)

## 8.1 Cuadro Comparativo: Funciones de Ranking

Imagina que 4 productos tienen los siguientes precios: `$100`, `$80`, `$80`, `$50`.

| Precio | `ROW_NUMBER()` | `RANK()` | `DENSE_RANK()` | ¿Por qué cambia? |
| :---: | :---: | :---: | :---: | :--- |
| **$100** | 1 | 1 | 1 | Primer puesto en todos. |
| **$80** | 2 | 2 | 2 | Empate en el segundo puesto. |
| **$80** | 3 | 2 | 2 | `RANK` y `DENSE_RANK` reconocen el empate. |
| **$50** | 4 | **4** | **3** | `RANK` saltó el puesto 3. `DENSE_RANK` no salta números. |

---

## 8.2 Cuadro Comparativo: LAG vs LEAD

```text
               LAG(monto, 1)        FILA ACTUAL        LEAD(monto, 1)
                  ▲                                        │
                  │ Consulta la fila previa               │ Consulta la fila siguiente
                  └─────────────────[ REGISTRO ]───────────┘
```

| Función | Uso Típico en BI | Fórmula / Expresión Clave |
| :--- | :--- | :--- |
| `LAG(col, 1)` | Variación de ventas respecto al mes anterior (**MoM**). | `venta_actual - LAG(venta_actual, 1)` |
| `LEAD(col, 1)` | Días transcurridos hasta el próximo evento. | `DATEDIFF(LEAD(fecha, 1), fecha)` |

---

## 8.3 Cuadro de Marcos de Ventana (Window Frames)

| Marco de Ventana (`ROWS BETWEEN ...`) | Qué abarca | Aplicación Típica |
| :--- | :--- | :--- |
| `UNBOUNDED PRECEDING AND CURRENT ROW` | Desde la primera fila de la historia hasta la actual. | **Sumas acumuladas progresivas**. |
| `2 PRECEDING AND CURRENT ROW` | Las 2 filas anteriores más la actual (3 filas). | **Medias móviles de 3 períodos**. |
| `CURRENT ROW AND UNBOUNDED FOLLOWING` | Desde la fila actual hasta el fin de los tiempos. | Saldo remanente por consumir. |
