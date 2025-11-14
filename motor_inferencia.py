#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import os
import platform

sistema = platform.system().lower()

if sistema == 'linux':
    import locale
    try:
        locale.setlocale(locale.LC_ALL, 'es_ES.UTF-8')
        print("✓ Locale configurado: es_ES.UTF-8")
    except locale.Error:
        try:
            locale.setlocale(locale.LC_ALL, 'en_US.UTF-8')
            print("✓ Locale configurado: en_US.UTF-8")
        except locale.Error:
            try:
                locale.setlocale(locale.LC_ALL, 'C.UTF-8')
                print("✓ Locale configurado: C.UTF-8")
            except locale.Error:
                print("⚠ Warning: No se pudo configurar locale UTF-8")
                locale.setlocale(locale.LC_ALL, 'C')
    
    os.environ['LC_ALL'] = locale.getlocale()[0] or 'C.UTF-8'
    os.environ['LANG'] = os.environ['LC_ALL']
    os.environ['LC_CTYPE'] = 'UTF-8'

elif sistema == 'windows':
    try:
        import ctypes
        kernel32 = ctypes.windll.kernel32
        kernel32.SetConsoleCP(65001)
        kernel32.SetConsoleOutputCP(65001)
        print("✓ Consola Windows configurada: UTF-8 (CP65001)")
    except Exception as e:
        print(f"⚠ Warning Windows encoding: {e}")
    
    if sys.stdout.encoding != 'utf-8':
        sys.stdout.reconfigure(encoding='utf-8')
    if sys.stderr.encoding != 'utf-8':
        sys.stderr.reconfigure(encoding='utf-8')
    
    os.environ['PYTHONIOENCODING'] = 'utf-8'

elif sistema == 'darwin':  
    import locale
    try:
        locale.setlocale(locale.LC_ALL, 'es_ES.UTF-8')
        print("✓ Locale macOS configurado: es_ES.UTF-8")
    except locale.Error:
        try:
            locale.setlocale(locale.LC_ALL, 'en_US.UTF-8')
            print("✓ Locale macOS configurado: en_US.UTF-8")
        except locale.Error:
            print("⚠ Warning macOS: No se pudo configurar locale UTF-8")
    
    os.environ['LC_ALL'] = 'UTF-8'
    os.environ['LANG'] = 'es_ES.UTF-8'

from pyswip import Prolog
from database_hardware import *

class MotorInferenciaHardware:
    def __init__(self):
        try:
            self.prolog = Prolog()
            
            if not os.path.exists("reglas_hardware.pl"):
                raise FileNotFoundError("No se encuentra reglas_hardware.pl")
            
            self.prolog.consult("reglas_hardware.pl")
            print("Reglas Prolog cargadas correctamente")
            
        except Exception as e:
            print(f"Error inicializando Prolog: {e}")
            raise
        
        self.sesion_actual = None
        self.respuestas_actuales = {}
        
        # DICCIONARIO COMPLETO DE PREGUNTAS
        self.preguntas_display = {
            # ALIMENTACION / POWER
            'enciende': '¿El equipo enciende al presionar el botón de power?',
            'led_power': '¿El LED de alimentación se enciende?',
            'ventiladores': '¿Los ventiladores giran al encender?',
            'pitidos_post': '¿Escucha pitidos al iniciar (POST)?',
            'patron_pitidos': '¿Cuántos pitidos escucha? (1, 2, 3 o más)',
            'olor_quemado': '¿Detecta olor a quemado o componentes recalentados?',
            'chispa_electrica': '¿Ha visto chispas o escuchado zumbidos eléctricos?',
            'reinicios_espontaneos': '¿Se reinicia sin razón aparente?',
            'apagado_subito': '¿Se apaga de golpe sin warning?',
            'voltaje_inestable': '¿Las luces parpadean al encender el equipo?',
            'zumbido_bobinas': '¿Escucha zumbido agudo (coil whine) de la fuente?',
            'olor_ozono': '¿Huele a ozono o electricidad quemada?',
            
            # DISPLAY / PANTALLA
            'pantalla_enciende': '¿La pantalla muestra imagen?',
            'pantalla_azul': '¿Aparece pantalla azul (BSOD)?',
            'codigo_error_bsod': '¿Qué código de error muestra el BSOD?',
            'artefactos_visuales': '¿Ve líneas, pixeles muertos o distorsión en pantalla?',
            'parpadeo_pantalla': '¿La pantalla parpadea o titila?',
            'resolucion_incorrecta': '¿La resolución de pantalla es incorrecta o borrosa?',
            'colores_distorsionados': '¿Los colores se ven raros o invertidos?',
            'pantalla_negra_post': '¿Pantalla negra pero el equipo parece funcionar?',
            'mensaje_no_signal': '¿Monitor muestra mensaje "No Signal"?',
            'artifactos_3d': '¿Ve triángulos o texturas rotas en juegos?',
            'screen_tearing': '¿La imagen se divide horizontalmente al mover?',
            'nieve_estatica': '¿Ve nieve o estática en la pantalla?',
            'color_temperatura_incorrecta': '¿Los blancos se ven amarillos o azulados?',
            
            # ALMACENAMIENTO
            'disco_detectado': '¿El BIOS/UEFI detecta el disco duro?',
            'ruidos_disco': '¿El disco hace ruidos extraños (clicks, chirridos)?',
            'ruido_tipo': '¿Qué tipo de ruido? (click repetitivo, chirrido continuo o golpeteo)',
            'velocidad_lenta': '¿El sistema operativo carga muy lento?',
            'archivos_corruptos': '¿Ha perdido archivos o aparecen corruptos?',
            'errores_lectura': '¿Aparecen errores de lectura/escritura?',
            'disco_desaparece': '¿El disco desaparece y reaparece del sistema?',
            'smart_warnings': '¿Ha visto alertas SMART del disco?',
            'sectores_realocados': '¿CrystalDiskInfo muestra sectores realocados?',
            'temperatura_disco': '¿El disco se siente muy caliente (más de 50°C)?',
            'ssd_ralentizado': '¿El SSD era rápido pero ahora es lento?',
            'ssd_no_reconocido': '¿El SSD no aparece en BIOS?',
            'nvme_throttling': '¿El NVMe reduce velocidad bajo carga?',
            'trim_no_funciona': '¿El comando TRIM no funciona en SSD?',
            
            # MEMORIA RAM
            'ram_detectada': '¿El BIOS detecta toda la RAM instalada?',
            'cantidad_ram_detectada': '¿Cuánta RAM detecta vs instalada?',
            'reinicios_aleatorios': '¿El equipo se reinicia aleatoriamente?',
            'congelamientos': '¿Se congela (freeze) frecuentemente?',
            'aplicaciones_crash': '¿Las aplicaciones se cierran inesperadamente?',
            'memtest_errores': '¿MemTest86 muestra errores?',
            'ubicacion_error_ram': '¿En qué dirección de memoria ocurren errores?',
            'dual_channel_activo': '¿El modo Dual Channel está activo?',
            'xmp_activado': '¿El perfil XMP/DOCP está activado?',
            'ram_a_velocidad_maxima': '¿La RAM corre a su velocidad nominal?',
            'slots_ocupados': '¿Cuántos slots de RAM tiene ocupados?',
            
            # TEMPERATURA
            'sobrecalentamiento': '¿El equipo se siente muy caliente al tacto?',
            'apagado_termico': '¿Se apaga solo después de uso intensivo?',
            'ventilador_ruidoso': '¿Los ventiladores hacen ruido excesivo?',
            'ventilador_detenido': '¿Algún ventilador no gira?',
            'ventilador_vibra': '¿Los ventiladores vibran o hacen ruido metálico?',
            'temp_cpu_idle': '¿Temperatura CPU en reposo más de 50°C?',
            'temp_cpu_carga': '¿Temperatura CPU bajo carga más de 85°C?',
            'temp_gpu_idle': '¿Temperatura GPU en reposo más de 50°C?',
            'temp_gpu_carga': '¿Temperatura GPU bajo carga más de 85°C?',
            'pasta_termica_vieja': '¿La pasta térmica tiene más de 3 años?',
            'polvo_acumulado': '¿Hay acumulación visible de polvo?',
            'flujo_aire_bloqueado': '¿Las rejillas de ventilación están bloqueadas?',
            
            # RED / CONECTIVIDAD
            'red_funciona': '¿La conexión de red funciona correctamente?',
            'wifi_detecta': '¿Detecta redes WiFi disponibles?',
            'ethernet_funciona': '¿El cable Ethernet es reconocido?',
            'velocidad_red_baja': '¿La velocidad de Internet es muy baja?',
            'ping_alto': '¿El ping es muy alto (más de 100ms)?',
            'paquetes_perdidos': '¿Se pierden paquetes (packet loss)?',
            'conexion_intermitente': '¿La conexión se cae frecuentemente?',
            'led_ethernet_parpadea': '¿El LED del puerto Ethernet parpadea?',
            'driver_red_actualizado': '¿El driver de red está actualizado?',
            
            # PUERTOS USB
            'usb_funciona': '¿Los puertos USB reconocen dispositivos?',
            'usb_intermitente': '¿Los USB se desconectan solos?',
            'usb_3_no_funciona': '¿Los puertos USB 3.0 no funcionan?',
            'usb_velocidad_lenta': '¿Los USB transfieren muy lento?',
            'dispositivos_no_reconocidos': '¿Aparece mensaje "dispositivo no reconocido"?',
            'usb_frontal_no_funciona': '¿Los USB frontales no responden?',
            'usb_posterior_funciona': '¿Los USB de la parte trasera funcionan?',
            
            # AUDIO
            'audio_funciona': '¿El audio se escucha correctamente?',
            'crackling_audio': '¿El audio tiene interferencias o chasquidos?',
            'audio_solo_un_lado': '¿Solo se escucha por un audífono o bocina?',
            'audio_distorsionado': '¿El audio suena robótico o distorsionado?',
            'microfono_funciona': '¿El micrófono es detectado?',
            'nivel_audio_bajo': '¿El volumen es muy bajo al máximo?',
            
            # BATERIA LAPTOP
            'bateria_carga': '¿La batería carga correctamente?',
            'duracion_bateria': '¿La batería dura muy poco tiempo?',
            'bateria_hinchada': '¿La batería está hinchada o deformada?',
            'carga_lenta': '¿La batería tarda mucho en cargar?',
            'porcentaje_bateria_salta': '¿El porcentaje de batería salta erráticamente?',
            'laptop_no_enciende_sin_cargador': '¿Solo funciona conectada a corriente?',
            'bateria_ciclos': '¿La batería tiene más de 500 ciclos de carga?',
            
            # TARJETA GRAFICA
            'gpu_detectada': '¿Windows detecta la tarjeta gráfica?',
            'driver_gpu_instalado': '¿Los drivers de GPU están instalados?',
            'artifactos_gpu': '¿Ve cuadros o líneas de colores en pantalla?',
            'pantallazos_negros': '¿La pantalla se pone negra por segundos?',
            'driver_crashed': '¿Mensaje "el driver de video dejó de responder"?',
            'fps_bajos': '¿Los FPS en juegos son muy bajos?',
            'gpu_throttling': '¿La GPU reduce frecuencia bajo carga?',
            'ventiladores_gpu_giran': '¿Los ventiladores de la GPU giran?',
            'coil_whine_gpu': '¿La GPU hace ruido de bobinas agudo?',
            'componente_quemado_visible': '¿Ve componentes visiblemente quemados o marcas en el PCB?',
            'overclock_activo': '¿Tiene overclock activado en la CPU o GPU?',
            'aio_age_years': '¿El sistema de refrigeración líquida (AIO) tiene más de 3 años de uso?',
            'cooler_age_years': '¿El cooler por aire tiene más de 5 años de uso?',
            'gpu_sag_estres_pcb': '¿La GPU está inclinada o presenta sag visible (estrés en el PCB)?',
            'fan_speed_constant': '¿Los ventiladores de la GPU giran siempre a máxima velocidad?',
            
            # MOTHERBOARD
            'puertos_traseros_funcionan': '¿Los puertos I/O traseros funcionan?',
            'slots_pcie_funcionan': '¿Otros slots PCIe funcionan?',
            'sata_ports_funcionan': '¿Los puertos SATA reconocen discos?',
            'm2_slot_funciona': '¿El slot M.2 reconoce SSD?',
            'bios_version_actualizada': '¿La BIOS está actualizada?',
            'fecha_hora_resetea': '¿La fecha y hora se resetean al apagar?',
            'configuracion_bios_se_pierde': '¿La configuración BIOS se pierde?',
            'chipset_caliente': '¿El chipset se siente muy caliente?',
            
            # CPU
            'cpu_reconocido_correctamente': '¿La CPU es reconocida correctamente?',
            'nucleos_detectados': '¿Se detectan todos los núcleos/threads?',
            'frecuencia_cpu_correcta': '¿La CPU alcanza su frecuencia boost?',
            'cpu_throttling': '¿La CPU reduce frecuencia por temperatura?',
            'uso_cpu_100': '¿El uso de CPU está siempre al 100%?',
            'proceso_consume_cpu': '¿Algún proceso específico consume mucha CPU?',
            
            # CASOS ESPECIFICOS
            'recientemente_instalo_hardware': '¿Instaló hardware nuevo recientemente?',
            'recientemente_actualizo_drivers': '¿Actualizó drivers recientemente?',
            'recientemente_actualizo_bios': '¿Actualizó BIOS recientemente?',
            'derramo_liquido': '¿Se derramó líquido en el equipo?',
            'golpe_caida': '¿El equipo sufrió golpe o caída?',
            'tormenta_electrica': '¿Hubo tormenta o corte de luz reciente?',
            'sobretension_electrica': '¿Sospecha sobretensión en la línea eléctrica?'
        }
        
    def reiniciar(self):
        try:
            list(self.prolog.query("retractall(sintoma(_, _))"))
            list(self.prolog.query("retractall(medicion(_, _, _))"))
            self.respuestas_actuales = {}
        except Exception as e:
            print(f"Error en reiniciar: {e}")
    
    def crear_nueva_sesion(self, id_equipo, id_usuario):
        self.sesion_actual = crear_sesion(id_equipo, id_usuario)
        self.reiniciar()
        return self.sesion_actual
    
    def obtener_pregunta(self, clave):
        try:
            return self.preguntas_display.get(clave, f"¿{clave.replace('_', ' ')}?")
        except Exception as e:
            print(f"Error obteniendo pregunta '{clave}': {e}")
            return f"¿{clave}?"
    
    def registrar_sintoma(self, clave, respuesta, categoria='general', severidad=None):
        try:
            clave = str(clave).strip()
            respuesta = str(respuesta).strip().lower()
            
            query = f"assertz(sintoma({clave}, {respuesta}))"
            list(self.prolog.query(query))
            
            self.respuestas_actuales[clave] = respuesta
            
            if self.sesion_actual:
                pregunta_texto = self.obtener_pregunta(clave)
                guardar_sintoma(
                    self.sesion_actual, 
                    categoria, 
                    pregunta_texto,
                    respuesta,
                    severidad
                )
            
        except Exception as e:
            print(f"Error registrando síntoma: {e}")
    
    def registrar_medicion(self, componente, tipo, valor):
        try:
            query = f"assertz(medicion({componente}, {tipo}, {valor}))"
            list(self.prolog.query(query))
        except Exception as e:
            print(f"Error registrando medición: {e}")
    
    def obtener_siguiente_pregunta(self, clave_actual, respuesta):
        try:
            clave_actual = str(clave_actual).strip()
            respuesta = str(respuesta).strip().lower()
            
            query = f"siguiente_pregunta({clave_actual}, {respuesta}, Siguiente)"
            resultado = list(self.prolog.query(query))
            
            if resultado and len(resultado) > 0:
                siguiente = resultado[0].get('Siguiente', None)
                if siguiente:
                    return str(siguiente)
            
            return None
            
        except Exception as e:
            print(f"Error obteniendo siguiente pregunta: {e}")
            return None
    
    def safe_string(self, s):
        if isinstance(s, bytes):
            s = s.decode('utf-8', errors='replace')
        return str(s).encode('ascii', errors='replace').decode('ascii')
    
    def ejecutar_diagnostico(self, max_resultados=10):
        diagnosticos = []
        
        try:
            print(f"\nSíntomas registrados: {len(self.respuestas_actuales)}")
            for clave, valor in self.respuestas_actuales.items():
                print(f"  ✓ {clave} = {valor}")
            
            if not self.respuestas_actuales:
                print("No hay síntomas registrados")
                return []
            
            print("\nConsultando diagnósticos en Prolog...")
            query_resultados = list(self.prolog.query(
                "diagnostico(Diag)", 
                maxresult=max_resultados
            ))
            
            print(f"Diagnósticos encontrados: {len(query_resultados)}")
            
            for resultado in query_resultados:
                diag_nombre = self.safe_string(resultado.get('Diag', ''))
                print(f"\n  *Evaluando: {diag_nombre}")
                
                try:
                    exp_query = list(self.prolog.query(
                        f"explicacion({diag_nombre}, Exp)",
                        maxresult=1
                    ))
                    explicacion = self.safe_string(exp_query[0].get('Exp', 'Sin explicacion')) if exp_query else "Sin explicacion"
                except:
                    explicacion = "Sin explicacion"
                
                try:
                    sol_query = list(self.prolog.query(
                        f"solucion({diag_nombre}, Sol)",
                        maxresult=1
                    ))
                    solucion = self.safe_string(sol_query[0].get('Sol', 'Sin solucion')) if sol_query else "Sin solucion"
                except:
                    solucion = "Sin solucion"
                
                try:
                    comp_query = list(self.prolog.query(
                        f"componente_afectado({diag_nombre}, Comp)",
                        maxresult=1
                    ))
                    componente = self.safe_string(comp_query[0].get('Comp', 'Desconocido')) if comp_query else "Desconocido"
                except:
                    componente = "Desconocido"
                
                diag_nombre_display = self.mejorar_nombre_diagnostico(diag_nombre)
                
                confianza = self.calcular_confianza(diag_nombre)
                
                print(f"    Confianza: {confianza*100:.0f}%")
                
                diagnosticos.append({
                    'nombre': diag_nombre_display,
                    'explicacion': explicacion,
                    'solucion': solucion,
                    'componente': componente,
                    'confianza': confianza
                })
            
            diagnosticos.sort(key=lambda x: x['confianza'], reverse=True)
            
            print(f"\nTotal diagnósticos procesados: {len(diagnosticos)}")
            
            if self.sesion_actual and diagnosticos:
                for diag in diagnosticos:
                    costo = self.extraer_costo(diag['solucion'])
                    tiempo = self.extraer_tiempo(diag['solucion'])
                    prioridad = self.determinar_prioridad(diag['solucion'])
                    
                    guardar_diagnostico(
                        self.sesion_actual,
                        diag['componente'],
                        diag['nombre'],
                        diag['confianza'],
                        diag['explicacion'],
                        diag['solucion'],
                        prioridad,
                        costo,
                        tiempo
                    )
            
            return diagnosticos
            
        except Exception as e:
            print(f"Error ejecutando diagnóstico: {e}")
            import traceback
            traceback.print_exc()
            return []
    
    def mejorar_nombre_diagnostico(self, nombre):
        mejoras = {
            # ===== PSU - 30 DIAGNÓSTICOS =====
            'psu_rail_12v_totalmente_muerto': 'Rail 12V PSU Totalmente Muerto',
            'psu_rail_5v_standby_muerto': 'Rail 5V Standby PSU Muerto',
            'psu_voltaje_inestable_12v': 'Voltaje 12V Inestable en PSU',
            'psu_overcurrent_protection': 'Protección OCP Activada en PSU',
            'psu_power_good_signal_fallo': 'Señal Power Good PSU Fallo',
            'psu_ventilador_bloqueado_polvo': 'Ventilador PSU Bloqueado por Polvo',
            'psu_capacitores_hinchados_visibles': 'Capacitores PSU Hinchados Visibles',
            'psu_ripple_excesivo': 'Ripple Excesivo en PSU',
            'psu_potencia_insuficiente': 'PSU con Potencia Insuficiente',
            'psu_ocp_activado': 'Protección OCP PSU Activada',
            'psu_ovp_activado': 'Protección OVP PSU Activada',
            'psu_modular_conector_flojo': 'Conector Modular PSU Flojo',
            'psu_cable_cpu_danado': 'Cable EPS CPU Dañado',
            'psu_cable_pcie_insuficiente': 'Cables PCIe GPU Insuficientes',
            
            # ===== MOTHERBOARD - 35 DIAGNÓSTICOS =====
            'mobo_muerte_total': 'Motherboard Completamente Muerta',
            'mobo_cortocircuito_standoffs': 'Cortocircuito por Standoffs',
            'mobo_bateria_cmos_muerta': 'Batería CMOS Muerta',
            'mobo_bios_corrupta': 'BIOS Corrupta',
            'mobo_bios_desactualizada_cpu': 'BIOS Desactualizada para CPU',
            'mobo_slot_ram_muerto': 'Slot RAM Muerto',
            'mobo_controlador_ram_danado': 'Controlador RAM Dañado',
            'mobo_slot_pcie_x16_muerto': 'Slot PCIe x16 Muerto',
            'mobo_puertos_sata_muertos': 'Puertos SATA Muertos',
            'mobo_slot_m2_muerto': 'Slot M.2 Muerto',
            'mobo_chipset_sobrecalentado': 'Chipset Sobrecalentado',
            'mobo_vrm_sobrecalentado': 'VRM Sobrecalentado',
            'mobo_capacitores_hinchados': 'Capacitores Motherboard Hinchados',
            'mobo_puertos_usb_quemados': 'Puertos USB Quemados',
            'mobo_controlador_red_muerto': 'Controlador Red Muerto',
            'mobo_audio_codec_muerto': 'Codec Audio Muerto',
            'mobo_socket_cpu_pines_doblados_amd': 'Socket AMD Pines Doblados',
            'mobo_socket_lga_contactos_danados_intel': 'Socket Intel LGA Contactos Dañados',
            'mobo_backplate_io_flojo': 'Backplate I/O Flojo',
            'mobo_traces_quemados': 'Traces PCB Quemados',
            'mobo_post_code_55': 'POST Code 55 - Fallo RAM',
            'mobo_bios_loop_infinito': 'BIOS Loop Infinito',
            'mobo_rgb_fusion_conflicto': 'Software RGB Causa Conflictos',
            'motherboard_bios_corruption': 'BIOS Corrupta',
            'motherboard_cmos_battery_dead': 'Batería CMOS Agotada',
            'motherboard_cpu_compatibility_issue': 'CPU Incompatible con BIOS',
            'motherboard_vrm_overheating': 'VRM Sobrecalentado',
            'motherboard_vrm_capacitor_failure': 'Capacitores VRM Fallidos',
            'motherboard_usb_overcurrent_protection': 'Protección USB Overcurrent',
            'motherboard_audio_codec_failure': 'Codec Audio Fallido',
            'motherboard_network_controller_failure': 'Controlador Red Fallido',
            'motherboard_pcie_slot_wear': 'Slot PCIe Desgastado',
            'motherboard_ram_slot_timing_issues': 'Problemas Timing Slots RAM',
            'motherboard_standoff_short_circuit': 'Cortocircuito por Standoff',
            
            # ===== CPU - 30 DIAGNÓSTICOS =====
            'cpu_muerte_total': 'CPU Completamente Muerto',
            'cpu_no_detectado_socket_sucio': 'CPU No Detectado - Socket Sucio',
            'cpu_pines_doblados_amd': 'CPU AMD Pines Doblados',
            'cpu_sobrecalentamiento_pasta_secada': 'CPU Sobrecalentado - Pasta Seca',
            'cpu_cooler_montaje_incorrecto': 'Cooler CPU Mal Montado',
            'cpu_voltage_regulation_module_fallo': 'VRM CPU Fallido',
            'cpu_degradacion_silicio': 'CPU Degradado - Silicio Dañado',
            'cpu_sobrecalentamiento_critico': 'CPU Sobrecalentamiento Crítico',
            'cpu_cooler_mal_montado': 'Cooler Mal Montado',
            'cpu_ihs_delaminado': 'IHS CPU Delaminado',
            'cpu_throttling_termico': 'CPU Throttling Térmico',
            'cpu_throttling_vrm': 'CPU Throttling por VRM',
            'cpu_nucleos_muertos': 'CPU Núcleos Muertos',
            'cpu_cache_corrupta': 'Cache CPU Corrupta',
            'cpu_degradacion_electromigracion': 'CPU Degradación por Electromigración',
            'cpu_pads_danados_intel': 'CPU Intel Pads Dañados',
            'cpu_imc_degradado': 'IMC CPU Degradado',
            'cpu_avx_offset_insuficiente': 'AVX Offset Insuficiente',
            'cpu_hyperthreading_inestable': 'Hyperthreading Inestable',
            'cpu_voltaje_vdroop_excesivo': 'Vdroop CPU Excesivo',
            'cpu_tjmax_alcanzado': 'CPU Alcanzó Tjmax',
            'cpu_boost_no_funciona': 'Turbo Boost No Funciona',
            'cpu_c_states_causan_crash': 'C-States Causan Crash',
            'cpu_ring_ratio_desbalanceado': 'Ring Ratio Desbalanceado',
            
            # ===== RAM - 30 DIAGNÓSTICOS =====
            'ram_modulo_completamente_muerto': 'Módulo RAM Completamente Muerto',
            'ram_slot_motherboard_danado': 'Slot RAM Motherboard Dañado',
            'ram_incompatible_jedec_profile': 'RAM Perfil JEDEC Incompatible',
            'ram_xmp_inestable_imc_debil': 'XMP Inestable - IMC Débil',
            'ram_timings_muy_apretados': 'Timings RAM Muy Apretados',
            'ram_temperature_related_errors': 'Errores RAM por Temperatura',
            'ram_rank_interleave_problema': 'Problema Rank Interleave RAM',
            'ram_power_delivery_insuficiente': 'Voltaje RAM Insuficiente',
            'ram_refresh_rate_problema': 'Problema Refresh Rate RAM',
            'ram_contactos_sucios': 'Contactos RAM Sucios',
            'ram_errores_ecc': 'RAM Errores ECC',
            'ram_xmp_inestable': 'Perfil XMP Inestable',
            'ram_dual_channel_roto': 'Dual Channel No Funciona',
            'ram_densidad_incompatible': 'Densidad RAM Incompatible',
            'ram_voltaje_insuficiente': 'Voltaje RAM Insuficiente',
            'ram_rank_mismatch': 'RAM Rank Mismatch',
            'ram_timings_muy_apretados': 'Timings Muy Apretados',
            'ram_subtimings_mal_configurados': 'Subtimings Mal Configurados',
            'ram_procodt_incorrecto': 'ProcODT Incorrecto',
            'ram_gear_mode_incorrecto': 'Gear Mode Incorrecto',
            'ram_command_rate_incorrecto': 'Command Rate Incorrecto',
            'ram_rowhammer_bit_flips': 'Rowhammer Bit Flips',
            'ram_slot_retencion_rota': 'Retención Slot RAM Rota',
            'ram_chips_ic_diferentes': 'Chips IC RAM Diferentes',
            'ram_revision_diferente': 'Revisión RAM Diferente',
            'ram_b_die_degradado': 'Samsung B-Die Degradado',
            'ram_daisy_chain_topology': 'Topología Daisy Chain Problemática',
            
            # ===== STORAGE HDD/SSD - 35 DIAGNÓSTICOS =====
            'hdd_click_of_death': 'HDD Click of Death',
            'hdd_motor_spindle_muerto': 'Motor Spindle HDD Muerto',
            'hdd_motor_spindle_fallo': 'Motor Spindle HDD Fallido',
            'hdd_cabezales_crashed': 'Head Crash HDD',
            'hdd_head_crash': 'Cabezales HDD Estrellados',
            'hdd_sectores_bad_growth': 'Sectores Defectuosos Creciendo',
            'hdd_smart_critical_parameters': 'Parámetros SMART Críticos',
            'hdd_firmware_corrupto': 'Firmware HDD Corrupto',
            'hdd_pcb_quemado': 'PCB HDD Quemado',
            'hdd_cache_ram_muerta': 'Cache DRAM HDD Muerta',
            'hdd_temperatura_excesiva': 'Temperatura HDD Excesiva',
            'hdd_power_on_hours_critico': 'HDD Horas de Uso Críticas',
            'ssd_controller_muerto': 'Controlador SSD Muerto',
            'ssd_nand_wear_out': 'Celdas NAND SSD Agotadas',
            'ssd_dram_cache_corrupto': 'Cache DRAM SSD Corrupto',
            'ssd_firmware_bug': 'Bug Firmware SSD',
            'ssd_trim_no_funcional': 'TRIM SSD No Funcional',
            'ssd_over_provisioning_insuficiente': 'Over-Provisioning SSD Insuficiente',
            'ssd_dram_cache_ausente': 'SSD Sin Cache DRAM',
            'nvme_thermal_throttling': 'NVMe Throttling Térmico',
            'nvme_thermal_throttling_severo': 'NVMe Throttling Severo',
            'nvme_pcie_lanes_insuficientes': 'NVMe Lanes PCIe Insuficientes',
            'nvme_pcie_gen_incorrecto': 'NVMe PCIe Gen Incorrecto',
            'ssd_write_amplification_alta': 'Write Amplification Alta SSD',
            'ssd_garbage_collection_lento': 'Garbage Collection Lento',
            'cable_sata_defectuoso': 'Cable SATA Defectuoso',
            'puerto_sata_sucio': 'Puerto SATA Sucio',
            'ssd_secure_erase_necesario': 'SSD Necesita Secure Erase',
            'sata_cable_defectuoso': 'Cable SATA Defectuoso',
            'm2_slot_pcie_lanes_conflicto': 'Conflicto Lanes M.2',
            'usb_external_disk_power_insufficient': 'Disco USB Potencia Insuficiente',
            'ssd_ralentizado': 'SSD Ralentizado',
            'ssd_no_reconocido': 'SSD No Reconocido',
            
            # ===== GPU - 30 DIAGNÓSTICOS =====
            'gpu_muerte_total': 'GPU Completamente Muerta',
            'gpu_no_detectada_power_insuficiente': 'GPU No Detectada - Power Insuficiente',
            'gpu_pcie_slot_compatibility_issue': 'GPU Incompatibilidad Slot PCIe',
            'gpu_vram_muerta': 'VRAM GPU Muerta',
            'gpu_vram_failure_specific_chip': 'Chip VRAM GPU Específico Fallido',
            'gpu_die_sobrecalentado': 'Die GPU Sobrecalentado',
            'gpu_thermal_paste_dried_out': 'Pasta Térmica GPU Seca',
            'gpu_vrm_overheating': 'VRM GPU Sobrecalentado',
            'gpu_fan_bearing_failure': 'Rodamientos Fan GPU Fallidos',
            'gpu_ventiladores_muertos': 'Ventiladores GPU Muertos',
            'gpu_power_limit_activado': 'Power Limit GPU Activado',
            'gpu_vbios_corrupto': 'VBIOS GPU Corrupto',
            'gpu_artifacts_memory_oc': 'Artefactos por Memory OC',
            'gpu_core_degradado': 'Core GPU Degradado',
            'gpu_core_degradation_from_mining': 'GPU Degradada por Mining',
            'gpu_driver_conflict_cleanup_needed': 'Conflicto Drivers GPU',
            'gpu_power_limit_throttling': 'GPU Power Limit Throttling',
            'gpu_pcie_bus_contention': 'Contención Bus PCIe GPU',
            'gpu_pcie_riser_defectuoso': 'Riser PCIe GPU Defectuoso',
            'gpu_sag_estres_pcb': 'GPU Sag - Estrés PCB',
            
            # ===== REFRIGERACIÓN - 25 DIAGNÓSTICOS =====
            'aio_pump_failure': 'Bomba AIO Fallida',
            'aio_fluid_evaporation': 'Líquido AIO Evaporado',
            'custom_loop_air_bubble': 'Burbuja Aire Custom Loop',
            'radiator_fins_clogged_dust': 'Aletas Radiador Obstruidas',
            'tower_cooler_mounting_pressure_issue': 'Presión Montaje Cooler Incorrecta',
            'heatpipe_phase_change_failure': 'Heatpipes Fallidos',
            'case_airflow_negative_pressure': 'Presión Negativa Case',
            'pwm_fan_controller_failure': 'Controlador PWM Fans Fallido',
            
            # ===== CASOS ESPECIALES - 25 DIAGNÓSTICOS =====
            'liquid_spill_immediate_damage': 'Daño Inmediato por Líquido',
            'liquid_spill_corrosion_long_term': 'Corrosión Largo Plazo por Líquido',
            'physical_impact_bga_failure': 'Fallo BGA por Impacto',
            'pcb_flex_cracked_traces': 'Traces PCB Rotos por Flexión',
            'power_surge_multiple_failures': 'Fallos Múltiples por Sobretensión',
            
            # ===== DIAGNÓSTICOS CRUZADOS - 20 REGLAS =====
            'imc_motherboard_ram_incompatibility': 'Incompatibilidad IMC-Mobo-RAM',
            'vrm_insufficient_for_cpu_boost': 'VRM Insuficiente para Boost CPU',
            'psu_ripple_affecting_stability': 'Ripple PSU Afecta Estabilidad',
            'transient_response_psu_issue': 'Respuesta Transiente PSU Pobre',
            'ground_loop_audio_network_issues': 'Ground Loops Causan Problemas',
            'thermal_runaway_scenario': 'Escenario Thermal Runaway',
            'compatibility_chain_reaction': 'Reacción en Cadena Incompatibilidad',
            
            # ===== DIAGNÓSTICOS GENERALES =====
            'no_faults_detected': 'Sistema Funcionando Correctamente',
            'insufficient_symptoms': 'Síntomas Insuficientes para Diagnóstico',
            'problema_general_hardware': 'Problema General de Hardware',
            'diagnostico_incompleto': 'Diagnóstico Incompleto'
        }
        
        if nombre in mejoras:
            return mejoras[nombre]
        
        return nombre.replace('_', ' ').title()
    
    def calcular_confianza(self, diagnostico_nombre):
        sintomas_totales = len(self.respuestas_actuales)
        
        if sintomas_totales == 0:
            return 0.5
        
        if sintomas_totales >= 15:
            return 0.95
        elif sintomas_totales >= 10:
            return 0.85
        elif sintomas_totales >= 5:
            return 0.70
        else:
            return 0.55
    
    def extraer_costo(self, texto_solucion):
        import re
        match = re.search(r'\$(\d+)-(\d+)', texto_solucion)
        if match:
            return (int(match.group(1)) + int(match.group(2))) / 2
        return None
    
    def extraer_tiempo(self, texto_solucion):
        import re
        
        match = re.search(r'Tiempo\s+(\d+-?\d*h?)', texto_solucion, re.IGNORECASE)
        if match:
            return match.group(1).strip()
        
        match = re.search(r'(\d+-\d+)\s*(horas?|minutos?|min)', texto_solucion, re.IGNORECASE)
        if match:
            return f"{match.group(1)} {match.group(2)}"
        
        return None
    
    def determinar_prioridad(self, texto_solucion):
        texto_lower = texto_solucion.lower()
        
        if any(keyword in texto_lower for keyword in [
            'critico', 'urgencia maxima', 'urgente', 'inmediatamente'
        ]):
            return 'critica'
        
        elif any(keyword in texto_lower for keyword in [
            'urgencia alta', 'importante', 'pronto', 'backup urgente'
        ]):
            return 'alta'
        
        elif any(keyword in texto_lower for keyword in [
            'moderado', 'recomendado', 'conveniente'
        ]):
            return 'media'
        
        else:
            return 'baja'
    
    def evaluar_componentes(self, componentes_lista):
        evaluaciones = []
        
        for comp in componentes_lista:
            estado = 'ok'
            salud = 100
            
            comp_lower = comp.lower()
            
            if comp_lower == 'cpu':
                if self.respuestas_actuales.get('temp_cpu_carga') == 'si':
                    estado = 'critical'
                    salud = 30
                elif self.respuestas_actuales.get('temp_cpu_idle') == 'si':
                    estado = 'warning'
                    salud = 60
                elif self.respuestas_actuales.get('cpu_throttling') == 'si':
                    estado = 'warning'
                    salud = 50
            
            elif comp_lower == 'ram':
                if self.respuestas_actuales.get('ram_detectada') == 'no':
                    estado = 'failed'
                    salud = 0
                elif self.respuestas_actuales.get('memtest_errores') == 'si':
                    estado = 'critical'
                    salud = 20
                elif self.respuestas_actuales.get('aplicaciones_crash') == 'si':
                    estado = 'warning'
                    salud = 50
            
            elif comp_lower in ['psu', 'fuente de poder', 'fuente']:
                if self.respuestas_actuales.get('enciende') == 'no':
                    estado = 'critical'
                    salud = 10
                elif self.respuestas_actuales.get('olor_quemado') == 'si':
                    estado = 'critical'
                    salud = 5
                elif self.respuestas_actuales.get('reinicios_espontaneos') == 'si':
                    estado = 'warning'
                    salud = 40
            
            elif comp_lower in ['hdd', 'disco duro', 'disco']:
                if self.respuestas_actuales.get('ruidos_disco') == 'si':
                    estado = 'critical'
                    salud = 20
                elif self.respuestas_actuales.get('sectores_realocados') == 'si':
                    estado = 'critical'
                    salud = 30
                elif self.respuestas_actuales.get('velocidad_lenta') == 'si':
                    estado = 'warning'
                    salud = 60
            
            elif comp_lower in ['ssd', 'nvme']:
                if self.respuestas_actuales.get('ssd_no_reconocido') == 'si':
                    estado = 'failed'
                    salud = 0
                elif self.respuestas_actuales.get('ssd_ralentizado') == 'si':
                    estado = 'warning'
                    salud = 50
                elif self.respuestas_actuales.get('smart_warnings') == 'si':
                    estado = 'warning'
                    salud = 40
            
            elif comp_lower in ['gpu', 'tarjeta grafica', 'tarjeta gráfica']:
                if self.respuestas_actuales.get('gpu_detectada') == 'no':
                    estado = 'failed'
                    salud = 0
                elif self.respuestas_actuales.get('artifactos_gpu') == 'si':
                    estado = 'critical'
                    salud = 25
                elif self.respuestas_actuales.get('temp_gpu_carga') == 'si':
                    estado = 'warning'
                    salud = 50
            
            elif comp_lower in ['motherboard', 'placa madre', 'mobo']:
                if self.respuestas_actuales.get('pitidos_post') == 'si':
                    estado = 'warning'
                    salud = 60
                elif self.respuestas_actuales.get('fecha_hora_resetea') == 'si':
                    estado = 'warning'
                    salud = 70
                elif self.respuestas_actuales.get('chipset_caliente') == 'si':
                    estado = 'warning'
                    salud = 55
            
            if self.sesion_actual:
                guardar_evaluacion_componente(
                    self.sesion_actual,
                    comp,
                    estado,
                    salud
                )
            
            evaluaciones.append({
                'componente': comp,
                'estado': estado,
                'salud': salud
            })
        
        return evaluaciones
    
    def finalizar_sesion(self):
        if self.sesion_actual:
            finalizar_sesion(self.sesion_actual)
            self.sesion_actual = None
    
    def obtener_estadisticas_sesion(self):
        if not self.sesion_actual:
            return None
        
        return {
            'sintomas_evaluados': len(self.respuestas_actuales),
            'respuestas_positivas': sum(1 for v in self.respuestas_actuales.values() if v == 'si'),
            'respuestas_negativas': sum(1 for v in self.respuestas_actuales.values() if v == 'no'),
            'sesion_id': self.sesion_actual
        }
    
    def obtener_arbol_decision(self):
        arbol = []
        try:
            resultados = list(self.prolog.query("siguiente_pregunta(Actual, Resp, Sig)"))
            for r in resultados:
                arbol.append({
                    'pregunta_actual': str(r.get('Actual', '')),
                    'respuesta': str(r.get('Resp', '')),
                    'siguiente': str(r.get('Sig', ''))
                })
        except Exception as e:
            print(f"Error obteniendo árbol: {e}")
        return arbol
    
    def validar_respuesta(self, clave, respuesta):
        respuesta = str(respuesta).lower().strip()
        
        preguntas_numericas = ['patron_pitidos', 'slots_ocupados']
        
        preguntas_texto = [
            'codigo_error_bsod', 'ruido_tipo', 'cantidad_ram_detectada',
            'ubicacion_error_ram', 'proceso_consume_cpu'
        ]
        
        if clave in preguntas_numericas:
            if respuesta == '_' or respuesta.isdigit():
                return True
            return False
        
        elif clave in preguntas_texto:
            return True
        
        else:
            return respuesta in ['si', 'no']
    
    def obtener_preguntas_criticas(self):
        return [
            'enciende',
            'led_power',
            'ventiladores',
            'pantalla_enciende',
            'olor_quemado',
            'chispa_electrica',
            'pitidos_post'
        ]
    
    def obtener_sintomas_actuales(self):
        return dict(self.respuestas_actuales)
    
    def importar_sintomas(self, sintomas_dict):
        for clave, valor in sintomas_dict.items():
            self.registrar_sintoma(clave, valor)
    
    def generar_reporte_diagnostico(self, diagnosticos):
        if not diagnosticos:
            return "No se encontraron diagnósticos específicos."
        
        reporte = []
        reporte.append("=" * 80)
        reporte.append("REPORTE DE DIAGNÓSTICO DE HARDWARE")
        reporte.append("=" * 80)
        reporte.append("")
        
        for i, diag in enumerate(diagnosticos, 1):
            reporte.append(f"{i}. {diag['nombre']}")
            reporte.append(f"   Componente: {diag['componente']}")
            reporte.append(f"   Confianza: {diag['confianza']*100:.1f}%")
            reporte.append(f"   Explicación: {diag['explicacion']}")
            reporte.append(f"   Solución: {diag['solucion']}")
            reporte.append("")
        
        reporte.append("=" * 80)
        return "\n".join(reporte)
    
    def obtener_diagnosticos_por_componente(self, componente):
        todos = self.ejecutar_diagnostico(max_resultados=50)
        return [d for d in todos if d['componente'].lower() == componente.lower()]
    
    def calcular_costo_total_reparacion(self, diagnosticos):
        costo_total = 0
        costos_encontrados = []
        
        for diag in diagnosticos:
            costo = self.extraer_costo(diag['solucion'])
            if costo:
                costo_total += costo
                costos_encontrados.append({
                    'diagnostico': diag['nombre'],
                    'costo': costo
                })
        
        return {
            'total': costo_total,
            'desglose': costos_encontrados,
            'promedio': costo_total / len(costos_encontrados) if costos_encontrados else 0
        }

    def obtener_primera_pregunta(self):
        try:
            return 'enciende'
        except Exception as e:
            print(f"Error obteniendo primera pregunta: {e}")
            return 'enciende'


    def validar_tipo_pregunta(self, clave):
        preguntas_texto_libre = [
            'patron_pitidos', 'ruido_tipo', 'codigo_error_bsod',
            'cantidad_ram_detectada', 'slots_ocupados', 'ubicacion_error_ram',
            'proceso_consume_cpu'
        ]
        
        return 'texto' if clave in preguntas_texto_libre else 'binaria'

    def obtener_opciones_pregunta(self, clave):
        opciones = {
            'patron_pitidos': ['1', '2', '3', 'mas'],
            'ruido_tipo': ['click_repetitivo', 'chirrido_continuo', 'golpeteo'],
            'cantidad_ram_detectada': ['parcial', 'incorrecta', '0GB', '50%']
        }
        
        return opciones.get(clave, [])

    def validar_camino_completo(self, clave_inicio):
        visitados = set()
        actual = clave_inicio
        
        while actual and actual not in visitados:
            visitados.add(actual)
            
            siguiente = self.obtener_siguiente_pregunta(actual, 'si')
            
            if not siguiente or siguiente == 'ejecutar_diagnostico':
                return True 
            
            actual = siguiente
        
        return False  

# FUNCIONES DE UTILIDAD PARA USO EXTERNO

def crear_motor():
    return MotorInferenciaHardware()

def diagnostico_rapido(sintomas_dict):
    motor = MotorInferenciaHardware()
    motor.importar_sintomas(sintomas_dict)
    return motor.ejecutar_diagnostico()


if __name__ == "__main__":
    print("Iniciando Motor de Inferencia de Hardware...")
    
    try:
        motor = MotorInferenciaHardware()
        print("✓ Motor inicializado correctamente")
        print(f"✓ {len(motor.preguntas_display)} preguntas cargadas")
        
        # Ejemplo de diagnóstico
        print("\n--- EJEMPLO DE DIAGNÓSTICO ---")
        
        # Simular síntomas de PSU muerta
        sintomas_test = {
            'enciende': 'no',
            'led_power': 'no',
            'ventiladores': 'no',
            'olor_quemado': 'no'
        }
        
        print("\nSíntomas de prueba:")
        for k, v in sintomas_test.items():
            print(f"  - {motor.obtener_pregunta(k)}: {v}")
            motor.registrar_sintoma(k, v)
        
        print("\nEjecutando diagnóstico...")
        diagnosticos = motor.ejecutar_diagnostico()
        
        if diagnosticos:
            print(f"\n✓ Se encontraron {len(diagnosticos)} diagnósticos posibles:\n")
            for i, diag in enumerate(diagnosticos, 1):
                print(f"{i}. {diag['nombre']} ({diag['confianza']*100:.0f}% confianza)")
                print(f"   Componente: {diag['componente']}")
                print(f"   {diag['explicacion'][:100]}...")
                print()
        else:
            print("✗ No se encontraron diagnósticos")
        
    except Exception as e:
        print(f"✗ Error: {e}")
        import traceback
        traceback.print_exc()