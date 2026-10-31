# Módulo 2: DML Básico y Manipulación de Datos

## 2.1 Inserción de Registros (INSERT)
- **Insert simple**:
  `INSERT INTO tabla (col1, col2) VALUES (val1, val2);`
- **Insert masivo (Bulk insert)**:
  `INSERT INTO tabla (col1, col2) VALUES (v1, v2), (v3, v4), (v5, v6);`
  *Rendimiento:* Agrupar inserciones en un solo query reduce drasticamente los `fsync` en el log de InnoDB.
- **Insert desde SELECT**:
  `INSERT INTO historico_pedidos (id, monto) SELECT id, monto FROM pedidos WHERE estado = 'Entregado';`

## 2.2 Actualización y Borrado Seguro (UPDATE, DELETE)
- **Modo Seguro (`SQL_SAFE_UPDATES = 1`)**:
  MySQL bloquea actualizaciones o borrados que no incluyan una cláusula `WHERE` referenciando una columna clave (KEY / Primary Key).
  ```sql
  SET SQL_SAFE_UPDATES = 1; -- Activar protección contra borrados accidentales
  UPDATE clientes SET saldo = 0; -- FALLA por no tener WHERE con clave
  ```
- **DELETE vs TRUNCATE**:
  `DELETE FROM tabla WHERE condicion;` registra cada fila eliminada en el undo log y activa triggers. `TRUNCATE` no.

## 2.3 Upserts en MySQL
- **INSERT ... ON DUPLICATE KEY UPDATE**:
  Si la fila genera colisión en la Primary Key o Unique Key, actualiza los campos indicados en lugar de lanzar error.
  ```sql
  INSERT INTO inventario (producto_id, stock)
  VALUES (101, 10)
  ON DUPLICATE KEY UPDATE stock = stock + VALUES(stock);
  ```
- **REPLACE INTO**:
  Elimina físicamente la fila existente y luego inserta la nueva. Provoca aumento innecesario de IDs autoincrementales y recreación de índices. Se prefiere `ON DUPLICATE KEY UPDATE`.

## 2.4 Carga Masiva (LOAD DATA INFILE)
- Importación directa de alta velocidad (hasta 20x más rápida que múltiples INSERTs):
  ```sql
  LOAD DATA INFILE '/var/lib/mysql-files/datos.csv'
  INTO TABLE clientes
  FIELDS TERMINATED BY ',' ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS;
  ```
