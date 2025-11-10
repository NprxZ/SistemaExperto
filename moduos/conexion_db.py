# Para la conexión a la base de datos, usando SQLite para que sea más portatil al compartirlo con los demás
import sqlite3

def conectar():
    """Crea o en caso contrario abre la base de datos y la tabla de diagnóstico."""
    conn = sqlite3.connect("sistema_experto.db")
    cursor = conn.cursor()

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS diagnosticos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fecha TEXT,
            respuestas TEXT,
            resultado TEXT
        )
    """)

    conn.commit()
    return conn
