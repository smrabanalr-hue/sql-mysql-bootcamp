# 📦 Dataset: Operaciones y Logística (Gestión Multi-Almacén y Kardex)

Base de datos orientada al control físico y contable de inventarios multi-almacén, despachos por flota y movimientos de Kardex en tiempo real.

---

## 📊 Diagrama Entidad-Relación Interactivo (Mermaid)

```mermaid
erDiagram
    ALMACENES ||--o{ STOCK_ALMACEN : "almacena (1:N)"
    ARTICULOS ||--o{ STOCK_ALMACEN : "registrado_en (1:N)"
    ALMACENES ||--o{ KARDEX_MOVIMIENTOS : "ocurre_en (1:N)"
    ARTICULOS ||--o{ KARDEX_MOVIMIENTOS : "afecta_a (1:N)"
    ALMACENES ||--o{ ENVIOS : "despacha_desde (1:N)"
    TRANSPORTISTAS ||--o{ ENVIOS : "transporta (1:N)"

    ALMACENES {
        int almacen_id PK
        string codigo UK
        string nombre
        string ciudad
        decimal capacidad_m3
    }

    ARTICULOS {
        int articulo_id PK
        string codigo_sku UK
        string descripcion
        decimal costo_promedio
        int punto_reorden
        int stock_minimo
    }

    STOCK_ALMACEN {
        int almacen_id PK,FK
        int articulo_id PK,FK
        int cantidad_disponible
        int cantidad_reservada
    }

    KARDEX_MOVIMIENTOS {
        bigint movimiento_id PK
        datetime fecha_hora
        string tipo_movimiento
        int almacen_id FK
        int articulo_id FK
        int cantidad
        decimal costo_unitario
        int saldo_nuevo_cantidad
    }

    TRANSPORTISTAS {
        int transportista_id PK
        string ruc UK
        string razon_social
        string tipo_flota
    }

    ENVIOS {
        int envio_id PK
        string guia_remision UK
        int almacen_origen_id FK
        int transportista_id FK
        datetime fecha_despacho
        datetime fecha_entrega_estimada
        datetime fecha_entrega_real
        string estado
    }
```

---

## ⚡ Importación Rápida
```bash
mysql -u root -proot < 01_schema.sql
mysql -u root -proot operaciones_logistica < 02_data.sql
```
