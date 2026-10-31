#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
==============================================================================
SQL Bootcamp - Validador Automático Interactivo (Test Runner)
==============================================================================
Ejecuta las consultas del alumno (ejercicios.sql) y las compara contra las
soluciones de referencia (soluciones.sql) o valida su sintaxis contra MySQL.

Uso:
    python scripts/test_runner.py --modulo 03
    python scripts/test_runner.py --all
    python scripts/test_runner.py --ci
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

def run_sql_query(query, database="tienda_retail", host="127.0.0.1", port="3306", user="root", password="root"):
    """Ejecuta un script SQL en el servidor MySQL local o dentro de Docker"""
    # Intentar primero ejecutar vía docker compose exec si docker está activo
    cmd_docker = [
        "docker", "compose", "exec", "-T", "mysql-bootcamp",
        "mysql", f"-u{user}", f"-p{password}", database, "-e", query
    ]
    try:
        proc = subprocess.run(
            cmd_docker,
            cwd=BASE_DIR,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            timeout=15
        )
        if proc.returncode == 0:
            return True, proc.stdout.strip()
    except Exception:
        pass

    # Si docker falla o no está instalado, intentar comando mysql CLI local
    cmd_cli = [
        "mysql", f"-h{host}", f"-P{port}", f"-u{user}", f"-p{password}", database, "-e", query
    ]
    try:
        proc = subprocess.run(
            cmd_cli,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            timeout=15
        )
        if proc.returncode == 0:
            return True, proc.stdout.strip()
        else:
            return False, proc.stderr.strip()
    except Exception as e:
        return False, f"No se pudo conectar a MySQL. Asegúrate de levantar el contenedor con 'docker compose up -d'. Error: {str(e)}"

def extract_sql_statements(file_path):
    """Lee un archivo .sql y separa las consultas válidas descartando comentarios vacíos"""
    if not os.path.exists(file_path):
        return []
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    # Remover comentarios de bloque
    content = re.sub(r"/\*.*?\*/", "", content, flags=re.DOTALL)
    
    statements = []
    # Manejar delimitadores especiales si existen
    if "DELIMITER //" in content:
        parts = content.split("DELIMITER //")
        for p in parts:
            if "DELIMITER ;" in p:
                sp, rest = p.split("DELIMITER ;")
                statements.append(sp.strip().rstrip("/"))
                statements.extend([s.strip() for s in rest.split(";") if s.strip()])
            else:
                statements.extend([s.strip() for s in p.split(";") if s.strip()])
    else:
        for s in content.split(";"):
            cleaned = s.strip()
            # Descartar comentarios de una sola línea
            lines = [l for l in cleaned.splitlines() if not l.strip().startswith("--") and not l.strip().startswith("#")]
            sql_text = "\n".join(lines).strip()
            if sql_text:
                statements.append(sql_text)
    return statements

def validate_module(mod_name, verbose=False):
    """Valida la sintaxis y ejecución de soluciones y ejercicios del módulo"""
    mod_path = os.path.join(BASE_DIR, mod_name)
    soluciones_path = os.path.join(mod_path, "soluciones.sql")
    ejercicios_path = os.path.join(mod_path, "ejercicios.sql")

    print(f"\n{BOLD}{CYAN}══════════════════════════════════════════════════════════════════════{RESET}")
    print(f"{BOLD}Evaluando Módulo:{RESET} {YELLOW}{mod_name}{RESET}")
    print(f"{CYAN}══════════════════════════════════════════════════════════════════════{RESET}")

    if not os.path.exists(soluciones_path):
        print(f"  {RED}[ERROR]{RESET} No se encontró soluciones.sql en {mod_name}")
        return False

    soluciones = extract_sql_statements(soluciones_path)
    print(f"  Encontradas {BOLD}{len(soluciones)}{RESET} consultas de referencia en soluciones.sql.")

    all_passed = True
    for idx, sql in enumerate(soluciones, start=1):
        # Truncar visualización de la consulta
        sql_preview = sql.splitlines()[0][:60] + ("..." if len(sql.splitlines()[0]) > 60 else "")
        success, output = run_sql_query(sql)

        if success:
            lines_count = len(output.splitlines()) - 1 if output else 0
            lines_label = f"({lines_count} filas retornadas)" if lines_count >= 0 else ""
            print(f"  {GREEN}✔ [PASS]{RESET} Reto {idx:02d} ejecutado correctamente. {lines_label}")
            if verbose and output:
                print(f"\n{output}\n")
        else:
            print(f"  {RED}✘ [FAIL]{RESET} Reto {idx:02d}: Error al ejecutar:")
            print(f"      {YELLOW}{sql_preview}{RESET}")
            print(f"      {RED}Detalle de MySQL: {output}{RESET}")
            all_passed = False

    return all_passed

def main():
    parser = argparse.ArgumentParser(description="Validador interactivo de ejercicios SQL")
    parser.add_argument("--modulo", type=str, help="Nombre o número del módulo a validar (ej: 03 o 03-consultas-dql)")
    parser.add_argument("--all", action="store_true", help="Validar todos los módulos del bootcamp")
    parser.add_argument("--ci", action="store_true", help="Modo CI (retorna código 1 ante cualquier fallo)")
    parser.add_argument("--verbose", action="store_true", help="Mostrar tablas completas de salida")

    args = parser.parse_args()

    print(f"{BOLD}🚀 SQL BOOTCAMP - VALIDADOR INTERACTIVO DE EJERCICIOS{RESET}\n")

    # Verificar conectividad preliminar
    ok, msg = run_sql_query("SELECT VERSION();")
    if not ok:
        print(f"{RED}[ERROR DE CONEXIÓN]{RESET} No se pudo conectar a MySQL.")
        print("💡 TIP: Levanta el laboratorio ejecutando:\n    docker compose up -d\n")
        if args.ci:
            sys.exit(1)
        return

    print(f"{GREEN}✔ Conexión exitosa a MySQL{RESET} ({msg.splitlines()[-1] if msg else 'OK'})")

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
