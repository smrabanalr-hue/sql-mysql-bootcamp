# Módulo 1: Modelado Relacional y DDL

## 1.1 Diagrama de Relaciones y Cardinalidad

```text
┌──────────────┐          1 : N          ┌──────────────┐
│   CLIENTES   │────────────────────────<│   PEDIDOS    │
├──────────────┤                         ├──────────────┤
│ PK cliente_id│                         │ PK pedido_id │
│    nombre    │                         │ FK cliente_id│
└──────────────┘                         └──────┬───────┘
                                                │ 1
                                                │ :
                                                │ N
┌──────────────┐          1 : N          ┌──────┴───────┐
│  PRODUCTOS   │────────────────────────<│DETALLE_PEDIDO│ (Tabla Puente)
├──────────────┤                         ├──────────────┤
│ PK producto_id                         │ PK detalle_id│
│    sku       │                         │ FK pedido_id │
└──────────────┘                         │ FK producto_id
```

---

## 1.2 Cuadro Comparativo: Tipos de Datos Fundamentales

### 🔢 Numéricos
| Tipo | Almacenamiento | Rango / Precisión | Cuándo Usarlo |
| :--- | :--- | :--- | :--- |
| `TINYINT UNSIGNED` | 1 Byte | 0 a 255 | Edad, meses, banderas booleanas |
| `INT` | 4 Bytes | -2.14 mil millones a +2.14 mil millones | Identificadores y claves foráneas generales |
| `BIGINT` | 8 Bytes | $\pm 9.22 	imes 10^{18}$ | Transacciones masivas, logs, timestamps epoch |
| `DECIMAL(p,s)` | Exacto | $p$ dígitos totales, $s$ decimales | **Dinero, precios, saldos contables (Obligatorio)** |
| `FLOAT` / `DOUBLE` | IEEE 754 Inexacto | Coma flotante científica | Sensores, coordenadas geográficas, física |

### 📝 Texto
| Tipo | Comportamiento | Límite | Ventaja / Desventaja |
| :--- | :--- | :--- | :--- |
| `CHAR(n)` | Longitud estática (rellena con espacios) | 255 chars | Ultrarrápido para longitudes fijas ('PE', 'USD', UUIDs) |
| `VARCHAR(n)` | Longitud dinámica | 65,535 bytes | Ahorra espacio; ideal para nombres y correos |
| `TEXT` | Almacenamiento off-page | 64 KB a 4 GB | Para descripciones largas o artículos |

### ⏰ Fechas y Horas
| Tipo | Formato | Rango | ¿Depende de Zona Horaria? |
| :--- | :--- | :--- | :--- |
| `DATE` | `YYYY-MM-DD` | 1000 al 9999 | No |
| `DATETIME` | `YYYY-MM-DD HH:MM:SS` | 1000 al 9999 | ❌ No (Guarda el valor tal cual) |
| `TIMESTAMP` | Segundos epoch UTC | 1970 al 2038 | ✅ **Sí** (Convierte a la zona horaria del cliente) |

---

## 1.3 Acciones Referenciales en Claves Foráneas (ON DELETE / ON UPDATE)

| Regla | Comportamiento al borrar el registro padre | Riesgo de Negocio |
| :--- | :--- | :--- |
| `RESTRICT` / `NO ACTION` | 🛑 Bloquea la eliminación si existen hijos asociados. | Máxima seguridad; evita dejar huérfanos. |
| `CASCADE` | 🗑️ Elimina automáticamente todos los registros hijos. | Riesgoso; un borrado accidental borra miles de filas. |
| `SET NULL` | ⚪ Coloca `NULL` en la clave foránea de los hijos. | Requiere que la columna acepte valores nulos. |

---

## 1.4 Cuadro Comparativo: TRUNCATE vs DROP vs DELETE

| Operación | Tipo | ¿Permite WHERE? | ¿Resetea AUTO_INCREMENT? | ¿Activa Triggers? | Velocidad |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **`DELETE`** | DML | ✅ Sí | ❌ No | ✅ Sí | Lenta (Fila por fila) |
| **`TRUNCATE`**| DDL | ❌ No | ✅ Sí | ❌ No | ⚡ Instantánea |
| **`DROP`** | DDL | ❌ No | N/A (Borra la tabla) | ❌ No | ⚡ Instantánea |
