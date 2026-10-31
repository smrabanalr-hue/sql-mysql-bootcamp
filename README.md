# 🚀 SQL & MySQL Professional Bootcamp

Repositorio exhaustivo de formación práctica y teórica en bases de datos relacionales, lenguaje SQL y administración con **MySQL 8.0+**, enfocado en escenarios de analítica de negocio (BI) y operaciones logísticas de alta concurrencia.

---

## 📁 Estructura del Repositorio

```text
sql-mysql-bootcamp/
├── docker-compose.yml             # Despliegue de MySQL 8.0 preconfigurado
├── datasets/                      # Esquemas y datos de prueba reales (.sql y .csv)
│   ├── tienda_retail/             # Retail, e-commerce, clientes y pedidos
│   └── operaciones_logistica/     # Kardex, almacenes y transportistas
├── 00-configuracion-entorno/      # Arquitectura InnoDB, CLI, Docker y sintaxis
├── 01-fundamentos-ddl/            # Modelo ER, Schemas, Tipos de datos, Constraints
├── 02-dml-manipulacion/           # INSERT, UPDATE, DELETE seguro, Upserts
├── 03-consultas-dql/              # SELECT, WHERE, LIKE, REGEXP, paginación
├── 04-funciones-nativas/          # String, Fechas/Horas, Matemáticas, CASE/IF
├── 05-agregacion-agrupamiento/    # COUNT, SUM, GROUP BY, WHERE vs HAVING, ROLLUP
├── 06-joins-relaciones/           # INNER, LEFT, RIGHT, CROSS, Full Outer, Self Joins
├── 07-subconsultas-ctes/          # Subconsultas escalares, correlacionadas, CTEs recursivas
├── 08-funciones-ventana/          # OVER(), PARTITION BY, RANK, LAG/LEAD, Acumulados
├── 09-objetos-programables/       # Views, Variables, Procedures, UDFs, Triggers
├── 10-transacciones-concurrencia/ # Principios ACID, Bloqueos, Niveles de aislamiento
├── 11-optimizacion-indexacion/    # EXPLAIN, EXPLAIN ANALYZE, B-Trees, Antipatrones
└── proyectos-finales/
    ├── 01-analitica-retail/       # Cohortes, Churn, Matriz RFM y YoY/MoM
    └── 02-control-inventarios/    # Kardex con Triggers y gestión OTD de flota
```

Cada módulo contiene:
- `teoria.md`: Fundamentos concisos, sintaxis clave y advertencias comunes.
- `queries.sql`: Scripts interactivos comentados y listos para ejecutar.
- `ejercicios.sql`: Retos con enunciados de negocio reales.
- `soluciones.sql`: Soluciones completas explicadas.

---

## ⚡ Inicio Rápido con Docker

Para levantar el servidor MySQL 8.0 localmente sin instalar dependencias:

```bash
# 1. Levantar el contenedor
docker compose up -d

# 2. Conectarse vía CLI interactiva
docker compose exec mysql-bootcamp mysql -u root -proot

# 3. Cargar el dataset de retail
docker compose exec mysql-bootcamp mysql -u root -proot -e "source /datasets/tienda_retail/01_schema.sql;"
docker compose exec mysql-bootcamp mysql -u root -proot -e "source /datasets/tienda_retail/02_data.sql;"
```

---

## 🗺️ Mapa de Contenidos

| Módulo | Tema Principal | Competencia Clave |
| :--- | :--- | :--- |
| **00** | Configuración del Entorno | Arquitectura InnoDB vs MyISAM, Docker, CLI |
| **01** | Modelado Relacional & DDL | Claves primarias, foráneas, constraints, ALTER |
| **02** | DML & Manipulación | Bulk inserts, safe updates, ON DUPLICATE KEY |
| **03** | Consultas Esenciales (DQL) | Filtros compuestos, comodines, paginación |
| **04** | Funciones Nativas | Fechas (`DATEDIFF`), Strings, condicionales `CASE` |
| **05** | Agregación y Métricas | `GROUP BY`, diferencia estricta `WHERE` vs `HAVING` |
| **06** | Joins y Relaciones | Uniones multitabla, anti-joins, simulación Full Join |
| **07** | Subconsultas y CTEs | CTEs analíticas y recursivas para grafos/calendarios |
| **08** | Funciones de Ventana | `ROW_NUMBER`, `RANK`, `LAG`/`LEAD`, marcos móviles |
| **09** | Objetos Programables | Stored Procedures, UDFs, Triggers de auditoría |
| **10** | Transacciones & Concurrencia | ACID, aislamiento, `SELECT ... FOR UPDATE` |
| **11** | Optimización & Rendimiento | Lectura de `EXPLAIN ANALYZE`, indexación B-Tree |
| **Final** | Proyectos Integradores | BI (RFM, Cohortes) y Logística (Kardex Trigger) |

---

## 👨‍💻 Autor
Bootcamp estructurado para el dominio integral de bases de datos relacionales en entornos analíticos y transaccionales modernos.
