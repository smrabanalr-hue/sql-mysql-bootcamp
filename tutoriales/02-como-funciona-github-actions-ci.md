# 🤖 Tutorial: Cómo Funciona el Pipeline de Integración Continua (CI/CD)

En el mundo laboral moderno, el código SQL no se sube a ciegas. Se valida mediante tuberías de integración continua (**CI**).

---

## ⚙️ ¿Cómo opera el workflow `.github/workflows/sql-ci.yml`?

Cada vez que haces un `git push` a tu repositorio en GitHub:
1. **GitHub enciende una máquina virtual Ubuntu en la nube**.
2. **Levanta un contenedor oficial de MySQL 8.0** de forma aislada.
3. **Carga los esquemas y datos de prueba** (`datasets/tienda_retail` y `datasets/operaciones_logistica`).
4. **Ejecuta el script `test_runner.py --all --ci`**.
5. Si todas las consultas son válidas, te otorga el **check verde** `✔ passing`. Si alguna consulta rompe o tiene un error de sintaxis, marca `✘ failing`.

---

## 🛡️ Cómo activar la Insignia Verde (Badge) en tu propio GitHub

1. Reemplaza en el `README.md` la URL de la badge con tu usuario:
```markdown
[![SQL Validation](https://github.com/TU_USUARIO/TU_REPOSITORIO/actions/workflows/sql-ci.yml/badge.svg)](https://github.com/TU_USUARIO/TU_REPOSITORIO/actions)
```
2. Haz `git push origin main`.
3. Visita la pestaña **Actions** en tu repositorio de GitHub para ver la ejecución en tiempo real con terminal y logs paso a paso.
