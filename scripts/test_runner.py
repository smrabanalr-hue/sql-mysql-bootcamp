#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
==============================================================================
SQL Bootcamp - Validador Automático Interactivo (Test Runner)
==============================================================================
Ejecuta las consultas del alumno y las valida contra el motor MySQL 8.0+.
Detecta automáticamente si la base de datos necesita inicializarse y la carga.

Uso:
    python scripts/test_runner.py --modulo 03
    python scripts/test_runner.py --all
    python scripts/test_runner.py --init-db
    python scripts/test_runner.py --verbose
"""

import argparse
import os
import re
import subprocess
import sys

# Colores ANSI para terminal interactiva
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
    """
    Ejecuta una consulta SQL priorizando el contenedor Docker de MySQL.
    Si Docker responde, devuelve el resultado directo (sea éxito o error de MySQL).
    """
    db_args = [database] if database else []
    
    # 1. Intentar vía Docker compose exec
    cmd_docker = [
        "docker", "compose", "exec", "-T", "mysql-bootcamp",
        "mysql", f"-u{user}", f"-p{password}"
    ] + db_args + ["-e", query]

    try:
        proc = subprocess.run(
            cmd_docker,
            cwd=BASE_DIR,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            timeout=20
        )
        if proc.returncode == 0:
            return True, proc.stdout.strip()
        else:
            stderr = proc.stderr.strip()
            # Si el error es de MySQL (ej. tabla no existe, error de sintaxis)
            if "ERROR" in stderr or "Can't connect" in stderr:
                return False, stderr
            if "No such container" in stderr or "is not running" in stderr:
                return False, f"El contenedor 'mysql-bootcamp' no está corriendo. Ejecuta: docker compose up -d\n{stderr}"
            return False, stderr
    except FileNotFoundError:
        # Docker CLI no está en el PATH
        pass
    except subprocess.TimeoutExpired:
        return False, "La consulta excedió el tiempo límite de ejecución (timeout)."
    except Exception:
        pass

    # 2. Intentar vía comando 'mysql' CLI local instalado en el sistema
    cmd_cli = [
        "mysql", f"-h{host}", f"-P{port}", f"-u{user}", f"-p{password}"
    ] + db_args + ["-e", query]

    try:
        proc = subprocess.run(
            cmd_cli,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            timeout=20
        )
        if proc.returncode == 0:
            return True, proc.stdout.strip()
        else:
            return False, proc.stderr.strip()
    except FileNotFoundError:
        return False, "No se encontró cliente 'docker' ni 'mysql' en tu PATH. Si Docker está activo, revisa la conexión con 'docker ps'."
    except Exception as e:
        return False, f"Error al conectar: {str(e)}"

def init_databases():
    """Carga los esquemas y datos iniciales en el servidor MySQL"""
    print(f"\n{BOLD}{CYAN}⚙️  Inicializando esquemas y datos de prueba en MySQL...{RESET}")
    
    scripts = [
        ("tienda_retail schema", os.path.join(BASE_DIR, "datasets", "tienda_retail", "01_schema.sql")),
        ("tienda_retail data", os.path.join(BASE_DIR, "datasets", "tienda_retail", "02_data.sql")),
        ("operaciones_logistica schema", os.path.join(BASE_DIR, "datasets", "operaciones_logistica", "01_schema.sql")),
        ("operaciones_logistica data", os.path.join(BASE_DIR, "datasets", "operaciones_logistica", "02_data.sql"))
    ]

    for label, path in scripts:
        if not os.path.exists(path):
            print(f"  {RED}✘ Archivo no encontrado:{RESET} {path}")
            continue
        with open(path, "r", encoding="utf-8") as f:
            sql_content = f.read()
        
        ok, out = run_sql_query(sql_content)
        if ok:
            print(f"  {GREEN}✔ {label} cargado exitosamente.{RESET}")
        else:
            print(f"  {RED}✘ Error al cargar {label}:{RESET} {out}")
            return False
            
    print(f"{GREEN}{BOLD}✨ Todas las bases de datos quedaron inicializadas y listas.{RESET}\n")
    return True

def check_and_auto_init():
    """Comprueba si la tabla 'clientes' existe en 'tienda_retail'. Si no, inicializa automáticamente"""
    ok, out = run_sql_query("SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='tienda_retail' AND table_name='clientes';")
    if ok and "\n" in out:
        try:
            count = int(out.splitlines()[-1].strip())
            if count == 0:
                print(f"{YELLOW}⚠️  Las tablas de 'tienda_retail' no existen aún en MySQL.{RESET}")
                init_databases()
        except ValueError:
            pass

def extract_sql_statements(file_path):
    """Lee un archivo .sql y separa las consultas válidas respetando delimitadores"""
    if not os.path.exists(file_path):
        return []
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    # Quitar comentarios multilínea
    content = re.sub(r"/\*.*?\*/", "", content, flags=re.DOTALL)
    
    statements = []
    if "DELIMITER //" in content:
        parts = content.split("DELIMITER //")
        for p in parts:
            if "DELIMITER ;" in p:
                sp, rest = p.split("DELIMITER ;")
                clean_sp = sp.strip().rstrip("/")
                if clean_sp:
                    statements.append(clean_sp)
                for s in rest.split(";"):
                    sql = clean_sql_statement(s)
                    if sql:
                        statements.append(sql)
            else:
                for s in p.split(";"):
                    sql = clean_sql_statement(s)
                    if sql:
                        statements.append(sql)
    else:
        for s in content.split(";"):
            sql = clean_sql_statement(s)
            if sql:
                statements.append(sql)
    return statements

def clean_sql_statement(text):
    """Limpia líneas comentadas y espacios vacíos"""
    lines = [l for l in text.splitlines() if not l.strip().startswith("--") and not l.strip().startswith("#")]
    return "\n".join(lines).strip()

def validate_module(mod_name, verbose=False):
    """Valida la ejecución de las consultas de un módulo manteniendo el contexto de la BD"""
    mod_path = os.path.join(BASE_DIR, mod_name)
    soluciones_path = os.path.join(mod_path, "soluciones.sql")

    print(f"\n{BOLD}{CYAN}══════════════════════════════════════════════════════════════════════{RESET}")
    print(f"{BOLD}Evaluando Módulo:{RESET} {YELLOW}{mod_name}{RESET}")
    print(f"{CYAN}══════════════════════════════════════════════════════════════════════{RESET}")

    if not os.path.exists(soluciones_path):
        print(f"  {RED}[ERROR]{RESET} No se encontró soluciones.sql en {mod_name}")
        return False

    soluciones = extract_sql_statements(soluciones_path)
    # Excluir comandos de simple selección de base de datos
    retos_reales = [s for s in soluciones if not re.match(r"^USE\s+\w+$", s, flags=re.IGNORECASE)]
    print(f"  Encontrados {BOLD}{len(retos_reales)}{RESET} retos de consulta a evaluar.")

    # Determinar la base de datos predeterminada del módulo
    current_db = "tienda_retail"
    if "logistica" in mod_name or "inventarios" in mod_name:
        current_db = "operaciones_logistica"

    all_passed = True
    reto_num = 1

    for sql in soluciones:
        # Si la consulta cambia de base de datos (USE nombre_db)
        match_use = re.match(r"^USE\s+(\w+)$", sql.strip(), flags=re.IGNORECASE)
        if match_use:
            current_db = match_use.group(1)
            continue

        sql_preview = sql.splitlines()[0][:60] + ("..." if len(sql.splitlines()[0]) > 60 else "")
        success, output = run_sql_query(sql, database=current_db)

        if success:
            lines_count = len(output.splitlines()) - 1 if output else 0
            lines_label = f"({lines_count} filas retornadas)" if lines_count >= 0 else ""
            print(f"  {GREEN}✔ [PASS]{RESET} Reto {reto_num:02d} ejecutado correctamente. {lines_label}")
            if verbose and output:
                print(f"\n{output}\n")
        else:
            print(f"  {RED}✘ [FAIL]{RESET} Reto {reto_num:02d}: Error al ejecutar:")
            print(f"      {YELLOW}{sql_preview}{RESET}")
            print(f"      {RED}Detalle de MySQL: {output}{RESET}")
            all_passed = False

        reto_num += 1

    return all_passed

def main():
    parser = argparse.ArgumentParser(description="Validador interactivo de ejercicios SQL")
    parser.add_argument("--modulo", type=str, help="Nombre o número del módulo (ej: 03 o 03-consultas-dql)")
    parser.add_argument("--all", action="store_true", help="Validar todos los módulos del bootcamp")
    parser.add_argument("--init-db", action="store_true", help="Inicializar/Restaurar las bases de datos con esquemas y datos iniciales")
    parser.add_argument("--ci", action="store_true", help="Modo CI (retorna código 1 ante cualquier fallo)")
    parser.add_argument("--verbose", action="store_true", help="Mostrar tablas completas de salida")

    args = parser.parse_args()

    print(f"{BOLD}🚀 SQL BOOTCAMP - VALIDADOR INTERACTIVO DE EJERCICIOS{RESET}\n")

    # Verificar conectividad con MySQL
    ok, msg = run_sql_query("SELECT VERSION();")
    if not ok:
        print(f"{RED}[ERROR DE CONEXIÓN]{RESET} No se pudo conectar a MySQL.")
        print(f"Detalle: {msg}")
        print("\n💡 TIP: Levanta el laboratorio ejecutando:\n    docker compose up -d\n")
        if args.ci:
            sys.exit(1)
        return

    mysql_version = msg.splitlines()[-1] if msg else "8.0"
    print(f"{GREEN}✔ Conexión exitosa a MySQL{RESET} (Versión: {mysql_version})")

    # Si se solicitó --init-db
    if args.init_db:
        success = init_databases()
        if not success and args.ci:
            sys.exit(1)
        return

    # Verificar automáticamente si las tablas existen; si no, inicializarlas
    check_and_auto_init()

    # Seleccionar módulos objetivo
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
    for t in targets:
        passed = validate_module(t, verbose=args.verbose)
        if not passed:
            global_success = False

    print(f"\n{BOLD}{CYAN}══════════════════════════════════════════════════════════════════════{RESET}")
    if global_success:
        print(f"{BOLD}{GREEN}🎉 ¡TODOS LOS TESTS PASARON EXITOSAMENTE! EXCELENTE TRABAJO.{RESET}")
    else:
        print(f"{BOLD}{RED}⚠️ Algunos retos tuvieron errores. Revisa la salida de MySQL arriba.{RESET}")
        if args.ci:
            sys.exit(1)

if __name__ == "__main__":
    main()
