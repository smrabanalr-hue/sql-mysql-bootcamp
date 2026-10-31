# Proyecto Final 2: Control de Inventarios con Kardex Automatizado

## 📌 Contexto de la Operación
Una empresa de logística centralizada requiere garantizar que el inventario disponible en cada almacén coincida exactamente con la sumatoria histórica de sus movimientos contables y físicos (Kardex), erradicando inconsistencias mediante triggers de base de datos y procedimientos transaccionales.

## 🎯 Componentes Técnicos
1. **Triggers de Integridad de Stock**: Actualización instantánea de `stock_almacen` ante cualquier inserción en `kardex_movimientos`.
2. **Control de Stock Mínimo y Punto de Reorden**: Alertas automáticas cuando el inventario cruza umbrales críticos.
3. **Procedimiento Almacenado de Despacho Seguro**: Bloqueo pesimista `SELECT ... FOR UPDATE` para evitar sobreventa concurrente.
4. **Cálculo de Tiempos de Entrega (OTD - On-Time Delivery)**: Comparación analítica entre fecha estimada vs real de entrega por transportista.
