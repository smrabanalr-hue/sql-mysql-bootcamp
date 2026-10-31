# Módulo 11: Optimización, Indexación y Rendimiento

## 11.1 Semáforo de Rendimiento en EXPLAIN (Columna `type`)

| Nivel | Tipo de Acceso | Significado Técnico | Evaluación |
| :---: | :--- | :--- | :--- |
| 🟢 | `system` / `const` | Registro único buscado por Primary Key o Unique Index. | **Excelente** ($O(1)$) |
| 🟢 | `eq_ref` | 1 fila leída en join usando clave primaria de tabla derecha. | **Excelente** |
| 🟡 | `ref` | Coincidencias múltiples en índice normal no único. | **Bueno** |
| 🟡 | `range` | Búsqueda por rango (`BETWEEN`, `<`, `>`, `IN`) sobre índice. | **Aceptable** |
| 🔴 | `index` | Full Index Scan (recorre todo el árbol de índice de punta a punta). | **Alerta** en tablas gigantes |
| 🚨 | `ALL` | Full Table Scan (lee todos los bloques de la tabla en disco). | **Crítico** (Falta índice) |

---

## 11.2 La Regla del Prefijo Más a la Izquierda (*Leftmost Prefix Rule*)

Si creas un índice compuesto en tres columnas:  
`CREATE INDEX idx_abc ON transacciones (A, B, C);`

| Filtro WHERE utilizado | ¿Aprovecha el índice? | Por qué |
| :--- | :---: | :--- |
| `WHERE A = 5` | ✅ Sí | Inicia con el prefijo más a la izquierda (A). |
| `WHERE A = 5 AND B = 10` | ✅ Sí | Utiliza las primeras dos columnas contiguas (A, B). |
| `WHERE A = 5 AND B = 10 AND C = 20` | ✅ Sí | Cobertura total del índice (A, B, C). |
| `WHERE B = 10 AND C = 20` | ❌ **No** | Falta la columna guía A; no puede usar el árbol. |
| `WHERE C = 20` | ❌ **No** | Falta A y B; provocará un Full Table Scan. |
