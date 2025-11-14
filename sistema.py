"""
DESCOMENTAR EN CASO DE LOS WARNINGS EN WINDOWS

import sys
import os
if sys.platform.startswith('win'):
    try:
        import ctypes
        kernel32 = ctypes.windll.kernel32
        kernel32.SetConsoleCP(65001)
        kernel32.SetConsoleOutputCP(65001)
    except:
        pass

"""

from modulos.Librerias import *
from modulos.Sonidos import *
from modulos import VentanasDialogo as VD
from motor_inferencia import MotorInferenciaHardware
from database_hardware import *

class AsistenteFlotante:
    def __init__(self, canvas, usar_voz=False):
        self.canvas = canvas
        self.usar_voz = usar_voz

        self._voice_lock = threading.Lock()
        self._voice_queue = queue.Queue()
        self._voz_activa = True

        self.canal_voz = pygame.mixer.Channel(0) 
        self.canal_efectos = pygame.mixer.Channel(1) 
        self.canal_musica = pygame.mixer.Channel(2)  
        
        self.canal_efectos.set_volume(0.7)
        self.canal_voz.set_volume(0.8)

        try:
            img = Image.open("imagenes/mascota_pc.png").resize((200, 200))
            self.img_nube = ImageTk.PhotoImage(img)
        except Exception as e:
            print("Error cargando imagen asistente:", e)
            self.img_nube = None

        self.nube_x = 20
        self.nube_y_inicial = 63

        self.dialogo_offset_x = 210  
        self.dialogo_offset_y = -20  

        self.angle = 0
        self.pulse = 0
        self.particles = []
        self.wave_offset = 0

        for _ in range(20):
            self.particles.append({
                'x': random.randint(0, 400),
                'y': random.randint(0, 150),
                'speed': random.uniform(0.2, 0.8),
                'size': random.randint(1, 2),
                'alpha': random.randint(30, 80)
            })

        self.nube_id = None
        if self.img_nube:
            self.nube_id = self.canvas.create_image(self.nube_x, self.nube_y_inicial,
                                                    image=self.img_nube, anchor="nw")

        self.bubble_canvas = tk.Canvas(self.canvas, width=450, height=160, 
                                    bg="#0f172a", highlightthickness=0)
        self.bubble_window = self.canvas.create_window(
            self.nube_x + self.dialogo_offset_x,
            self.nube_y_inicial + self.dialogo_offset_y,
            window=self.bubble_canvas, anchor="nw"
        )

        self.bubble_elements = []
        self.crear_burbuja_moderna()

        self.tip_var = tk.StringVar()
        self.tip_label = tk.Label(self.bubble_canvas, textvariable=self.tip_var,
                                bg="#1e293b", fg="#e2e8f0", 
                                font=("Segoe UI", 13, "bold"),
                                wraplength=400, justify="left", 
                                padx=20, pady=18)
        self.tip_label.place(x=15, y=20, width=420, height=110)

        self._typing_job = None
        self._anim_job = None
        self.engine = None
        self._preferred_rate = 130
        self._voz_hilo = None
        self._bubble_anim_job = None

        if self.usar_voz:
            self.init_engine()
            self._iniciar_hilo_voz()


        self._t0 = time.time()
        self.animar_nube_rebotando()
        self.animar_burbuja()  
        self.use_gtts = True

    def crear_burbuja_moderna(self):
        w, h = 450, 160
        
        self.bubble_canvas.create_rectangle(0, 0, w, h, fill="#0a0f1a", outline="")
        self.bubble_canvas.create_rectangle(5, 5, w-5, h-5, fill="#0f172a", outline="")
    
        self.burbuja_bg = self.bubble_canvas.create_rectangle(
            10, 15, w-10, h-15, 
            fill="#1e293b", outline="", tags="burbuja_bg"
        )
        
        self.borde_superior = self.bubble_canvas.create_line(
            15, 15, w-15, 15, 
            fill="#38bdf8", width=3, tags="borde_animado"
        )
        
        self.borde_inferior = self.bubble_canvas.create_line(
            15, h-15, w-15, h-15,
            fill="#38bdf8", width=3, tags="borde_animado"
        )
        
        self.borde_izq = self.bubble_canvas.create_line(
            10, 20, 10, h-20,
            fill="#22d3ee", width=3, tags="borde_animado"
        )
        
        self.borde_der = self.bubble_canvas.create_line(
            w-10, 20, w-10, h-20,
            fill="#22d3ee", width=3, tags="borde_animado"
        )
        
        corners = [
            (15, 15), (w-15, 15), (15, h-15), (w-15, h-15)
        ]
        for cx, cy in corners:
            self.bubble_canvas.create_oval(
                cx-5, cy-5, cx+5, cy+5,
                fill="#38bdf8", outline=""
            )
        
        self.typing_indicators = []
        base_x, base_y = 25, h - 35
        for i in range(3):
            dot = self.bubble_canvas.create_oval(
                base_x + i*15, base_y, 
                base_x + i*15 + 8, base_y + 8,
                fill="#64748b", outline="", tags="typing_dot"
            )
            self.typing_indicators.append(dot)
        
        self.icono_pregunta = self.bubble_canvas.create_text(
            w - 30, 30,
            text="?", font=("Segoe UI", 20),
            fill="#38bdf8", tags="icono_pregunta"
        )
        
        for i in range(3):
            y = 40 + i * 30
            self.bubble_canvas.create_line(
                20, y, w-20, y,
                fill="#334155", width=1, dash=(5, 3)
            )
        
        self.glow_rect = self.bubble_canvas.create_rectangle(
            8, 13, w-8, h-13,
            outline="#22d3ee", width=1, tags="glow"
        )

    def animar_burbuja(self):
        self.pulse = (self.pulse + 5) % 360
        self.angle = (self.angle + 3) % 360
        self.wave_offset = (self.wave_offset + 2) % 360
        
        for i, borde in enumerate([self.borde_superior, self.borde_inferior, 
                                   self.borde_izq, self.borde_der]):
            intensity = 100 + int(155 * abs(math.sin(math.radians(self.pulse + i * 90))))
            color = f"#{intensity//4:02x}{intensity:02x}{min(intensity + 50, 255):02x}"
            self.bubble_canvas.itemconfig(borde, fill=color)
        
        for i, dot in enumerate(self.typing_indicators):
            offset = 3 * math.sin(math.radians(self.pulse + i * 120))
            coords = self.bubble_canvas.coords(dot)
            if coords:
                base_x = 25 + i*15
                base_y = 125 + offset
                self.bubble_canvas.coords(dot, 
                    base_x, base_y,
                    base_x + 8, base_y + 8
                )
            
            alpha = int(100 + 155 * abs(math.sin(math.radians(self.pulse + i * 120))))
            self.bubble_canvas.itemconfig(dot, fill=f"#{alpha//3:02x}{alpha//2:02x}{alpha:02x}")
        
        scale = 1 + 0.15 * math.sin(math.radians(self.pulse))
        font_size = int(20 * scale)
        self.bubble_canvas.itemconfig(
            self.icono_pregunta, 
            font=("Segoe UI", font_size)
        )
        
        simbolos = ["?", "?", "?"]
        if self.pulse % 180 == 0:
            simbolo = simbolos[(self.pulse // 180) % len(simbolos)]
            self.bubble_canvas.itemconfig(self.icono_pregunta, text=simbolo)
        
        glow_width = 1 + int(2 * abs(math.sin(math.radians(self.pulse))))
        self.bubble_canvas.itemconfig(self.glow_rect, width=glow_width)
        
        self.animar_particulas_burbuja()
        
        self._bubble_anim_job = self.canvas.after(50, self.animar_burbuja)

    def animar_particulas_burbuja(self):
        self.bubble_canvas.delete("particula")
        
        for particle in self.particles:
            particle['y'] -= particle['speed']
            if particle['y'] < 0:
                particle['y'] = 160
                particle['x'] = random.randint(15, 435)
            
            alpha_var = int(particle['alpha'] + 30 * math.sin(math.radians(self.pulse)))
            alpha_val = max(20, min(alpha_var, 120))
            color = f"#{alpha_val//2:02x}{alpha_val:02x}{min(alpha_val + 40, 255):02x}"
            
            self.bubble_canvas.create_oval(
                particle['x'], particle['y'],
                particle['x'] + particle['size'], 
                particle['y'] + particle['size'],
                fill=color, outline="", tags="particula"
            )

    def animar_nube_rebotando(self):
        t = time.time() - self._t0
        y = self.nube_y_inicial + math.sin(t * 2.0) * 6
        if self.nube_id:
            self.canvas.coords(self.nube_id, self.nube_x, y)
        self.canvas.coords(
            self.bubble_window,
            self.nube_x + self.dialogo_offset_x,
            y + self.dialogo_offset_y
        )
        self._anim_job = self.canvas.after(50, self.animar_nube_rebotando)

    def init_engine(self):
        try:
            sistema = platform.system().lower()
            self.engine = pyttsx3.init()
            voices = self.engine.getProperty('voices')
            for v in voices:
                nombre = v.name.lower()
                if any(k in nombre for k in ['latam', 'es_', 'spanish', 'castilian']):
                    self.engine.setProperty('voice', v.id)
                    break
            rate = 100 if "linux" in sistema else 125
            self.engine.setProperty('rate', rate)
            self.engine.setProperty('volume', 1.0)
            print(f"Voz local inicializada (rate={rate})")
        except Exception as e:
            print("Error inicializando pyttsx3:", e)
            self.engine = None

    def _iniciar_hilo_voz(self):
        def worker():
            while self._voz_activa:
                try:
                    texto = self._voice_queue.get(timeout=0.1)
                except queue.Empty:
                    continue
                if texto is None:
                    continue
                try:
                    if getattr(self, "use_gtts", False):
                        self._hablar_gtts(texto)
                    else:
                        self._hablar_pyttsx3(texto)
                except Exception as e:
                    print("Error al hablar:", e)

        self._voz_hilo = threading.Thread(target=worker, daemon=True)
        self._voz_hilo.start()

    def _hablar_pyttsx3(self, texto):
        if not self.engine:
            self.init_engine()
        with self._voice_lock:
            self.engine.stop()
            self.engine.say(texto)
            self.engine.runAndWait()

    def _hablar_gtts(self, texto):
            import tempfile
            
            if not self.verificar_conexion():
                print("Sin conexión: cambiando a voz local pyttsx3")
                self.use_gtts = False
                self._voice_queue.put(texto)
                return

            sistema = platform.system().lower()
            tmp_file = None
            
            try:
                if "windows" in sistema:
                    tmp_file = tempfile.NamedTemporaryFile(delete=False, suffix=".mp3")
                    tmp_path = tmp_file.name
                    tmp_file.close() 
                else:
                    tmp_file = tempfile.NamedTemporaryFile(delete=False, suffix=".mp3")
                    tmp_path = tmp_file.name
                
                tts = gTTS(text=texto, lang="es")
                tts.save(tmp_path)
                
                sound_voz = pygame.mixer.Sound(tmp_path)
                
                self.canal_voz.stop() 
                self.canal_voz.play(sound_voz)
                
                while self.canal_voz.get_busy() and self._voz_activa:
                    time.sleep(0.05)
                
                if "windows" in sistema:
                    time.sleep(0.2)
                    
            except Exception as e:
                print(f"Error en gTTS ({sistema}): {e}")
                self.use_gtts = False
                self._voice_queue.put(texto)
            finally:
                if tmp_path:
                    try:
                        time.sleep(0.1)
                        if os.path.exists(tmp_path):
                            os.remove(tmp_path)
                    except Exception as e:
                        print(f"No se pudo eliminar archivo temporal: {e}")
                        if "windows" in sistema:
                            try:
                                time.sleep(0.3)
                                if os.path.exists(tmp_path):
                                    os.remove(tmp_path)
                            except:
                                pass


    def verificar_conexion(self, host="8.8.8.8", port=53, timeout=2):
        import socket
        try:
            socket.setdefaulttimeout(timeout)
            socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect((host, port))
            return True
        except OSError:
            return False


    def detener_habla(self, force_stop=False):
        with self._voice_lock:
            while not self._voice_queue.empty():
                try:
                    self._voice_queue.get_nowait()
                except queue.Empty:
                    break
            if self.engine:
                self.engine.stop()

        if force_stop:
            try:
                for ch in range(pygame.mixer.get_num_channels()):
                    canal = pygame.mixer.Channel(ch)
                    if canal.get_busy():
                        canal.stop()
            except Exception:
                pass


    def mostrar_tip_ani_2(self, texto, velocidad=20, hablar=None):
        if hablar is None:
            hablar = self.usar_voz

        if self._typing_job:
            try:
                self.canvas.after_cancel(self._typing_job)
            except:
                pass
            self._typing_job = None

        self.tip_var.set("")
        texto = str(texto)
        self.bubble_canvas.itemconfig(self.burbuja_bg, fill="#2d3748")
        self.canvas.after(200, lambda: self.bubble_canvas.itemconfig(
            self.burbuja_bg, fill="#1e293b"
        ))

        if hablar:
            self.detener_habla(force_stop=True)
            self._voice_queue.put(texto)

        def escribir(i=0):
            self.tip_var.set(texto[:i])
            if i < len(texto):
                self._typing_job = self.canvas.after(velocidad, escribir, i + 1)
            else:
                self._typing_job = None

        escribir(1)

    def detener(self):
        self._voz_activa = False
        
        self.detener_habla()
        
        for job in [self._anim_job, self._typing_job, self._bubble_anim_job]:
            if job:
                try:
                    self.canvas.after_cancel(job)
                except (ValueError, tk.TclError):
                    pass
        
        self._anim_job = None
        self._typing_job = None
        self._bubble_anim_job = None
        
        if self.engine:
            try:
                self.engine.stop()
            except:
                pass
        
        try:
            self.canal_voz.stop()
            self.canal_efectos.stop()
        except:
            pass
        
        try:
            if self.canvas.winfo_exists():
                self.canvas.unbind_all("<MouseWheel>")
                self.canvas.unbind_all("<Button-4>")
                self.canvas.unbind_all("<Button-5>")
        except (AttributeError, tk.TclError):
            pass
        
        try:
            if hasattr(self, 'bubble_canvas') and self.bubble_canvas.winfo_exists():
                self.bubble_canvas.destroy()
        except (AttributeError, tk.TclError):
            pass
        
        try:
            if hasattr(self, 'tip_label') and self.tip_label.winfo_exists():
                self.tip_label.destroy()
        except (AttributeError, tk.TclError):
            pass



class SistemaExpertoUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Sistema Experto - Diagnóstico de Computadoras")
        self.root.geometry("1400x900")
        self.root.configure(bg="#0f172a")
        self.diagnostico_iniciado = False

        self.angle = 0
        self.pulse = 0
        self.current_question = 0
        self.musica_activada = False
        self.lista_canciones = [f"musica_fondo/{f}" for f in os.listdir("musica_fondo") if f.endswith(".mpeg")]
        self.musica_hilo = None
        self._ultima_cancion = None


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

        self.motor = MotorInferenciaHardware()
        
        self.usuario_actual = None
        self.equipo_actual = None
        self.sesion_actual = None
        
        self.preguntas_actuales = []
        self.indice_pregunta = 0
        
        self.componentes = [
            "CPU", "RAM", "Disco Duro", "Tarjeta Madre",
            "GPU", "Fuente de Poder", "Monitor", "BIOS", 
            "SSD", "Cooler", "Ventiladores"
        ]
        

        self.crear_interfaz()
        self.animar()

    def determinar_categoria(self, clave):
        categorias = {
                    # POWER / ALIMENTACIÓN
                    'enciende': 'power',
                    'led_power': 'power',
                    'ventiladores': 'power',
                    'olor_quemado': 'power',
                    'chispa_electrica': 'power',
                    'reinicios_espontaneos': 'power',
                    'apagado_subito': 'power',
                    'voltaje_inestable': 'power',
                    'zumbido_bobinas': 'power',
                    'olor_ozono': 'power',
                    
                    # DISPLAY
                    'pantalla_enciende': 'display',
                    'pantalla_azul': 'display',
                    'codigo_error_bsod': 'display',
                    'artefactos_visuales': 'display',
                    'parpadeo_pantalla': 'display',
                    'resolucion_incorrecta': 'display',
                    'colores_distorsionados': 'display',
                    'pantalla_negra_post': 'display',
                    'mensaje_no_signal': 'display',
                    'artifactos_3d': 'display',
                    'screen_tearing': 'display',
                    'nieve_estatica': 'display',
                    'color_temperatura_incorrecta': 'display',
                    
                    # STORAGE
                    'disco_detectado': 'storage',
                    'ruidos_disco': 'storage',
                    'ruido_tipo': 'storage',
                    'velocidad_lenta': 'storage',
                    'archivos_corruptos': 'storage',
                    'errores_lectura': 'storage',
                    'disco_desaparece': 'storage',
                    'smart_warnings': 'storage',
                    'sectores_realocados': 'storage',
                    'temperatura_disco': 'storage',
                    'ssd_ralentizado': 'storage',
                    'ssd_no_reconocido': 'storage',
                    'nvme_throttling': 'storage',
                    'trim_no_funciona': 'storage',
                    
                    # MEMORY
                    'ram_detectada': 'memory',
                    'cantidad_ram_detectada': 'memory',
                    'reinicios_aleatorios': 'memory',
                    'congelamientos': 'memory',
                    'aplicaciones_crash': 'memory',
                    'memtest_errores': 'memory',
                    'ubicacion_error_ram': 'memory',
                    'dual_channel_activo': 'memory',
                    'xmp_activado': 'memory',
                    'ram_a_velocidad_maxima': 'memory',
                    'slots_ocupados': 'memory',
                    
                    # COOLING / TEMPERATURA
                    'sobrecalentamiento': 'cooling',
                    'apagado_termico': 'cooling',
                    'ventilador_ruidoso': 'cooling',
                    'ventilador_detenido': 'cooling',
                    'ventilador_vibra': 'cooling',
                    'temp_cpu_idle': 'cooling',
                    'temp_cpu_carga': 'cooling',
                    'temp_gpu_idle': 'cooling',
                    'temp_gpu_carga': 'cooling',
                    'pasta_termica_vieja': 'cooling',
                    'polvo_acumulado': 'cooling',
                    'flujo_aire_bloqueado': 'cooling',
                    
                    # NETWORK
                    'red_funciona': 'network',
                    'wifi_detecta': 'network',
                    'ethernet_funciona': 'network',
                    'velocidad_red_baja': 'network',
                    'ping_alto': 'network',
                    'paquetes_perdidos': 'network',
                    'conexion_intermitente': 'network',
                    'led_ethernet_parpadea': 'network',
                    'driver_red_actualizado': 'network',
                    
                    # USB / CONNECTIVITY
                    'usb_funciona': 'connectivity',
                    'usb_intermitente': 'connectivity',
                    'usb_3_no_funciona': 'connectivity',
                    'usb_velocidad_lenta': 'connectivity',
                    'dispositivos_no_reconocidos': 'connectivity',
                    'usb_frontal_no_funciona': 'connectivity',
                    'usb_posterior_funciona': 'connectivity',
                    
                    # AUDIO
                    'audio_funciona': 'audio',
                    'crackling_audio': 'audio',
                    'audio_solo_un_lado': 'audio',
                    'audio_distorsionado': 'audio',
                    'microfono_funciona': 'audio',
                    'nivel_audio_bajo': 'audio',
                    
                    # BATTERY (LAPTOP)
                    'bateria_carga': 'battery',
                    'duracion_bateria': 'battery',
                    'bateria_hinchada': 'battery',
                    'carga_lenta': 'battery',
                    'porcentaje_bateria_salta': 'battery',
                    'laptop_no_enciende_sin_cargador': 'battery',
                    'bateria_ciclos': 'battery',
                    
                    # GPU
                    'gpu_detectada': 'gpu',
                    'driver_gpu_instalado': 'gpu',
                    'artifactos_gpu': 'gpu',
                    'pantallazos_negros': 'gpu',
                    'driver_crashed': 'gpu',
                    'fps_bajos': 'gpu',
                    'gpu_throttling': 'gpu',
                    'ventiladores_gpu_giran': 'gpu',
                    'coil_whine_gpu': 'gpu',
                    'componente_quemado_visible': 'gpu',
                    'overclock_activo': 'gpu',
                    'aio_age_years': 'gpu',
                    'cooler_age_years': 'gpu',
                    'gpu_sag_estres_pcb': 'gpu',
                    'fan_speed_constant': 'gpu',
                    
                    # MOTHERBOARD
                    'puertos_traseros_funcionan': 'motherboard',
                    'slots_pcie_funcionan': 'motherboard',
                    'sata_ports_funcionan': 'motherboard',
                    'm2_slot_funciona': 'motherboard',
                    'bios_version_actualizada': 'motherboard',
                    'fecha_hora_resetea': 'motherboard',
                    'configuracion_bios_se_pierde': 'motherboard',
                    'chipset_caliente': 'motherboard',
                    'pitidos_post': 'motherboard',
                    'patron_pitidos': 'motherboard',
                    
                    # CPU
                    'cpu_reconocido_correctamente': 'cpu',
                    'nucleos_detectados': 'cpu',
                    'frecuencia_cpu_correcta': 'cpu',
                    'cpu_throttling': 'cpu',
                    'uso_cpu_100': 'cpu',
                    'proceso_consume_cpu': 'cpu',
                    
                    # ESPECIALES
                    'recientemente_instalo_hardware': 'general',
                    'recientemente_actualizo_drivers': 'general',
                    'recientemente_actualizo_bios': 'general',
                    'derramo_liquido': 'general',
                    'golpe_caida': 'general',
                    'tormenta_electrica': 'general',
                    'sobretension_electrica': 'general'
                }
        return categorias.get(clave, 'general')


    def finalizar_diagnostico(self):
        """Ejecuta diagnóstico final y muestra resultados"""
        self.agregar_historial("\n🔍 Analizando síntomas...")
        self.agregar_historial("⚙️ Ejecutando motor de inferencia...")
        
        self.deshabilitar_botones_respuesta()
        
        diagnosticos = self.motor.ejecutar_diagnostico(max_resultados=5)
        
        evaluaciones = self.motor.evaluar_componentes(self.componentes)
        
        self.actualizar_estado_componentes(evaluaciones)
        
        self.motor.finalizar_sesion()
        
        self.mostrar_resultados_diagnostico(diagnosticos)
        
        self.progress['value'] = 100

    def mostrar_resultados_diagnostico(self, diagnosticos):
        if not diagnosticos:
            mensaje = "No se detectaron fallas críticas.\n\nEl sistema parece estar funcionando correctamente."
            self.asistente.mostrar_tip_ani_2(mensaje, velocidad=15, hablar=True)
            self.agregar_historial("\nDiagnóstico: Sistema OK")
            return
        
        # Mensaje del asistente
        principal = diagnosticos[0]
        mensaje_asistente = f"""Diagnóstico Completado

        Problema principal detectado:
        {principal['nombre']}

        Confianza: {principal['confianza']*100:.0f}%
        Componente: {principal['componente']}

        Presiona 'Generar Informe' para ver detalles completos."""
        
        self.asistente.mostrar_tip_ani_2(mensaje_asistente, velocidad=15, hablar=True)
        
        self.agregar_historial(f"\nDIAGNÓSTICO PRINCIPAL:")
        self.agregar_historial(f"  • {principal['nombre']}")
        self.agregar_historial(f"  • Confianza: {principal['confianza']*100:.0f}%")
        self.agregar_historial(f"  • Componente: {principal['componente']}")
        
        if len(diagnosticos) > 1:
            self.agregar_historial(f"\nWarning: Problemas adicionales detectados: {len(diagnosticos)-1}")
        
        self.diagnosticos_actuales = diagnosticos

    def actualizar_estado_componentes(self, evaluaciones):

        self.comp_canvas.delete("all")
        
        colores_estado = {
            'ok': '#10b981',       # Verde
            'warning': '#f59e0b',  # Amarillo
            'critical': '#ef4444', # Rojo
            'failed': '#7f1d1d'    # Rojo oscuro
        }
        
        iconos_estado = {
            'ok': '✓',
            'warning': '⚠',
            'critical': '⚠',
            'failed': '✗'
        }
        
        width = self.comp_canvas.winfo_width() or 280
        y_offset = 20
        
        componentes_evaluados = {eval['componente']: eval for eval in evaluaciones}
        
        for i, comp in enumerate(self.componentes):
            x = 20
            y = y_offset + (i * 50)
            
            if comp in componentes_evaluados:
                eval_comp = componentes_evaluados[comp]
                estado = eval_comp['estado']
                salud = eval_comp['salud']
                color = colores_estado[estado]
                icono = iconos_estado[estado]
            else:
                estado = 'ok'
                salud = 100
                color = '#64748b' 
                icono = '○'
            
            self.comp_canvas.create_rectangle(
                x, y, x + 240, y + 35,
                fill="#334155", outline=""
            )
            
            barra_width = int(240 * (salud / 100))
            self.comp_canvas.create_rectangle(
                x, y, x + barra_width, y + 35,
                fill=color, outline=""
            )
            
            self.comp_canvas.create_text(
                x + 10, y + 17,
                text=f"{icono} {comp}",
                anchor="w",
                font=("Segoe UI", 11, "bold"),
                fill="white"
            )
            
            self.comp_canvas.create_text(
                x + 220, y + 17,
                text=f"{salud}%",
                anchor="e",
                font=("Segoe UI", 9, "bold"),
                fill="white"
            )


    def mostrar_pregunta_actual(self):

        texto_pregunta = self.motor.obtener_pregunta(self.clave_pregunta_actual)
        
        if texto_pregunta:
            progreso = min((self.indice_pregunta / 15) * 100, 95)
            self.progress['value'] = progreso
            
            tipo_pregunta = self.motor.validar_tipo_pregunta(self.clave_pregunta_actual)
            
            if tipo_pregunta == 'texto':
                self.mostrar_pregunta_texto(texto_pregunta)
            else:
                self.asistente.mostrar_tip_ani_2(
                    texto_pregunta,
                    velocidad=18,
                    hablar=self.asistente.usar_voz
                )
                self.agregar_historial(f"? {texto_pregunta}")
        else:
            self.finalizar_diagnostico()

    def crear_interfaz(self):
        header_frame = tk.Frame(self.root, bg="#1e293b", height=100)
        header_frame.pack(fill="x", padx=20, pady=20)
        header_frame.pack_propagate(False)

        self.logo_canvas = tk.Canvas(header_frame, width=80, height=80, bg="#1e293b", highlightthickness=0)
        self.logo_canvas.pack(side="left", padx=20)

        title_frame = tk.Frame(header_frame, bg="#1e293b")
        title_frame.pack(side="left", fill="both", expand=True)

        title_label = tk.Label(title_frame,
                               text="🔧 Sistema Experto de Diagnóstico",
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

        voz_frame = tk.Frame(header_frame, bg="#1e293b")
        voz_frame.pack(side="right", padx=20)

        self.control_canvas = tk.Canvas(voz_frame, bg="#1e293b", 
                                        width=280, height=60, highlightthickness=0)
        self.control_canvas.pack()

        self.icono_asistente = ImageTk.PhotoImage(Image.open("imagenes/mascota_pc.png").resize((26, 26)))
        self.icono_voz = ImageTk.PhotoImage(Image.open("imagenes/repetir.png").resize((26, 26)))
        self.icono_musica = ImageTk.PhotoImage(Image.open("imagenes/guitarra.png").resize((26, 26)))
        self.icono_siguiente = ImageTk.PhotoImage(Image.open("imagenes/next.png").resize((26, 26)))

        self._icon_refs = [
            self.icono_asistente,
            self.icono_voz,
            self.icono_musica,
            self.icono_siguiente
        ]

        botones_config = [
            {"x": 30, "icono": self.icono_asistente, "color": "#5aa4ed", "comando": self.toggle_asistente},
            {"x": 90, "icono": self.icono_voz, "color": "#4caf50", "comando": self.cambiar_modo_voz},
            {"x": 150, "icono": self.icono_musica, "color": "#b2a6f5", "comando": self.MUSICA_FONDO},
            {"x": 210, "icono": self.icono_siguiente, "color": "#3b82f6", "comando": self.cambiar_cancion_manual},
        ]


        self.botones_control = []
        
        for btn_config in botones_config:
            btn_visual = self.crear_boton_control(
                btn_config["x"], 30, 
                btn_config["icono"], 
                btn_config["color"],
                btn_config["comando"]
            )
            
            if "ref" in btn_config and btn_config["ref"] == "MUSICA":
                self.btn_MUSICA_visual = btn_visual
            
            self.botones_control.append(btn_visual)

        self.indicadores = []
        for i, btn_config in enumerate(botones_config):
            indicador = self.control_canvas.create_oval(
                btn_config["x"] - 3, 52,
                btn_config["x"] + 3, 58,
                fill="#334155", outline=""
            )
            self.indicadores.append(indicador)


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


        self.canvas_asistente = tk.Canvas(question_container, bg="#0f172a", 
                                        highlightthickness=0, height=260)
        self.canvas_asistente.pack(fill="x", pady=(0, 10))

        self.asistente = AsistenteFlotante(self.canvas_asistente, usar_voz=True)

        # MENSAJE DE BIENVENIDA INICIAL
        mensaje_bienvenida = """¡Bienvenido al Sistema Experto de Diagnóstico de Hardware!

        Soy tu asistente y te ayudaré a identificar problemas en tu computadora.

        Este sistema utiliza una red semántica para analizar síntomas y diagnosticar fallas de hardware.

        Presiona 'Iniciar Diagnóstico' cuando estés listo para comenzar, o 'Más Información' para conocer todos los detalles del sistema."""

        self.asistente.mostrar_tip_ani_2(mensaje_bienvenida, velocidad=15, 
                                        hablar=self.asistente.usar_voz)

        self.question_frame = tk.Frame(question_container, bg="#1e293b", 
                                    relief="solid", bd=2)
        self.question_frame.pack(fill="x", padx=20, pady=20)

        self.button_frame = tk.Frame(question_container, bg="#0f172a")
        self.button_frame.pack(pady=20)

        self.btn_canvas = tk.Canvas(self.button_frame, bg="#0f172a", 
                                width=700, height=100, highlightthickness=0)
        self.btn_canvas.pack()

        self.crear_botones_iniciales()

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

        self.footer_canvas = tk.Canvas(footer_frame, bg="#1e293b", 
                                    width=1360, height=70, highlightthickness=0)
        self.footer_canvas.pack(fill="both", expand=True)

        self.icono_cerrar = ImageTk.PhotoImage(Image.open("imagenes/cerrar.png").resize((24, 24)))
        self.icono_reiniciar = ImageTk.PhotoImage(Image.open("imagenes/para.png").resize((24, 24)))
        self.icono_informe = ImageTk.PhotoImage(Image.open("imagenes/texto.png").resize((24, 24)))
        self.icono_registro = ImageTk.PhotoImage(Image.open("imagenes/leer.png").resize((24, 24)))

        self._icon_footer_refs = [
            self.icono_cerrar,
            self.icono_reiniciar,
            self.icono_informe,
            self.icono_registro
        ]


        botones_footer_config = [
            {"x": 150, "texto": "Cerrar Sistema", "icono": self.icono_cerrar, "color": "#ef4444", "acento": "#f87171", "comando": self.cerrar_aplicacion},
            {"x": 400, "texto": "Reiniciar", "icono": self.icono_reiniciar, "color": "#6366f1", "acento": "#818cf8", "comando": self.reiniciar},
            {"x": 620, "texto": "Generar Informe", "icono": self.icono_informe, "color": "#8b5cf6", "acento": "#a78bfa", "comando": self.generar_informe},
            {"x": 840, "texto": "Ver Historial G..", "icono": self.icono_registro, "color": "#22c55e", "acento": "#a78bfa", "comando": self.ver_historial},
        ]


        self.botones_footer = []
        for btn_config in botones_footer_config:
            btn = self.crear_boton_footer(
                btn_config["x"], 35,
                btn_config["texto"],
                btn_config["color"],
                btn_config["acento"],
                btn_config["comando"],
                btn_config["icono"] 
            )
            self.botones_footer.append(btn)

        self.status_footer = self.footer_canvas.create_text(
            1200, 35,
            text="Sistema Experto v1.0\n🔗 RedSemántica Activa",
            font=("Segoe UI", 10, "bold"),
            fill="#22d3ee",
            justify="right"
        )

        self.footer_pulse = 0
        self.animar_footer()

        self.dibujar_componentes()
        self.MUSICA_FONDO()


    def ver_historial(self):
        if getattr(self, "_viendo_registros", False):
            return
        self._viendo_registros = True
        
        try:
            SONIDO_LECTURA.play()
        except:
            pass
        
        def mostrar_historial():
            try:
                VD.DialogoHistorial(self.root).mostrar()
            except Exception as e:
                print(f"Error mostrando historial: {e}")
                messagebox.showerror("Error", f"No se pudo cargar el historial:\n{str(e)}")
            finally:
                self._viendo_registros = False
        
        self.root.after(100, mostrar_historial)


    def crear_botones_iniciales(self):
        self.btn_canvas.delete("all")
        
        if hasattr(self, 'btn_si_visual'):
            del self.btn_si_visual
        if hasattr(self, 'btn_no_visual'):
            del self.btn_no_visual
        
        self.btn_canvas.config(cursor="")
        
        self.btn_iniciar = self.crear_boton_grande(
            250, 50,
            "Iniciar Diagnóstico",
            "#10b981",
            "#34d399",
            self.iniciar_diagnostico
        )
        
        self.btn_manual = self.crear_boton_grande(
            450, 50,
            "Más Información",
            "#6366f1",
            "#818cf8",
            self.mostrar_manual
        )
        
        self.btn_canvas.update_idletasks()
        
        print("Botones iniciales creados correctamente")

    def debug_canvas_botones(self):
        print("\nDEBUG CANVAS BOTONES")
        print(f"Canvas existe: {hasattr(self, 'btn_canvas')}")
        
        if hasattr(self, 'btn_canvas'):
            try:
                print(f"Canvas width: {self.btn_canvas.winfo_width()}")
                print(f"Canvas height: {self.btn_canvas.winfo_height()}")
                print(f"Canvas visible: {self.btn_canvas.winfo_viewable()}")
                print(f"Canvas mapped: {self.btn_canvas.winfo_ismapped()}")
                
                items = self.btn_canvas.find_all()
                print(f"Items en canvas: {len(items)}")
                
                for item in items:
                    tags = self.btn_canvas.gettags(item)
                    coords = self.btn_canvas.coords(item)
                    print(f"  Item {item}: tags={tags}, coords={coords[:4] if len(coords) > 4 else coords}")
                
                all_tags = set()
                for item in items:
                    all_tags.update(self.btn_canvas.gettags(item))
                
                print(f"Tags únicos: {all_tags}")
                
            except Exception as e:
                print(f"Error en debug: {e}")
        
        print("FIN DEBUG \n")

    def crear_botones_preguntas(self):

        self.btn_canvas.delete("all")
        
        if hasattr(self, 'btn_iniciar'):
            del self.btn_iniciar
        if hasattr(self, 'btn_manual'):
            del self.btn_manual
        
        self.btn_canvas.config(cursor="")
        
        self.btn_si_visual = self.crear_boton_grande(
            230, 50,
            "✓ Sí",
            "#10b981",
            "#34d399",
            self.responder_si
        )
        
        self.btn_no_visual = self.crear_boton_grande(
            470, 50,
            "✗ No",
            "#ef4444",
            "#f87171",
            self.responder_no
        )
        
        self.btn_canvas.update_idletasks()
        
        print("Botones de preguntas creados correctamente")

    def crear_boton_grande(self, x, y, texto, color, color_acento, comando):
        width = 200
        height = 70
        
        tag = f"btn_{x}_{y}"
        
        shadow = self.btn_canvas.create_rectangle(
            x - width//2 + 4, y - height//2 + 4,
            x + width//2 + 4, y + height//2 + 4,
            fill="#0a0f1a", outline="", tags=tag
        )
        
        bg = self.btn_canvas.create_rectangle(
            x - width//2, y - height//2,
            x + width//2, y + height//2,
            fill=color, outline="", tags=tag
        )
        
        border = self.btn_canvas.create_rectangle(
            x - width//2, y - height//2,
            x + width//2, y + height//2,
            outline=color_acento, width=3, tags=tag
        )
        
        text = self.btn_canvas.create_text(
            x, y,
            text=texto,
            font=("Segoe UI", 14, "bold"),
            fill="white", tags=tag
        )
        
        btn_state = {"habilitado": True}
        
        def on_enter(e):
            if not btn_state["habilitado"]:
                return
            self.btn_canvas.itemconfig(bg, fill=self.ajustar_brillo(color, 1.3))
            self.btn_canvas.itemconfig(border, width=4)
            self.btn_canvas.config(cursor="hand2")
            try:
                SONIDO_CLICK.set_volume(0.2)
                SONIDO_CLICK.play()
            except:
                pass
        
        def on_leave(e):
            if not btn_state["habilitado"]:
                return
            self.btn_canvas.itemconfig(bg, fill=color)
            self.btn_canvas.itemconfig(border, width=3)
            self.btn_canvas.config(cursor="")
        
        def on_click(e):
            if not btn_state["habilitado"]:
                return
            self.btn_canvas.itemconfig(bg, fill=self.ajustar_brillo(color, 0.7))
            self.btn_canvas.after(100, lambda: self.btn_canvas.itemconfig(bg, fill=color) if btn_state["habilitado"] else None)
            try:
                comando()
            except Exception as ex:
                print(f"Error ejecutando comando del botón: {ex}")
        
        self.btn_canvas.tag_bind(tag, "<Enter>", on_enter)
        self.btn_canvas.tag_bind(tag, "<Leave>", on_leave)
        self.btn_canvas.tag_bind(tag, "<Button-1>", on_click)
        
        self.btn_canvas.tag_raise(tag)
        
        return {
            "bg": bg, 
            "border": border, 
            "text": text,
            "tag": tag,
            "state": btn_state,
            "color_original": color,
            "acento_original": color_acento
        }

    def iniciar_diagnostico(self):

        self.preguntas_vistas = []
        
        dialogo_registro = VD.DialogoRegistroEquipo(self.root)
        resultado = dialogo_registro.mostrar()
        
        if not resultado:
            return
        
        self.usuario_actual = registrar_usuario(
            resultado['nombre'],
            resultado['correo']
        )
        
        self.equipo_actual = registrar_equipo(
            self.usuario_actual,
            resultado.get('marca', 'Desconocido'),
            resultado.get('modelo', 'Desconocido'),
            resultado.get('tipo', 'Desktop')
        )
        
        self.sesion_actual = self.motor.crear_nueva_sesion(
            self.equipo_actual,
            self.usuario_actual
        )
        
        try:
            SONIDO_POWER.play()
        except:
            pass
        
        self.diagnostico_iniciado = True
        self.agregar_historial("🚀 Diagnóstico iniciado")
        self.agregar_historial(f"Usuario: {resultado['nombre']}")
        self.agregar_historial(f"Equipo: {resultado.get('marca', '')} {resultado.get('modelo', '')}")
        
        self.indice_pregunta = 0
        self.clave_pregunta_actual = self.motor.obtener_primera_pregunta()
        
        self.crear_botones_preguntas()
        
        self.mostrar_pregunta_actual()

    def bloquear_botones_footer(self, bloquear=True):
        try:
            for btn in self.botones_footer:
                texto = self.footer_canvas.itemcget(btn["text"], "text")
                tag = f"btn_{texto}"
                color = "#475569" if bloquear else btn["color"]

                self.footer_canvas.itemconfig(btn["bg"], fill=color)

                if bloquear:
                    self.footer_canvas.tag_unbind(tag, "<Button-1>")
                else:
                    self.footer_canvas.tag_bind(tag, "<Button-1>", lambda e, b=btn: b["comando"]())
        except Exception as e:
            print("Error bloqueando botones:", e)


    def mostrar_manual(self):
        SONIDO_LECTURA.play()
        VD.ManualDetallado(self.root).mostrar()


    def crear_boton_footer(self, x, y, texto, color, color_acento, comando, icono=None):
        width = 180
        height = 45
        
        btn_state = {"habilitado": True, "procesando": False}
        
        shadow = self.footer_canvas.create_rectangle(
            x - width//2 + 3, y - height//2 + 3,
            x + width//2 + 3, y + height//2 + 3,
            fill="#0a0f1a", outline="", tags=f"btn_{texto}"
        )
        
        bg_layer1 = self.footer_canvas.create_rectangle(
            x - width//2, y - height//2,
            x + width//2, y + height//2,
            fill=color, outline="", tags=f"btn_{texto}"
        )
        
        shine = self.footer_canvas.create_rectangle(
            x - width//2, y - height//2,
            x + width//2, y - height//2 + 15,
            fill=self.ajustar_brillo(color, 1.3), 
            outline="", tags=f"btn_{texto}"
        )
        self.footer_canvas.itemconfig(shine, state="hidden")
        
        border_outer = self.footer_canvas.create_rectangle(
            x - width//2 - 2, y - height//2 - 2,
            x + width//2 + 2, y + height//2 + 2,
            outline=color_acento, width=2, tags=f"btn_{texto}"
        )
        
        border_inner = self.footer_canvas.create_rectangle(
            x - width//2, y - height//2,
            x + width//2, y + height//2,
            outline=self.ajustar_brillo(color, 1.4), 
            width=1, tags=f"btn_{texto}"
        )
        
        particles = []
        corners = [
            (x - width//2 + 10, y - height//2 + 10),
            (x + width//2 - 10, y - height//2 + 10),
            (x - width//2 + 10, y + height//2 - 10),
            (x + width//2 - 10, y + height//2 - 10),
        ]
        
        for cx, cy in corners:
            particle = self.footer_canvas.create_oval(
                cx - 2, cy - 2, cx + 2, cy + 2,
                fill=color_acento, outline="", tags=f"btn_{texto}"
            )
            particles.append(particle)
        
        
        text_shadow = self.footer_canvas.create_text(
            x + 16, y + 1,
            text=texto,
            font=("Segoe UI", 12, "bold"),
            fill="#000000", tags=f"btn_{texto}"
        )
        
        text_main = self.footer_canvas.create_text(
            x + 15, y,
            text=texto,
            font=("Segoe UI", 12, "bold"),
            fill="white", tags=f"btn_{texto}"
        )

        if icono:
            icono_x = x - 60  
            icono_y = y       
            icono_id = self.footer_canvas.create_image(
                icono_x, icono_y, image=icono, anchor="center", tags=f"btn_{texto}"
            )
        else:
            icono_id = None

        
        energy_dot = self.footer_canvas.create_oval(
            x + width//2 - 15, y - 3,
            x + width//2 - 9, y + 3,
            fill=color_acento, outline="", tags=f"btn_{texto}"
        )
        
        def on_enter(e):
            if not btn_state["habilitado"] or btn_state["procesando"]:
                return
            
            try:
                if self.footer_canvas.winfo_exists():
                    self.footer_canvas.itemconfig(bg_layer1, fill=self.ajustar_brillo(color, 1.2))
                    self.footer_canvas.itemconfig(shine, state="normal")
                    self.footer_canvas.itemconfig(border_outer, width=3)
                    
                    for particle in particles:
                        self.footer_canvas.itemconfig(particle, fill="#ffffff")
                    
                    self.footer_canvas.config(cursor="hand2")
                    
                    try:
                        SONIDO_IDEA.set_volume(0.1)
                        SONIDO_IDEA.play()
                    except:
                        pass
            except (tk.TclError, RuntimeError):
                pass
        
        def on_leave(e):
            if not btn_state["habilitado"] or btn_state["procesando"]:
                return
            
            try:
                if self.footer_canvas.winfo_exists():
                    self.footer_canvas.itemconfig(bg_layer1, fill=color)
                    self.footer_canvas.itemconfig(shine, state="hidden")
                    self.footer_canvas.itemconfig(border_outer, width=2)
                    
                    for particle in particles:
                        self.footer_canvas.itemconfig(particle, fill=color_acento)
                    
                    self.footer_canvas.config(cursor="")
            except (tk.TclError, RuntimeError):
                pass
        
        def on_click(e):
            if not btn_state["habilitado"] or btn_state["procesando"]:
                return
            
            btn_state["procesando"] = True
            
            try:
                if self.footer_canvas.winfo_exists():
                    self.footer_canvas.itemconfig(bg_layer1, fill=self.ajustar_brillo(color, 0.7))
                    
                    self.crear_efecto_onda_footer(x, y, color_acento)
                    
                    def ejecutar_comando():
                        try:
                            comando()
                        finally:
                            self.footer_canvas.after(500, lambda: btn_state.update({"procesando": False}))
                            try:
                                if self.footer_canvas.winfo_exists():
                                    self.footer_canvas.itemconfig(bg_layer1, fill=color)
                            except:
                                pass
                    
                    self.footer_canvas.after(150, ejecutar_comando)
            except (tk.TclError, RuntimeError):
                btn_state["procesando"] = False
        
        for item in [shadow, bg_layer1, shine, border_outer, border_inner, 
                    text_shadow, text_main, energy_dot] + particles:
            self.footer_canvas.tag_bind(item, "<Enter>", on_enter)
            self.footer_canvas.tag_bind(item, "<Leave>", on_leave)
            self.footer_canvas.tag_bind(item, "<Button-1>", on_click)
        
        return {
            "shadow": shadow,
            "bg": bg_layer1,
            "shine": shine,
            "border_outer": border_outer,
            "border_inner": border_inner,
            "text": text_main,
            "energy_dot": energy_dot,
            "particles": particles,
            "x": x,
            "y": y,
            "color": color,
            "acento": color_acento,
            "state": btn_state, 
            "icono": icono_id
        }

    def crear_efecto_onda_footer(self, x, y, color):
        onda1 = self.footer_canvas.create_oval(
            x - 5, y - 5, x + 5, y + 5,
            outline=color, width=3
        )
        
        onda2 = self.footer_canvas.create_oval(
            x - 3, y - 3, x + 3, y + 3,
            outline="#ffffff", width=2
        )
        
        def expandir(size=5):
            if size < 50:
                self.footer_canvas.coords(onda1,
                    x - size, y - size,
                    x + size, y + size
                )
                
                size2 = size * 1.3
                self.footer_canvas.coords(onda2,
                    x - size2, y - size2,
                    x + size2, y + size2
                )
                
                width = max(1, int(3 * (1 - size/50)))
                self.footer_canvas.itemconfig(onda1, width=width)
                self.footer_canvas.itemconfig(onda2, width=max(1, width - 1))
                
                self.footer_canvas.after(20, lambda: expandir(size + 3))
            else:
                self.footer_canvas.delete(onda1)
                self.footer_canvas.delete(onda2)
        
        expandir()

    def animar_footer(self):
        try:
            if not self.root.winfo_exists():
                return
            
            self.footer_pulse = (self.footer_pulse + 3) % 360
            
            for i, btn in enumerate(self.botones_footer):
                if "state" in btn and not btn["state"]["habilitado"]:
                    continue
                
                try:
                    pulse_size = 2 + math.sin(math.radians(self.footer_pulse + i * 120))
                    coords = self.footer_canvas.coords(btn["energy_dot"])
                    if coords:
                        cx = (coords[0] + coords[2]) / 2
                        cy = (coords[1] + coords[3]) / 2
                        self.footer_canvas.coords(btn["energy_dot"],
                            cx - pulse_size, cy - pulse_size,
                            cx + pulse_size, cy + pulse_size
                        )
                    
                    for j, particle in enumerate(btn["particles"]):
                        offset = 1 + 0.5 * math.sin(math.radians(self.footer_pulse + i * 90 + j * 90))
                        coords = self.footer_canvas.coords(particle)
                        if coords:
                            cx = (coords[0] + coords[2]) / 2
                            cy = (coords[1] + coords[3]) / 2
                            size = 2 * offset
                            self.footer_canvas.coords(particle,
                                cx - size, cy - size,
                                cx + size, cy + size
                            )
                    
                    border_width = 2 + int(0.5 * math.sin(math.radians(self.footer_pulse + i * 120)))
                    self.footer_canvas.itemconfig(btn["border_outer"], width=border_width)
                except (tk.TclError, RuntimeError, KeyError):
                    continue
            
            try:
                scale = 1 + 0.05 * math.sin(math.radians(self.footer_pulse))
                font_size = int(10 * scale)
                self.footer_canvas.itemconfig(
                    self.status_footer,
                    font=("Segoe UI", font_size, "bold")
                )
            except (tk.TclError, RuntimeError):
                pass
            
            self.root.after(50, self.animar_footer)
        except (tk.TclError, RuntimeError):
            pass


    def cerrar_aplicacion(self):
        if getattr(self, "_cerrando", False):
            return
        self._cerrando = True
        
        try:
            SONIDO_BREAK.play()
        except:
            pass
        
        def mostrar_dialogo_y_cerrar():
            resultado = VD.DialogoConfirmacion(
                self.root,
                "⚠️ Cerrar Sistema",
                "¿Estás seguro de que deseas salir?\nSe perderá el progreso actual del diagnóstico.",
                tipo="warning"
            ).mostrar()
            
            if resultado:
                self._ejecutar_cierre()
            else:
                self._cerrando = False
        
        self.root.after(100, mostrar_dialogo_y_cerrar)

    def _ejecutar_cierre(self):
        try:
            if hasattr(self, 'asistente'):
                self.asistente.detener()
        except Exception as e:
            print(f"Error deteniendo asistente: {e}")
        
        try:
            self.musica_activada = False
            pygame.mixer.music.stop()
        except:
            pass
        
        try:
            for i in range(pygame.mixer.get_num_channels()):
                pygame.mixer.Channel(i).stop()
        except:
            pass
        
        try:
            self.agregar_historial("Sistema cerrado por el usuario.")
        except:
            pass
        
        try:
            SONIDO_POWER.play()
        except:
            pass
        
        try:
            for job_id in self.root.tk.call('after', 'info'):
                try:
                    self.root.after_cancel(job_id)
                except:
                    pass
        except:
            pass
        
        self.root.after(300, self._destruir_ventana)

    def _destruir_ventana(self):
        try:
            self.root.quit()
            self.root.destroy()
        except:
            pass


    def crear_boton_control(self, x, y, icono, color, comando):
        circulo_borde = self.control_canvas.create_oval(
            x - 22, y - 22, x + 22, y + 22,
            outline=color, width=2, tags=f"btn_{id(icono)}"
        )
        
        circulo_fondo = self.control_canvas.create_oval(
            x - 20, y - 20, x + 20, y + 20,
            fill=color, outline="", tags=f"btn_{id(icono)}"
        )
        
        circulo_brillo = self.control_canvas.create_oval(
            x - 15, y - 18, x + 8, y - 5,
            fill="#ffffff", outline="", tags=f"btn_{id(icono)}"
        )
        self.control_canvas.itemconfig(circulo_brillo, state="hidden")

        if isinstance(icono, (PhotoImage, ImageTk.PhotoImage)):
            texto = self.control_canvas.create_image(
                x, y, image=icono, tags=f"btn_{id(icono)}"
            )
            if not hasattr(self, "_icon_refs"):
                self._icon_refs = []
            self._icon_refs.append(icono)
        else:
            texto = self.control_canvas.create_text(
                x, y, text=icono,
                font=("Segoe UI", 18),
                fill="white", tags=f"btn_{id(icono)}"
            )

        def on_enter(e):
            self.control_canvas.itemconfig(circulo_fondo, fill=self.ajustar_brillo(color, 1.3))
            self.control_canvas.itemconfig(circulo_brillo, state="normal")
            self.control_canvas.itemconfig(circulo_borde, width=3)
            self.control_canvas.config(cursor="hand2")

        def on_leave(e):
            self.control_canvas.itemconfig(circulo_fondo, fill=color)
            self.control_canvas.itemconfig(circulo_brillo, state="hidden")
            self.control_canvas.itemconfig(circulo_borde, width=2)
            self.control_canvas.config(cursor="")

        def on_click(e):
            self.control_canvas.itemconfig(circulo_fondo, fill=self.ajustar_brillo(color, 0.7))
            self.control_canvas.after(100, lambda: self.control_canvas.itemconfig(circulo_fondo, fill=color))
            self.crear_efecto_onda(x, y)
            comando()

        tag = f"btn_{id(icono)}"
        self.control_canvas.tag_bind(tag, "<Enter>", on_enter)
        self.control_canvas.tag_bind(tag, "<Leave>", on_leave)
        self.control_canvas.tag_bind(tag, "<Button-1>", on_click)

        return {
            "borde": circulo_borde,
            "fondo": circulo_fondo,
            "brillo": circulo_brillo,
            "texto": texto,
            "color": color,
            "x": x,
            "y": y
        }

    
    def crear_efecto_onda(self, x, y):
        onda = self.control_canvas.create_oval(
            x - 5, y - 5, x + 5, y + 5,
            outline="#ffffff", width=2
        )
        
        def expandir(size=5):
            if size < 30:
                self.control_canvas.coords(onda, 
                    x - size, y - size, 
                    x + size, y + size
                )
                alpha = int(255 * (1 - size/30))
                self.control_canvas.after(20, lambda: expandir(size + 2))
            else:
                self.control_canvas.delete(onda)
        
        expandir()
    
    def actualizar_indicador(self, indice, activo):
        if indice < len(self.indicadores):
            color = "#10b981" if activo else "#334155"  
            self.control_canvas.itemconfig(self.indicadores[indice], fill=color)

    def crear_boton_visual(self, x, y, texto, color, comando):
        btn_rect = self.btn_canvas.create_rectangle(
            x - 80, y - 25, x + 80, y + 25,
            fill=color, outline="", tags=f"btn_{texto}"
        )
        
        btn_border = self.btn_canvas.create_rectangle(
            x - 80, y - 25, x + 80, y + 25,
            outline="#ffffff", width=2, tags=f"btn_{texto}"
        )
        
        btn_text = self.btn_canvas.create_text(
            x, y, text=texto,
            font=("Segoe UI", 16, "bold"),
            fill="white", tags=f"btn_{texto}"
        )
        
        def on_enter(e):
            self.btn_canvas.itemconfig(btn_rect, fill=self.ajustar_brillo(color, 1.2))
            self.btn_canvas.config(cursor="hand2")
        
        def on_leave(e):
            self.btn_canvas.itemconfig(btn_rect, fill=color)
            self.btn_canvas.config(cursor="")
        
        def on_click(e):
            self.btn_canvas.itemconfig(btn_rect, fill=self.ajustar_brillo(color, 0.8))
            self.btn_canvas.after(100, lambda: self.btn_canvas.itemconfig(btn_rect, fill=color))
            comando()
        
        self.btn_canvas.tag_bind(f"btn_{texto}", "<Enter>", on_enter)
        self.btn_canvas.tag_bind(f"btn_{texto}", "<Leave>", on_leave)
        self.btn_canvas.tag_bind(f"btn_{texto}", "<Button-1>", on_click)
        
        return {"rect": btn_rect, "border": btn_border, "text": btn_text}
    
    def ajustar_brillo(self, hex_color, factor):

        hex_color = hex_color.lstrip('#')
        
        r, g, b = tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))
        
        r = min(255, int(r * factor))
        g = min(255, int(g * factor))
        b = min(255, int(b * factor))
        
        return f"#{r:02x}{g:02x}{b:02x}"
    
    def actualizar_barra_progreso(self, valor):

        x_end = 50 + (500 * valor / 100)
        
        self.progress_canvas.coords(self.progress_fill_rect, 50, 20, x_end, 45)
        self.progress_canvas.coords(self.progress_glow_rect, 50, 20, x_end, 45)
        
        self.progress_canvas.itemconfig(self.progress_text, text=f"{int(valor)}%")
        
        pregunta_num = min(int(valor / 10) + 1, 10)
        self.progress_canvas.itemconfig(
            self.progress_question_text, 
            text=f"Pregunta {pregunta_num} de 10"
        )
        
        if valor < 33:
            color = "#ef4444" 
        elif valor < 66:
            color = "#f59e0b"  
        else:
            color = "#10b981" 
        
        self.progress_canvas.itemconfig(self.progress_fill_rect, fill=color)
        self.progress_canvas.itemconfig(self.progress_glow_rect, outline=color)

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

    def toggle_musica(self):
        try:
            if not self.musica_activa:
                SONIDO_TEMA.play(-1)  
                self.musica_activa = True
                messagebox.showinfo("Música", "Música de fondo activada.")
            else:
                SONIDO_TEMA.stop()
                self.musica_activa = False
                messagebox.showinfo("Música", "Música de fondo detenida.")
        except Exception as e:
            print("Error al controlar música:", e)


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
        
        if hasattr(self, 'header_icons'):
            for i, icon in enumerate(self.header_icons):
                y_offset = 40 + math.sin(math.radians(self.pulse + i * 72)) * 5
                self.header_canvas.coords(icon, 80 + i * 140, y_offset)
        
        if hasattr(self, 'btn_canvas'):
            pulse_width = 2 + int(math.sin(math.radians(self.pulse)) * 0.5)
            if hasattr(self, 'btn_si_visual'):
                self.btn_canvas.itemconfig(self.btn_si_visual['border'], width=pulse_width)
            if hasattr(self, 'btn_no_visual'):
                self.btn_canvas.itemconfig(self.btn_no_visual['border'], width=pulse_width)
        
        if hasattr(self, 'botones_control'):
            for i, btn in enumerate(self.botones_control):
                pulse_width = 2 + int(math.sin(math.radians(self.pulse + i * 90)) * 0.5)
                self.control_canvas.itemconfig(btn['borde'], width=pulse_width)
                
                if hasattr(self, 'control_canvas'):
                    offset_y = math.sin(math.radians(self.pulse + i * 90)) * 1
                    self.control_canvas.coords(btn['texto'], btn['x'], btn['y'] + offset_y)
        
        if hasattr(self, 'indicadores'):
            for i, indicador in enumerate(self.indicadores):
                color_actual = self.control_canvas.itemcget(indicador, 'fill')
                if color_actual == "#10b981":  
                    alpha = 0.7 + 0.3 * math.sin(math.radians(self.pulse + i * 120))
                    r, g, b = int(16 * alpha), int(185 * alpha), int(129 * alpha)
                    self.control_canvas.itemconfig(indicador, fill=f"#{r:02x}{g:02x}{b:02x}")
        
        self.root.after(50, self.animar)

    def responder_si(self):
        SONIDO_POWER.play()
        self.procesar_respuesta('si')

    def responder_no(self):
        SONIDO_SOLTAR.play()
        self.procesar_respuesta('no')

    def mostrar_pregunta_texto(self, texto_pregunta):
        self.asistente.mostrar_tip_ani_2(
            texto_pregunta,
            velocidad=18,
            hablar=self.asistente.usar_voz
        )
        self.agregar_historial(f"? {texto_pregunta}")
        
        self.crear_entrada_texto()

    def crear_entrada_texto(self):

        self.btn_canvas.delete("all")
        
        entrada_frame = tk.Frame(self.btn_canvas, bg="#1e293b")
        entrada_window = self.btn_canvas.create_window(
            350, 50,
            window=entrada_frame,
            anchor="center"
        )
        
        self.entrada_texto = tk.Entry(
            entrada_frame,
            font=("Segoe UI", 14),
            bg="#334155",
            fg="#e2e8f0",
            insertbackground="#38bdf8",
            relief="flat",
            width=30
        )
        self.entrada_texto.pack(pady=10, padx=10)
        self.entrada_texto.focus()
        
        btn_enviar = tk.Button(
            entrada_frame,
            text="✓ Enviar",
            font=("Segoe UI", 12, "bold"),
            bg="#10b981",
            fg="white",
            relief="flat",
            padx=20,
            pady=10,
            cursor="hand2",
            command=self.procesar_respuesta_texto
        )
        btn_enviar.pack(pady=5)
        
        self.entrada_texto.bind("<Return>", lambda e: self.procesar_respuesta_texto())

    def procesar_respuesta_texto(self):

        respuesta = self.entrada_texto.get().strip()
        
        if not respuesta:
            return
        
        try:
            SONIDO_POWER.play()
        except:
            pass
        
        self.motor.registrar_sintoma(
            self.clave_pregunta_actual,
            respuesta,
            categoria=self.determinar_categoria(self.clave_pregunta_actual)
        )
        
        self.agregar_historial(f"  ➤ Respuesta: {respuesta}")
        
        siguiente = self.motor.obtener_siguiente_pregunta(
            self.clave_pregunta_actual,
            respuesta
        )
        
        self.crear_botones_preguntas()
        
        if siguiente:
            self.clave_pregunta_actual = siguiente
            self.indice_pregunta += 1
            self.mostrar_pregunta_actual()
        else:
            self.finalizar_diagnostico()

    def procesar_respuesta(self, respuesta):
        self.motor.registrar_sintoma(
            self.clave_pregunta_actual,
            respuesta,
            categoria=self.determinar_categoria(self.clave_pregunta_actual)
        )
        
        if not hasattr(self, 'preguntas_vistas'):
            self.preguntas_vistas = []
        
        if self.clave_pregunta_actual in self.preguntas_vistas:
            print(f"BUCLE DETECTADO en: {self.clave_pregunta_actual}")
            self.finalizar_diagnostico()
            return
        
        self.preguntas_vistas.append(self.clave_pregunta_actual)
        
        self.agregar_historial(f"  ➤ Respuesta: {respuesta.upper()}")
        
        siguiente = self.motor.obtener_siguiente_pregunta(
            self.clave_pregunta_actual,
            respuesta
        )
        
        if siguiente:
            self.clave_pregunta_actual = siguiente
            self.indice_pregunta += 1
            self.mostrar_pregunta_actual()
        else:
            self.finalizar_diagnostico()

    def siguiente_pregunta(self, value):
        self.current_question += 1
        
        if self.current_question < len(self.preguntas):
            pregunta_actual = self.preguntas[self.current_question]
            self.asistente.mostrar_tip_ani_2(pregunta_actual, velocidad=18, 
                                            hablar=self.asistente.usar_voz)
            
            progreso = (self.current_question / len(self.preguntas)) * 100
            self.progress['value'] = progreso
            
        else:
            pregunta_actual = "Diagnóstico completado.\nPresiona 'Generar Informe' para ver los resultados"
            self.asistente.mostrar_tip_ani_2(pregunta_actual, velocidad=18, 
                                            hablar=self.asistente.usar_voz)
            
            self.deshabilitar_botones_respuesta()
            
            self.progress['value'] = 100
            self.agregar_historial("Diagnóstico finalizado.")
        
        if value == 1:
            try:
                SONIDO_POWER.play()
            except:
                pass
        else:
            try:
                SONIDO_SOLTAR.play()
            except:
                pass

    def deshabilitar_botones_respuesta(self):
        try:
            if hasattr(self, 'btn_si_visual') and self.btn_si_visual:
                self.btn_si_visual['state']['habilitado'] = False
                
                self.btn_canvas.itemconfig(self.btn_si_visual['bg'], fill="#475569")
                self.btn_canvas.itemconfig(self.btn_si_visual['border'], outline="#64748b", width=1)
                
                if 'tag' in self.btn_si_visual:
                    self.btn_canvas.tag_unbind(self.btn_si_visual['tag'], "<Enter>")
                    self.btn_canvas.tag_unbind(self.btn_si_visual['tag'], "<Leave>")
                    self.btn_canvas.tag_unbind(self.btn_si_visual['tag'], "<Button-1>")
            
            if hasattr(self, 'btn_no_visual') and self.btn_no_visual:
                self.btn_no_visual['state']['habilitado'] = False
                
                self.btn_canvas.itemconfig(self.btn_no_visual['bg'], fill="#475569")
                self.btn_canvas.itemconfig(self.btn_no_visual['border'], outline="#64748b", width=1)
                
                if 'tag' in self.btn_no_visual:
                    self.btn_canvas.tag_unbind(self.btn_no_visual['tag'], "<Enter>")
                    self.btn_canvas.tag_unbind(self.btn_no_visual['tag'], "<Leave>")
                    self.btn_canvas.tag_unbind(self.btn_no_visual['tag'], "<Button-1>")
            
            self.btn_canvas.config(cursor="")
            
        except Exception as e:
            print(f"Error deshabilitando botones: {e}")

    def habilitar_botones_respuesta(self):
        try:
            self.crear_botones_preguntas()
        except Exception as e:
            print(f"Error habilitando botones: {e}")


    def agregar_historial(self, texto):
        self.history_text.config(state="normal")
        self.history_text.insert("end", f"{texto}\n")
        self.history_text.see("end")
        self.history_text.config(state="disabled")

    def reiniciar(self):
        if getattr(self, "_reiniciando", False):
            return
        self._reiniciando = True
        
        try:
            SONIDO_VOICE.play()
        except:
            pass
        
        def ejecutar_reinicio():
            try:
                self._reiniciar_seguro()
            finally:
                self._reiniciando = False
        
        self.root.after(100, ejecutar_reinicio)

    def _reiniciar_seguro(self):
        self.current_question = 0
        self.progress['value'] = 10
        self.diagnostico_iniciado = False
        
        if hasattr(self, 'btn_si_visual'):
            del self.btn_si_visual
        if hasattr(self, 'btn_no_visual'):
            del self.btn_no_visual

        self.crear_botones_iniciales()

        self.history_text.config(state="normal")
        self.history_text.delete("1.0", "end")
        self.history_text.insert("1.0", "Sistema reiniciado\n\n")
        self.history_text.insert("end", "Listo para nuevo diagnóstico...\n\n")
        self.history_text.config(state="disabled")
        
        mensaje_bienvenida = """¡Sistema reiniciado!
        Estoy listo para un nuevo diagnóstico. 
        Presiona 'Iniciar Diagnóstico' cuando quieras comenzar."""
        
        try:
            self.asistente.mostrar_tip_ani_2(mensaje_bienvenida, velocidad=15, 
                                            hablar=self.asistente.usar_voz)
        except Exception as e:
            print(f"Error mostrando mensaje: {e}")


    def reset_ex(self):
        try:
            SONIDO_VOICE.play()
        except:
            pass
        
        if not self.preguntas or len(self.preguntas) == 0:
            print("Error: No hay preguntas disponibles")
            return
        
        self.current_question = 0
        self.progress['value'] = 10
        
        if not hasattr(self, 'btn_si_visual') or not hasattr(self, 'btn_no_visual'):
            self.crear_botones_preguntas()
        else:
            self.habilitar_botones_respuesta()
        
        try:
            pregunta_actual = self.preguntas[0]
            self.asistente.mostrar_tip_ani_2(pregunta_actual, velocidad=18, 
                                            hablar=self.asistente.usar_voz)
        except Exception as e:
            print(f"Error mostrando pregunta: {e}")

    def generar_informe(self):

        if getattr(self, "_generando_informe", False):
            return
        self._generando_informe = True
        
        try:
            SONIDO_LECTURA.play()
        except:
            pass
        
        def mostrar_informe():
            try:
                if not hasattr(self, 'diagnosticos_actuales') or not self.diagnosticos_actuales:
                    VD.DialogoPersonalizado(
                        self.root,
                        "Info: Sin Diagnóstico",
                        "Primero debes completar un diagnóstico.",
                        tipo="warning"
                    ).mostrar()
                else:
                    VD.DialogoInformeDiagnostico(
                        self.root,
                        self.diagnosticos_actuales,
                        self.sesion_actual
                    ).mostrar()
            finally:
                self._generando_informe = False
        
        self.root.after(100, mostrar_informe)

    def _mostrar_informe_dialogo(self):
        try:
            VD.DialogoPersonalizado(
                self.root,
                "Informe Generado",
                "El análisis de diagnóstico ha sido completado.\nRevisa el historial para más detalles.",
                tipo="success"
            ).mostrar()
        except Exception as e:
            print("Error mostrando diálogo de informe:", e)
        
        self.bloquear_botones_footer(False)
        self._footer_lock = False


    def toggle_asistente(self):
        self.asistente.usar_voz = not self.asistente.usar_voz
        
        self.actualizar_indicador(0, self.asistente.usar_voz)
        
        if self.asistente.usar_voz:
            SONIDO_VOICE.play()
            if hasattr(self, 'botones_control') and len(self.botones_control) > 0:
                btn = self.botones_control[0]
                self.control_canvas.itemconfig(btn['fondo'], fill="#22d3ee")
                self.control_canvas.after(300, lambda: self.control_canvas.itemconfig(
                    btn['fondo'], fill=btn['color']
                ))
            
            VD.DialogoPersonalizado(
                self.root,
                "🤖 Asistente Activado",
                "El asistente hablará las preguntas\ncon voz inteligente y natural.",
                tipo="success"
            ).mostrar()
        else:
            SONIDO_POWER.play()
            VD.DialogoPersonalizado(
                self.root,
                "🔇 Modo Silencioso",
                "El asistente permanecerá en silencio.\nPuedes reactivarlo en cualquier momento.",
                tipo="info"
            ).mostrar()

    def cambiar_modo_voz(self):
        SONIDO_CHANGE.play()
        if not hasattr(self, "modo_voz"):
            self.modo_voz = "gtts"

        if self.modo_voz == "gtts":
            self.modo_voz = "local"
            
            if hasattr(self, 'botones_control') and len(self.botones_control) > 1:
                btn = self.botones_control[1]
                self.control_canvas.itemconfig(btn['fondo'], fill="#f59e0b")
                self.control_canvas.after(300, lambda: self.control_canvas.itemconfig(
                    btn['fondo'], fill=btn['color']
                ))
            
            VD.DialogoPersonalizado(
                self.root,
                "🎤 Voz Local Activada",
                "Ahora se usará el motor de voz offline\ncon pyttsx3 para mayor rapidez.",
                tipo="warning"
            ).mostrar()
            
            self.asistente.use_gtts = False
            if not getattr(self.asistente, "engine", None):
                try:
                    self.asistente.init_engine()
                except Exception as e:
                    print("Error inicializando engine al cambiar a local:", e)
        else:
            self.modo_voz = "gtts"
            
            if hasattr(self, 'botones_control') and len(self.botones_control) > 1:
                btn = self.botones_control[1]
                self.control_canvas.itemconfig(btn['fondo'], fill="#22d3ee")
                self.control_canvas.after(300, lambda: self.control_canvas.itemconfig(
                    btn['fondo'], fill=btn['color']
                ))
            
            VD.DialogoPersonalizado(
                self.root,
                "🌐 TTS Activado",
                "Ahora se usará la voz en línea de Google\npara mejor calidad de audio.",
                tipo="info"
            ).mostrar()
            
            self.asistente.use_gtts = True


    def MUSICA_FONDO(self):
        SONIDO_CHANGE.play()
        self.musica_activada = not self.musica_activada

        self.actualizar_indicador(2, self.musica_activada)

        if self.musica_activada:
            if hasattr(self, 'btn_MUSICA_visual'):
                self.control_canvas.itemconfig(
                    self.btn_MUSICA_visual['fondo'], 
                    fill="#a1ffb1"
                )
                self.control_canvas.itemconfig(
                    self.btn_MUSICA_visual['borde'], 
                    outline="#a1ffb1"
                )
            
            self.iniciar_musica_fondo()
        else:
            if hasattr(self, 'btn_MUSICA_visual'):
                self.control_canvas.itemconfig(
                    self.btn_MUSICA_visual['fondo'], 
                    fill="#b2a6f5"
                )
                self.control_canvas.itemconfig(
                    self.btn_MUSICA_visual['borde'], 
                    outline="#b2a6f5"
                )
            
            pygame.mixer.music.stop()


    def cambiar_cancion_manual(self):
        SONIDO_NEXT.play()
        
        if hasattr(self, 'botones_control') and len(self.botones_control) > 3:
            btn = self.botones_control[3]
            colores = ["#60a5fa", "#3b82f6", "#2563eb", "#3b82f6", "#60a5fa"]
            
            def animar_colores(i=0):
                if i < len(colores):
                    self.control_canvas.itemconfig(btn['fondo'], fill=colores[i])
                    self.control_canvas.after(50, lambda: animar_colores(i + 1))
                else:
                    self.control_canvas.itemconfig(btn['fondo'], fill=btn['color'])
            
            animar_colores()
        
        if not self.musica_activada:
            return

        if not self.lista_canciones:
            return

        ultima = getattr(self, "_ultima_cancion", None)
        canciones_disponibles = [c for c in self.lista_canciones if c != ultima]
        if not canciones_disponibles:
            canciones_disponibles = self.lista_canciones

        nueva_cancion = random.choice(canciones_disponibles)
        self._ultima_cancion = nueva_cancion

        try:
            pygame.mixer.music.load(nueva_cancion)
            pygame.mixer.music.set_volume(0.4)
            pygame.mixer.music.play()

            nombre = os.path.basename(nueva_cancion)
            print("Cambiada a:", nueva_cancion)
        except Exception as e:
            print("Error al cambiar de canción:", e)


    def iniciar_musica_fondo(self):
        def reproducir_loop():
            while self.musica_activada:
                if not pygame.mixer.music.get_busy():
                    cancion = random.choice(self.lista_canciones)
                    try:
                        pygame.mixer.music.load(cancion)
                        pygame.mixer.music.set_volume(0.2)
                        pygame.mixer.music.play()
                        self._ultima_cancion = cancion
                    except Exception as e:
                        print(f"Error al reproducir {cancion}: {e}")
                time.sleep(1)

        if self.musica_hilo is None or not self.musica_hilo.is_alive():
            self.musica_hilo = threading.Thread(target=reproducir_loop, daemon=True)
            self.musica_hilo.start()

    def reproducir_sonido(self, sonido, volumen=0.7):
        try:
            voz_ocupada = False
            if hasattr(self, 'asistente') and hasattr(self.asistente, 'canal_voz'):
                voz_ocupada = self.asistente.canal_voz.get_busy()
            
            if voz_ocupada:
                sonido.set_volume(volumen * 0.3) 
            else:
                sonido.set_volume(volumen)
                
            if hasattr(self, 'asistente') and hasattr(self.asistente, 'canal_efectos'):
                canal = self.asistente.canal_efectos
                if not canal.get_busy() or not voz_ocupada: 
                    canal.play(sonido)
            else:
                sonido.play()
                
        except Exception as e:
            print(f"Error reproduciendo sonido: {e}")
            try:
                sonido.play()
            except:
                pass

class VentanaCarga:
    def __init__(self, master):
        self.master = master
        self.master.title("Cargando...")
        self.master.geometry("600x400")
        self.master.config(bg="#0f172a")
        self.master.resizable(False, False)
        self.master.overrideredirect(True)

        self.master.update_idletasks()
        w, h = 600, 400
        x = (self.master.winfo_screenwidth() // 2) - (w // 2)
        y = (self.master.winfo_screenheight() // 2) - (h // 2)
        self.master.geometry(f"{w}x{h}+{x}+{y}")

        self.angle = 0
        self.pulse = 0
        self.progress_val = 0
        self.particles = []

        self.animacion_activa = True
        self._anim_logo_job = None
        self._anim_particulas_job = None
        self._anim_barra_job = None
        
        for _ in range(30):
            self.particles.append({
                'x': random.randint(0, w),
                'y': random.randint(0, h),
                'speed': random.uniform(0.5, 2),
                'size': random.randint(1, 3)
            })

        self.canvas = tk.Canvas(master, width=600, height=400, bg="#0f172a", highlightthickness=0)
        self.canvas.pack(fill="both", expand=True)

        self.canvas.create_rectangle(0, 0, 600, 400, fill="#0f172a", outline="")
        
        self.canvas.create_rectangle(0, 0, 600, 400, outline="#1e293b", width=3)

        self.logo_elements = []
        
        self.canvas.create_text(300, 100, 
                               text="SISTEMA EXPERTO", 
                               font=("Segoe UI", 32, "bold"),
                               fill="#38bdf8")
        
        self.canvas.create_text(300, 140, 
                               text="Diagnóstico Inteligente de Hardware", 
                               font=("Segoe UI", 12),
                               fill="#94a3b8")

        # Barra de progreso personalizada
        self.bar_bg = self.canvas.create_rectangle(100, 250, 500, 280, 
                                                   fill="#1e293b", outline="#334155", width=2)
        self.bar_fill = self.canvas.create_rectangle(100, 250, 100, 280, 
                                                     fill="#38bdf8", outline="")
        
        # Borde brillante de la barra
        self.bar_glow = self.canvas.create_rectangle(100, 250, 100, 280, 
                                                     outline="#22d3ee", width=2)

        # Texto de porcentaje
        self.percent_text = self.canvas.create_text(300, 265, 
                                                    text="0%", 
                                                    font=("Segoe UI", 14, "bold"),
                                                    fill="#ffffff")

        # Texto de estado
        self.status_text = self.canvas.create_text(300, 310, 
                                                   text="Inicializando componentes...", 
                                                   font=("Segoe UI", 10),
                                                   fill="#64748b")

        self.mensajes_carga = [
            "Inicializando componentes...",
            "Cargando módulos de diagnóstico...",
            "Configurando red semántica...",
            "Preparando interfaz gráfica...",
            "Activando asistente virtual...",
            "Verificando sistema de audio...",
            "Cargando base de conocimientos...",
            "Optimizando rendimiento...",
            "Finalizando configuración...",
            "¡Listo para diagnosticar!"
        ]
        self.mensaje_actual = 0

        self.animar_logo()
        self.animar_particulas()
        self.animar_barra()

    def animar_logo(self):
        if not self.animacion_activa:
            return
        
        try:
            self.angle = (self.angle + 3) % 360
            self.pulse = (self.pulse + 5) % 360
            
            for elem in self.logo_elements:
                self.canvas.delete(elem)
            self.logo_elements.clear()

            cx, cy = 300, 190
            
            for i in range(8):
                angle = self.angle + (i * 45)
                x = cx + 40 * math.cos(math.radians(angle))
                y = cy + 40 * math.sin(math.radians(angle))
                size = 4 + 2 * math.sin(math.radians(self.pulse + i * 45))
                elem = self.canvas.create_oval(x - size, y - size, x + size, y + size,
                                            fill="#38bdf8", outline="")
                self.logo_elements.append(elem)

            pulse_size = 12 + 4 * math.sin(math.radians(self.pulse))
            elem = self.canvas.create_oval(cx - pulse_size, cy - pulse_size,
                                        cx + pulse_size, cy + pulse_size,
                                        fill="#10b981", outline="#22d3ee", width=2)
            self.logo_elements.append(elem)

            ring_size = 50 + 5 * math.sin(math.radians(self.pulse * 0.5))
            elem = self.canvas.create_oval(cx - ring_size, cy - ring_size,
                                        cx + ring_size, cy + ring_size,
                                        outline="#6366f1", width=2)
            self.logo_elements.append(elem)

            self._anim_logo_job = self.master.after(50, self.animar_logo)
        except tk.TclError:
            self.animacion_activa = False

    def animar_particulas(self):
        if not self.animacion_activa:
            return
        
        try:
            for particle in self.particles:
                particle['y'] -= particle['speed']
                
                if particle['y'] < 0:
                    particle['y'] = 400
                    particle['x'] = random.randint(0, 600)
                
                alpha = int(100 + 100 * math.sin(math.radians(self.pulse + particle['x'])))
                color = f"#{alpha:02x}{alpha:02x}{min(alpha + 50, 255):02x}"
                
                self.canvas.create_oval(
                    particle['x'], particle['y'],
                    particle['x'] + particle['size'], 
                    particle['y'] + particle['size'],
                    fill=color, outline=""
                )
            
            self._anim_particulas_job = self.master.after(50, self.animar_particulas)
        except tk.TclError:
            self.animacion_activa = False

    def animar_barra(self, valor=0):
        if not self.animacion_activa:
            return
        
        try:
            if valor <= 100:
                self.progress_val = valor
                
                x_end = 100 + (400 * valor / 100)
                self.canvas.coords(self.bar_fill, 100, 250, x_end, 280)
                self.canvas.coords(self.bar_glow, 100, 250, x_end, 280)
                
                self.canvas.itemconfig(self.percent_text, text=f"{int(valor)}%")
                
                if valor < 33:
                    color = "#ef4444"  
                elif valor < 66:
                    color = "#f59e0b" 
                else:
                    color = "#10b981" 
                
                self.canvas.itemconfig(self.bar_fill, fill=color)
                self.canvas.itemconfig(self.bar_glow, outline=color)
                
                nuevo_mensaje = min(int(valor / 10), len(self.mensajes_carga) - 1)
                if nuevo_mensaje != self.mensaje_actual:
                    self.mensaje_actual = nuevo_mensaje
                    self.canvas.itemconfig(self.status_text, 
                                        text=self.mensajes_carga[self.mensaje_actual])
                
                if valor > 90:
                    pulse_width = 2 + int(2 * math.sin(math.radians(self.pulse)))
                    self.canvas.itemconfig(self.bar_glow, width=pulse_width)
                
                self._anim_barra_job = self.master.after(40, self.animar_barra, valor + 1)
            else:
                self.canvas.itemconfig(self.status_text, 
                                    text="Carga completada - Iniciando sistema...",
                                    fill="#10b981")
                self.master.after(800, self.cerrar_splash)
        except tk.TclError:
            self.animacion_activa = False

    def detener_animaciones(self):
        self.animacion_activa = False
        
        for job in [self._anim_logo_job, self._anim_particulas_job, self._anim_barra_job]:
            if job:
                try:
                    self.master.after_cancel(job)
                except (ValueError, tk.TclError):
                    pass
        
        self._anim_logo_job = None
        self._anim_particulas_job = None
        self._anim_barra_job = None

    def cerrar_splash(self):
        self.detener_animaciones()
        
        try:
            if 'SONIDO_BURBUJAS' in globals():
                SONIDO_BURBUJAS.play()
        except:
            pass
        
        try:
            self.master.destroy()
        except:
            pass

        root_principal = tk.Tk()
        app = SistemaExpertoUI(root_principal)
        root_principal.mainloop()

if __name__ == "__main__":
    root = tk.Tk()
    splash = VentanaCarga(root)
    root.mainloop()

    
