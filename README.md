# 🚀 SQL & MySQL Professional Bootcamp: De Cero a Arquitectura de Datos y BI

<div align="center">

[![MySQL 8.0](https://img.shields.io/badge/MySQL-8.0.36-blue?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![CI Validation](https://img.shields.io/badge/CI%20Pipeline-GitHub%20Actions-2088FF?logo=github-actions&logoColor=white)](.github/workflows/sql-ci.yml)
[![Test Runner](https://img.shields.io/badge/Interactive%20Testing-Python%20Runner-3776AB?logo=python&logoColor=white)](scripts/test_runner.py)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

*El bootcamp práctico, interactivo y riguroso para dominar bases de datos relacionales, analítica de negocio (BI) y alta concurrencia.*

</div>

---

## 🧭 ¿Por qué este Bootcamp? La Importancia de la Práctica Diaria

Aprender SQL **no es memorizar sintaxis** ni ver tutoriales pasivamente. SQL es un **lenguaje declarativo**: tú no le dices a la máquina *cómo* hacer el trabajo paso a paso (como en Python o JavaScript), sino que le describes con precisión matemática *qué conjunto de datos deseas obtener*.

### 💡 Cómo la práctica diaria transforma tu pensamiento:
1. **Modelado mental en conjuntos**: Tu mente deja de pensar en bucles `for` o `while` y comienza a razonar en términos de intersecciones, uniones, particiones y agrupaciones.
2. **Autonomía profesional absoluta**: En cualquier empresa, quien sabe consultar la base de datos directamente no depende de reportes de terceros ni de interfaces intermedias: valida hipótesis en segundos.
3. **Optimización por instinto**: Escribir una consulta al día te enseña a notar patrones ineficientes (como un `SELECT *` o funciones sobre índices) antes de que colapsen el servidor de producción.
4. **La regla de los 20 minutos**: Dedicar solo 20 minutos diarios a resolver uno de los retos de este repositorio genera un efecto compuesto más potente que una maratón de 10 horas en fin de semana.

---

## 📚 Tutoriales Interactivos del Repositorio

Aprende a sacarle el 100% de provecho a las herramientas incluidas en este repositorio:

| Guía / Tutorial | Qué Aprenderás | Enlace Directo |
| :--- | :--- | :--- |
| 🐳 **Guía Definitiva Docker** | Requisitos, instalación, solución a puertos ocupados y la regla del directorio | [Ver Tutorial](tutoriales/00-guia-definitiva-docker.md) |
| 🧪 **Validador de Retos** | Cómo correr tus consultas y validarlas automáticamente con `test_runner.py` | [Ver Tutorial](tutoriales/01-como-usar-el-validador-interactivo.md) |
| 🤖 **GitHub Actions CI/CD** | Cómo se prueba tu código automáticamente en la nube ante cada `git push` | [Ver Tutorial](tutoriales/02-como-funciona-github-actions-ci.md) |
| 📊 **Diagramas Mermaid** | Cómo renderizar y modificar esquemas entidad-relación interactivos en GitHub | [Ver Tutorial](tutoriales/03-como-usar-los-diagramas-mermaid.md) |
| 📑 **Cheat Sheet de Bolsillo** | Cómo consultar y exportar a PDF la guía condensada de sintaxis SQL | [Ver Tutorial](tutoriales/04-como-usar-el-cheat-sheet-de-bolsillo.md) |

---

## 🏆 Checklist Interactivo de Gamificación (Tu Progreso)

> *Haz un **Fork** de este repositorio y ve marcando con una `[x]` cada módulo conforme superes sus ejercicios y pruebas con `test_runner.py`.*

| Estado | Nivel / Módulo | Hito / Reto Principal | XP |
| :---: | :--- | :--- | :---: |
| [ ] | **00-configuracion-entorno** | Levantar contenedor Docker e inspeccionar Buffer Pool de InnoDB | `+100 XP` |
| [ ] | **01-fundamentos-ddl** | Diseñar esquema de hospital con restricciones `CHECK` y FKs | `+150 XP` |
| [ ] | **02-dml-manipulacion** | Cargas masivas seguras y estrategias de Upsert con `ON DUPLICATE` | `+150 XP` |
| [ ] | **03-consultas-dql** | Consultas compuestas con `BETWEEN`, comodines `REGEXP` y paginación | `+200 XP` |
| [ ] | **04-funciones-nativas** | Cálculo de antigüedad con `DATEDIFF` y lógica condicional con `CASE` | `+200 XP` |
| [ ] | **05-agregacion-agrupamiento** | Dominar la diferencia `WHERE` vs `HAVING` y subtotales con `ROLLUP` | `+250 XP` |
| [ ] | **06-joins-relaciones** | Anti-joins para detectar clientes inactivos y simulación Full Outer | `+300 XP` |
| [ ] | **07-subconsultas-ctes** | CTEs encadenadas y CTEs recursivas para generar calendarios de fechas | `+350 XP` |
| [ ] | **08-funciones-ventana** | Ranking con `DENSE_RANK`, cálculo MoM con `LAG` y medias móviles | `+400 XP` |
| [ ] | **09-objetos-programables** | Stored Procedures con control de excepciones `SIGNAL` y Triggers | `+450 XP` |
| [ ] | **10-transacciones-concurrencia** | Bloqueo pesimista `SELECT ... FOR UPDATE` y prevención de Deadlocks | `+500 XP` |
| [ ] | **11-optimizacion-indexacion** | Análisis con `EXPLAIN ANALYZE` y regla del prefijo más a la izquierda | `+500 XP` |
| [ ] | 🚀 **PROYECTO FINAL BI** | Matriz RFM, análisis de cohortes y crecimiento interanual YoY | `+1000 XP` |
| [ ] | 📦 **PROYECTO FINAL LOGÍSTICA** | Kardex con Triggers automatizados y cálculo OTD de transportistas | `+1000 XP` |

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

## 🗺️ Mapa de la Estructura del Repositorio

```text
sql-mysql-bootcamp/
├── 🐳 docker-compose.yml             # MySQL 8.0 preconfigurado con utf8mb4 y volúmenes
├── 🧪 scripts/
│   └── test_runner.py                # Validador automático de consultas interactivo
├── 🤖 .github/workflows/
│   └── sql-ci.yml                    # Integración continua con GitHub Actions
├── 📑 recursos/
│   └── cheatsheet.md                 # Guía condensada de sintaxis SQL y atajos
├── 📚 tutoriales/                    # Guías interactivas paso a paso
│   ├── 00-guia-definitiva-docker.md
│   ├── 01-como-usar-el-validador-interactivo.md
│   ├── 02-como-funciona-github-actions-ci.md
│   ├── 03-como-usar-los-diagramas-mermaid.md
│   └── 04-como-usar-el-cheat-sheet-de-bolsillo.md
├── 📁 datasets/                      # Esquemas con diagramas Mermaid y datos .sql/.csv
│   ├── tienda_retail/                # Retail, E-commerce, Clientes y Pedidos
│   └── operaciones_logistica/        # Kardex, Almacenes multi-sede y Transportistas
├── 00-configuracion-entorno/         # Arquitectura InnoDB, CLI, Docker y delimitadores
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

## ⚡ Inicio Rápido (3 Comandos)

Para levantar tu laboratorio de experimentación con Docker:

```bash
# 1. Levanta el contenedor de MySQL 8.0 en segundo plano
docker compose up -d

# 2. Conéctate a la consola interactiva
docker compose exec mysql-bootcamp mysql -u root -proot

# 3. Ejecuta el validador automático sobre el módulo 03
python scripts/test_runner.py --modulo 03
```

---

## 📜 Licencia y Contribución
Distribuido bajo la licencia **MIT**. Puedes utilizar este material con fines educativos, profesionales o formativos. ¡Las sugerencias y pull requests son bienvenidas!
