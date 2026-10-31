# Módulo 0: Configuración del Entorno y Conceptos Base

## 0.1 Arquitectura Básica de Datos
- **RDBMS (Relational Database Management System)**: Sistema gestor basado en el modelo relacional de E.F. Codd, donde los datos se estructuran en tablas bidimensionales (filas y columnas) con relaciones matemáticas e integridad referencial.
- **Modelo Cliente-Servidor**:
  - **Servidor (`mysqld`)**: Proceso demonio que administra el almacenamiento, memoria compartida (Buffer Pool), concurrencia, transacciones y ejecución de planes.
  - **Cliente (`mysql` CLI, Workbench, DBeaver, Drivers JDBC/ODBC)**: Aplicaciones que envían instrucciones SQL a través de TCP/IP (puerto predeterminado `3306`) o sockets UNIX/Named Pipes.
- **Motores de Almacenamiento (Storage Engines)**:
  - **InnoDB** (Predeterminado desde MySQL 5.5): Transaccional, compatible con ACID, bloqueo a nivel de fila (Row-Level Locking), soporte de Claves Foráneas (Foreign Keys), crash recovery con redo/undo logs.
  - **MyISAM**: No transaccional, sin claves foráneas, bloqueo a nivel de tabla completa (Table-level lock). Recomendado solo para lectura masiva estática muy legacy.
  - **MEMORY**: Almacenamiento puramente en RAM para tablas volátiles o intermedias ultrarrápidas.

## 0.2 Herramientas de Trabajo
- **MySQL CLI**: Conexión estándar rápida: `mysql -h localhost -P 3306 -u root -p`.
- **DBeaver Community / MySQL Workbench**: GUIs recomendadas para modelado visual, inspección de catálogos y profiling de consultas.

## 0.3 Contenedores para Pruebas Rápidas (Docker)
```bash
docker run -d --name mysql-bootcamp \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=bootcamp_sandbox \
  -p 3306:3306 \
  -v mysql_bootcamp_data:/var/lib/mysql \
  mysql:8.0
```

## 0.4 Estructura de un Script SQL y Convenciones
- **Comentarios**:
  - Línea simple: `-- Comentario` o `# Comentario`
  - Multilínea: `/* Comentario en bloque */`
- **Delimitadores**: `;` estándar. En procedimientos almacenados o triggers se redefine con `DELIMITER //` para evitar que MySQL corte el código antes del `END`.
- **Nomenclatura recomendada**:
  - Esquemas, tablas y columnas en `snake_case` minúsculo (ej. `detalle_pedidos`, `fecha_nacimiento`).
  - Palabras reservadas de SQL en MAYÚSCULAS (`SELECT`, `WHERE`, `JOIN`).
  - Tablas en plural o singular consistente (`clientes`, `pedidos` o `cliente`, `pedido`). En este bootcamp usamos plural.
