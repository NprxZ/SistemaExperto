#!/usr/bin/env python3
"""
python instalar_dependencias.py

"""

import os
import platform
import subprocess
import sys
import shutil

def detect_os():
    system = platform.system().lower()
    if "windows" in system:
        return "windows"

    if os.path.exists("/etc/os-release"):
        with open("/etc/os-release") as f:
            data = f.read().lower()
        if "arch" in data:
            return "arch"
        elif "ubuntu" in data or "debian" in data:
            return "debian"
    return "linux"

def ensure_pip():
    if not shutil.which("pip"):
        print("pip no está instalado. Intentando instalarlo...")
        subprocess.run([sys.executable, "-m", "ensurepip", "--upgrade"], check=True)

def install_requirements():
    os_type = detect_os()
    ensure_pip()

    print(f" Sistema detectado: {os_type.upper()}")

    base_cmd = [sys.executable, "-m", "pip", "install", "--no-cache-dir", "-r", "requirements.txt"]

    if os_type == "arch":
        print(" Usando instalación directa (Arch Linux)...")
        subprocess.run(base_cmd, check=True)

    elif os_type == "debian":
        print(" Instalando en entorno Debian/Ubuntu...")
        subprocess.run([sys.executable, "-m", "pip", "install", "--upgrade", "pip", "setuptools"], check=True)
        subprocess.run(base_cmd, check=True)

    elif os_type == "windows":
        print(" Instalando en Windows...")
        subprocess.run(base_cmd, check=True)

    else:
        print(" Sistema desconocido. Intentando instalación estándar...")
        subprocess.run(base_cmd, check=True)

    print(" Dependencias instaladas correctamente.")

if __name__ == "__main__":
    if not os.path.exists("requirements.txt"):
        print(" No se encontró 'requirements.txt'. Genera uno primero.")
        sys.exit(1)
    install_requirements()