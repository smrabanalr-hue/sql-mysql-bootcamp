#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
==============================================================================
SQL Bootcamp - Validador Automático Interactivo (Test Runner)
==============================================================================
Evalúa las consultas escritas por el alumno en 'ejercicios.sql' y las compara
contra los resultados esperados de 'soluciones.sql' en MySQL 8.0+.
Garantiza codificación pura utf8mb4 para acentos y caracteres especiales.

Uso:
    python scripts/test_runner.py --modulo 03
    python scripts/test_runner.py --modulo 03 --verbose
    python scripts/test_runner.py --init-db     # Recarga los datasets en UTF-8 limpio
    python scripts/test_runner.py --all
"""

import argparse
import os
import re
import subprocess
import sys

# Forzar salida de consola en UTF-8 en Windows
if sys.platform == "win32":
    try:
        sys.stdout.reconfigure(encoding="utf-8")
        sys.stderr.reconfigure(encoding="utf-8")
    except Exception:
        pass

GREEN = "\033[92m"
RED = "\033[91m"
YELLOW = "\033[93m"
CYAN = "\033[96m"
BOLD = "\033[1m"
RESET = "\033[0m"

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

MODULES = [
    "00-configuracion-entorno",
    "01-fundamentos-ddl",
    "02-dml-manipulacion",
    "03-consultas-dql",
    "04-funciones-nativas",
    "05-agregacion-agrupamiento",
    "06-joins-relaciones",
    "07-subconsultas-ctes",
    "08-funciones-ventana",
    "09-objetos-programables",
    "10-transacciones-concurrencia",
    "11-optimizacion-indexacion",
    "proyectos-finales/01-analitica-retail",
    "proyectos-finales/02-control-inventarios"
]

def run_sql_query(query, database=None, host="127.0.0.1", port="3306", user="root", password="root"):
    """Ejecuta una consulta SQL forzando codificación utf8mb4 tanto en cliente como en sesión"""
    db_args = [database] if database else []
    
    # 1. Ejecución prioritaria vía Docker Compose
    cmd_docker = [
        "docker", "compose", "exec", "-T", "mysql-bootcamp",
        "mysql", "--default-character-set=utf8mb4", f"-u{user}", f"-p{password}"
    ] + db_args + ["-e", query]

    try:
        proc = subprocess.run(
            cmd_docker,
            cwd=BASE_DIR,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            encoding="utf-8",
            errors="replace",
            timeout=25
        )
        if proc.returncode == 0:
            return True, proc.stdout.strip()
        else:
            stderr = proc.stderr.strip()
            if "ERROR" in stderr or "Can't connect" in stderr:
                return False, stderr
            if "No such container" in stderr or "is not running" in stderr:
                return False, f"El contenedor 'mysql-bootcamp' no está corriendo. Ejecuta: docker compose up -d\n{stderr}"
            return False, stderr
    except FileNotFoundError:
        pass
    except subprocess.TimeoutExpired:
        return False, "La consulta excedió el tiempo límite de ejecución (timeout)."
    except Exception:
        pass

    # 2. Fallback CLI local
    cmd_cli = [
        "mysql", "--default-character-set=utf8mb4", f"-h{host}", f"-P{port}", f"-u{user}", f"-p{password}"
    ] + db_args + ["-e", query]

    try:
        proc = subprocess.run(
            cmd_cli,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            encoding="utf-8",
            errors="replace",
            timeout=25
        )
        if proc.returncode == 0:
            return True, proc.stdout.strip()
        else:
            return False, proc.stderr.strip()
    except FileNotFoundError:
        return False, "No se encontró cliente 'docker' ni 'mysql' en tu PATH. Asegúrate de tener Docker Desktop iniciado."
    except Exception as e:
        return False, f"Error al conectar: {str(e)}"

def init_databases():
    """
    Inicializa los esquemas y datos cargándolos directamente dentro del contenedor Linux.
    Esto garantiza codificación UTF-8 nativa al 100% sin corrupción de acentos en Windows.
    """
    print(f"\n{BOLD}{CYAN}⚙️  Inicializando esquemas y datos de prueba con codificación UTF-8...{RESET}")
    
    # Rutas dentro del contenedor (/datasets ya está montado en docker-compose.yml)
    container_scripts = [
        ("Esquema Tienda Retail", "/datasets/tienda_retail/01_schema.sql", os.path.join(BASE_DIR, "datasets", "tienda_retail", "01_schema.sql")),
        ("Datos Tienda Retail", "/datasets/tienda_retail/02_data.sql", os.path.join(BASE_DIR, "datasets", "tienda_retail", "02_data.sql")),
        ("Esquema Operaciones Logística", "/datasets/operaciones_logistica/01_schema.sql", os.path.join(BASE_DIR, "datasets", "operaciones_logistica", "01_schema.sql")),
        ("Datos Operaciones Logística", "/datasets/operaciones_logistica/02_data.sql", os.path.join(BASE_DIR, "datasets", "operaciones_logistica", "02_data.sql"))
    ]

    for label, container_path, host_path in container_scripts:
        # Intentar ejecutar con 'source /datasets/...' dentro del contenedor (sin intermediación de Windows)
        source_query = f"source {container_path};"
        ok, out = run_sql_query(source_query)

        if not ok:
            # Fallback si docker no tiene el volumen montado: leer en UTF-8 y enviar
            if os.path.exists(host_path):
                with open(host_path, "r", encoding="utf-8") as f:
                    content = f.read()
                ok, out = run_sql_query(content)

        if ok:
            print(f"  {GREEN}✔ {label} cargado limpiamente (UTF-8).{RESET}")
        else:
            print(f"  {RED}✘ Error al cargar {label}:{RESET} {out}")
            return False
            
    print(f"{GREEN}{BOLD}✨ Todas las tablas y caracteres con tildes quedaron impecables.{RESET}\n")
    return True

def check_and_auto_init():
    """Verifica si existen las tablas base; si no, inicializa automáticamente"""
    ok, out = run_sql_query("SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='tienda_retail' AND table_name='clientes';")
    if ok and "\n" in out:
        try:
            count = int(out.splitlines()[-1].strip())
            if count == 0:
                print(f"{YELLOW}⚠️  Las tablas de 'tienda_retail' no existen aún en MySQL.{RESET}")
                init_databases()
        except ValueError:
            pass

def parse_retos_from_file(file_path):
    """
    Parsea un archivo SQL dividiéndolo en retos por encabezados '-- Reto X:'.
    Retorna un diccionario: { '3.1': {'id': '3.1', 'sql': '...', 'db': '...'} }
    """
    if not os.path.exists(file_path):
        return {}
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    match_use = re.search(r"^\s*USE\s+([a-zA-Z0-9_]+)\s*;", content, re.MULTILINE | re.IGNORECASE)
    db_name = match_use.group(1) if match_use else None

    reto_pattern = re.compile(r"(?:^|\n)--\s*(?:Reto|Enunciado)\s+([A-Za-z0-9_.\s]+?):(?:[^\n]*\n|$)", re.IGNORECASE)
    matches = list(reto_pattern.finditer(content))

    retos = {}
    if not matches:
        statements = [s.strip() for s in content.split(";") if s.strip()]
        for idx, s in enumerate(statements, 1):
            clean_s = clean_sql(s)
            if clean_s:
                retos[str(idx)] = {"id": str(idx), "sql": clean_s, "db": db_name}
        return retos

    for i, m in enumerate(matches):
        reto_id = m.group(1).strip()
        start_idx = m.end()
        end_idx = matches[i + 1].start() if (i + 1) < len(matches) else len(content)
        block = content[start_idx:end_idx]

        sql_code = clean_sql(block)
        retos[reto_id] = {
            "id": reto_id,
            "sql": sql_code,
            "db": db_name
        }

    return retos

def clean_sql(text):
    """Limpia comentarios y devuelve solo el código SQL ejecutable"""
    text = re.sub(r"/\*.*?\*/", "", text, flags=re.DOTALL)
    lines = []
    for l in text.splitlines():
        trimmed = l.strip()
        if not trimmed.startswith("--") and not trimmed.startswith("#") and trimmed:
            lines.append(l)
    return "\n".join(lines).strip().rstrip(";")

def parse_output_rows(output_str):
    """Convierte la salida tabular de MySQL en un conjunto comparable de filas de datos"""
    if not output_str:
        return 0, []
    lines = output_str.strip().splitlines()
    if len(lines) <= 1:
        return 0, []
    rows = [tuple(line.split("\t")) for line in lines[1:]]
    return len(rows), rows

def validate_module_exercises(mod_name, verbose=False, test_solutions=False):
    """
    Evalúa los ejercicios del alumno en 'ejercicios.sql' contra 'soluciones.sql'.
    Si test_solutions=True, evalúa 'soluciones.sql' directamente (modo CI).
    """
    mod_path = os.path.join(BASE_DIR, mod_name)
    ejercicios_path = os.path.join(mod_path, "ejercicios.sql")
    soluciones_path = os.path.join(mod_path, "soluciones.sql")

    target_file_name = "soluciones.sql" if test_solutions else "ejercicios.sql"
    target_path = soluciones_path if test_solutions else ejercicios_path

    print(f"\n{BOLD}{CYAN}══════════════════════════════════════════════════════════════════════{RESET}")
    print(f"{BOLD}Evaluando:{RESET} {YELLOW}{mod_name}/{target_file_name}{RESET}")
    print(f"{CYAN}══════════════════════════════════════════════════════════════════════{RESET}")

    if not os.path.exists(target_path):
        print(f"  {RED}[ERROR]{RESET} No se encontró {target_file_name} en {mod_name}")
        return False

    soluciones_retos = parse_retos_from_file(soluciones_path)
    alumno_retos = parse_retos_from_file(ejercicios_path) if not test_solutions else soluciones_retos

    default_db = "tienda_retail"
    if "logistica" in mod_name or "inventarios" in mod_name:
        default_db = "operaciones_logistica"

    all_passed = True
    completed_any = False

    for reto_id, sol_data in soluciones_retos.items():
        db_to_use = sol_data.get("db") or default_db

        if not test_solutions:
            alumno_data = alumno_retos.get(reto_id)
            alumno_sql = alumno_data["sql"] if alumno_data else ""

            if not alumno_sql:
                print(f"  {YELLOW}⏳ [PENDIENTE]{RESET} Reto {reto_id}: Aún no has escrito tu consulta en ejercicios.sql.")
                all_passed = False
                continue

            completed_any = True

            # 1. Ejecutar consulta del alumno
            success_alumno, out_alumno = run_sql_query(alumno_sql, database=db_to_use)
            if not success_alumno:
                print(f"  {RED}✘ [FAIL]{RESET} Reto {reto_id}: Error de MySQL en tu consulta:")
                sql_preview = alumno_sql.splitlines()[0][:60] + ("..." if len(alumno_sql.splitlines()[0]) > 60 else "")
                print(f"      {YELLOW}{sql_preview}{RESET}")
                print(f"      {RED}{out_alumno}{RESET}")
                all_passed = False
                continue

            # 2. Ejecutar solución de referencia
            success_sol, out_sol = run_sql_query(sol_data["sql"], database=db_to_use)
            if not success_sol:
                print(f"  {YELLOW}[WARN]{RESET} Reto {reto_id}: Solución de referencia falló: {out_sol}")
                continue

            filas_alumno, rows_alumno = parse_output_rows(out_alumno)
            filas_esperadas, rows_esperadas = parse_output_rows(out_sol)

            if filas_alumno == filas_esperadas and sorted(rows_alumno) == sorted(rows_esperadas):
                print(f"  {GREEN}✔ [PASS]{RESET} Reto {reto_id}: ¡Correcto! ({filas_alumno} filas devueltas)")
                if verbose:
                    print(f"\n{out_alumno}\n")
            else:
                print(f"  {RED}✘ [FAIL]{RESET} Reto {reto_id}: El resultado no coincide con la solución esperada.")
                print(f"      {YELLOW}Esperabas:{RESET} {filas_esperadas} filas | {YELLOW}Obtuviste:{RESET} {filas_alumno} filas")
                if verbose:
                    print(f"\nTu resultado:\n{out_alumno}\n\nEsperado:\n{out_sol}\n")
                all_passed = False

        else:
            success, out = run_sql_query(sol_data["sql"], database=db_to_use)
            if success:
                filas, _ = parse_output_rows(out)
                print(f"  {GREEN}✔ [PASS]{RESET} Reto {reto_id} solución verificada. ({filas} filas)")
            else:
                print(f"  {RED}✘ [FAIL]{RESET} Reto {reto_id} solución con error: {out}")
                all_passed = False

    return all_passed and (completed_any or test_solutions)

def main():
    parser = argparse.ArgumentParser(description="Validador interactivo de ejercicios SQL")
    parser.add_argument("--modulo", type=str, help="Nombre o número del módulo (ej: 03 o 03-consultas-dql)")
    parser.add_argument("--all", action="store_true", help="Validar todos los módulos del bootcamp")
    parser.add_argument("--solutions", action="store_true", help="Validar soluciones.sql oficiales en vez de ejercicios.sql")
    parser.add_argument("--ci", action="store_true", help="Modo CI (valida soluciones y retorna código 1 ante fallos)")
    parser.add_argument("--init-db", action="store_true", help="Inicializar/Restaurar las bases de datos con datos de prueba limpios")
    parser.add_argument("--verbose", action="store_true", help="Mostrar tablas completas de salida y diferencias")

    args = parser.parse_args()

    print(f"{BOLD}🚀 SQL BOOTCAMP - VALIDADOR INTERACTIVO DE EJERCICIOS{RESET}\n")

    ok, msg = run_sql_query("SELECT VERSION();")
    if not ok:
        print(f"{RED}[ERROR DE CONEXIÓN]{RESET} No se pudo conectar a MySQL.")
        print(f"Detalle: {msg}")
        print("\n💡 TIP: Levanta el laboratorio ejecutando:\n    docker compose up -d\n")
        sys.exit(1)

    mysql_version = msg.splitlines()[-1] if msg else "8.0"
    print(f"{GREEN}✔ Conexión exitosa a MySQL{RESET} (Versión: {mysql_version})")

    if args.init_db:
        success = init_databases()
        if not success:
            sys.exit(1)
        return

    check_and_auto_init()

    targets = []
    if args.modulo:
        for m in MODULES:
            if args.modulo in m:
                targets.append(m)
        if not targets:
            print(f"{RED}[ERROR]{RESET} No se encontró un módulo que coincida con '{args.modulo}'")
            sys.exit(1)
    else:
        targets = MODULES

    global_success = True
    test_mode_solutions = args.solutions or args.ci

    for t in targets:
        passed = validate_module_exercises(t, verbose=args.verbose, test_solutions=test_mode_solutions)
        if not passed:
            global_success = False

    print(f"\n{BOLD}{CYAN}══════════════════════════════════════════════════════════════════════{RESET}")
    if global_success:
        print(f"{BOLD}{GREEN}🎉 ¡TODOS LOS TESTS EVALUADOS PASARON EXITOSAMENTE!{RESET}")
    else:
        print(f"{BOLD}{RED}⚠️ Revisa los retos pendientes o con fallos mostrados arriba.{RESET}")
        if args.ci:
            sys.exit(1)

if __name__ == "__main__":
    main()
