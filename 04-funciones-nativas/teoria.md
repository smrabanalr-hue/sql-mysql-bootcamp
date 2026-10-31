# Módulo 4: Funciones Nativas y Manipulación de Atributos

## 4.1 Manejo de Cadenas de Texto
- `CONCAT(str1, str2, ...)` y `CONCAT_WS(separador, s1, s2, ...)`: Concatena ignorando nulos en WS.
- `SUBSTRING(cadena, pos, len)`: Extrae fragmentos (1-based index).
- `TRIM()`, `LTRIM()`, `RTRIM()`: Limpia espacios en blanco.
- `REPLACE(texto, origen, destino)`: Sustituye subcadenas.
- `UPPER(str)`, `LOWER(str)`: Conversión de caja.
- `LENGTH(str)` (bytes) vs `CHAR_LENGTH(str)` (número de caracteres en utf8mb4).

## 4.2 Fechas y Horas
- `NOW()`, `CURRENT_TIMESTAMP`: Fecha y hora actual del sistema.
- `CURDATE()`: Solo fecha ('YYYY-MM-DD').
- `DATEDIFF(fecha1, fecha2)`: Diferencia en días entre fecha1 y fecha2.
- `DATE_ADD(fecha, INTERVAL n UNIDAD)`, `DATE_SUB(...)`: Suma/resta días, meses o años.
- `DATE_FORMAT(fecha, '%Y-%m-%d %H:%i')`: Formateo personalizado.
- Extracción de componentes: `YEAR()`, `MONTH()`, `DAY()`, `QUARTER()`, `DAYOFWEEK()`.

## 4.3 Matemáticas y Redondeo
- `ROUND(x, d)`: Redondeo aritmético estándar a `d` decimales.
- `TRUNCATE(x, d)`: Corta sin redondear.
- `FLOOR(x)` (entero menor), `CEIL(x)` (entero mayor).
- `ABS(x)` (valor absoluto), `MOD(n, d)` (residuo de división).

## 4.4 Lógica Condicional en Consultas
- **CASE WHEN**:
  ```sql
  CASE 
    WHEN condicion1 THEN resultado1
    WHEN condicion2 THEN resultado2
    ELSE valor_por_defecto
  END
  ```
- `IF(condicion, valor_si_verdadero, valor_si_falso)`.
- `COALESCE(val1, val2, val3)`: Retorna el primer valor no nulo de la lista.
- `IFNULL(expresion, reemplazo)`: Reemplazo si es NULL.
