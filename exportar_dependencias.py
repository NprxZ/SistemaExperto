#!/usr/bin/env python3
"""
source venv/bin/activate
python exportar_dependencias.py

"""

import subprocess

EXCLUDE = {
    "pip", "setuptools", "wheel", "pkg-resources",
    "apt-clone", "python-apt", "pysqlite3",
    "opencv-python-headless", "opencv-contrib-python",
    "mysqlclient", "psycopg2"
}

def main():
    print(" Generando lista de dependencias...")
    result = subprocess.run(["pip", "freeze", "--exclude-editable"],
                            capture_output=True, text=True, check=True)

    clean_lines = []
    for line in result.stdout.splitlines():
        pkg = line.split("==")[0].strip()
        if pkg not in EXCLUDE:
            clean_lines.append(line)

    with open("requirements.txt", "w", encoding="utf-8") as f:
        f.write("\n".join(clean_lines) + "\n")

    print(f" Archivo 'requirements.txt' generado con {len(clean_lines)} paquetes.")
    print("   Compatible con Arch, Ubuntu/Debian y Windows.")

if __name__ == "__main__":
    main()