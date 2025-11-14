from modulos.Librerias import *

from modulos.Sonidos import *

from tkinter import messagebox
import math
import random

class DialogoPersonalizado:

    def __init__(self, parent, titulo, mensaje, tipo="info", icono="ℹ️"):
        self.resultado = None
        self.dialog = tk.Toplevel(parent)
        self.dialog.title("")
        self.dialog.geometry("450x280")
        self.dialog.configure(bg="#0f172a")
        self.dialog.resizable(False, False)
        self.dialog.overrideredirect(True)
        
        self.dialog.update_idletasks()
        x = parent.winfo_x() + (parent.winfo_width() // 2) - 225
        y = parent.winfo_y() + (parent.winfo_height() // 2) - 140
        self.dialog.geometry(f"450x280+{x}+{y}")
        
        self.angle = 0
        self.pulse = 0
        self.particles = []
        
        for _ in range(15):
            self.particles.append({
                'x': random.randint(0, 450),
                'y': random.randint(0, 280),
                'speed': random.uniform(0.3, 1.5),
                'size': random.randint(1, 2)
            })
        
        self.canvas = tk.Canvas(self.dialog, width=450, height=280, 
                                bg="#0f172a", highlightthickness=0)
        self.canvas.pack(fill="both", expand=True)
        
        self.canvas.create_rectangle(0, 0, 450, 280, outline="#334155", width=3)
        self.canvas.create_rectangle(3, 3, 447, 277, outline="#1e293b", width=2)
        
        colores = {
            "info": {"primario": "#38bdf8", "secundario": "#0ea5e9", "acento": "#22d3ee"},
            "success": {"primario": "#10b981", "secundario": "#059669", "acento": "#34d399"},
            "warning": {"primario": "#f59e0b", "secundario": "#d97706", "acento": "#fbbf24"},
            "error": {"primario": "#ef4444", "secundario": "#dc2626", "acento": "#f87171"}
        }
        self.colores = colores.get(tipo, colores["info"])
        
        self.icono_elements = []
        self.icono_x, self.icono_y = 225, 80
        
        self.canvas.create_text(225, 140, 
                                text=titulo, 
                                font=("Segoe UI", 18, "bold"),
                                fill=self.colores["primario"])
        
        # Mensaje
        self.canvas.create_text(225, 180, 
                                text=mensaje, 
                                font=("Segoe UI", 11),
                                fill="#94a3b8",
                                width=380,
                                justify="center")
        
        self.crear_boton_ok()
        
        self.animar_icono()
        self.animar_particulas()
        
        # Hacer modal
        self.dialog.transient(parent)
        self.dialog.grab_set()
        
        sonidos = {
            "info": SONIDO_IDEA,
            "success": SONIDO_POWER,
            "warning": SONIDO_VOICE,
            "error": SONIDO_BREAK
        }
        sonidos.get(tipo, SONIDO_IDEA).play()
    
    def crear_boton_ok(self):
        btn_x, btn_y = 225, 235
        
        self.btn_shadow = self.canvas.create_rectangle(
            btn_x - 58, btn_y - 17, btn_x + 58, btn_y + 17,
            fill="#0a0f1a", outline=""
        )
        
        self.btn_bg = self.canvas.create_rectangle(
            btn_x - 60, btn_y - 18, btn_x + 60, btn_y + 18,
            fill=self.colores["primario"], outline=""
        )
        
        self.btn_border = self.canvas.create_rectangle(
            btn_x - 60, btn_y - 18, btn_x + 60, btn_y + 18,
            outline=self.colores["acento"], width=2
        )
        
        self.btn_text = self.canvas.create_text(
            btn_x, btn_y, 
            text="✓  Entendido", 
            font=("Segoe UI", 12, "bold"),
            fill="white"
        )
        
        def on_enter(e):
            self.canvas.itemconfig(self.btn_bg, fill=self.colores["secundario"])
            self.canvas.itemconfig(self.btn_border, width=3)
            self.canvas.config(cursor="hand2")
        
        def on_leave(e):
            self.canvas.itemconfig(self.btn_bg, fill=self.colores["primario"])
            self.canvas.itemconfig(self.btn_border, width=2)
            self.canvas.config(cursor="")
        
        def on_click(e):
            SONIDO_CLICK.play()
            self.resultado = True
            self.canvas.itemconfig(self.btn_bg, fill=self.colores["acento"])
            self.dialog.after(100, self.cerrar)
        
        for item in [self.btn_shadow, self.btn_bg, self.btn_border, self.btn_text]:
            self.canvas.tag_bind(item, "<Enter>", on_enter)
            self.canvas.tag_bind(item, "<Leave>", on_leave)
            self.canvas.tag_bind(item, "<Button-1>", on_click)
    
    def animar_icono(self):
        self.angle = (self.angle + 4) % 360
        self.pulse = (self.pulse + 6) % 360
        
        for elem in self.icono_elements:
            self.canvas.delete(elem)
        self.icono_elements.clear()
        
        ring_size = 35 + 3 * math.sin(math.radians(self.pulse))
        elem = self.canvas.create_oval(
            self.icono_x - ring_size, self.icono_y - ring_size,
            self.icono_x + ring_size, self.icono_y + ring_size,
            outline=self.colores["primario"], width=2
        )
        self.icono_elements.append(elem)
        
        for i in range(6):
            angle = self.angle + (i * 60)
            x = self.icono_x + 30 * math.cos(math.radians(angle))
            y = self.icono_y + 30 * math.sin(math.radians(angle))
            size = 2 + math.sin(math.radians(self.pulse + i * 60))
            elem = self.canvas.create_oval(
                x - size, y - size, x + size, y + size,
                fill=self.colores["acento"], outline=""
            )
            self.icono_elements.append(elem)
        
        pulse_size = 18 + 3 * math.sin(math.radians(self.pulse))
        elem = self.canvas.create_oval(
            self.icono_x - pulse_size, self.icono_y - pulse_size,
            self.icono_x + pulse_size, self.icono_y + pulse_size,
            fill=self.colores["primario"], 
            outline=self.colores["acento"], width=2
        )
        self.icono_elements.append(elem)
        
        pulse_width = 2 + int(math.sin(math.radians(self.pulse)) * 0.5)
        self.canvas.itemconfig(self.btn_border, width=pulse_width)
        
        self.dialog.after(40, self.animar_icono)
    
    def animar_particulas(self):
        for particle in self.particles:
            particle['y'] -= particle['speed']
            if particle['y'] < 0:
                particle['y'] = 280
                particle['x'] = random.randint(0, 450)
            
            alpha = int(50 + 50 * math.sin(math.radians(self.pulse + particle['x'])))
            color = f"#{alpha:02x}{alpha:02x}{min(alpha + 30, 255):02x}"
            
            self.canvas.create_oval(
                particle['x'], particle['y'],
                particle['x'] + particle['size'], 
                particle['y'] + particle['size'],
                fill=color, outline=""
            )
        
        self.dialog.after(50, self.animar_particulas)
    
    def cerrar(self):
        self.dialog.grab_release()
        self.dialog.destroy()
    
    def mostrar(self):
        self.dialog.wait_window()
        return self.resultado


class DialogoConfirmacion:
    
    def __init__(self, parent, titulo, mensaje, tipo="warning"):
        self.resultado = None
        self.dialog = tk.Toplevel(parent)
        self.dialog.title("")
        self.dialog.geometry("450x300")
        self.dialog.configure(bg="#0f172a")
        self.dialog.resizable(False, False)
        self.dialog.overrideredirect(True)
        
        # Centrar diálogo
        self.dialog.update_idletasks()
        x = parent.winfo_x() + (parent.winfo_width() // 2) - 225
        y = parent.winfo_y() + (parent.winfo_height() // 2) - 150
        self.dialog.geometry(f"450x300+{x}+{y}")
        
        self.angle = 0
        self.pulse = 0
        self.particles = []
        self._animando = True 
        
        for _ in range(15):
            self.particles.append({
                'x': random.randint(0, 450),
                'y': random.randint(0, 300),
                'speed': random.uniform(0.3, 1.5),
                'size': random.randint(1, 2)
            })
        
        self.canvas = tk.Canvas(self.dialog, width=450, height=300, 
                                bg="#0f172a", highlightthickness=0)
        self.canvas.pack(fill="both", expand=True)
        
        # Borde exterior
        self.canvas.create_rectangle(0, 0, 450, 300, outline="#334155", width=3)
        self.canvas.create_rectangle(3, 3, 447, 297, outline="#1e293b", width=2)
        
        colores = {
            "info": {"primario": "#38bdf8", "secundario": "#0ea5e9", "acento": "#22d3ee"},
            "success": {"primario": "#10b981", "secundario": "#059669", "acento": "#34d399"},
            "warning": {"primario": "#f59e0b", "secundario": "#d97706", "acento": "#fbbf24"},
            "error": {"primario": "#ef4444", "secundario": "#dc2626", "acento": "#f87171"}
        }
        self.colores = colores.get(tipo, colores["warning"])
        
        self.icono_elements = []
        self.icono_x, self.icono_y = 225, 80
        
        self.canvas.create_text(225, 150, 
                                text=titulo, 
                                font=("Segoe UI", 18, "bold"),
                                fill=self.colores["primario"])
        
        # Mensaje
        self.canvas.create_text(225, 195, 
                                text=mensaje, 
                                font=("Segoe UI", 11),
                                fill="#94a3b8",
                                width=380,
                                justify="center")
        
        # Botones
        self.crear_botones()
        
        self.animar_icono()
        self.animar_particulas()
        
        self.dialog.transient(parent)
        self.dialog.grab_set()
        
        # Sonido
        SONIDO_VOICE.play()
    
    def crear_botones(self):
        btn_si_x, btn_y = 160, 255
        
        self.canvas.create_rectangle(
            btn_si_x - 58, btn_y - 17, btn_si_x + 58, btn_y + 17,
            fill="#0a0f1a", outline=""
        )
        
        self.btn_si_bg = self.canvas.create_rectangle(
            btn_si_x - 60, btn_y - 18, btn_si_x + 60, btn_y + 18,
            fill="#10b981", outline="", tags="btn_si"
        )
        
        self.btn_si_border = self.canvas.create_rectangle(
            btn_si_x - 60, btn_y - 18, btn_si_x + 60, btn_y + 18,
            outline="#34d399", width=2, tags="btn_si"
        )
        
        self.canvas.create_text(
            btn_si_x, btn_y, 
            text="✓ Sí", 
            font=("Segoe UI", 12, "bold"),
            fill="white", tags="btn_si"
        )
        
        btn_no_x = 290
        
        self.canvas.create_rectangle(
            btn_no_x - 58, btn_y - 17, btn_no_x + 58, btn_y + 17,
            fill="#0a0f1a", outline=""
        )
        
        self.btn_no_bg = self.canvas.create_rectangle(
            btn_no_x - 60, btn_y - 18, btn_no_x + 60, btn_y + 18,
            fill="#ef4444", outline="", tags="btn_no"
        )
        
        self.btn_no_border = self.canvas.create_rectangle(
            btn_no_x - 60, btn_y - 18, btn_no_x + 60, btn_y + 18,
            outline="#f87171", width=2, tags="btn_no"
        )
        
        self.canvas.create_text(
            btn_no_x, btn_y, 
            text="✗ No", 
            font=("Segoe UI", 12, "bold"),
            fill="white", tags="btn_no"
        )
        
        def on_si_enter(e):
            self.canvas.itemconfig(self.btn_si_bg, fill="#059669")
            self.canvas.config(cursor="hand2")
        
        def on_si_leave(e):
            self.canvas.itemconfig(self.btn_si_bg, fill="#10b981")
            self.canvas.config(cursor="")
        
        def on_si_click(e):
            SONIDO_POWER.play()
            self.resultado = True
            self.cerrar()
        
        def on_no_enter(e):
            self.canvas.itemconfig(self.btn_no_bg, fill="#dc2626")
            self.canvas.config(cursor="hand2")
        
        def on_no_leave(e):
            self.canvas.itemconfig(self.btn_no_bg, fill="#ef4444")
            self.canvas.config(cursor="")
        
        def on_no_click(e):
            SONIDO_SOLTAR.play()
            self.resultado = False
            self.cerrar()
        
        self.canvas.tag_bind("btn_si", "<Enter>", on_si_enter)
        self.canvas.tag_bind("btn_si", "<Leave>", on_si_leave)
        self.canvas.tag_bind("btn_si", "<Button-1>", on_si_click)
        
        self.canvas.tag_bind("btn_no", "<Enter>", on_no_enter)
        self.canvas.tag_bind("btn_no", "<Leave>", on_no_leave)
        self.canvas.tag_bind("btn_no", "<Button-1>", on_no_click)
    
    def animar_icono(self):
        """Anima el icono de advertencia"""
        if not self._animando: 
            return
            
        self.angle = (self.angle + 4) % 360
        self.pulse = (self.pulse + 6) % 360
        
        for elem in self.icono_elements:
            self.canvas.delete(elem)
        self.icono_elements.clear()
        
        pulse_size = 25 + 3 * math.sin(math.radians(self.pulse))
        points = [
            self.icono_x, self.icono_y - pulse_size,  
            self.icono_x - pulse_size, self.icono_y + pulse_size//2, 
            self.icono_x + pulse_size, self.icono_y + pulse_size//2   
        ]
        elem = self.canvas.create_polygon(
            points,
            fill=self.colores["primario"],
            outline=self.colores["acento"], width=3
        )
        self.icono_elements.append(elem)
        
        elem = self.canvas.create_text(
            self.icono_x, self.icono_y - 5,
            text="!",
            font=("Segoe UI", 28, "bold"),
            fill="white"
        )
        self.icono_elements.append(elem)
        
        for i in range(3):
            angle = self.angle + (i * 120)
            x = self.icono_x + 40 * math.cos(math.radians(angle))
            y = self.icono_y + 40 * math.sin(math.radians(angle))
            size = 2 + math.sin(math.radians(self.pulse + i * 120))
            elem = self.canvas.create_oval(
                x - size, y - size, x + size, y + size,
                fill=self.colores["acento"], outline=""
            )
            self.icono_elements.append(elem)
        
        self.dialog.after(40, self.animar_icono)
    
    def animar_particulas(self):
        if not self._animando:  
            return
            
        for particle in self.particles:
            particle['y'] -= particle['speed']
            if particle['y'] < 0:
                particle['y'] = 300
                particle['x'] = random.randint(0, 450)
            
            alpha = int(50 + 50 * math.sin(math.radians(self.pulse + particle['x'])))
            color = f"#{alpha:02x}{alpha:02x}{min(alpha + 30, 255):02x}"
            
            self.canvas.create_oval(
                particle['x'], particle['y'],
                particle['x'] + particle['size'], 
                particle['y'] + particle['size'],
                fill=color, outline=""
            )
        
        self.dialog.after(50, self.animar_particulas)
    
    def cerrar(self):
        self._animando = False 
        self.dialog.grab_release()
        self.dialog.destroy()
    
    def mostrar(self):
        self.dialog.wait_window()
        return self.resultado


class ManualDetallado:
    
    def __init__(self, parent):
        self.dialog = tk.Toplevel(parent)
        self.dialog.title("")
        self.dialog.geometry("900x700")
        self.dialog.configure(bg="#0f172a")
        self.dialog.resizable(True, True)
        self.dialog.overrideredirect(False)  
        
        self.dialog.update_idletasks()
        x = parent.winfo_x() + (parent.winfo_width() // 2) - 450
        y = parent.winfo_y() + (parent.winfo_height() // 2) - 350
        self.dialog.geometry(f"900x700+{x}+{y}")
        
        self.angle = 0
        self.pulse = 0
        self._animando = True
        
        self.crear_interfaz()
        self.animar_header()
        
        self.dialog.transient(parent)
        self.dialog.grab_set()
        
        try:
            SONIDO_LECTURA.play()
        except:
            pass
    
    def crear_interfaz(self):
        header_frame = tk.Frame(self.dialog, bg="#1e293b", height=80)
        header_frame.pack(fill="x")
        header_frame.pack_propagate(False)
        
        self.header_canvas = tk.Canvas(header_frame, bg="#1e293b", 
                                       width=900, height=80, highlightthickness=0)
        self.header_canvas.pack(fill="both", expand=True)
        
        self.logo_elements = []
        
        self.header_canvas.create_text(450, 30,
                                       text="Manual del Sistema Experto",
                                       font=("Segoe UI", 24, "bold"),
                                       fill="#38bdf8")
        
        self.header_canvas.create_text(450, 55,
                                       text="Guía completa de uso y funcionamiento",
                                       font=("Segoe UI", 11),
                                       fill="#94a3b8")
        
        self.btn_cerrar_x = self.header_canvas.create_oval(
            840, 10, 890, 60,  # ahora 50x50
            fill="#ef4444", outline="#f87171", width=2
        )

        self.header_canvas.create_text(865, 30,
                                       text="",
                                       font=("Segoe UI", 18, "bold"),
                                       fill="white")
        
        self.header_canvas.tag_bind(self.btn_cerrar_x, "<Button-1>", lambda e: self.cerrar())
        self.header_canvas.tag_bind(self.btn_cerrar_x, "<Enter>", 
                                    lambda e: self.header_canvas.itemconfig(self.btn_cerrar_x, fill="#dc2626"))
        self.header_canvas.tag_bind(self.btn_cerrar_x, "<Leave>", 
                                    lambda e: self.header_canvas.itemconfig(self.btn_cerrar_x, fill="#ef4444"))
        
        main_frame = tk.Frame(self.dialog, bg="#0f172a")
        main_frame.pack(fill="both", expand=True, padx=10, pady=10)
        
        self.canvas = tk.Canvas(main_frame, bg="#0f172a", highlightthickness=0)
        scrollbar = tk.Scrollbar(main_frame, orient="vertical", command=self.canvas.yview)
        self.scrollable_frame = tk.Frame(self.canvas, bg="#0f172a")
        
        self.scrollable_frame.bind(
            "<Configure>",
            lambda e: self.canvas.configure(scrollregion=self.canvas.bbox("all"))
        )
        
        self.canvas.create_window((0, 0), window=self.scrollable_frame, anchor="nw")
        self.canvas.configure(yscrollcommand=scrollbar.set)
        
        self.canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")
        
        self.crear_contenido()
        
        self.canvas.bind_all("<MouseWheel>", self._on_mousewheel)
        self.canvas.bind_all("<Button-4>", self._on_mousewheel)
        self.canvas.bind_all("<Button-5>", self._on_mousewheel)
    
    def _on_mousewheel(self, event):
        try:
            if not self.canvas.winfo_exists():
                return
        except (AttributeError, tk.TclError):
            return
        
        try:
            if event.num == 5 or event.delta < 0:
                self.canvas.yview_scroll(1, "units")
            elif event.num == 4 or event.delta > 0:
                self.canvas.yview_scroll(-1, "units")
        except tk.TclError:
            pass
        except Exception as e:
            print(f"Error en mousewheel: {e}")
    
    def crear_seccion(self, titulo, contenido, icono="📌"):
        seccion_frame = tk.Frame(self.scrollable_frame, bg="#1e293b", 
                                relief="solid", bd=2)
        seccion_frame.pack(fill="x", padx=20, pady=15)
        
        titulo_frame = tk.Frame(seccion_frame, bg="#334155", height=50)
        titulo_frame.pack(fill="x")
        titulo_frame.pack_propagate(False)
        
        tk.Label(titulo_frame,
                text=f"{icono} {titulo}",
                font=("Segoe UI", 16, "bold"),
                bg="#334155",
                fg="#38bdf8").pack(anchor="w", padx=20, pady=10)
        
        contenido_label = tk.Label(seccion_frame,
                                   text=contenido,
                                   font=("Segoe UI", 11),
                                   bg="#1e293b",
                                   fg="#e2e8f0",
                                   justify="left",
                                   wraplength=800,
                                   padx=20,
                                   pady=20)
        contenido_label.pack(fill="x")
    
    def crear_imagen_referencia(self, descripcion, ruta_imagen):
            img_frame = tk.Frame(self.scrollable_frame, bg="#334155", 
                                relief="solid", bd=2, height=220)
            img_frame.pack(fill="x", padx=20, pady=10)
            img_frame.pack_propagate(False)
            
            canvas = tk.Canvas(img_frame, bg="#1e293b", highlightthickness=0)
            canvas.pack(fill="both", expand=True, padx=10, pady=10)
            
            try:
                from PIL import Image, ImageTk
                import os
                
                if os.path.exists(ruta_imagen):
                    imagen_original = Image.open(ruta_imagen)
                    
                    ancho_max = 800
                    alto_max = 180
                    
                    ancho_orig, alto_orig = imagen_original.size
                    ratio = min(ancho_max/ancho_orig, alto_max/alto_orig)
                    
                    nuevo_ancho = int(ancho_orig * ratio)
                    nuevo_alto = int(alto_orig * ratio)
                    
                    imagen_redimensionada = imagen_original.resize(
                        (nuevo_ancho, nuevo_alto), 
                        Image.Resampling.LANCZOS
                    )
                    
                    self.photo = ImageTk.PhotoImage(imagen_redimensionada)
                    
                    x_centro = 400
                    y_centro = 90
                    
                    canvas.create_image(
                        x_centro, y_centro, 
                        image=self.photo, 
                        anchor="center"
                    )
                    
                    if not hasattr(self, 'imagenes'):
                        self.imagenes = []
                    self.imagenes.append(self.photo)
                    
                else:
                    canvas.create_text(
                        400, 90,
                        text=f"Imagen no encontrada:\n{ruta_imagen}",
                        font=("Segoe UI", 11, "bold"),
                        fill="#f59e0b",
                        justify="center"
                    )
                    
            except ImportError:
                canvas.create_text(
                    400, 70,
                    text="Instalar PIL para ver imágenes",
                    font=("Segoe UI", 11, "bold"),
                    fill="#ef4444"
                )
                canvas.create_text(
                    400, 100,
                    text="pip install Pillow",
                    font=("Courier", 10),
                    fill="#94a3b8"
                )
                
            except Exception as e:
                canvas.create_text(
                    400, 90,
                    text=f"Error al cargar imagen:\n{str(e)}",
                    font=("Segoe UI", 10),
                    fill="#ef4444",
                    justify="center"
                )
            
            tk.Label(img_frame,
                    text=f"📷 {descripcion}",
                    font=("Segoe UI", 10, "italic"),
                    bg="#334155",
                    fg="#94a3b8").pack(pady=5)
    
    def crear_contenido(self):
        self.crear_seccion(
            "¿Qué es un Sistema Experto?",
            """Un Sistema Experto es un programa  que simula el conocimiento y razonamiento de un experto humano en un dominio específico.

Nuestro sistema experto está especializado en el diagnóstico de problemas de hardware en computadoras, utilizando una red semántica para analizar síntomas y determinar posibles fallas.

Características principales:
- Análisis de síntomas
- Diagnóstico basado en reglas existentes descritas en una base de conocimiento
- Interfaz interactiva con asistente virtual
- Historial de diagnósticos
- Generación de informes""",
            "*"
        )
        
        self.crear_imagen_referencia("Arquitectura del Sistema Experto","imagenes/arquitectura_sistema.jpg")
        
        # Cómo funciona
        self.crear_seccion(
            "¿Cómo Funciona?",
            """El sistema utiliza un motor de inferencia que procesa tus respuestas a través de:

1. BASE DE CONOCIMIENTOS
   Contiene reglas y hechos sobre problemas comunes de hardware, síntomas y soluciones.

2. MOTOR DE INFERENCIA
   Analiza respuestas y las compara con la base de conocimientos para generar conclusiones.

3. RED SEMÁNTICA
   Conecta componentes, síntomas y soluciones mediante relaciones lógicas.

4. INTERFAZ DE USUARIO
   Te guía a través de preguntas estratégicas para identificar el problema.

El asistente te acompañará durante todo el proceso, explicando cada paso.""",
            "*"
        )
        
        self.crear_imagen_referencia("Diagrama de Flujo del Motor de Inferencia","imagenes/motor_inferencia.jpg")
        
        self.crear_seccion(
            "Componentes que Diagnosticamos",
            """El sistema puede identificar problemas en los siguientes componentes:

CPU (Procesador)
   • Sobrecalentamiento
   • Fallas de rendimiento
   • Problemas de frecuencia

RAM (Memoria)
   • Módulos defectuosos
   • Incompatibilidad
   • Problemas de contacto

Disco Duro / SSD
   • Sectores dañados
   • Fallas mecánicas
   • Problemas de lectura/escritura

GPU (Tarjeta Gráfica)
   • Artefactos visuales
   • Sobrecalentamiento
   • Driver corrupto

Fuente de Poder
   • Voltaje insuficiente
   • Fallas intermitentes
   • Ruido eléctrico

Tarjeta Madre
   • Componentes quemados
   • Puertos USB dañados
   • Problemas de POST

Monitor
   • Sin señal
   • Píxeles muertos
   • Problemas de conexión

BIOS
   • Configuración incorrecta
   • Actualización necesaria
   • Batería agotada""",
            "*"
        )
        
        self.crear_imagen_referencia("Componentes de Hardware Principales","imagenes/componentes_hardware.jpg")
        
        # Guía de uso
        self.crear_seccion(
            "Guía de Uso Paso a Paso",
            """Sigue estos pasos para un diagnóstico efectivo:

PASO 1: INICIO
- Lee la explicación inicial del sistema
- Presiona "Iniciar Diagnóstico" cuando estés listo

PASO 2: CUESTIONARIO
- Responde SÍ o NO a cada pregunta
- Sé honesto y preciso en tus respuestas
- El asistente te guiará con su voz

PASO 3: ANÁLISIS
- El sistema procesará tus respuestas
- Observa el progreso en la barra
- Revisa el historial en tiempo real

PASO 4: RESULTADOS
- Genera el informe al finalizar
- Lee las recomendaciones
- Guarda el diagnóstico si es necesario

PASO 5: REINICIO (Opcional)
- Puedes reiniciar para un nuevo diagnóstico
- Tu historial anterior se borrará""",
            "*"
        )
        
        self.crear_seccion(
            "Controles y Funciones",
            """Botones del panel superior:

ASISTENTE
   Activa/desactiva la voz del asistente virtual

CAMBIAR VOZ
   Alterna entre voz en línea (Google) y voz local (pyttsx3)

MÚSICA DE FONDO
   Activa música ambiental relajante

SIGUIENTE CANCIÓN
   Cambia la pista de música actual

Botones del panel inferior:

CERRAR SISTEMA
   Sal del programa de forma segura

REINICIAR DIAGNÓSTICO
   Comienza un nuevo diagnóstico desde cero

GENERAR INFORME
   Crea un reporte detallado de los resultados""",
            "*"
        )
        
        self.crear_seccion(
            "Consejos para Mejores Resultados",
            """TIPS IMPORTANTES:

✓ Responde con precisión
  No adivines, si no estás seguro, verifica antes de responder.

✓ Observa tu computadora
  Ten tu equipo cerca para verificar síntomas físicos.

✓ Anota detalles
  Apunta cualquier mensaje de error o comportamiento extraño.

✓ Usa el historial
  Revisa tus respuestas anteriores en el panel derecho.

✓ No te apresures
  Tómate tu tiempo para responder cada pregunta.

✓ Consulta el manual
  Si tienes dudas, revisa esta guía en cualquier momento.

***IMPORTANTE***:
Este sistema es una herramienta de apoyo. Para problemas graves, consulta con un técnico profesional.""",
            "*"
        )
        
        self.crear_seccion(
            "¿Qué es la Red Semántica?",
            """La Red Semántica es el cerebro de nuestro sistema experto.

Es una estructura de conocimiento que representa:
- NODOS: Conceptos (componentes, síntomas, soluciones)
- ENLACES: Relaciones entre conceptos (causa, requiere, diagnostica)

Ejemplo de relación:
[CPU] --sobrecalienta--> [Ventilador defectuoso]
[RAM defectuosa] --causa--> [Pantallas azules]
[Fuente débil] --afecta--> [Reinicios aleatorios]

El motor de inferencia navega por esta red para encontrar diagnósticos precisos basándose en tus respuestas.""",
            "*"
        )
        
        self.crear_imagen_referencia("Ejemplo de Red Semántica del Sistema","imagenes/motor_inferencia.jpg")
        
        self.crear_seccion(
            "Soporte y Créditos",
            """Sistema Experto de Diagnóstico de Hardware
Versión 2.0 © 2025 - Sistema Experto""",
            "*"
        )
        
        tk.Frame(self.scrollable_frame, bg="#0f172a", height=50).pack()
    
    def animar_header(self):
        if not self._animando:
            return
        
        self.angle = (self.angle + 4) % 360
        self.pulse = (self.pulse + 6) % 360
        
        for elem in self.logo_elements:
            self.header_canvas.delete(elem)
        self.logo_elements.clear()
        
        cx, cy = 50, 40
        for i in range(4):
            angle = self.angle + (i * 90)
            x = cx + 20 * math.cos(math.radians(angle))
            y = cy + 20 * math.sin(math.radians(angle))
            size = 2 + math.sin(math.radians(self.pulse + i * 90))
            elem = self.header_canvas.create_oval(
                x - size, y - size, x + size, y + size,
                fill="#38bdf8", outline=""
            )
            self.logo_elements.append(elem)
        
        pulse_size = 8 + 2 * math.sin(math.radians(self.pulse))
        elem = self.header_canvas.create_oval(
            cx - pulse_size, cy - pulse_size,
            cx + pulse_size, cy + pulse_size,
            fill="#10b981", outline="#22d3ee", width=2
        )
        self.logo_elements.append(elem)
        
        self.dialog.after(50, self.animar_header)
    
    def cerrar(self):
        self._animando = False
        try:
            SONIDO_SOLTAR.play()
        except:
            pass
        self.dialog.grab_release()
        self.dialog.destroy()
    
    def mostrar(self):
        self.dialog.wait_window()


class DialogoRegistroEquipo:
    def __init__(self, parent):
        self.parent = parent
        self.resultado = None
        
    def mostrar(self):
        self.ventana = tk.Toplevel(self.parent)
        self.ventana.title("Registro de Equipo")
        self.ventana.geometry("500x650")
        self.ventana.configure(bg="#0f172a")
        self.ventana.transient(self.parent)
        self.ventana.after(10,lambda: self.ventana.grab_set())
        
        self.ventana.update_idletasks()
        x = (self.ventana.winfo_screenwidth() // 2) - 250
        y = (self.ventana.winfo_screenheight() // 2) - 300
        self.ventana.geometry(f"500x650+{x}+{y}")
        
        main_frame = tk.Frame(self.ventana, bg="#1e293b", padx=30, pady=30)
        main_frame.pack(fill="both", expand=True, padx=20, pady=20)
        
        tk.Label(main_frame, text="Registro de Equipo",
                font=("Segoe UI", 20, "bold"),
                bg="#1e293b", fg="#38bdf8").pack(pady=(0, 20))
        
        campos = [
            ("Nombre del técnico/usuario:", "nombre"),
            ("Correo electrónico:", "correo"),
            ("Marca del equipo:", "marca"),
            ("Modelo:", "modelo")
        ]
        
        self.entries = {}
        
        for label_text, key in campos:
            frame = tk.Frame(main_frame, bg="#1e293b")
            frame.pack(fill="x", pady=10)
            
            tk.Label(frame, text=label_text,
                    font=("Segoe UI", 11),
                    bg="#1e293b", fg="#94a3b8").pack(anchor="w")
            
            entry = tk.Entry(frame, font=("Segoe UI", 12),
                           bg="#0f172a", fg="white",
                           insertbackground="white")
            entry.pack(fill="x", pady=5)
            self.entries[key] = entry
        
        tipo_frame = tk.Frame(main_frame, bg="#1e293b")
        tipo_frame.pack(fill="x", pady=10)
        
        tk.Label(tipo_frame, text="Tipo de equipo:",
                font=("Segoe UI", 11),
                bg="#1e293b", fg="#94a3b8").pack(anchor="w")
        
        self.tipo_var = tk.StringVar(value="Desktop")
        tipos = ["Desktop", "Laptop", "Server", "All-in-One"]
        
        tipo_buttons = tk.Frame(tipo_frame, bg="#1e293b")
        tipo_buttons.pack(fill="x", pady=5)
        
        for tipo in tipos:
            tk.Radiobutton(tipo_buttons, text=tipo,
                          variable=self.tipo_var, value=tipo,
                          bg="#1e293b", fg="white",
                          selectcolor="#334155",
                          font=("Segoe UI", 10)).pack(side="left", padx=10)
        
        btn_frame = tk.Frame(main_frame, bg="#1e293b")
        btn_frame.pack(pady=20)
        
        tk.Button(btn_frame, text="✓ Iniciar Diagnóstico",
                 command=self.aceptar,
                 bg="#10b981", fg="white",
                 font=("Segoe UI", 12, "bold"),
                 padx=20, pady=10).pack(side="left", padx=10)
        
        tk.Button(btn_frame, text="✗ Cancelar",
                 command=self.cancelar,
                 bg="#ef4444", fg="white",
                 font=("Segoe UI", 12, "bold"),
                 padx=20, pady=10).pack(side="left", padx=10)
        
        self.ventana.wait_window()
        return self.resultado
    
    def aceptar(self):
        if not self.entries['nombre'].get() or not self.entries['correo'].get():
            DialogoPersonalizado(
                        self.ventana,
                        "Campos incompletos",
                        "Nombre y correo son obligatorios",
                        tipo="warning"
            ).mostrar()
            return
        
        self.resultado = {
            'nombre': self.entries['nombre'].get(),
            'correo': self.entries['correo'].get(),
            'marca': self.entries['marca'].get() or "Desconocido",
            'modelo': self.entries['modelo'].get() or "Desconocido",
            'tipo': self.tipo_var.get()
        }
        self.ventana.destroy()
    
    def cancelar(self):
        self.resultado = None
        self.ventana.destroy()


class DialogoInformeDiagnostico:
    def __init__(self, parent, diagnosticos, sesion_id):
        self.parent = parent
        self.diagnosticos = diagnosticos
        self.sesion_id = sesion_id
    
    def mostrar(self):
        self.ventana = tk.Toplevel(self.parent)
        self.ventana.title("Informe de Diagnóstico")
        self.ventana.geometry("900x700")
        self.ventana.configure(bg="#0f172a")
        self.ventana.transient(self.parent)
        
        main_frame = tk.Frame(self.ventana, bg="#0f172a")
        main_frame.pack(fill="both", expand=True, padx=20, pady=20)
        
        header = tk.Frame(main_frame, bg="#1e293b")
        header.pack(fill="x", pady=(0, 20))
        
        tk.Label(header, text="Informe Completo de Diagnóstico",
                font=("Segoe UI", 24, "bold"),
                bg="#1e293b", fg="#38bdf8").pack(pady=15)
        
        tk.Label(header, text=f"Sesión #{self.sesion_id}",
                font=("Segoe UI", 10),
                bg="#1e293b", fg="#64748b").pack()
        
        canvas_frame = tk.Frame(main_frame, bg="#0f172a")
        canvas_frame.pack(fill="both", expand=True)
        
        canvas = tk.Canvas(canvas_frame, bg="#0f172a", highlightthickness=0)
        scrollbar = tk.Scrollbar(canvas_frame, orient="vertical", command=canvas.yview)
        scrollable_frame = tk.Frame(canvas, bg="#0f172a")
        
        scrollable_frame.bind(
            "<Configure>",
            lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
        )
        
        canvas.create_window((0, 0), window=scrollable_frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)
        
        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")
        
        for i, diag in enumerate(self.diagnosticos, 1):
            self.crear_tarjeta_diagnostico(scrollable_frame, diag, i)
        
        btn_frame = tk.Frame(main_frame, bg="#0f172a")
        btn_frame.pack(pady=20)
        
        tk.Button(btn_frame, text="Exportar PDF",
                 command=self.exportar_pdf,
                 bg="#6366f1", fg="white",
                 font=("Segoe UI", 12, "bold"),
                 padx=20, pady=10).pack(side="left", padx=10)
        
        tk.Button(btn_frame, text="X Cerrar",
                 command=self.ventana.destroy,
                 bg="#10b981", fg="white",
                 font=("Segoe UI", 12, "bold"),
                 padx=20, pady=10).pack(side="left", padx=10)
    
    def crear_tarjeta_diagnostico(self, parent, diag, numero):
        card = tk.Frame(parent, bg="#1e293b", relief="solid", bd=2)
        card.pack(fill="x", pady=10, padx=10)
        header = tk.Frame(card, bg="#334155")
        header.pack(fill="x", padx=2, pady=2)
        
        tk.Label(header, text=f"Diagnóstico #{numero}",
                font=("Segoe UI", 14, "bold"),
                bg="#334155", fg="#38bdf8").pack(side="left", padx=15, pady=10)
        
        confianza_pct = int(diag['confianza'] * 100)
        color_confianza = "#10b981" if confianza_pct >= 80 else "#f59e0b" if confianza_pct >= 60 else "#ef4444"
        
        tk.Label(header, text=f"{confianza_pct}% Confianza",
                font=("Segoe UI", 10, "bold"),
                bg=color_confianza, fg="white",
                padx=10, pady=5).pack(side="right", padx=15)
        
        content = tk.Frame(card, bg="#1e293b")
        content.pack(fill="both", expand=True, padx=20, pady=15)
        
        tk.Label(content, text=diag['nombre'],
                font=("Segoe UI", 16, "bold"),
                bg="#1e293b", fg="white",
                wraplength=800, justify="left").pack(anchor="w", pady=(0, 10))
        
        comp_frame = tk.Frame(content, bg="#0f172a")
        comp_frame.pack(fill="x", pady=5)
        
        tk.Label(comp_frame, text="Componente:",
                font=("Segoe UI", 11, "bold"),
                bg="#0f172a", fg="#64748b").pack(side="left", padx=10)
        
        tk.Label(comp_frame, text=diag['componente'],
                font=("Segoe UI", 11),
                bg="#0f172a", fg="#38bdf8").pack(side="left")
        
        exp_frame = tk.Frame(content, bg="#0f172a")
        exp_frame.pack(fill="x", pady=10)
        
        tk.Label(exp_frame, text="Explicación:",
                font=("Segoe UI", 11, "bold"),
                bg="#0f172a", fg="#64748b").pack(anchor="w", padx=10, pady=(5, 0))
        
        tk.Label(exp_frame, text=diag['explicacion'],
                font=("Segoe UI", 10),
                bg="#0f172a", fg="#94a3b8",
                wraplength=780, justify="left").pack(anchor="w", padx=10, pady=(5, 10))
        
        sol_frame = tk.Frame(content, bg="#0f172a")
        sol_frame.pack(fill="x", pady=10)
        
        tk.Label(sol_frame, text="Solución Recomendada:",
                font=("Segoe UI", 11, "bold"),
                bg="#0f172a", fg="#64748b").pack(anchor="w", padx=10, pady=(5, 0))
        
        solucion_formateada = self.formatear_solucion(diag['solucion'])
        
        tk.Label(sol_frame, text=solucion_formateada,
                font=("Segoe UI", 10),
                bg="#0f172a", fg="#94a3b8",
                wraplength=780, justify="left").pack(anchor="w", padx=10, pady=(5, 10))
    
    def formatear_solucion(self, texto):
        lineas = texto.split('\n')
        formateado = '\n'.join(f"  {linea}" if linea.strip() else "" for linea in lineas)
        return formateado
    
    def exportar_pdf(self):
        try:
            from reportlab.lib.pagesizes import letter
            from reportlab.pdfgen import canvas
            from reportlab.lib.units import inch
            import os
            from datetime import datetime
            
            if not os.path.exists('reportes'):
                os.makedirs('reportes')
            
            filename = f"reportes/diagnostico_{self.sesion_id}_{datetime.now().strftime('%Y%m%d_%H%M%S')}.pdf"
            
            c = canvas.Canvas(filename, pagesize=letter)
            width, height = letter
            
            c.setFont("Helvetica-Bold", 20)
            c.drawString(1*inch, height - 1*inch, "Informe de Diagnóstico de Hardware")
            
            c.setFont("Helvetica", 10)
            c.drawString(1*inch, height - 1.3*inch, f"Sesión: #{self.sesion_id}")
            c.drawString(1*inch, height - 1.5*inch, f"Fecha: {datetime.now().strftime('%d/%m/%Y %H:%M')}")
            
            c.line(1*inch, height - 1.7*inch, width - 1*inch, height - 1.7*inch)
            
            y_position = height - 2*inch
            
            for i, diag in enumerate(self.diagnosticos, 1):
                if y_position < 2*inch:
                    c.showPage()
                    y_position = height - 1*inch
                
                c.setFont("Helvetica-Bold", 14)
                c.drawString(1*inch, y_position, f"Diagnóstico #{i}")
                y_position -= 0.3*inch
                
                c.setFont("Helvetica-Bold", 12)
                c.drawString(1*inch, y_position, diag['nombre'])
                y_position -= 0.25*inch
                
                c.setFont("Helvetica", 10)
                c.drawString(1*inch, y_position, f"Componente: {diag['componente']}")
                y_position -= 0.2*inch
                
                c.drawString(1*inch, y_position, f"Confianza: {int(diag['confianza']*100)}%")
                y_position -= 0.3*inch
                
                c.setFont("Helvetica-Bold", 10)
                c.drawString(1*inch, y_position, "Explicación:")
                y_position -= 0.2*inch
                
                c.setFont("Helvetica", 9)
                texto_explicacion = diag['explicacion']
                max_width = 90
                palabras = texto_explicacion.split()
                linea_actual = ""
                
                for palabra in palabras:
                    if len(linea_actual + palabra) < max_width:
                        linea_actual += palabra + " "
                    else:
                        c.drawString(1.2*inch, y_position, linea_actual)
                        y_position -= 0.15*inch
                        linea_actual = palabra + " "
                
                if linea_actual:
                    c.drawString(1.2*inch, y_position, linea_actual)
                    y_position -= 0.3*inch
                
                c.setFont("Helvetica-Bold", 10)
                c.drawString(1*inch, y_position, "Solución:")
                y_position -= 0.2*inch
                
                c.setFont("Helvetica", 9)
                lineas_solucion = diag['solucion'].split('\n')
                for linea in lineas_solucion[:5]: 
                    if y_position < 1*inch:
                        break
                    c.drawString(1.2*inch, y_position, linea[:100])
                    y_position -= 0.15*inch
                
                y_position -= 0.5*inch
            
            c.save()

        
            DialogoPersonalizado(
                        self.ventana,
                        "Exportación exitosa",
                        f"PDF generado:\n{filename}",
                        tipo="success"
            ).mostrar()
            
            import subprocess
            import platform
            if platform.system() == 'Windows':
                os.startfile(filename)
            elif platform.system() == 'Darwin': 
                subprocess.call(['open', filename])
            else:  
                subprocess.call(['xdg-open', filename], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

                
        except ImportError:
            DialogoPersonalizado(
                        self.ventana,
                        "Módulo faltante",
                        "Instalar reportlab para exportar PDF:\npip install reportlab",
                        tipo="error"
            ).mostrar()
        except Exception as e:
            DialogoPersonalizado(
                        self.ventana,
                        "Error:",
                        f"No se pudo exportar PDF:\n{str(e)}",
                        tipo="error"
            ).mostrar()


class DialogoHistorial:
    def __init__(self, parent):
        self.parent = parent
        self.sesion_seleccionada = None
        self.angle = 0
        self.pulse = 0
        self._animando = True
        
        from database_hardware import (
            obtener_todas_sesiones,
            obtener_diagnosticos_por_sesion,
            obtener_sintomas_por_sesion,
            eliminar_sesion,
            obtener_estadisticas_generales
        )
        
        self.obtener_sesiones = obtener_todas_sesiones
        self.obtener_diagnosticos = obtener_diagnosticos_por_sesion
        self.obtener_sintomas = obtener_sintomas_por_sesion
        self.eliminar_sesion = eliminar_sesion
        self.obtener_stats = obtener_estadisticas_generales
    
    def mostrar(self):
        self.ventana = tk.Toplevel(self.parent)
        self.ventana.title("Historial de Diagnósticos")
        self.ventana.geometry("1200x800")
        self.ventana.configure(bg="#0f172a")
        self.ventana.transient(self.parent)
        
        self.ventana.update_idletasks()
        x = (self.ventana.winfo_screenwidth() // 2) - 600
        y = (self.ventana.winfo_screenheight() // 2) - 400
        self.ventana.geometry(f"1200x800+{x}+{y}")
        
        header_frame = tk.Frame(self.ventana, bg="#1e293b", height=100)
        header_frame.pack(fill="x")
        header_frame.pack_propagate(False)
        
        self.header_canvas = tk.Canvas(header_frame, bg="#1e293b", 
                                       width=1200, height=100, highlightthickness=0)
        self.header_canvas.pack(fill="both", expand=True)
        
        self.logo_elements = []
        
        self.header_canvas.create_text(600, 35,
                                       text="Historial de Diagnósticos",
                                       font=("Segoe UI", 26, "bold"),
                                       fill="#38bdf8")
        
        self.header_canvas.create_text(600, 65,
                                       text="Consulta, edita o elimina sesiones anteriores",
                                       font=("Segoe UI", 11),
                                       fill="#94a3b8")
        
        stats_frame = tk.Frame(self.ventana, bg="#1e293b", height=80)
        stats_frame.pack(fill="x", padx=20, pady=(10, 0))
        stats_frame.pack_propagate(False)
        
        self.crear_panel_estadisticas(stats_frame)
        
        main_container = tk.Frame(self.ventana, bg="#0f172a")
        main_container.pack(fill="both", expand=True, padx=20, pady=10)
        
        left_panel = tk.Frame(main_container, bg="#1e293b", width=400)
        left_panel.pack(side="left", fill="both", padx=(0, 10))
        left_panel.pack_propagate(False)
        
        tk.Label(left_panel, text="Sesiones Registradas",
                font=("Segoe UI", 14, "bold"),
                bg="#1e293b", fg="#38bdf8").pack(pady=10)
        
        self.lista_canvas = tk.Canvas(left_panel, bg="#0f172a", highlightthickness=0)
        lista_scroll = tk.Scrollbar(left_panel, orient="vertical", command=self.lista_canvas.yview)
        self.lista_frame = tk.Frame(self.lista_canvas, bg="#0f172a")
        
        self.lista_frame.bind(
            "<Configure>",
            lambda e: self.lista_canvas.configure(scrollregion=self.lista_canvas.bbox("all"))
        )
        
        self.lista_canvas.create_window((0, 0), window=self.lista_frame, anchor="nw")
        self.lista_canvas.configure(yscrollcommand=lista_scroll.set)
        
        self.lista_canvas.pack(side="left", fill="both", expand=True, padx=5, pady=5)
        lista_scroll.pack(side="right", fill="y")
        
        right_panel = tk.Frame(main_container, bg="#1e293b")
        right_panel.pack(side="left", fill="both", expand=True)
        
        tk.Label(right_panel, text="Detalles de la Sesión",
                font=("Segoe UI", 14, "bold"),
                bg="#1e293b", fg="#38bdf8").pack(pady=10)
        
        self.detalles_canvas = tk.Canvas(right_panel, bg="#0f172a", highlightthickness=0)
        detalles_scroll = tk.Scrollbar(right_panel, orient="vertical", command=self.detalles_canvas.yview)
        self.detalles_frame = tk.Frame(self.detalles_canvas, bg="#0f172a")
        
        self.detalles_frame.bind(
            "<Configure>",
            lambda e: self.detalles_canvas.configure(scrollregion=self.detalles_canvas.bbox("all"))
        )
        
        self.detalles_canvas.create_window((0, 0), window=self.detalles_frame, anchor="nw")
        self.detalles_canvas.configure(yscrollcommand=detalles_scroll.set)
        
        self.detalles_canvas.pack(side="left", fill="both", expand=True, padx=5, pady=5)
        detalles_scroll.pack(side="right", fill="y")
        
        tk.Label(self.detalles_frame,
                text="Selecciona una sesión para ver detalles",
                font=("Segoe UI", 12),
                bg="#0f172a", fg="#64748b").pack(pady=100)
        
        btn_frame = tk.Frame(self.ventana, bg="#0f172a")
        btn_frame.pack(pady=15)
        
        tk.Button(btn_frame, text="Actualizar",
                 command=self.actualizar_lista,
                 bg="#6366f1", fg="white",
                 font=("Segoe UI", 11, "bold"),
                 padx=20, pady=8).pack(side="left", padx=5)
        
        tk.Button(btn_frame, text="✖ Cerrar",
                 command=self.cerrar,
                 bg="#10b981", fg="white",
                 font=("Segoe UI", 11, "bold"),
                 padx=20, pady=8).pack(side="left", padx=5)
        
        self.cargar_sesiones()
        
        self.animar_header()
        
        self.ventana.transient(self.parent)
        self.ventana.grab_set()
        
        try:
            SONIDO_LECTURA.play()
        except:
            pass
    
    def crear_panel_estadisticas(self, parent):
        stats = self.obtener_stats()
        
        stats_items = [
            ("Total Sesiones", str(stats['total_sesiones']), "#38bdf8"),
            ("Diagnósticos", str(stats['total_diagnosticos']), "#10b981"),
            ("Componente Crítico", stats['componente_critico'], "#f59e0b"),
            ("Confianza Promedio", f"{stats['confianza_promedio']}%", "#8b5cf6")
        ]
        
        for i, (titulo, valor, color) in enumerate(stats_items):
            item_frame = tk.Frame(parent, bg="#334155", relief="solid", bd=1)
            item_frame.pack(side="left", fill="both", expand=True, padx=5, pady=10)
            
            tk.Label(item_frame, text=titulo,
                    font=("Segoe UI", 9),
                    bg="#334155", fg="#94a3b8").pack(pady=(8, 2))
            
            tk.Label(item_frame, text=valor,
                    font=("Segoe UI", 14, "bold"),
                    bg="#334155", fg=color).pack(pady=(0, 8))
    
    def cargar_sesiones(self):
        for widget in self.lista_frame.winfo_children():
            widget.destroy()
        
        sesiones = self.obtener_sesiones()
        
        if not sesiones:
            tk.Label(self.lista_frame,
                    text="No hay sesiones registradas",
                    font=("Segoe UI", 11),
                    bg="#0f172a", fg="#64748b").pack(pady=50)
            return
        
        for sesion in sesiones:
            self.crear_tarjeta_sesion(sesion)
    
    def crear_tarjeta_sesion(self, sesion):
        id_sesion, fecha_inicio, fecha_fin, estado, usuario, marca, modelo, tipo, num_diag = sesion
        
        card = tk.Frame(self.lista_frame, bg="#1e293b", relief="solid", bd=2)
        card.pack(fill="x", padx=5, pady=5)
        
        header = tk.Frame(card, bg="#334155")
        header.pack(fill="x")
        
        tk.Label(header, text=f"Sesión #{id_sesion}",
                font=("Segoe UI", 12, "bold"),
                bg="#334155", fg="#38bdf8").pack(side="left", padx=10, pady=8)
        
        color_estado = {
            'en_progreso': '#f59e0b',
            'completado': '#10b981',
            'cancelado': '#ef4444'
        }.get(estado, '#64748b')
        
        tk.Label(header, text=estado.upper(),
                font=("Segoe UI", 8, "bold"),
                bg=color_estado, fg="white",
                padx=8, pady=3).pack(side="right", padx=10)
        
        content = tk.Frame(card, bg="#1e293b")
        content.pack(fill="x", padx=10, pady=8)
        
        tk.Label(content, text=f"USUARIO: {usuario}",
                font=("Segoe UI", 10),
                bg="#1e293b", fg="#e2e8f0").pack(anchor="w")
        
        tk.Label(content, text=f"MARCA: {marca} {modelo} ({tipo})",
                font=("Segoe UI", 9),
                bg="#1e293b", fg="#94a3b8").pack(anchor="w", pady=2)
        
        fecha_fmt = fecha_inicio.split('.')[0] if fecha_inicio else "N/A"
        tk.Label(content, text=f"FECHA: {fecha_fmt}",
                font=("Segoe UI", 8),
                bg="#1e293b", fg="#64748b").pack(anchor="w")
        
        tk.Label(content, text=f"T:{num_diag} diagnóstico(s)",
                font=("Segoe UI", 9, "bold"),
                bg="#1e293b", fg="#22d3ee").pack(anchor="w", pady=(5, 0))
        
        btn_frame = tk.Frame(card, bg="#1e293b")
        btn_frame.pack(fill="x", padx=10, pady=(0, 8))
        
        tk.Button(btn_frame, text="Ver",
                 command=lambda: self.ver_detalles(id_sesion),
                 bg="#3b82f6", fg="white",
                 font=("Segoe UI", 9, "bold"),
                 padx=15, pady=3).pack(side="left", padx=2)
        
        tk.Button(btn_frame, text="* Editar",
                 command=lambda: self.editar_sesion(id_sesion),
                 bg="#8b5cf6", fg="white",
                 font=("Segoe UI", 9, "bold"),
                 padx=15, pady=3).pack(side="left", padx=2)
        
        tk.Button(btn_frame, text="X Eliminar",
                 command=lambda: self.confirmar_eliminar(id_sesion),
                 bg="#ef4444", fg="white",
                 font=("Segoe UI", 9, "bold"),
                 padx=15, pady=3).pack(side="left", padx=2)
    
    def ver_detalles(self, id_sesion):
        try:
            SONIDO_CLICK.play()
        except:
            pass
        
        self.sesion_seleccionada = id_sesion
        
        for widget in self.detalles_frame.winfo_children():
            widget.destroy()
        
        diagnosticos = self.obtener_diagnosticos(id_sesion)
        sintomas = self.obtener_sintomas(id_sesion)
        
        titulo_frame = tk.Frame(self.detalles_frame, bg="#334155")
        titulo_frame.pack(fill="x", padx=10, pady=10)
        
        tk.Label(titulo_frame, text=f"Sesión #{id_sesion} - Detalle Completo",
                font=("Segoe UI", 16, "bold"),
                bg="#334155", fg="#38bdf8").pack(padx=15, pady=12)
        
        if diagnosticos:
            diag_header = tk.Frame(self.detalles_frame, bg="#0f172a")
            diag_header.pack(fill="x", padx=10, pady=(10, 5))
            
            tk.Label(diag_header, text="Diagnósticos Encontrados",
                    font=("Segoe UI", 13, "bold"),
                    bg="#0f172a", fg="#10b981").pack(anchor="w", padx=5)
            
            for diag in diagnosticos:
                self.crear_tarjeta_diagnostico_detalle(diag)
        else:
            tk.Label(self.detalles_frame,
                    text="No se encontraron diagnósticos",
                    font=("Segoe UI", 11),
                    bg="#0f172a", fg="#64748b").pack(pady=20)
        
        if sintomas:
            sint_header = tk.Frame(self.detalles_frame, bg="#0f172a")
            sint_header.pack(fill="x", padx=10, pady=(20, 5))
            
            tk.Label(sint_header, text="Síntomas Registrados",
                    font=("Segoe UI", 13, "bold"),
                    bg="#0f172a", fg="#f59e0b").pack(anchor="w", padx=5)
            
            sintomas_frame = tk.Frame(self.detalles_frame, bg="#1e293b", relief="solid", bd=1)
            sintomas_frame.pack(fill="x", padx=10, pady=5)
            
            headers = ["Categoría", "Síntoma", "Respuesta", "Severidad"]
            header_row = tk.Frame(sintomas_frame, bg="#334155")
            header_row.pack(fill="x")
            
            for header in headers:
                tk.Label(header_row, text=header,
                        font=("Segoe UI", 9, "bold"),
                        bg="#334155", fg="#94a3b8",
                        width=15).pack(side="left", padx=5, pady=5)
            
            for categoria, sintoma, respuesta, severidad, timestamp in sintomas[:20]: 
                row = tk.Frame(sintomas_frame, bg="#1e293b")
                row.pack(fill="x")
                
                tk.Label(row, text=categoria[:15],
                        font=("Segoe UI", 8),
                        bg="#1e293b", fg="#e2e8f0",
                        width=15, anchor="w").pack(side="left", padx=5, pady=2)
                
                tk.Label(row, text=sintoma[:15],
                        font=("Segoe UI", 8),
                        bg="#1e293b", fg="#94a3b8",
                        width=15, anchor="w").pack(side="left", padx=5, pady=2)
                
                color_resp = "#10b981" if respuesta.lower() == "si" else "#ef4444"
                tk.Label(row, text=respuesta.upper(),
                        font=("Segoe UI", 8, "bold"),
                        bg="#1e293b", fg=color_resp,
                        width=15, anchor="w").pack(side="left", padx=5, pady=2)
                
                sev_text = str(severidad) if severidad else "N/A"
                tk.Label(row, text=sev_text,
                        font=("Segoe UI", 8),
                        bg="#1e293b", fg="#64748b",
                        width=15, anchor="w").pack(side="left", padx=5, pady=2)
    
    def crear_tarjeta_diagnostico_detalle(self, diagnostico):
        id_diag, componente, tipo_falla, confianza, desc, solucion, prioridad, costo, tiempo = diagnostico
        
        card = tk.Frame(self.detalles_frame, bg="#1e293b", relief="solid", bd=2)
        card.pack(fill="x", padx=10, pady=5)
        
        header = tk.Frame(card, bg="#334155")
        header.pack(fill="x")
        
        tk.Label(header, text=f"⚠️ {componente}",
                font=("Segoe UI", 12, "bold"),
                bg="#334155", fg="#38bdf8").pack(side="left", padx=15, pady=8)
        
        confianza_pct = int(confianza * 100) if confianza else 0
        color_conf = "#10b981" if confianza_pct >= 80 else "#f59e0b" if confianza_pct >= 60 else "#ef4444"
        
        tk.Label(header, text=f"{confianza_pct}%",
                font=("Segoe UI", 11, "bold"),
                bg=color_conf, fg="white",
                padx=12, pady=5).pack(side="right", padx=15)
        
        content = tk.Frame(card, bg="#1e293b")
        content.pack(fill="both", expand=True, padx=15, pady=10)
        
        tk.Label(content, text=f"Tipo: {tipo_falla}",
                font=("Segoe UI", 10, "bold"),
                bg="#1e293b", fg="#e2e8f0").pack(anchor="w", pady=2)
        
        if desc:
            tk.Label(content, text="Descripción:",
                    font=("Segoe UI", 9, "bold"),
                    bg="#1e293b", fg="#94a3b8").pack(anchor="w", pady=(8, 2))
            
            tk.Label(content, text=desc,
                    font=("Segoe UI", 9),
                    bg="#1e293b", fg="#cbd5e1",
                    wraplength=650, justify="left").pack(anchor="w", padx=10)
        
        if solucion:
            tk.Label(content, text="Solución:",
                    font=("Segoe UI", 9, "bold"),
                    bg="#1e293b", fg="#94a3b8").pack(anchor="w", pady=(8, 2))
            
            tk.Label(content, text=solucion,
                    font=("Segoe UI", 9),
                    bg="#1e293b", fg="#cbd5e1",
                    wraplength=650, justify="left").pack(anchor="w", padx=10)
        
        info_frame = tk.Frame(content, bg="#0f172a")
        info_frame.pack(fill="x", pady=(10, 0))
        
        if prioridad:
            color_prior = {
                'critica': '#ef4444',
                'alta': '#f59e0b',
                'media': '#3b82f6',
                'baja': '#10b981'
            }.get(prioridad.lower(), '#64748b')
            
            tk.Label(info_frame, text=f"Prioridad: {prioridad.upper()}",
                    font=("Segoe UI", 8, "bold"),
                    bg=color_prior, fg="white",
                    padx=8, pady=3).pack(side="left", padx=5)
        
        if costo:
            tk.Label(info_frame, text=f"Costo: ${costo:.2f}",
                    font=("Segoe UI", 8),
                    bg="#0f172a", fg="#94a3b8",
                    padx=8, pady=3).pack(side="left", padx=5)
        
        if tiempo:
            tk.Label(info_frame, text=f"Tiempo: {tiempo}",
                    font=("Segoe UI", 8),
                    bg="#0f172a", fg="#94a3b8",
                    padx=8, pady=3).pack(side="left", padx=5)
        
        tk.Button(content, text="Editar este diagnóstico",
                 command=lambda: self.editar_diagnostico(id_diag, desc, solucion, prioridad),
                 bg="#8b5cf6", fg="white",
                 font=("Segoe UI", 9, "bold"),
                 padx=12, pady=5).pack(anchor="w", pady=(10, 0))
    
    def editar_diagnostico(self, id_diag, desc_actual, sol_actual, prior_actual):
        from database_hardware import actualizar_diagnostico
        
        edit_win = tk.Toplevel(self.ventana)
        edit_win.title("Editar Diagnóstico")
        edit_win.geometry("600x610")
        edit_win.configure(bg="#1e293b")
        edit_win.transient(self.ventana)
        edit_win.grab_set()
        
        edit_win.update_idletasks()
        x = (edit_win.winfo_screenwidth() // 2) - 300
        y = (edit_win.winfo_screenheight() // 2) - 250
        edit_win.geometry(f"600x610+{x}+{y}")
        
        main_frame = tk.Frame(edit_win, bg="#1e293b", padx=20, pady=20)
        main_frame.pack(fill="both", expand=True)
        
        tk.Label(main_frame, text="Editar Diagnóstico",
                font=("Segoe UI", 18, "bold"),
                bg="#1e293b", fg="#38bdf8").pack(pady=(0, 20))
        
        tk.Label(main_frame, text="Descripción:",
                font=("Segoe UI", 11, "bold"),
                bg="#1e293b", fg="#94a3b8").pack(anchor="w", pady=(10, 5))
        
        desc_text = tk.Text(main_frame, height=6, font=("Segoe UI", 10),
                           bg="#0f172a", fg="white", wrap="word")
        desc_text.pack(fill="x", pady=(0, 10))
        desc_text.insert("1.0", desc_actual or "")
        
        tk.Label(main_frame, text="Solución:",
                font=("Segoe UI", 11, "bold"),
                bg="#1e293b", fg="#94a3b8").pack(anchor="w", pady=(10, 5))
        
        sol_text = tk.Text(main_frame, height=8, font=("Segoe UI", 10),
                          bg="#0f172a", fg="white", wrap="word")
        sol_text.pack(fill="x", pady=(0, 10))
        sol_text.insert("1.0", sol_actual or "")
        
        tk.Label(main_frame, text="Prioridad:",
                font=("Segoe UI", 11, "bold"),
                bg="#1e293b", fg="#94a3b8").pack(anchor="w", pady=(10, 5))
        
        prior_var = tk.StringVar(value=prior_actual or "media")
        prior_frame = tk.Frame(main_frame, bg="#1e293b")
        prior_frame.pack(anchor="w", pady=(0, 20))
        
        for prioridad in ["critica", "alta", "media", "baja"]:
            tk.Radiobutton(prior_frame, text=prioridad.capitalize(),
                          variable=prior_var, value=prioridad,
                          bg="#1e293b", fg="white",
                          selectcolor="#334155",
                          font=("Segoe UI", 10)).pack(side="left", padx=10)
        
        btn_frame = tk.Frame(main_frame, bg="#1e293b")
        btn_frame.pack(pady=10)
        
        def guardar():
            nueva_desc = desc_text.get("1.0", "end-1c").strip()
            nueva_sol = sol_text.get("1.0", "end-1c").strip()
            nueva_prior = prior_var.get()
            
            if actualizar_diagnostico(id_diag, nueva_desc, nueva_sol, nueva_prior):
                try:
                    SONIDO_POWER.play()
                except:
                    pass
                DialogoPersonalizado(
                        edit_win,
                        "Éxito",
                        "Diagnóstico actualizado correctamente",
                        tipo="success"
                ).mostrar()

                edit_win.destroy()
                self.ver_detalles(self.sesion_seleccionada) 
            else:
                DialogoPersonalizado(
                        edit_win,
                        "Error",
                        "No se pudo actualizar el diagnóstico",
                        tipo="error"
                ).mostrar()
        
        tk.Button(btn_frame, text="Guardar Cambios",
                 command=guardar,
                 bg="#10b981", fg="white",
                 font=("Segoe UI", 11, "bold"),
                 padx=20, pady=8).pack(side="left", padx=5)
        
        tk.Button(btn_frame, text="Cancelar",
                 command=edit_win.destroy,
                 bg="#ef4444", fg="white",
                 font=("Segoe UI", 11, "bold"),
                 padx=20, pady=8).pack(side="left", padx=5)
    
    def editar_sesion(self, id_sesion):
        DialogoPersonalizado(
                self.ventana,
                f"INFO: Editar Sesión #{id_sesion}\n",
                "Por ahora puedes editar diagnósticos individuales usando el botón 'Ver'",
                tipo="info"
        ).mostrar()
    
    def confirmar_eliminar(self, id_sesion):
        resultado = DialogoConfirmacion(
            self.ventana,
            "⚠️ Eliminar Sesión",
            f"¿Estás seguro de que deseas eliminar la sesión #{id_sesion}?\n\n"
            "Esta acción eliminará:\n"
            "• Todos los diagnósticos\n"
            "• Todos los síntomas registrados\n"
            "• Todas las evaluaciones de componentes\n\n"
            "Esta acción NO se puede deshacer.",
            tipo="error"
        ).mostrar()
        
        if resultado:
            if self.eliminar_sesion(id_sesion):
                try:
                    SONIDO_BREAK.play()
                except:
                    pass

                DialogoPersonalizado(
                            self.ventana,
                            "Eliminado",
                            "eliminada correctamente",
                            tipo="success"
                ).mostrar()

                self.actualizar_lista()
                
                if self.sesion_seleccionada == id_sesion:
                    for widget in self.detalles_frame.winfo_children():
                        widget.destroy()
                    tk.Label(self.detalles_frame,
                            text="Selecciona una sesión para ver detalles",
                            font=("Segoe UI", 12),
                            bg="#0f172a", fg="#64748b").pack(pady=100)
            else:
                DialogoPersonalizado(
                            self.ventana,
                            "Error",
                            "No se pudo eliminar la sesión",
                            tipo="error"
                ).mostrar()
    
    def actualizar_lista(self):
        try:
            SONIDO_CHANGE.play()
        except:
            pass
        
        self.cargar_sesiones()
        
        for widget in self.ventana.winfo_children():
            if isinstance(widget, tk.Frame):
                for child in widget.winfo_children():
                    if isinstance(child, tk.Frame) and child.winfo_height() == 80:
                        for w in child.winfo_children():
                            w.destroy()
                        self.crear_panel_estadisticas(child)
                        break
                break
    
    def animar_header(self):
        if not self._animando:
            return
        
        try:
            if not self.ventana.winfo_exists():
                self._animando = False
                return
        except:
            self._animando = False
            return
        
        self.angle = (self.angle + 4) % 360
        self.pulse = (self.pulse + 6) % 360
        
        for elem in self.logo_elements:
            try:
                self.header_canvas.delete(elem)
            except:
                pass
        self.logo_elements.clear()
        
        cx, cy = 50, 50
        
        ring_size = 30 + 3 * math.sin(math.radians(self.pulse))
        elem = self.header_canvas.create_oval(
            cx - ring_size, cy - ring_size,
            cx + ring_size, cy + ring_size,
            outline="#38bdf8", width=2
        )
        self.logo_elements.append(elem)
        
        for i in range(6):
            angle = self.angle + (i * 60)
            x = cx + 25 * math.cos(math.radians(angle))
            y = cy + 25 * math.sin(math.radians(angle))
            size = 2 + math.sin(math.radians(self.pulse + i * 60))
            elem = self.header_canvas.create_oval(
                x - size, y - size, x + size, y + size,
                fill="#22d3ee", outline=""
            )
            self.logo_elements.append(elem)
        
        pulse_size = 12 + 3 * math.sin(math.radians(self.pulse))
        elem = self.header_canvas.create_oval(
            cx - pulse_size, cy - pulse_size,
            cx + pulse_size, cy + pulse_size,
            fill="#10b981", outline="#22d3ee", width=2
        )
        self.logo_elements.append(elem)
        
        elem = self.header_canvas.create_text(
            cx, cy,
            text="BD",
            font=("Segoe UI", 16)
        )
        self.logo_elements.append(elem)
        
        try:
            self.ventana.after(50, self.animar_header)
        except:
            self._animando = False
    
    def cerrar(self):
        self._animando = False
        try:
            SONIDO_SOLTAR.play()
        except:
            pass
        self.ventana.grab_release()
        self.ventana.destroy()
