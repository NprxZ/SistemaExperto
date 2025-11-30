import os
import sys
import platform
import subprocess

LIBRERIAS = [
    "Pillow",
    "gTTS",
    "pygame",
    "pyttsx3",
    "opencv-python",
    "playsound",
    "pyswip"
]

def instalar_paquete(paquete):
    try:
        print(f"\nInstalando {paquete}...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", "--upgrade", paquete])
    except subprocess.CalledProcessError:
        print(f"Error al instalar {paquete}")

def verificar_tkinter():
    try:
        import tkinter
        print("Tkinter ya está instalado.")
    except ImportError:
        sistema = platform.system()
        print("Tkinter no está instalado.")
        if sistema == "Linux":
            print("Se instala con ejecutando:\n   sudo apt install python3-tk -y")
        elif sistema == "Darwin":
            print("En macOS instalarlo con:\n   brew install python-tk")
        elif sistema == "Windows":
            print("Reinstala Python y asegúrar de marcar la opción 'tcl/tk and IDLE'.")

def instalar_dependencias():
    sistema = platform.system()
    print(f"Detectando sistema operativo: {sistema}")

    try:
        subprocess.check_call([sys.executable, "-m", "pip", "--version"])
    except subprocess.CalledProcessError:
        print("Instalando pip...")
        if sistema == "Linux":
            subprocess.run(["sudo", "apt", "update"])
            subprocess.run(["sudo", "apt", "install", "-y", "python3-pip"])
        elif sistema == "Windows":
            subprocess.run([sys.executable, "-m", "ensurepip", "--upgrade"])

    for lib in LIBRERIAS:
        instalar_paquete(lib)

    verificar_tkinter()

    print("\nTodas las dependencias se han instalado o verificado correctamente.")

if __name__ == "__main__":
    instalar_dependencias()
