# Dataset: Tienda Retail

Base de datos simulada de una cadena de comercio electrónico y tiendas físicas.

## Diagrama Entidad-Relación (ER)
```
categorias (1) <--- (N) productos (1) <--- (N) detalle_pedidos (N) ---> (1) pedidos (N) ---> (1) clientes
```

## Importación Rápida
```bash
mysql -u root -p < 01_schema.sql
mysql -u root -p tienda_retail < 02_data.sql
```
