# 🚀 SQL & MySQL Bootcamp: De Cero a Arquitectura de Datos y BI

> *"En tecnología los frameworks nacen y mueren cada dos años, pero SQL ha dominado el mundo de los datos por más de medio siglo. Quien domina SQL, domina la verdad del negocio."*

Bienvenido al repositorio definitivo para convertirte en un profesional capaz de escribir consultas de alto rendimiento, diseñar modelos relacionales robustos y resolver problemas reales de Analítica de Negocio (BI) e Ingeniería de Software con **MySQL 8.0+**.

---

## 🧭 ¿Por qué este Bootcamp? La Importancia de la Práctica Diaria

Aprender SQL **no es memorizar sintaxis** ni ver tutoriales pasivamente. SQL es un **lenguaje declarativo**: tú no le dices a la máquina *cómo* hacer el trabajo paso a paso (como en Python o JavaScript), sino que le describes con precisión matemática *qué conjunto de datos deseas obtener*.

### 💡 Cómo la práctica diaria transforma tu pensamiento:
1. **Modelado mental en conjuntos**: Tu mente deja de pensar en bucles `for` o `while` y comienza a razonar en términos de intersecciones, uniones, particiones y agrupaciones.
2. **Autonomía profesional absoluta**: En cualquier empresa, quien sabe consultar la base de datos directamente no depende de reportes de terceros ni de interfaces intermedias: valida hipótesis en segundos.
3. **Optimización por instinto**: Escribir una consulta al día te enseña a notar patrones ineficientes (como un `SELECT *` o funciones sobre índices) antes de que colapsen el servidor de producción.
4. **La regla de los 20 minutos**: Dedicar solo 20 minutos diarios a resolver uno de los retos de este repositorio genera un efecto compuesto más potente que una maratón de 10 horas en fin de semana.

---

## 🎯 Consejos Clave para Empezar con el Pie Derecho

### 1. El Método "Predice el Output" (Active Recall)
Antes de presionar `Ctrl + Enter` para ejecutar un script:
- Toma lápiz y papel o abre una nota mental.
- Predice: *¿Cuántas filas espero recibir?*, *¿Qué columnas vendrán?*, *¿Habrá registros nulos?*.
- Si el resultado difiere de tu predicción, investiga **por qué**. Ese desfase es exactamente donde ocurre el aprendizaje real.

### 2. Dibuja los Modelos antes de Codificar
Nunca crees tablas a ciegas. Dibuja las entidades, sus atributos clave y las flechas de cardinalidad ($1:1$, $1:N$, $N:M$). Si la relación sobre papel no tiene sentido, tu código SQL tampoco lo tendrá.

### 3. Respeta el Orden Lógico de Ejecución
Recuerda siempre que el motor SQL **no lee el código en el orden que lo escribes**:

```text
Orden en que lo ESCRIBES:      Orden en que MySQL lo EJECUTA:
1. SELECT                      1. FROM & JOIN     (¿De dónde saco los datos?)
2. FROM & JOIN                 2. WHERE           (¿Qué filas descarto primero?)
3. WHERE                       3. GROUP BY        (¿Cómo formo los grupos?)
4. GROUP BY                    4. HAVING          (¿Qué grupos filtro?)
5. HAVING                      5. SELECT          (¿Qué columnas proyecto y calculo?)
6. ORDER BY                    6. DISTINCT        (¿Elimino filas duplicadas?)
7. LIMIT / OFFSET              7. ORDER BY        (¿Cómo ordeno el resultado final?)
                               8. LIMIT / OFFSET  (¿Cuántas filas devuelvo?)
```
*Comprender esta secuencia te evitará el 90% de los errores de novato (como intentar usar un alias del SELECT dentro del WHERE).*

---

## 🚫 Los 5 Antipatrones del Principiante (Y Cómo Evitarlos)

| Error Común | Por qué es destructivo | La Solución Profesional |
| :--- | :--- | :--- |
| **Abusar de `SELECT *`** | Transfiere columnas innecesarias por la red, satura memoria y anula *Covering Indexes*. | Proyecta exclusivamente las columnas que el negocio necesita: `SELECT id, total FROM pedidos;` |
| **Comparar con `col = NULL`** | En lógica trivalente de SQL (`TRUE`, `FALSE`, `UNKNOWN`), `NULL = NULL` es `UNKNOWN` (falso). | Usa siempre la sintaxis formal: `WHERE col IS NULL` o `WHERE col IS NOT NULL`. |
| **Aplicar funciones en el `WHERE`** | `WHERE YEAR(fecha) = 2024` obliga a escanear toda la tabla fila por fila (*Full Table Scan*). | Haz la consulta SARGable: `WHERE fecha >= '2024-01-01' AND fecha < '2025-01-01'`. |
| **Usar `HAVING` en vez de `WHERE`** | `HAVING` procesa datos después de agrupar; filtrar tarde quema CPU y memoria RAM. | Usa `WHERE` para descartar filas individuales antes del `GROUP BY`. Reserva `HAVING` para agregaciones (`SUM`, `COUNT`). |
| **Confundir `UNION` con `UNION ALL`** | `UNION` ejecuta un paso oculto de deduplicación que sobrecarga el motor con tablas temporales. | Si sabes que los conjuntos no se solapan o no te molestan duplicados, usa siempre `UNION ALL`. |

---

## 🗺️ Mapa Curricular del Bootcamp

```text
sql-mysql-bootcamp/
├── 🐳 docker-compose.yml             # MySQL 8.0 preconfigurado con utf8mb4 y volúmenes
├── 📁 datasets/                      # Esquemas y datos de prueba reales (.sql y .csv)
│   ├── tienda_retail/                # Retail, E-commerce, Clientes y Pedidos
│   └── operaciones_logistica/        # Kardex, Almacenes multi-sede y Transportistas
├── 00-configuracion-entorno/         # Arquitectura InnoDB, CLI, Docker y convenciones
├── 01-fundamentos-ddl/               # Modelo ER, Schemas, Constraints, ALTER, TRUNCATE
├── 02-dml-manipulacion/              # Bulk INSERT, Safe Updates, ON DUPLICATE KEY
├── 03-consultas-dql/                 # SELECT, filtros lógicos, LIKE/REGEXP, paginación
├── 04-funciones-nativas/             # Fechas (DATEDIFF), Strings, CASE WHEN, IFNULL
├── 05-agregacion-agrupamiento/       # COUNT, SUM, GROUP BY, WHERE vs HAVING, ROLLUP
├── 06-joins-relaciones/              # INNER, LEFT/RIGHT, Anti-Joins, simulación Full Join
├── 07-subconsultas-ctes/             # Subconsultas correlacionadas y CTEs recursivas
├── 08-funciones-ventana/             # OVER(), PARTITION BY, RANK, LAG/LEAD, Rolling Avg
├── 09-objetos-programables/          # Views, Variables, Stored Procedures, UDFs, Triggers
├── 10-transacciones-concurrencia/    # Principios ACID, SELECT ... FOR UPDATE, Deadlocks
├── 11-optimizacion-indexacion/       # EXPLAIN, EXPLAIN ANALYZE, B-Trees, SARGability
└── proyectos-finales/
    ├── 01-analitica-retail/          # Caso BI: Cohortes, Churn, Matriz RFM y YoY / MoM
    └── 02-control-inventarios/       # Caso Logística: Kardex con Triggers y gestión OTD
```

---

## 📊 Matriz de Rutas de Especialización

Elige tu enfoque de acuerdo a tu objetivo profesional:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                        TU OBJETIVO PROFESIONAL                         │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
         ┌──────────────────────────┼──────────────────────────┐
         ▼                          ▼                          ▼
┌──────────────────┐       ┌──────────────────┐       ┌──────────────────┐
│   DATA ANALYST   │       │ BACKEND DEVELOPER│       │  DATA ENGINEER / │
│      / BI        │       │    (API / Web)   │       │       DBA        │
├──────────────────┤       ├──────────────────┤       ├──────────────────┤
│ Módulos Clave:   │       │ Módulos Clave:   │       │ Módulos Clave:   │
│ • 03 (DQL Base)  │       │ • 01 (DDL & Rel) │       │ • 00 (InnoDB Arc)│
│ • 04 (Funciones) │       │ • 02 (DML & Ups) │       │ • 09 (Triggers)  │
│ • 05 (Agregación)│       │ • 06 (Joins)     │       │ • 10 (ACID & Tx) │
│ • 07 (CTEs)      │       │ • 09 (Procedures)│       │ • 11 (EXPLAIN &  │
│ • 08 (Ventanas)  │       │ • 10 (Transac.)  │       │      B-Trees)    │
│ • Proy. Final 1  │       │ • Proy. Final 2  │       │ • Particionam.   │
└──────────────────┘       └──────────────────┘       └──────────────────┘
```

---

## ⚡ Inicio Rápido (3 Comandos)

Para levantar tu laboratorio de experimentación con Docker:

```bash
# 1. Levanta el contenedor de MySQL 8.0 en segundo plano
docker compose up -d

# 2. Conéctate a la consola interactiva
docker compose exec mysql-bootcamp mysql -u root -proot

# 3. Carga el esquema y datos iniciales de la tienda retail
docker compose exec mysql-bootcamp mysql -u root -proot -e "source /datasets/tienda_retail/01_schema.sql;"
docker compose exec mysql-bootcamp mysql -u root -proot -e "source /datasets/tienda_retail/02_data.sql;"
```

---

## 🛠️ Cómo Utilizar Cada Módulo

Cada carpeta de módulo cuenta con 4 archivos sincronizados:
1. `teoria.md`: Cuadros comparativos, sintaxis formal y alertas técnicas de producción.
2. `queries.sql`: Ejemplos prácticos listos para correr con resultados esperados documentados.
3. `ejercicios.sql`: Retos con enunciados de negocio reales, esquemas de entrada y salidas esperadas.
4. `soluciones.sql`: Soluciones completamente comentadas con razonamiento arquitectónico.

---

## 🚀 Tu Compromiso de Aprendizaje

> **"Un maestro en SQL no es aquel que escribe consultas de 500 líneas incomprensibles, sino quien resuelve la pregunta del negocio en una consulta elegante, predecible y que no hace pestañear al motor de base de datos."**

¡Empieza hoy mismo con el [Módulo 00: Configuración del Entorno](00-configuracion-entorno/teoria.md) y construye tu maestría paso a paso!
