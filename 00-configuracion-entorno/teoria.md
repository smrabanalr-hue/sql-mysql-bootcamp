# Módulo 0: Configuración del Entorno y Conceptos Base

## 0.1 Arquitectura Básica de Datos
Un RDBMS (Relational Database Management System) gestiona la persistencia, integridad y concurrencia de datos siguiendo principios matemáticos de conjuntos.

### 📊 Cuadro Comparativo: Motores de Almacenamiento (Storage Engines)

| Característica | InnoDB (Predeterminado) | MyISAM (Legacy) | MEMORY (RAM) |
| :--- | :--- | :--- | :--- |
| **Soporte Transaccional (ACID)** | ✅ Sí (`COMMIT` / `ROLLBACK`) | ❌ No | ❌ No |
| **Nivel de Bloqueo (Locking)** | 🔹 **Fila** (Row-level) | 🔸 **Tabla completa** (Table-level) | 🔸 **Tabla completa** |
| **Claves Foráneas (FK)** | ✅ Sí (Integridad referencial) | ❌ No | ❌ No |
| **Recuperación tras caídas** | ✅ Automática (vía Redo Log) | ❌ Lenta / Requiere REPAIR | ❌ Se pierden datos al reiniciar |
| **Caso de Uso Ideal** | Aplicaciones transaccionales, OLTP, APIs | Lecturas masivas estáticas antiguas | Tablas intermedias de caché volátil |

---

## 0.2 Variables Críticas del Sistema

| Variable | Valor Recomendado | Propósito / Impacto |
| :--- | :--- | :--- |
| `innodb_buffer_pool_size` | 60% - 75% de la RAM del servidor | Caché en RAM de páginas de datos e índices. El parámetro más crítico. |
| `sql_safe_updates` | `1` (Activo en desarrollo) | Bloquea `UPDATE` y `DELETE` si no tienen una cláusula `WHERE` con clave. |
| `character_set_server` | `utf8mb4` | Soporte Unicode completo de 4 bytes (acentos, caracteres internacionales, emojis). |
| `collation_server` | `utf8mb4_unicode_ci` | Comparaciones lingüísticas precisas e insensibles a mayúsculas/minúsculas. |

---

## 0.3 Delimitadores y Estructura de Scripts

> [!WARNING]
> **El problema del punto y coma (`;`):**  
> Cuando escribes consultas normales, `;` le dice a MySQL *"ejecuta esto ahora"*. Pero cuando defines un `STORED PROCEDURE` o un `TRIGGER`, el bloque interno contiene múltiples `;`.  
> Si no cambias el delimitador con `DELIMITER //`, el cliente enviará el código cortado y lanzará error de sintaxis.

```sql
DELIMITER //  -- Cambiamos el delimitador a //
CREATE PROCEDURE demo()
BEGIN
    SELECT 1; -- MySQL no corta aquí porque el delimitador ya no es ;
END //        -- Aquí termina realmente el procedimiento
DELIMITER ;   -- Restauramos el delimitador estándar
```

---

## 🧠 Pregunta Interactiva de Calentamiento
**¿Qué crees que devolverá la siguiente consulta en MySQL?**
```sql
SELECT 10 + '20 apples';
```
<details>
<summary>👉 Clic para ver la respuesta explicada</summary>

**Resultado:** `30`  
**Explicación:** MySQL realiza conversión implícita de tipos (*Type Coercion*). Lee la cadena `'20 apples'` desde el inicio, extrae el número entero `20`, descarta el texto restante y suma $10 + 20 = 30$.  
*¡Cuidado en producción! Depender de la coerción implícita oculta bugs graves.*
</details>
