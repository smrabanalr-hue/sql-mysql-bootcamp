# Módulo 9: Objetos Programables en Base de Datos

## 9.1 Vistas (Views)
- Tablas virtuales basadas en un `SELECT`. Simplifican reportes, ocultan columnas sensibles y garantizan coherencia lógica.
- `WITH CHECK OPTION`: Previene inserciones o modificaciones a través de la vista que violen la cláusula `WHERE` de su definición.

## 9.2 Variables en MySQL
- **Variables de Usuario (`@mi_var`)**: Débilmente tipadas, alcance de toda la sesión de conexión.
- **Variables Locales (`DECLARE var_name INT DEFAULT 0`)**: Fuertemente tipadas, solo existen dentro de bloques `BEGIN ... END` de procedimientos, funciones o triggers.

## 9.3 Procedimientos Almacenados (Stored Procedures)
- Compilados en el servidor. Admiten parámetros:
  - `IN`: Entrada de valor.
  - `OUT`: Retorno de valor hacia el llamador.
  - `INOUT`: Modificación de una variable pasada como referencia.
- Control de flujo: `IF ... ELSEIF ... END IF`, `CASE`, bucles `WHILE` y manejo de cursores (`DECLARE CONTINUE HANDLER FOR NOT FOUND`).

## 9.4 Funciones Definidas por el Usuario (UDF)
- Retornan siempre un valor escalar (`RETURNS tipo`).
- Deben declararse como `DETERMINISTIC` (siempre da el mismo resultado ante los mismos argumentos) o `NOT DETERMINISTIC` (lee datos mutables o usa `NOW()`), `READS SQL DATA`.

## 9.5 Triggers (Disparadores)
- Se ejecutan automáticamente ante eventos DML: `BEFORE` o `AFTER` de `INSERT`, `UPDATE`, `DELETE`.
- Pseudo-registros:
  - `NEW`: Representa los valores entrantes (`INSERT`, `UPDATE`).
  - `OLD`: Representa los valores previos (`UPDATE`, `DELETE`).

## 9.6 Event Scheduler (Eventos Programados)
- Cron interno de MySQL (`SET GLOBAL event_scheduler = ON`).
- Ejecuta tareas recurrentes (`EVERY 1 DAY`, `EVERY 1 HOUR`).
