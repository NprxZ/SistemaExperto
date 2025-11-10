from moduos import inferencia
import tkinter as tk
from tkinter import ttk, messagebox, filedialog
from PIL import Image, ImageTk
from gtts import gTTS
import pygame
import platform
import math
import random
import pyttsx3
import threading
import time
import urllib.request
import os
import urllib.parse
import socket
import cv2
import playsound




class SistemaExpertoUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Sistema Experto - Diagnóstico de Computadoras")
        self.root.geometry("1200x800")
        self.root.configure(bg="#0f172a")

        self.angle = 0
        self.pulse = 0
        self.current_question = 0

        self.preguntas = [
            "¿Tu computadora enciende correctamente?",
            "¿Escuchas pitidos al encender el equipo?",
            "¿La pantalla muestra alguna imagen?",
            "¿El ventilador del CPU está funcionando?",
            "¿Has notado sobrecalentamiento en el equipo?",
            "¿La computadora se reinicia aleatoriamente?",
            "¿Tienes problemas con la velocidad del sistema?",
            "¿El disco duro hace ruidos extraños?",
            "¿Aparecen mensajes de error en pantalla?",
            "¿Los puertos USB funcionan correctamente?"
        ]

        self.componentes = [
            "CPU", "RAM", "Disco Duro", "Tarjeta Madre",
            "GPU", "Fuente de Poder", "Monitor", "BIOS", "SSD"
        ]

        self.crear_interfaz()
        self.animar()

    def crear_interfaz(self):
        header_frame = tk.Frame(self.root, bg="#1e293b", height=100)
        header_frame.pack(fill="x", padx=20, pady=20)
        header_frame.pack_propagate(False)

        self.logo_canvas = tk.Canvas(header_frame, width=80, height=80, bg="#1e293b", highlightthickness=0)
        self.logo_canvas.pack(side="left", padx=20)

        title_frame = tk.Frame(header_frame, bg="#1e293b")
        title_frame.pack(side="left", fill="both", expand=True)

        title_label = tk.Label(title_frame,
                               text="Sistema Experto de Diagnóstico",
                               font=("Segoe UI", 28, "bold"),
                               bg="#1e293b",
                               fg="#38bdf8")
        title_label.pack(anchor="w", pady=(15, 0))

        subtitle_label = tk.Label(title_frame,
                                  text="Diagnóstico inteligente de problemas de Hardware",
                                  font=("Segoe UI", 12),
                                  bg="#1e293b",
                                  fg="#94a3b8")
        subtitle_label.pack(anchor="w")

        main_container = tk.Frame(self.root, bg="#0f172a")
        main_container.pack(fill="both", expand=True, padx=20, pady=(0, 20))

        left_panel = tk.Frame(main_container, bg="#1e293b", width=300)
        left_panel.pack(side="left", fill="both", padx=(0, 10))
        left_panel.pack_propagate(False)

        status_title = tk.Label(left_panel,
                                text="Estado del Sistema",
                                font=("Segoe UI", 14, "bold"),
                                bg="#1e293b",
                                fg="#38bdf8")
        status_title.pack(pady=15)

        self.comp_canvas = tk.Canvas(left_panel, bg="#0f172a", highlightthickness=0)
        self.comp_canvas.pack(fill="both", expand=True, padx=10, pady=10)

        center_panel = tk.Frame(main_container, bg="#1e293b")
        center_panel.pack(side="left", fill="both", expand=True, padx=10)

        question_container = tk.Frame(center_panel, bg="#0f172a")
        question_container.pack(fill="both", expand=True, padx=15, pady=15)

        question_header = tk.Label(question_container,
                                   text="Cuestionario de Diagnóstico",
                                   font=("Segoe UI", 16, "bold"),
                                   bg="#0f172a",
                                   fg="#38bdf8")
        question_header.pack(pady=20)

        self.question_frame = tk.Frame(question_container, bg="#1e293b", relief="solid", bd=2)
        self.question_frame.pack(fill="x", padx=20, pady=20)

        self.question_label = tk.Label(self.question_frame,
                                       text=self.preguntas[0],
                                       font=("Segoe UI", 18),
                                       bg="#1e293b",
                                       fg="#e2e8f0",
                                       wraplength=500,
                                       justify="center",
                                       pady=30)
        self.question_label.pack()

        button_frame = tk.Frame(question_container, bg="#0f172a")
        button_frame.pack(pady=20)

        self.btn_si = tk.Button(button_frame,
                                text="Sí",
                                font=("Segoe UI", 14, "bold"),
                                bg="#10b981",
                                fg="white",
                                activebackground="#059669",
                                activeforeground="white",
                                width=15,
                                height=2,
                                cursor="hand2",
                                relief="flat",
                                command=self.responder_si)
        self.btn_si.pack(side="left", padx=10)

        self.btn_no = tk.Button(button_frame,
                                text="No",
                                font=("Segoe UI", 14, "bold"),
                                bg="#ef4444",
                                fg="white",
                                activebackground="#dc2626",
                                activeforeground="white",
                                width=15,
                                height=2,
                                cursor="hand2",
                                relief="flat",
                                command=self.responder_no)
        self.btn_no.pack(side="left", padx=10)

        progress_frame = tk.Frame(question_container, bg="#0f172a")
        progress_frame.pack(fill="x", padx=40, pady=10)

        progress_label = tk.Label(progress_frame,
                                  text="Progreso del diagnóstico",
                                  font=("Segoe UI", 10),
                                  bg="#0f172a",
                                  fg="#94a3b8")
        progress_label.pack()

        self.progress = ttk.Progressbar(progress_frame,
                                        length=400,
                                        mode='determinate',
                                        style="Custom.Horizontal.TProgressbar")
        self.progress.pack(pady=5)
        self.progress['value'] = 10

        style = ttk.Style()
        style.theme_use('clam')
        style.configure("Custom.Horizontal.TProgressbar",
                        troughcolor='#334155',
                        background='#38bdf8',
                        bordercolor='#1e293b',
                        lightcolor='#38bdf8',
                        darkcolor='#38bdf8')

        right_panel = tk.Frame(main_container, bg="#1e293b", width=300)
        right_panel.pack(side="left", fill="both", padx=(10, 0))
        right_panel.pack_propagate(False)

        history_title = tk.Label(right_panel,
                                 text="Historial",
                                 font=("Segoe UI", 14, "bold"),
                                 bg="#1e293b",
                                 fg="#38bdf8")
        history_title.pack(pady=15)

        history_frame = tk.Frame(right_panel, bg="#0f172a")
        history_frame.pack(fill="both", expand=True, padx=10, pady=10)

        scrollbar = tk.Scrollbar(history_frame)
        scrollbar.pack(side="right", fill="y")

        self.history_text = tk.Text(history_frame,
                                    bg="#0f172a",
                                    fg="#94a3b8",
                                    font=("Segoe UI", 10),
                                    wrap="word",
                                    yscrollcommand=scrollbar.set,
                                    relief="flat",
                                    padx=10,
                                    pady=10)
        self.history_text.pack(side="left", fill="both", expand=True)
        scrollbar.config(command=self.history_text.yview)

        self.history_text.insert("1.0", "Sistema iniciado\n\n")
        self.history_text.insert("end", "Listo para diagnóstico...\n\n")
        self.history_text.config(state="disabled")

        footer_frame = tk.Frame(self.root, bg="#1e293b", height=70)
        footer_frame.pack(fill="x", padx=20, pady=(0, 20))
        footer_frame.pack_propagate(False)

        self.btn_reiniciar = tk.Button(footer_frame,
                                       text="Reiniciar Diagnóstico",
                                       font=("Segoe UI", 12),
                                       bg="#6366f1",
                                       fg="white",
                                       activebackground="#4f46e5",
                                       activeforeground="white",
                                       cursor="hand2",
                                       relief="flat",
                                       padx=20,
                                       pady=10,
                                       command=self.reiniciar)
        self.btn_reiniciar.pack(side="left", padx=20, pady=15)

        self.btn_informe = tk.Button(footer_frame,
                                     text="Generar Informe",
                                     font=("Segoe UI", 12),
                                     bg="#8b5cf6",
                                     fg="white",
                                     activebackground="#7c3aed",
                                     activeforeground="white",
                                     cursor="hand2",
                                     relief="flat",
                                     padx=20,
                                     pady=10,
                                     command=self.generar_informe)
        self.btn_informe.pack(side="left", padx=10, pady=15)

        self.btn_historial = tk.Button(footer_frame,
                                       text="Ver Historial Guardado",
                                       font=("Segoe UI", 12),
                                       bg="#22c55e",
                                       fg="white",
                                       activebackground="#16a34a",
                                       activeforeground="white",
                                       cursor="hand2",
                                       relief="flat",
                                       padx=20,
                                       pady=10,
                                       command=self.ver_historial)
        self.btn_historial.pack(side="left", padx=10, pady=15)

        status_label = tk.Label(footer_frame,
                                text="Sistema Experto v1.0 | RedSemántica Activa",
                                font=("Segoe UI", 10),
                                bg="#1e293b",
                                fg="#22d3ee")
        status_label.pack(side="right", padx=20)

        self.dibujar_componentes()

    def dibujar_logo_animado(self):
        self.logo_canvas.delete("all")
        cx, cy = 40, 40
        for i in range(8):
            angle = self.angle + (i * 45)
            x = cx + 25 * math.cos(math.radians(angle))
            y = cy + 25 * math.sin(math.radians(angle))
            size = 4 + 2 * math.sin(math.radians(self.pulse + i * 45))
            self.logo_canvas.create_oval(x - size, y - size, x + size, y + size,
                                         fill="#38bdf8", outline="")
        pulse_size = 8 + 3 * math.sin(math.radians(self.pulse))
        self.logo_canvas.create_oval(cx - pulse_size, cy - pulse_size,
                                     cx + pulse_size, cy + pulse_size,
                                     fill="#10b981", outline="")

    def dibujar_componentes(self):
        self.comp_canvas.delete("all")
        width = self.comp_canvas.winfo_width() or 280
        height = self.comp_canvas.winfo_height() or 500
        y_offset = 20
        for i, comp in enumerate(self.componentes):
            x = 20
            y = y_offset + (i * 50)
            intensity = 0.5 + 0.5 * math.sin(math.radians(self.pulse + i * 40))
            color = f"#{int(56 * intensity):02x}{int(189 * intensity):02x}{int(248 * intensity):02x}"
            self.comp_canvas.create_rectangle(x, y, x + 200, y + 35, fill="#334155", outline="")
            self.comp_canvas.create_rectangle(x, y, x + int(200 * intensity), y + 35, fill=color, outline="")
            self.comp_canvas.create_text(x + 10, y + 17, text=comp, anchor="w", font=("Segoe UI", 11, "bold"), fill="white")
            status = "OK" if intensity > 0.6 else "..."
            self.comp_canvas.create_text(x + 180, y + 17, text=status, anchor="e", font=("Segoe UI", 9),
                                         fill="#10b981" if status == "OK" else "#64748b")

    def animar(self):
        self.angle = (self.angle + 3) % 360
        self.pulse = (self.pulse + 5) % 360
        self.dibujar_logo_animado()
        self.dibujar_componentes()
        intensity = int(30 + 20 * math.sin(math.radians(self.pulse)))
        color = f"#{intensity:02x}{intensity:02x}{intensity + 40:02x}"
        self.question_frame.configure(highlightbackground=color, highlightthickness=2)
        self.root.after(50, self.animar)

    def responder_si(self):
        self.agregar_historial(f"Pregunta {self.current_question + 1}: Sí")
        self.siguiente_pregunta()

    def responder_no(self):
        self.agregar_historial(f"Pregunta {self.current_question + 1}: No")
        self.siguiente_pregunta()

    def siguiente_pregunta(self):
        self.current_question += 1
        if self.current_question < len(self.preguntas):
            self.question_label.config(text=self.preguntas[self.current_question])
            self.progress['value'] = (self.current_question / len(self.preguntas)) * 100
        else:
            self.question_label.config(
                text="Diagnóstico completado.\nPresiona 'Generar Informe' para ver los resultados")
            self.btn_si.config(state="disabled")
            self.btn_no.config(state="disabled")
            self.progress['value'] = 100
            self.agregar_historial("Diagnóstico finalizado.")

    def agregar_historial(self, texto):
        self.history_text.config(state="normal")
        self.history_text.insert("end", f"{texto}\n")
        self.history_text.see("end")
        self.history_text.config(state="disabled")

    def reiniciar(self):
        self.current_question = 0
        self.question_label.config(text=self.preguntas[0])
        self.progress['value'] = 10
        self.btn_si.config(state="normal")
        self.btn_no.config(state="normal")
        self.history_text.config(state="normal")
        self.history_text.delete("1.0", "end")
        self.history_text.insert("1.0", "Sistema reiniciado\n\n")
        self.history_text.config(state="disabled")

    def generar_informe(self):
        """Genera el diagnóstico final usando el motor de inferencia."""
        try:
            self.agregar_historial("Generando informe...")
            respuestas = []

            for i in range(self.current_question):
                respuestas.append(self.preguntas[i])

            import importlib.util
            import sys, os

            ruta_modulos = os.path.join(os.path.dirname(__file__), "moduos")
            ruta_inferencia = os.path.join(ruta_modulos, "inferencia.py")

            spec = importlib.util.spec_from_file_location("inferencia", ruta_inferencia)
            inferencia = importlib.util.module_from_spec(spec)
            sys.modules["inferencia"] = inferencia
            spec.loader.exec_module(inferencia)

            diagnostico = inferencia.inferir(respuestas)

            from tkinter import messagebox
            messagebox.showinfo("Resultado del Diagnóstico", diagnostico)

            self.agregar_historial("Diagnóstico generado:")
            self.agregar_historial(diagnostico)

        except Exception as e:
            from tkinter import messagebox
            messagebox.showerror("Error", f"Ocurrió un error al generar el informe:\n{e}")
            print("Error en generar_informe:", e)

    def ver_historial(self):
        """Muestra los diagnósticos guardados en la base de datos."""
        try:
            import sqlite3
            import os
            from tkinter import Toplevel, Text, Scrollbar, END

            db_path = os.path.join(os.path.dirname(__file__), "sistema_experto.db")

            if not os.path.exists(db_path):
                messagebox.showwarning("Aviso", "No hay base de datos aún o no se han guardado diagnósticos.")
                return

            conn = sqlite3.connect(db_path)
            cursor = conn.cursor()

            cursor.execute("SELECT fecha, resultado FROM diagnosticos ORDER BY fecha DESC")
            datos = cursor.fetchall()
            conn.close()

            if not datos:
                messagebox.showinfo("Historial", "No se han registrado diagnósticos aún.")
                return

            ventana = Toplevel(self.root)
            ventana.title("Historial de Diagnósticos")
            ventana.geometry("600x400")
            ventana.configure(bg="#0f172a")

            text_area = Text(ventana, bg="#1e293b", fg="#e2e8f0", font=("Consolas", 10), wrap="word", padx=10, pady=10)
            text_area.pack(fill="both", expand=True)

            scroll = Scrollbar(text_area, command=text_area.yview)
            text_area.config(yscrollcommand=scroll.set)
            scroll.pack(side="right", fill="y")

            for fecha, resultado in datos:
                text_area.insert(END, f" {fecha}\n {resultado}\n{'-'*50}\n\n")

            text_area.config(state="disabled")

        except Exception as e:
            messagebox.showerror("Error", f"No se pudo leer el historial:\n{e}")






if __name__ == "__main__":
    root = tk.Tk()
    app = SistemaExpertoUI(root)
    root.mainloop()
