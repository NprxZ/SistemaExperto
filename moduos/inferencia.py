# MOTOR DE INFERENCIA PARA EL SISTEMA EXPERTO (LO DEJE MUY BÁSICO PARA COMPROBAR LA FUNCIONALIDAD)
from datetime import datetime
from moduos.conexion_db import conectar

def inferir(respuestas):

    reglas = {
        "pitido": "Error en la RAM o BIOS",
        "pantalla": "Posible falla en GPU o monitor",
        "sobrecalentamiento": "Problemas de ventilación o CPU",
        "reinicio": "Fuente de poder inestable o RAM defectuosa",
        "ruido": "Falla en disco duro",
        "usb": "Problemas en tarjeta madre o controladores"
    }

    texto = " ".join(respuestas).lower()
    diagnostico = []

    for palabra, conclusion in reglas.items():
        if palabra in texto:
            diagnostico.append(conclusion)

    if not diagnostico:
        diagnostico.append("No se detectaron fallas críticas.")

    guardar_resultado(respuestas, diagnostico)
    return "\n".join(diagnostico)


def guardar_resultado(respuestas, diagnostico):
    """Guarda en la base de datos el resultado del diagnóstico."""
    try:
        conn = conectar()
        cursor = conn.cursor()
        fecha = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        cursor.execute("""
            INSERT INTO diagnosticos (fecha, respuestas, resultado)
            VALUES (?, ?, ?)
        """, (fecha, str(respuestas), str(diagnostico)))

        conn.commit()
        conn.close()
        print("Diagnóstico guardado correctamente.")
    except Exception as e:
        print("Error al guardar diagnóstico:", e)
