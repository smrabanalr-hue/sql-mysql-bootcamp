# 🧪 Tutorial Interactivo: Cómo Usar el Validador Automático de Retos

El **Test Runner** es tu evaluador personal de consultas SQL. Te permite comprobar al instante si tus soluciones resuelven los retos de negocio y si tu sintaxis es 100% válida en MySQL 8.0+.

---

## 🚀 Paso a Paso: Tu Primer Test en 3 Minutos

### 1. Asegúrate de tener el laboratorio activo
En tu terminal:
```bash
docker compose up -d
```

### 2. Abre el archivo de ejercicios
Por ejemplo, navega a `03-consultas-dql/ejercicios.sql` y lee el Reto 3.1:
> *"Encontrar todos los clientes que vivan en Lima o Arequipa, cuyo apellido no contenga la letra z..."*

### 3. Escribe tu consulta
Prueba tu lógica en tu cliente favorito (DBeaver, VS Code o terminal).

### 4. Ejecuta el Validador desde tu terminal
```bash
# Validar únicamente el módulo 03
python scripts/test_runner.py --modulo 03
```

### 5. ¿Qué verás en tu pantalla?
Si todo está correcto, el runner te felicitará con salida en verde:
```text
══════════════════════════════════════════════════════════════════════
Evaluando Módulo: 03-consultas-dql
══════════════════════════════════════════════════════════════════════
  ✔ [PASS] Reto 01 ejecutado correctamente. (3 filas retornadas)
  ✔ [PASS] Reto 02 ejecutado correctamente. (2 filas retornadas)
  ✔ [PASS] Reto 03 ejecutado correctamente. (3 filas retornadas)

══════════════════════════════════════════════════════════════════════
🎉 ¡TODOS LOS TESTS PASARON EXITOSAMENTE! EXCELENTE TRABAJO.
```

---

## 🔍 Modo Inspección Detallada (`--verbose`)
Si quieres ver la tabla completa con los datos exactos que devolvió MySQL:
```bash
python scripts/test_runner.py --modulo 03 --verbose
```

---

## 🛠️ ¿Qué pasa si una consulta falla? (Debugging en Vivo)
El validador atrapará el error de MySQL y te dirá exactamente la causa:
```text
  ✘ [FAIL] Reto 02: Error al ejecutar:
      SELECT * FROM productos WHERE categorias_id = 1...
      Detalle de MySQL: ERROR 1054 (42S22): Unknown column 'categorias_id' in 'where clause'
```
*💡 Tip: Corriges el nombre de la columna a `categoria_id`, guardas y vuelves a correr el runner.*
