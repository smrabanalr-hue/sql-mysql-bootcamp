# Proyecto Final 1: Analítica de Negocio y Business Intelligence (Retail)

## 📌 Contexto del Negocio
Una compañía de comercio minorista omnicanal (Web, Móvil, Físico) necesita modernizar su capa analítica para tomar decisiones estratégicas basadas en el comportamiento real de sus clientes y la rentabilidad de sus líneas de producto.

## 🎯 Objetivos Analíticos
1. **Análisis de Cohortes**: Medir la retención de clientes agrupados por el mes en que realizaron su primera compra.
2. **Segmentación RFM (Recency, Frequency, Monetary)**: Clasificar clientes usando cuantiles (`NTILE`) para identificar clientes Campeones, En Riesgo y Perdidos.
3. **Métricas de Crecimiento Temporal**:
   - Ventas Mes contra Mes (**MoM**) y Año contra Año (**YoY**) usando `LAG()`.
   - Ticket Promedio (AOV - Average Order Value).
4. **Análisis de Abandono (Churn Rate)**: Detectar clientes inactivos por más de 90 días.

## 🗂️ Estructura de Scripts
- `analitica_queries.sql`: Consultas analíticas completas comentadas paso a paso.
- `ejercicios.sql`: Retos analíticos adicionales para evaluación.
- `soluciones.sql`: Soluciones comentadas.
