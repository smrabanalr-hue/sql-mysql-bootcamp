# Módulo 10: Transacciones y Concurrencia

## 10.1 Principios ACID
- **Atomicidad (Atomicity)**: O todas las operaciones de la transacción se aplican exitosamente, o ninguna surte efecto.
- **Consistencia (Consistency)**: La base de datos pasa de un estado válido a otro, respetando constraints y reglas de negocio.
- **Aislamiento (Isolation)**: Las transacciones concurrentes no interfieren ni ven estados corruptos o a medio guardar de otras transacciones.
- **Durabilidad (Durability)**: Una vez hecho el COMMIT, los cambios persisten ante caídas de energía o fallos del OS (garantizado por el Redo Log de InnoDB).

## 10.2 Control Transaccional
- `START TRANSACTION` (o `BEGIN`): Inicia el bloque transaccional desactivando el `autocommit` implícito.
- `COMMIT`: Hace permanentes todas las modificaciones.
- `ROLLBACK`: Revierte todas las modificaciones desde el inicio de la transacción.
- `SAVEPOINT nombre_punto`: Guarda un estado intermedio al cual revertir con `ROLLBACK TO SAVEPOINT`.

## 10.3 Niveles de Aislamiento en InnoDB
1. **READ UNCOMMITTED**: Permite lecturas sucias (*Dirty Reads*). Una transacción ve cambios no confirmados de otra.
2. **READ COMMITTED**: Evita lecturas sucias. Permite lecturas no repetibles (*Non-repeatable reads*).
3. **REPEATABLE READ** (Predeterminado de MySQL InnoDB): Utiliza MVCC (Multi-Version Concurrency Control). Si lees una fila dos veces en la misma transacción, verás exactamente los mismos datos.
4. **SERIALIZABLE**: Máximo aislamiento; fuerza bloqueos compartidos en todas las lecturas.

## 10.4 Manejo de Bloqueos y Deadlocks
- `SELECT ... FOR UPDATE`: Bloqueo exclusivo de fila (X-Lock). Otras transacciones no pueden modificarla ni bloquearla hasta el commit.
- `SELECT ... FOR SHARE` (antes `LOCK IN SHARE MODE`): Bloqueo compartido de lectura (S-Lock).
- **Deadlocks**: Situación donde Tx1 espera recurso bloqueado por Tx2, y Tx2 espera recurso bloqueado por Tx1. El motor InnoDB detecta el ciclo y aborta la transacción con menor costo (*deadlock victim*).
