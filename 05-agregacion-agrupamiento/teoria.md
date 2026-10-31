# Módulo 5: Agregación y Agrupamiento (El Core de Analítica)

## 5.1 Diagrama del Pipeline de Ejecución de Datos

```text
[ TABLA ORIGINAL: 1,000,000 Filas ]
                 │
                 ▼
          ┌─────────────┐
          │    WHERE    │  --> Descarta filas individuales (ej. solo pedidos de 2024)
          └──────┬──────┘
                 ▼
         [ 200,000 Filas ]
                 │
                 ▼
          ┌─────────────┐
          │  GROUP BY   │  --> Empaqueta las filas en cubos/grupos por categoría
          └──────┬──────┘
                 ▼
            [ 10 Grupos ]
                 │
                 ▼
          ┌─────────────┐
          │   HAVING    │  --> Descarta grupos completos (ej. solo grupos con venta > 50K)
          └──────┬──────┘
                 ▼
            [ 4 Grupos ]
                 │
                 ▼
          ┌─────────────┐
          │   SELECT    │  --> Proyecta métricas agregadas (SUM, AVG, COUNT)
          └─────────────┘
```

---

## 5.2 Cuadro Comparativo Estricto: WHERE vs HAVING

| Criterio | Cláusula `WHERE` | Cláusula `HAVING` |
| :--- | :--- | :--- |
| **Momento de Ejecución** | ⏳ **Antes** de agrupar los datos | ⌛ **Después** de haber agrupado |
| **Unidad de Operación** | Filas individuales | Grupos consolidados |
| **¿Permite `SUM()`, `AVG()`?** | ❌ **No** (Lanza error 1111: Invalid use of group function) | ✅ **Sí** (Diseñado específicamente para ello) |
| **Uso de Índices** | ✅ Altamente eficiente con índices B-Tree | ❌ Opera sobre datos ya en memoria |
| **Regla de Oro** | Si un filtro no requiere agregación, ponlo **siempre en el WHERE**. | Usa `HAVING` exclusivamente para condiciones sobre métricas agregadas. |

---

## 5.3 Cuadro de Funciones de Agregación Clave

| Función | Sintaxis | Comportamiento con Nulos (`NULL`) |
| :--- | :--- | :--- |
| `COUNT(*)` | `COUNT(*)` | Cuenta todas las filas del grupo, **incluyendo nulos**. |
| `COUNT(col)` | `COUNT(columna)` | Cuenta solo las filas donde `columna` **NO es nula**. |
| `COUNT(DISTINCT)`| `COUNT(DISTINCT col)`| Cuenta valores únicos no repetidos. |
| `SUM(col)` | `SUM(precio)` | Suma los valores numéricos; ignora nulos. |
| `AVG(col)` | `AVG(calificacion)`| Promedio aritmético; **no toma en cuenta nulos** para el divisor. |
| `GROUP_CONCAT` | `GROUP_CONCAT(nombre)` | Concatena los textos del grupo en una sola cadena. |
