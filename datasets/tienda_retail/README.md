# 🛒 Dataset: Tienda Retail (E-Commerce & Omnicanal)

Base de datos simulada de una cadena de comercio minorista omnicanal (Web, Móvil, Físico) con transacciones, clientes y detalle de facturación.

---

## 📊 Diagrama Entidad-Relación Interactivo (Mermaid)

```mermaid
erDiagram
    CATEGORIAS ||--o{ PRODUCTOS : "clasifica (1:N)"
    CLIENTES ||--o{ PEDIDOS : "realiza (1:N)"
    PEDIDOS ||--|{ DETALLE_PEDIDOS : "contiene (1:N)"
    PRODUCTOS ||--o{ DETALLE_PEDIDOS : "se vende en (1:N)"

    CATEGORIAS {
        int categoria_id PK
        string nombre UK
        text descripcion
        boolean activo
    }

    CLIENTES {
        int cliente_id PK
        string nombre
        string apellido
        string email UK
        string ciudad
        date fecha_registro
        string segmento
    }

    PRODUCTOS {
        int producto_id PK
        string sku UK
        string nombre
        int categoria_id FK
        decimal precio
        decimal costo
        int stock_actual
    }

    PEDIDOS {
        int pedido_id PK
        string codigo_pedido UK
        int cliente_id FK
        datetime fecha_pedido
        string estado
        string canal_venta
        decimal total_neto
    }

    DETALLE_PEDIDOS {
        int detalle_id PK
        int pedido_id FK
        int producto_id FK
        int cantidad
        decimal precio_unitario
        decimal subtotal
    }
```

---

## ⚡ Importación Rápida
```bash
# Vía CLI directa
mysql -u root -proot < 01_schema.sql
mysql -u root -proot tienda_retail < 02_data.sql

# O mediante Docker
docker compose exec mysql-bootcamp mysql -u root -proot -e "source /datasets/tienda_retail/01_schema.sql;"
docker compose exec mysql-bootcamp mysql -u root -proot -e "source /datasets/tienda_retail/02_data.sql;"
```
