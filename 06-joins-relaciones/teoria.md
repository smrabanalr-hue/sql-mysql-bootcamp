# Módulo 6: Relaciones y Joins Multitabla

## 6.1 Diagramas Visuales de Conjuntos en ASCII

```text
      INNER JOIN                    LEFT JOIN                   ANTI-JOIN (LEFT EXCLUDING)
   Tabla A   Tabla B             Tabla A   Tabla B                Tabla A   Tabla B
    ┌─────┬───┬─────┐             ┌─────┬───┬─────┐                ┌─────┬───┬─────┐
    │     │███│     │             │█████│███│     │                │█████│   │     │
    │  A  │███│  B  │             │██ A │███│  B  │                │██ A │   │  B  │
    │     │███│     │             │█████│███│     │                │█████│   │     │
    └─────┴───┴─────┘             └─────┴───┴─────┘                └─────┴───┴─────┘
 Solo coincidencias en          Todo A + Coincidencias           Solo filas de A que
    ambas tablas.                   de B (o NULL).              NO existen en B (IS NULL).
```

---

## 6.2 Matriz de Selección de Joins

| Situación de Negocio | Tipo de JOIN Recomendado | Ejemplo Clave |
| :--- | :--- | :--- |
| Quiero clientes con sus pedidos existentes. | `INNER JOIN` | `clientes c INNER JOIN pedidos p ON c.id = p.cliente_id` |
| Quiero TODOS los clientes, compren o no compren. | `LEFT JOIN` | `clientes c LEFT JOIN pedidos p ON c.id = p.cliente_id` |
| Quiero detectar clientes que NUNCA han comprado. | `LEFT JOIN` + `WHERE ... IS NULL` | `WHERE p.pedido_id IS NULL` |
| Quiero cruzar tallas y colores posibles. | `CROSS JOIN` | `tallas CROSS JOIN colores` |
| Necesito jerarquías (empleado y su jefe). | `SELF JOIN` | `empleados e LEFT JOIN empleados jefe ON e.jefe_id = jefe.id` |

---

## 6.3 Cuadro Comparativo: UNION vs UNION ALL

| Criterio | `UNION` | `UNION ALL` |
| :--- | :--- | :--- |
| **Manejo de Duplicados** | 🧹 Elimina duplicados automáticamente | 📋 Mantiene absolutamente todas las filas |
| **Paso Oculto de Ordenamiento** | ✅ Sí (Hace un `Sort Distinct` en disco/memoria) | ❌ No |
| **Velocidad y Consumo de Recursos** | 🐢 Lenta en grandes volúmenes | ⚡ Máxima velocidad y ligereza |
| **Recomendación Profesional** | Úsalo solo si requieres explícitamente deduplicar | **Predeterminado de la industria** si los conjuntos son disjuntos |
