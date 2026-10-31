# Dataset: Operaciones y Logística

Base de datos orientada al control de stock multi-almacén, kardex y despacho de transporte.

## Diagrama Entidad-Relación (ER)
```
almacenes (1) <--- (N) stock_almacen (N) ---> (1) articulos
almacenes (1) <--- (N) kardex_movimientos (N) ---> (1) articulos
almacenes (1) <--- (N) envios (N) ---> (1) transportistas
```

## Importación Rápida
```bash
mysql -u root -p < 01_schema.sql
mysql -u root -p operaciones_logistica < 02_data.sql
```
