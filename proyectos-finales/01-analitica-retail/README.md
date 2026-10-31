# 📊 Proyecto Final 1: Analítica de Negocio y Business Intelligence (Retail)

## 📌 Contexto del Negocio
Una compañía minorista omnicanal requiere implementar una capa analítica para la toma de decisiones basada en el comportamiento del consumidor y la rentabilidad por canal de venta.

---

## 🔄 Flujo Analítico del Proyecto (Mermaid)

```mermaid
flowchart TD
    A[Datos Transaccionales de Pedidos] --> B[Segmentación RFM]
    A --> C[Análisis de Cohortes]
    A --> D[Crecimiento MoM & YoY]

    B --> B1[NTILE Cuantiles Recencia / Frecuencia / Monto]
    B1 --> B2[Clientes Campeones vs En Riesgo de Churn]

    C --> C1[Mes de Primera Compra]
    C1 --> C2[Tasa de Retención Mes a Mes]

    D --> D1[LAG Funciones de Ventana]
    D1 --> D2[Delta de Ventas y % Crecimiento]
```

---

## 🎯 Objetivos de Negocio
1. **Análisis de Cohortes**: Medir la retención de clientes según el mes de adquisición.
2. **Segmentación RFM (Recency, Frequency, Monetary)**: Clasificación de clientes mediante cuantiles (`NTILE(4)`).
3. **Métricas Temporales**: Variaciones Mes contra Mes (**MoM**) con `LAG()`.
4. **Análisis de Márgenes**: Detección del canal más rentable (Web vs App Móvil vs Tienda Física).

## 🗂️ Scripts Disponibles
- `queries.sql`: Solución guiada paso a paso comentada.
- `ejercicios.sql`: Retos analíticos adicionales con casos de prueba.
- `soluciones.sql`: Soluciones completas para auto-evaluación.
