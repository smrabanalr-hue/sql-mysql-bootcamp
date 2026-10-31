# Módulo 10: Transacciones y Concurrencia

## 10.1 Cuadro Comparativo: Niveles de Aislamiento y Anomalías

| Nivel de Aislamiento | Lectura Sucia (*Dirty Read*) | Lectura No Repetible (*Non-repeatable*) | Lectura Fantasma (*Phantom Read*) | Rendimiento |
| :--- | :---: | :---: | :---: | :--- |
| **READ UNCOMMITTED** | ⚠️ Sí | ⚠️ Sí | ⚠️ Sí | 🚀 Máximo (Poco seguro) |
| **READ COMMITTED** | 🛡️ No | ⚠️ Sí | ⚠️ Sí | ⚡ Rápido |
| **REPEATABLE READ** (Default InnoDB) | 🛡️ No | 🛡️ No | 🛡️ No (MVCC + Next-Key Lock) | ⚖️ Balanceado |
| **SERIALIZABLE** | 🛡️ No | 🛡️ No | 🛡️ No | 🐢 Lento (Bloqueo masivo) |

---

## 10.2 Cuadro Comparativo: Tipos de Bloqueo Pesimista

| Sintaxis | Nombre | Compatibilidad | Caso de Uso |
| :--- | :--- | :--- | :--- |
| `SELECT ... FOR UPDATE` | Bloqueo Exclusivo (**X-Lock**) | Nadie más puede leer con bloqueo ni escribir. | Reserva de saldo o stock crítico antes de descontar. |
| `SELECT ... FOR SHARE` | Bloqueo Compartido (**S-Lock**) | Otros pueden leer con S-Lock, pero nadie puede modificar. | Validar que un cliente o contrato no cambie mientras genero factura. |
