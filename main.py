#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""

PARA PODER ACTIVAR EL VENV DE ARCH
source venv/bin/activate

"""

import sys
import os
import locale

if sys.platform.startswith('linux'):
    locale.setlocale(locale.LC_ALL, 'C')
    os.environ['LC_ALL'] = 'C'
    os.environ['LANG'] = 'C'


sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from database_hardware import crear_base_datos
from sistema import *

def inicializar_sistema():
    print("Iniciando Sistema Experto de Hardware...")
    
    if not os.path.exists('db'):
        os.makedirs('db')
        print("- Directorio 'db' creado")
    
    try:
        crear_base_datos()
        print("- Base de datos inicializada")
    except Exception as e:
        print(f"Error creando BD: {e}")
    
    if not os.path.exists('reglas_hardware.pl'):
        print("ADVERTENCIA: No se encontró 'reglas_hardware.pl'")
        print("   El sistema puede no funcionar correctamente")
    else:
        print("- Archivo de reglas Prolog encontrado")
    
    try:
        from pyswip import Prolog
        print("- PySwip instalado correctamente")
    except ImportError:
        print("ERROR: PySwip no está instalado")
        print("   Instala con: pip install pyswip")
        print("   Y asegúrate de tener SWI-Prolog instalado")
        sys.exit(1)
    
    print("\nSistema listo para iniciar\n")

def main():
    inicializar_sistema()
    
    root = tk.Tk()
    splash = VentanaCarga(root)
    root.mainloop()

if __name__ == "__main__":
    main()