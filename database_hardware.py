import sqlite3
from datetime import datetime

def crear_base_datos():
    conn = sqlite3.connect('db/diagnostico_hardware.db')
    cursor = conn.cursor()
    
    # Tabla de usuarios/técnicos
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS usuarios (
            id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            correo TEXT NOT NULL,
            rol TEXT DEFAULT 'usuario',
            fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ''')
    
    # Tabla de equipos diagnosticados
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS equipos (
            id_equipo INTEGER PRIMARY KEY AUTOINCREMENT,
            id_usuario INTEGER NOT NULL,
            marca TEXT,
            modelo TEXT,
            tipo TEXT, -- Desktop, Laptop, Server
            fecha_compra DATE,
            FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)
        )
    ''')
    
    # Tabla de sesiones de diagnóstico
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS sesiones (
            id_sesion INTEGER PRIMARY KEY AUTOINCREMENT,
            id_equipo INTEGER NOT NULL,
            id_usuario INTEGER NOT NULL,
            fecha_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            fecha_fin TIMESTAMP,
            estado TEXT DEFAULT 'en_progreso',
            FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo),
            FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)
        )
    ''')
    
    # Tabla de respuestas a síntomas
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS respuestas_sintomas (
            id_respuesta INTEGER PRIMARY KEY AUTOINCREMENT,
            id_sesion INTEGER NOT NULL,
            categoria TEXT NOT NULL, -- power, display, storage, memory, etc.
            sintoma TEXT NOT NULL,
            respuesta TEXT NOT NULL, -- si, no, parcial
            severidad INTEGER, -- 1-5
            timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (id_sesion) REFERENCES sesiones (id_sesion)
        )
    ''')
    
    # Tabla de diagnósticos (resultados)
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS diagnosticos (
            id_diagnostico INTEGER PRIMARY KEY AUTOINCREMENT,
            id_sesion INTEGER NOT NULL,
            componente_afectado TEXT NOT NULL,
            tipo_falla TEXT NOT NULL,
            nivel_confianza REAL, -- 0.0 - 1.0
            descripcion TEXT,
            solucion_recomendada TEXT,
            prioridad TEXT, -- critica, alta, media, baja
            costo_estimado REAL,
            tiempo_reparacion TEXT,
            FOREIGN KEY (id_sesion) REFERENCES sesiones (id_sesion)
        )
    ''')
    
    # Tabla de componentes evaluados
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS evaluacion_componentes (
            id_evaluacion INTEGER PRIMARY KEY AUTOINCREMENT,
            id_sesion INTEGER NOT NULL,
            componente TEXT NOT NULL,
            estado TEXT, -- ok, warning, critical, failed
            porcentaje_salud INTEGER,
            temperatura REAL,
            voltaje REAL,
            observaciones TEXT,
            FOREIGN KEY (id_sesion) REFERENCES sesiones (id_sesion)
        )
    ''')
    
    # Tabla de historial de reparaciones
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS historial_reparaciones (
            id_reparacion INTEGER PRIMARY KEY AUTOINCREMENT,
            id_diagnostico INTEGER NOT NULL,
            fecha_reparacion TIMESTAMP,
            tecnico TEXT,
            componentes_reemplazados TEXT,
            costo_real REAL,
            exito BOOLEAN,
            notas TEXT,
            FOREIGN KEY (id_diagnostico) REFERENCES diagnosticos (id_diagnostico)
        )
    ''')
    
    conn.commit()
    conn.close()

# Funciones CRUD para usuarios
def registrar_usuario(nombre, correo, rol='usuario'):
    conn = sqlite3.connect('db/diagnostico_hardware.db')
    cursor = conn.cursor()
    cursor.execute('INSERT INTO usuarios (nombre, correo, rol) VALUES (?, ?, ?)', 
                   (nombre, correo, rol))
    conn.commit()
    id_usuario = cursor.lastrowid
    conn.close()
    return id_usuario

# Funciones para equipos
def registrar_equipo(id_usuario, marca, modelo, tipo, fecha_compra=None):
    conn = sqlite3.connect('db/diagnostico_hardware.db')
    cursor = conn.cursor()
    cursor.execute('''INSERT INTO equipos 
                      (id_usuario, marca, modelo, tipo, fecha_compra) 
                      VALUES (?, ?, ?, ?, ?)''',
                   (id_usuario, marca, modelo, tipo, fecha_compra))
    conn.commit()
    id_equipo = cursor.lastrowid
    conn.close()
    return id_equipo

# Funciones para sesiones
def crear_sesion(id_equipo, id_usuario):
    conn = sqlite3.connect('db/diagnostico_hardware.db')
    cursor = conn.cursor()
    cursor.execute('INSERT INTO sesiones (id_equipo, id_usuario) VALUES (?, ?)',
                   (id_equipo, id_usuario))
    conn.commit()
    id_sesion = cursor.lastrowid
    conn.close()
    return id_sesion

def finalizar_sesion(id_sesion):
    conn = sqlite3.connect('db/diagnostico_hardware.db')
    cursor = conn.cursor()
    cursor.execute('''UPDATE sesiones 
                      SET fecha_fin = CURRENT_TIMESTAMP, estado = 'completado'
                      WHERE id_sesion = ?''', (id_sesion,))
    conn.commit()
    conn.close()

# Guardar respuestas de síntomas
def guardar_sintoma(id_sesion, categoria, sintoma, respuesta, severidad=None):
    conn = sqlite3.connect('db/diagnostico_hardware.db')
    cursor = conn.cursor()
    cursor.execute('''INSERT INTO respuestas_sintomas 
                      (id_sesion, categoria, sintoma, respuesta, severidad)
                      VALUES (?, ?, ?, ?, ?)''',
                   (id_sesion, categoria, sintoma, respuesta, severidad))
    conn.commit()
    conn.close()

# Guardar diagnóstico
def guardar_diagnostico(id_sesion, componente, tipo_falla, confianza, 
                       descripcion, solucion, prioridad, costo=None, tiempo=None):
    conn = sqlite3.connect('db/diagnostico_hardware.db')
    cursor = conn.cursor()
    cursor.execute('''INSERT INTO diagnosticos 
                      (id_sesion, componente_afectado, tipo_falla, nivel_confianza,
                       descripcion, solucion_recomendada, prioridad, 
                       costo_estimado, tiempo_reparacion)
                      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)''',
                   (id_sesion, componente, tipo_falla, confianza, 
                    descripcion, solucion, prioridad, costo, tiempo))
    conn.commit()
    id_diag = cursor.lastrowid
    conn.close()
    return id_diag

# Evaluar componente
def guardar_evaluacion_componente(id_sesion, componente, estado, 
                                  salud, temp=None, voltaje=None, obs=None):
    conn = sqlite3.connect('db/diagnostico_hardware.db')
    cursor = conn.cursor()
    cursor.execute('''INSERT INTO evaluacion_componentes
                      (id_sesion, componente, estado, porcentaje_salud,
                       temperatura, voltaje, observaciones)
                      VALUES (?, ?, ?, ?, ?, ?, ?)''',
                   (id_sesion, componente, estado, salud, temp, voltaje, obs))
    conn.commit()
    conn.close()

# Obtener historial completo
def obtener_historial_completo(id_sesion):
    conn = sqlite3.connect('db/diagnostico_hardware.db')
    cursor = conn.cursor()
    
    # Síntomas
    cursor.execute('''SELECT categoria, sintoma, respuesta, severidad, timestamp
                      FROM respuestas_sintomas WHERE id_sesion = ?
                      ORDER BY timestamp''', (id_sesion,))
    sintomas = cursor.fetchall()
    
    # Diagnósticos
    cursor.execute('''SELECT componente_afectado, tipo_falla, nivel_confianza,
                      descripcion, solucion_recomendada, prioridad
                      FROM diagnosticos WHERE id_sesion = ?''', (id_sesion,))
    diagnosticos = cursor.fetchall()
    
    # Evaluaciones
    cursor.execute('''SELECT componente, estado, porcentaje_salud
                      FROM evaluacion_componentes WHERE id_sesion = ?''', 
                   (id_sesion,))
    evaluaciones = cursor.fetchall()
    
    conn.close()
    return {
        'sintomas': sintomas,
        'diagnosticos': diagnosticos,
        'evaluaciones': evaluaciones
    }



def obtener_todas_sesiones():
    """Obtiene todas las sesiones con información del usuario y equipo"""
    conn = sqlite3.connect('db/diagnostico_hardware.db')
    cursor = conn.cursor()
    
    cursor.execute('''
        SELECT 
            s.id_sesion,
            s.fecha_inicio,
            s.fecha_fin,
            s.estado,
            u.nombre as usuario,
            e.marca,
            e.modelo,
            e.tipo,
            COUNT(DISTINCT d.id_diagnostico) as num_diagnosticos
        FROM sesiones s
        LEFT JOIN usuarios u ON s.id_usuario = u.id_usuario
        LEFT JOIN equipos e ON s.id_equipo = e.id_equipo
        LEFT JOIN diagnosticos d ON s.id_sesion = d.id_sesion
        GROUP BY s.id_sesion
        ORDER BY s.fecha_inicio DESC
    ''')
    
    sesiones = cursor.fetchall()
    conn.close()
    return sesiones

def obtener_diagnosticos_por_sesion(id_sesion):
    """Obtiene todos los diagnósticos de una sesión específica"""
    conn = sqlite3.connect('db/diagnostico_hardware.db')
    cursor = conn.cursor()
    
    cursor.execute('''
        SELECT 
            id_diagnostico,
            componente_afectado,
            tipo_falla,
            nivel_confianza,
            descripcion,
            solucion_recomendada,
            prioridad,
            costo_estimado,
            tiempo_reparacion
        FROM diagnosticos
        WHERE id_sesion = ?
        ORDER BY nivel_confianza DESC
    ''', (id_sesion,))
    
    diagnosticos = cursor.fetchall()
    conn.close()
    return diagnosticos

def obtener_sintomas_por_sesion(id_sesion):
    """Obtiene todos los síntomas registrados en una sesión"""
    conn = sqlite3.connect('db/diagnostico_hardware.db')
    cursor = conn.cursor()
    
    cursor.execute('''
        SELECT 
            categoria,
            sintoma,
            respuesta,
            severidad,
            timestamp
        FROM respuestas_sintomas
        WHERE id_sesion = ?
        ORDER BY timestamp
    ''', (id_sesion,))
    
    sintomas = cursor.fetchall()
    conn.close()
    return sintomas

def eliminar_sesion(id_sesion):
    """Elimina una sesión completa y todos sus registros relacionados"""
    conn = sqlite3.connect('db/diagnostico_hardware.db')
    cursor = conn.cursor()
    
    try:
        # Eliminar en orden debido a foreign keys
        cursor.execute('DELETE FROM historial_reparaciones WHERE id_diagnostico IN (SELECT id_diagnostico FROM diagnosticos WHERE id_sesion = ?)', (id_sesion,))
        cursor.execute('DELETE FROM evaluacion_componentes WHERE id_sesion = ?', (id_sesion,))
        cursor.execute('DELETE FROM diagnosticos WHERE id_sesion = ?', (id_sesion,))
        cursor.execute('DELETE FROM respuestas_sintomas WHERE id_sesion = ?', (id_sesion,))
        cursor.execute('DELETE FROM sesiones WHERE id_sesion = ?', (id_sesion,))
        
        conn.commit()
        conn.close()
        return True
    except Exception as e:
        conn.rollback()
        conn.close()
        print(f"Error eliminando sesión: {e}")
        return False

def actualizar_diagnostico(id_diagnostico, descripcion, solucion, prioridad):
    """Actualiza los campos editables de un diagnóstico"""
    conn = sqlite3.connect('db/diagnostico_hardware.db')
    cursor = conn.cursor()
    
    try:
        cursor.execute('''
            UPDATE diagnosticos
            SET descripcion = ?,
                solucion_recomendada = ?,
                prioridad = ?
            WHERE id_diagnostico = ?
        ''', (descripcion, solucion, prioridad, id_diagnostico))
        
        conn.commit()
        conn.close()
        return True
    except Exception as e:
        conn.rollback()
        conn.close()
        print(f"Error actualizando diagnóstico: {e}")
        return False

def obtener_estadisticas_generales():
    """Obtiene estadísticas generales del sistema"""
    conn = sqlite3.connect('db/diagnostico_hardware.db')
    cursor = conn.cursor()
    
    stats = {}
    
    # Total de sesiones
    cursor.execute('SELECT COUNT(*) FROM sesiones')
    stats['total_sesiones'] = cursor.fetchone()[0]
    
    # Total de diagnósticos
    cursor.execute('SELECT COUNT(*) FROM diagnosticos')
    stats['total_diagnosticos'] = cursor.fetchone()[0]
    
    # Componente más problemático
    cursor.execute('''
        SELECT componente_afectado, COUNT(*) as cantidad
        FROM diagnosticos
        GROUP BY componente_afectado
        ORDER BY cantidad DESC
        LIMIT 1
    ''')
    resultado = cursor.fetchone()
    stats['componente_critico'] = resultado[0] if resultado else "N/A"
    stats['veces_componente'] = resultado[1] if resultado else 0
    
    # Promedio de confianza
    cursor.execute('SELECT AVG(nivel_confianza) FROM diagnosticos')
    promedio = cursor.fetchone()[0]
    stats['confianza_promedio'] = round(promedio * 100, 1) if promedio else 0
    
    conn.close()
    return stats


