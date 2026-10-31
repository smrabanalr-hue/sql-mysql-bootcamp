# Módulo 3: Consultas Esenciales (DQL)

## 3.1 Precedencia de Operadores Lógicos

> [!CAUTION]
> **El peligro de la precedencia:**  
> `NOT` tiene mayor prioridad que `AND`, y `AND` tiene mayor prioridad que `OR`.  
> Si combinas `AND` y `OR` sin paréntesis, MySQL agrupará primero los `AND`, cambiando por completo el significado de tu consulta de negocio.

```text
Sin Paréntesis:     A OR B AND C       ==>    A OR (B AND C)
Con Paréntesis:    (A OR B) AND C      ==>    Ambos deben cumplir C
```

---

## 3.2 Cuadro Comparativo: Coincidencia de Patrones

| Operador | Patrón | Ejemplo | Coincide con | No coincide con |
| :--- | :--- | :--- | :--- | :--- |
| `LIKE` | `%` (Cero o más) | `'A%'` | 'Ana', 'Alejandro', 'A' | 'Carlos', 'a' (si es binary) |
| `LIKE` | `_` (Exactamente 1) | `'T_m'` | 'Tom', 'Tim' | 'Team', 'Tm' |
| `REGEXP` | `^` (Inicio de línea) | `'^L'` | 'Lima', 'Loreto' | 'Callao' |
| `REGEXP` | `[0-9]+` (Dígitos) | `'[0-9]+'` | 'Casa 12', 'Piso 3' | 'Solo texto' |

---

## 3.3 El Truco de la Paginación Eficiente (LIMIT & OFFSET)

| Página Solicitada | Registros por Página | Sintaxis Estándar | Fórmula de Desplazamiento |
| :--- | :--- | :--- | :--- |
| **Página 1** | 10 | `LIMIT 10 OFFSET 0` | $(1 - 1) 	imes 10 = 0$ |
| **Página 2** | 10 | `LIMIT 10 OFFSET 10` | $(2 - 1) 	imes 10 = 10$ |
| **Página 3** | 10 | `LIMIT 10 OFFSET 20` | $(3 - 1) 	imes 10 = 20$ |
| **Página $N$** | $K$ | `LIMIT K OFFSET (N-1)*K` | $(N - 1) 	imes K$ |

---

## 🧠 Desafío Mental Rápido
¿Cuántas filas retorna la siguiente consulta sobre clientes con nulos?
```sql
-- Supongamos que 5 clientes tienen telefono = NULL y 15 tienen número
SELECT * FROM clientes WHERE telefono = NULL;
```
<details>
<summary>👉 Clic para ver la respuesta explicada</summary>

**Resultado:** `0 filas`.  
**Por qué:** `NULL` representa lo "desconocido". Comparar `= NULL` devuelve `UNKNOWN`, que en una cláusula `WHERE` se evalúa como falso. Debes usar obligatoriamente `WHERE telefono IS NULL`.
</details>
