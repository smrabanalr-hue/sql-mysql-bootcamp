# Módulo 1: Modelado Relacional y DDL (Data Definition Language)

## 1.1 Modelo Entidad-Relación (ER)
- **Entidades**: Objetos del dominio de negocio (Cliente, Pedido, Factura).
- **Relaciones**:
  - **1:1 (Uno a Uno)**: Clave primaria compartida o UNIQUE Foreign Key (ej. Usuario - Perfil).
  - **1:N (Uno a Muchos)**: La clave primaria de la tabla fuerte pasa como Clave Foránea a la tabla dependiente (ej. Cliente -> Pedidos).
  - **N:M (Muchos a Muchos)**: Requiere una **tabla intermedia (tabla puente)** con claves compuestas o clave propia y dos FKs (ej. Pedido -> DetallePedido <- Producto).

## 1.2 Gestión de Esquemas y Collation
```sql
CREATE DATABASE IF NOT EXISTS empresa_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
```
- **utf8mb4**: Soporte completo de 4 bytes por caracter (incluye emojis y alfabetos extendidos).
- **Collation `_ci` vs `_bin` / `_cs`**: Case-Insensitive (no diferencia mayúsculas de minúsculas) vs Case-Sensitive o binario exacto.

## 1.3 Tipos de Datos Fundamentales
- **Numéricos**:
  - `TINYINT` (1 byte, -128 a 127 o 0-255 con UNSIGNED), `INT` (4 bytes), `BIGINT` (8 bytes).
  - `DECIMAL(p,s)`: Precisión fija exacta (10 dígitos en total, 2 decimales). **Obligatorio para dinero/finanzas**.
  - `FLOAT` / `DOUBLE`: Coma flotante de precisión inexacta (IEEE 754), útil para física/sensores, jamás para saldo monetario.
- **Cadenas**:
  - `CHAR(n)`: Longitud fija, rellena con espacios. Ideal para códigos ISO ('PE', 'USD'), hashes MD5/SHA.
  - `VARCHAR(n)`: Longitud variable (ahorra espacio). Máx 65,535 bytes por fila.
  - `TEXT` / `LONGTEXT`: Cadenas largas almacenadas fuera de página (off-page).
- **Fechas**:
  - `DATE`: 'YYYY-MM-DD'.
  - `DATETIME`: 'YYYY-MM-DD HH:MM:SS' (Rango 1000 a 9999, no cambia con zona horaria del servidor).
  - `TIMESTAMP`: Representación de segundos epoch UTC (Rango 1970 a 2038). Se convierte a la zona horaria de la sesión.

## 1.4 Restricciones de Integridad (Constraints)
- `PRIMARY KEY`: Identificador único y no nulo. Clustered index en InnoDB.
- `FOREIGN KEY`: Asegura integridad referencial. Reglas: `ON DELETE CASCADE`, `RESTRICT`, `SET NULL`.
- `UNIQUE`: Evita duplicados permitiendo nulos.
- `CHECK`: Valida expresiones booleanas lógicas (MySQL 8.0+ valida activamente `CHECK`).
- `DEFAULT`: Asigna un valor predeterminado si no se provee en el INSERT.

## 1.5 Modificaciones de Estructuras (ALTER TABLE)
- `ALTER TABLE tabla ADD COLUMN ...`
- `ALTER TABLE tabla DROP COLUMN ...`
- `ALTER TABLE tabla MODIFY COLUMN ...` (cambia tipo)
- `ALTER TABLE tabla CHANGE COLUMN viejo_nombre nuevo_nombre ...`
- **TRUNCATE TABLE vs DROP TABLE**:
  - `TRUNCATE`: DDL rápido, vacía la tabla recreándola por debajo, resetea el `AUTO_INCREMENT`, no dispara triggers DELETE.
  - `DROP`: Elimina tanto los datos como la definición de la tabla y sus dependencias del catálogo.
