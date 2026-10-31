<div align="center">

# ⚡ SQL & MySQL Professional Bootcamp
### *De Cero a Arquitectura de Datos Relacionales, BI y Alta Concurrencia*

[![MySQL 8.0](https://img.shields.io/badge/MySQL-8.0.36-00758F?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?style=for-the-badge&logo=docker&logoColor=white)](tutoriales/00-guia-definitiva-docker.md)
[![Python Test Runner](https://img.shields.io/badge/Test%20Runner-Interactive-3776AB?style=for-the-badge&logo=python&logoColor=white)](scripts/test_runner.py)
[![CI Validation](https://img.shields.io/badge/CI%20Pipeline-GitHub%20Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)](https://github.com/smrabanalr-hue/sql-mysql-bootcamp/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-F5A623?style=for-the-badge)](LICENSE)

<br/>

<p align="center">
  <a href="#inicio-rapido"><b>🚀 Inicio Rápido</b></a> •
  <a href="tutoriales/00-guia-definitiva-docker.md"><b>🐳 Guía Docker</b></a> •
  <a href="recursos/cheatsheet.md"><b>📑 Cheat Sheet</b></a> •
  <a href="#modulos"><b>🗺️ Módulos</b></a> •
  <a href="#tutoriales"><b>📚 Tutoriales</b></a>
</p>

> 💡 *"En tecnología los frameworks nacen y mueren cada dos años, pero SQL ha dominado el mundo de los datos por más de medio siglo. Quien domina SQL, domina la verdad del negocio."*

</div>

---

## 🧭 ¿Por qué este Bootcamp? La Importancia de la Práctica Diaria

Aprender SQL **no es memorizar sintaxis** ni ver tutoriales pasivamente. SQL es un **lenguaje declarativo**: tú no le dices a la máquina *cómo* hacer el trabajo paso a paso (como en bucles `for` o `while`), sino que le describes con precisión matemática *qué conjunto de datos deseas obtener*.

```mermaid
flowchart LR
    A[Problema de Negocio] --> B[Pensamiento en Conjuntos]
    B --> C[Consulta Declarativa SQL]
    C --> D[Motor InnoDB & Buffer Pool]
    D --> E[Respuesta en Milisegundos]

    style A fill:#1e293b,stroke:#38bdf8,stroke-width:2px,color:#fff
    style B fill:#0f766e,stroke:#2dd4bf,stroke-width:2px,color:#fff
    style C fill:#1e40af,stroke:#60a5fa,stroke-width:2px,color:#fff
    style D fill:#7c2d12,stroke:#fb923c,stroke-width:2px,color:#fff
    style E fill:#14532d,stroke:#4ade80,stroke-width:2px,color:#fff
```

### 💡 Los 4 Pilares del Aprendizaje Activo:
1. **Modelado mental en conjuntos**: Tu cerebro razona en términos de intersecciones, uniones, particiones analíticas y agrupaciones.
2. **Autonomía analítica absoluta**: Validarás hipótesis directamente en la base de datos sin depender de reportes intermedios.
3. **Optimización por instinto**: Detectarás consultas lentas o *Full Table Scans* antes de que colapsen el servidor de producción.
4. **La regla de los 20 minutos**: Resolver un reto diario genera un efecto compuesto más potente que una maratón de 10 horas el fin de semana.

---

<a id="inicio-rapido"></a>
## ⚡ Inicio Rápido en 3 Minutos

> [!TIP]
> Si es tu primera vez usando Docker, consulta nuestra **[🐳 Guía Definitiva de Docker](tutoriales/00-guia-definitiva-docker.md)** para una puesta en marcha paso a paso sin errores de puertos ni directorios.

```bash
# 1. Enciende el laboratorio de MySQL en segundo plano
docker compose up -d

# 2. Inicializa las bases de datos con codificación limpia UTF-8
python scripts/test_runner.py --init-db

# 3. Valida tus ejercicios del Módulo 03 interactivamente
python scripts/test_runner.py --modulo 03
```

---

<a id="modulos"></a>
## 🗺️ Mapa Curricular y Progreso

<details open>
<summary><b>🎯 Haz clic aquí para desplegar la Matriz de Módulos y Puntos de Experiencia (XP)</b></summary>
<br/>

> *Haz un **Fork** de este repositorio y marca con una `[x]` cada módulo superado conforme avances en tus prácticas.*

| Estado | Módulo | Competencia Profesional | Archivos Clave | XP |
| :---: | :--- | :--- | :--- | :---: |
| [ ] | **[00-configuracion-entorno](00-configuracion-entorno/teoria.md)** | Arquitectura InnoDB vs MyISAM, Docker y variables de memoria | [Teoría](00-configuracion-entorno/teoria.md) • [Retos](00-configuracion-entorno/ejercicios.sql) | `+100` |
| [ ] | **[01-fundamentos-ddl](01-fundamentos-ddl/teoria.md)** | Modelado ER, constraints `CHECK`, `FOREIGN KEY` y `ALTER TABLE` | [Teoría](01-fundamentos-ddl/teoria.md) • [Retos](01-fundamentos-ddl/ejercicios.sql) | `+150` |
| [ ] | **[02-dml-manipulacion](02-dml-manipulacion/teoria.md)** | Bulk inserts, safe updates y estrategias de Upsert con `ON DUPLICATE` | [Teoría](02-dml-manipulacion/teoria.md) • [Retos](02-dml-manipulacion/ejercicios.sql) | `+150` |
| [ ] | **[03-consultas-dql](03-consultas-dql/teoria.md)** | Filtros con `BETWEEN`, comodines `REGEXP` y paginación con `LIMIT` | [Teoría](03-consultas-dql/teoria.md) • [Retos](03-consultas-dql/ejercicios.sql) | `+200` |
| [ ] | **[04-funciones-nativas](04-funciones-nativas/teoria.md)** | Manipulación de cadenas, fechas (`DATEDIFF`) y lógica con `CASE WHEN` | [Teoría](04-funciones-nativas/teoria.md) • [Retos](04-funciones-nativas/ejercicios.sql) | `+200` |
| [ ] | **[05-agregacion-agrupamiento](05-agregacion-agrupamiento/teoria.md)** | Dominar `WHERE` vs `HAVING`, pipeline de agregación y `WITH ROLLUP` | [Teoría](05-agregacion-agrupamiento/teoria.md) • [Retos](05-agregacion-agrupamiento/ejercicios.sql) | `+250` |
| [ ] | **[06-joins-relaciones](06-joins-relaciones/teoria.md)** | `INNER`, `LEFT`, Anti-Joins con `IS NULL` y simulación de Full Outer Join | [Teoría](06-joins-relaciones/teoria.md) • [Retos](06-joins-relaciones/ejercicios.sql) | `+300` |
| [ ] | **[07-subconsultas-ctes](07-subconsultas-ctes/teoria.md)** | Subconsultas correlacionadas con `EXISTS` y CTEs recursivas | [Teoría](07-subconsultas-ctes/teoria.md) • [Retos](07-subconsultas-ctes/ejercicios.sql) | `+350` |
| [ ] | **[08-funciones-ventana](08-funciones-ventana/teoria.md)** | Ranking con `DENSE_RANK()`, crecimiento MoM con `LAG()` y medias móviles | [Teoría](08-funciones-ventana/teoria.md) • [Retos](08-funciones-ventana/ejercicios.sql) | `+400` |
| [ ] | **[09-objetos-programables](09-objetos-programables/teoria.md)** | Stored Procedures, control de excepciones `SIGNAL`, UDFs y Triggers | [Teoría](09-objetos-programables/teoria.md) • [Retos](09-objetos-programables/ejercicios.sql) | `+450` |
| [ ] | **[10-transacciones-concurrencia](10-transacciones-concurrencia/teoria.md)** | Principios ACID, bloqueos `SELECT ... FOR UPDATE` y Deadlocks | [Teoría](10-transacciones-concurrencia/teoria.md) • [Retos](10-transacciones-concurrencia/ejercicios.sql) | `+500` |
| [ ] | **[11-optimizacion-indexacion](11-optimizacion-indexacion/teoria.md)** | Profiling con `EXPLAIN ANALYZE`, índices B-Tree y consultas SARGables | [Teoría](11-optimizacion-indexacion/teoria.md) • [Retos](11-optimizacion-indexacion/ejercicios.sql) | `+500` |
| [ ] | 🚀 **[PROYECTO FINAL 1: BI RETAIL](proyectos-finales/01-analitica-retail/README.md)** | Matriz RFM, análisis de cohortes de retención y crecimiento YoY / MoM | [Proyecto BI](proyectos-finales/01-analitica-retail/README.md) | `+1000` |
| [ ] | 📦 **[PROYECTO FINAL 2: KARDEX](proyectos-finales/02-control-inventarios/README.md)** | Control de stock multi-almacén con Triggers y gestión de flota OTD | [Proyecto Logística](proyectos-finales/02-control-inventarios/README.md) | `+1000` |

</details>

---

<a id="tutoriales"></a>
## 📚 Tutoriales Interactivos del Repositorio

Aprende a aprovechar al máximo todas las herramientas del entorno:

| Tutorial | Qué Aprenderás | Guía |
| :--- | :--- | :---: |
| 🐳 **Guía Definitiva Docker** | Instalación, solución a conflictos de puerto y la regla del directorio de trabajo | [Abrir Guía](tutoriales/00-guia-definitiva-docker.md) |
| 🧪 **Validador de Retos** | Cómo correr tus consultas y validarlas automáticamente con `test_runner.py` | [Abrir Guía](tutoriales/01-como-usar-el-validador-interactivo.md) |
| 🤖 **GitHub Actions CI/CD** | Cómo se prueba tu código automáticamente en la nube ante cada `git push` | [Abrir Guía](tutoriales/02-como-funciona-github-actions-ci.md) |
| 📊 **Diagramas Mermaid** | Cómo renderizar y modificar esquemas entidad-relación interactivos en GitHub | [Abrir Guía](tutoriales/03-como-usar-los-diagramas-mermaid.md) |
| 📑 **Cheat Sheet de Bolsillo** | Cómo consultar y exportar a PDF la guía condensada de sintaxis SQL | [Abrir Guía](tutoriales/04-como-usar-el-cheat-sheet-de-bolsillo.md) |

---

## 🚫 Los 5 Antipatrones del Principiante (Y Cómo Evitarlos)

<details>
<summary><b>⚠️ Desplegar tabla de buenas prácticas para producción</b></summary>
<br/>

| Error Común | Por qué es destructivo | La Solución Profesional |
| :--- | :--- | :--- |
| **Abusar de `SELECT *`** | Transfiere columnas innecesarias por la red, satura memoria y anula *Covering Indexes*. | Proyecta exclusivamente las columnas requeridas: `SELECT id, total FROM pedidos;` |
| **Comparar con `col = NULL`** | En lógica trivalente de SQL (`TRUE`, `FALSE`, `UNKNOWN`), `NULL = NULL` es `UNKNOWN` (falso). | Usa siempre la sintaxis formal: `WHERE col IS NULL` o `WHERE col IS NOT NULL`. |
| **Aplicar funciones en el `WHERE`** | `WHERE YEAR(fecha) = 2024` obliga a escanear toda la tabla fila por fila (*Full Table Scan*). | Haz la consulta SARGable: `WHERE fecha >= '2024-01-01' AND fecha < '2025-01-01'`. |
| **Usar `HAVING` en vez de `WHERE`** | `HAVING` procesa datos después de agrupar; filtrar tarde quema CPU y memoria RAM. | Usa `WHERE` para descartar filas individuales antes del `GROUP BY`. Reserva `HAVING` para agregaciones (`SUM`, `COUNT`). |
| **Confundir `UNION` con `UNION ALL`** | `UNION` ejecuta un paso oculto de deduplicación que sobrecarga el motor con tablas temporales. | Si sabes que los conjuntos no se solapan o no te molestan duplicados, usa siempre `UNION ALL`. |

</details>

---

## 📊 Arquitectura del Repositorio

```text
sql-mysql-bootcamp/
├── 🐳 docker-compose.yml             # MySQL 8.0 preconfigurado con utf8mb4 y volúmenes
├── 🧪 scripts/
│   └── test_runner.py                # Validador automático interactivo con auto-init
├── 🤖 .github/workflows/
│   └── sql-ci.yml                    # Pipeline de CI con GitHub Actions
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

<div align="center">

### ⭐ ¿Te resulta útil este Bootcamp?
¡Dale una estrella a este repositorio en GitHub para apoyar su desarrollo y ayudar a otros profesionales a dominar SQL!

Distributed under the **MIT License**.

</div>
