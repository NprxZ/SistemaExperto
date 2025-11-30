:- dynamic(sintoma/2).
:- dynamic(medicion/3).
:- discontiguous diagnostico/1.
:- discontiguous explicacion/2.
:- discontiguous solucion/2.
:- discontiguous componente_afectado/2.
:- discontiguous siguiente_pregunta/3.


% ========================================
% PREGUNTAS PARA EL SISTEMA EXPERTO
% ========================================

% --- ALIMENTACION / POWER ---
pregunta(enciende, 'El equipo enciende al presionar el boton de power').
pregunta(led_power, 'El LED de alimentacion se enciende').
pregunta(ventiladores, 'Los ventiladores giran al encender').
pregunta(pitidos_post, 'Escucha pitidos al iniciar POST').
pregunta(patron_pitidos, 'Cuantos pitidos escucha 1, 2, 3 o mas').
pregunta(olor_quemado, 'Detecta olor a quemado o componentes recalentados').
pregunta(chispa_electrica, 'Ha visto chispas o escuchado zumbidos electricos').
pregunta(reinicios_espontaneos, 'Se reinicia sin razon aparente').
pregunta(apagado_subito, 'Se apaga de golpe sin warning').
pregunta(voltaje_inestable, 'Las luces parpadean al encender el equipo').
pregunta(zumbido_bobinas, 'Escucha zumbido agudo coil whine de la fuente').
pregunta(olor_ozono, 'Huele a ozono o electricidad quemada').

% --- DISPLAY / PANTALLA ---
pregunta(pantalla_enciende, 'La pantalla muestra imagen').
pregunta(pantalla_azul, 'Aparece pantalla azul BSOD').
pregunta(codigo_error_bsod, 'Que codigo de error muestra el BSOD').
pregunta(artefactos_visuales, 'Ve lineas pixeles muertos o distorsion en pantalla').
pregunta(parpadeo_pantalla, 'La pantalla parpadea o titila').
pregunta(resolucion_incorrecta, 'La resolucion de pantalla es incorrecta o borrosa').
pregunta(colores_distorsionados, 'Los colores se ven raros o invertidos').
pregunta(pantalla_negra_post, 'Pantalla negra pero el equipo parece funcionar').
pregunta(mensaje_no_signal, 'Monitor muestra mensaje No Signal').
pregunta(artifactos_3d, 'Ve triangulos o texturas rotas en juegos').
pregunta(screen_tearing, 'La imagen se divide horizontalmente al mover').
pregunta(nieve_estatica, 'Ve nieve o estatica en la pantalla').
pregunta(color_temperatura_incorrecta, 'Los blancos se ven amarillos o azulados').

% --- ALMACENAMIENTO ---
pregunta(disco_detectado, 'El BIOS UEFI detecta el disco duro').
pregunta(ruidos_disco, 'El disco hace ruidos extranos clicks chirridos').
pregunta(ruido_tipo, 'Que tipo de ruido click repetitivo, chirrido continuo o golpeteo').
pregunta(velocidad_lenta, 'El sistema operativo carga muy lento').
pregunta(archivos_corruptos, 'Ha perdido archivos o aparecen corruptos').
pregunta(errores_lectura, 'Aparecen errores de lectura escritura').
pregunta(disco_desaparece, 'El disco desaparece y reaparece del sistema').
pregunta(smart_warnings, 'Ha visto alertas SMART del disco').
pregunta(sectores_realocados, 'CrystalDiskInfo muestra sectores realocados').
pregunta(temperatura_disco, 'El disco se siente muy caliente mas de 50C').
pregunta(ssd_ralentizado, 'El SSD era rapido pero ahora es lento').
pregunta(ssd_no_reconocido, 'El SSD no aparece en BIOS').
pregunta(nvme_throttling, 'El NVMe reduce velocidad bajo carga').
pregunta(trim_no_funciona, 'El comando TRIM no funciona en SSD').

% --- MEMORIA RAM ---
pregunta(ram_detectada, 'El BIOS detecta toda la RAM instalada').
pregunta(cantidad_ram_detectada, 'Cuanta RAM detecta vs instalada').
pregunta(reinicios_aleatorios, 'El equipo se reinicia aleatoriamente').
pregunta(congelamientos, 'Se congela freeze frecuentemente').
pregunta(aplicaciones_crash, 'Las aplicaciones se cierran inesperadamente').
pregunta(memtest_errores, 'MemTest86 muestra errores').
pregunta(ubicacion_error_ram, 'En que direccion de memoria ocurren errores').
pregunta(dual_channel_activo, 'El modo Dual Channel esta activo').
pregunta(xmp_activado, 'El perfil XMP DOCP esta activado').
pregunta(ram_a_velocidad_maxima, 'La RAM corre a su velocidad nominal').
pregunta(slots_ocupados, 'Cuantos slots de RAM tiene ocupados').

% --- TEMPERATURA ---
pregunta(sobrecalentamiento, 'El equipo se siente muy caliente al tacto').
pregunta(apagado_termico, 'Se apaga solo despues de uso intensivo').
pregunta(ventilador_ruidoso, 'Los ventiladores hacen ruido excesivo').
pregunta(ventilador_detenido, 'Algun ventilador no gira').
pregunta(ventilador_vibra, 'Los ventiladores vibran o hacen ruido metalico').
pregunta(temp_cpu_idle, 'Temperatura CPU en reposo mas de 50C').
pregunta(temp_cpu_carga, 'Temperatura CPU bajo carga mas de 85C').
pregunta(temp_gpu_idle, 'Temperatura GPU en reposo mas de 50C').
pregunta(temp_gpu_carga, 'Temperatura GPU bajo carga mas de 85C').
pregunta(pasta_termica_vieja, 'La pasta termica tiene mas de 3 anos').
pregunta(polvo_acumulado, 'Hay acumulacion visible de polvo').
pregunta(flujo_aire_bloqueado, 'Las rejillas de ventilacion estan bloqueadas').

% --- RED / CONECTIVIDAD ---
pregunta(red_funciona, 'La conexion de red funciona correctamente').
pregunta(wifi_detecta, 'Detecta redes WiFi disponibles').
pregunta(ethernet_funciona, 'El cable Ethernet es reconocido').
pregunta(velocidad_red_baja, 'La velocidad de Internet es muy baja').
pregunta(ping_alto, 'El ping es muy alto mas de 100ms').
pregunta(paquetes_perdidos, 'Se pierden paquetes packet loss').
pregunta(conexion_intermitente, 'La conexion se cae frecuentemente').
pregunta(led_ethernet_parpadea, 'El LED del puerto Ethernet parpadea').
pregunta(driver_red_actualizado, 'El driver de red esta actualizado').

% --- PUERTOS USB ---
pregunta(usb_funciona, 'Los puertos USB reconocen dispositivos').
pregunta(usb_intermitente, 'Los USB se desconectan solos').
pregunta(usb_3_no_funciona, 'Los puertos USB 3.0 no funcionan').
pregunta(usb_velocidad_lenta, 'Los USB transfieren muy lento').
pregunta(dispositivos_no_reconocidos, 'Aparece mensaje dispositivo no reconocido').
pregunta(usb_frontal_no_funciona, 'Los USB frontales no responden').
pregunta(usb_posterior_funciona, 'Los USB de la parte trasera funcionan').

% --- AUDIO ---
pregunta(audio_funciona, 'El audio se escucha correctamente').
pregunta(crackling_audio, 'El audio tiene interferencias o chasquidos').
pregunta(audio_solo_un_lado, 'Solo se escucha por un audifonos o bocina').
pregunta(audio_distorsionado, 'El audio suena robotico o distorsionado').
pregunta(microfono_funciona, 'El microfono es detectado').
pregunta(nivel_audio_bajo, 'El volumen es muy bajo al maximo').

% --- BATERIA LAPTOP ---
pregunta(bateria_carga, 'La bateria carga correctamente').
pregunta(duracion_bateria, 'La bateria dura muy poco tiempo').
pregunta(bateria_hinchada, 'La bateria esta hinchada o deformada').
pregunta(carga_lenta, 'La bateria tarda mucho en cargar').
pregunta(porcentaje_bateria_salta, 'El porcentaje de bateria salta erraticamente').
pregunta(laptop_no_enciende_sin_cargador, 'Solo funciona conectada a corriente').
pregunta(bateria_ciclos, 'La bateria tiene mas de 500 ciclos de carga').

% --- TARJETA GRAFICA ---
pregunta(gpu_detectada, 'Windows detecta la tarjeta grafica').
pregunta(driver_gpu_instalado, 'Los drivers de GPU estan instalados').
pregunta(artifactos_gpu, 'Ve cuadros o lineas de colores en pantalla').
pregunta(pantallazos_negros, 'La pantalla se pone negra por segundos').
pregunta(driver_crashed, 'Mensaje el driver de video dejo de responder').
pregunta(fps_bajos, 'Los FPS en juegos son muy bajos').
pregunta(gpu_throttling, 'La GPU reduce frecuencia bajo carga').
pregunta(ventiladores_gpu_giran, 'Los ventiladores de la GPU giran').
pregunta(coil_whine_gpu, 'La GPU hace ruido de bobinas agudo').
pregunta(componente_quemado_visible, 'Ve componentes visiblemente quemados o marcas en PCB').
pregunta(overclock_activo, 'Tiene overclock activado en CPU o GPU').
pregunta(aio_age_years, 'El AIO tiene mas de 3 anos de uso').
pregunta(cooler_age_years, 'El cooler tiene mas de 5 anos').
pregunta(gpu_sag_estres_pcb, 'La GPU esta inclinada o con sag visible').
pregunta(fan_speed_constant, 'Los ventiladores giran siempre a maxima velocidad').

% --- MOTHERBOARD ---
pregunta(puertos_traseros_funcionan, 'Los puertos I O traseros funcionan').
pregunta(slots_pcie_funcionan, 'Otros slots PCIe funcionan').
pregunta(sata_ports_funcionan, 'Los puertos SATA reconocen discos').
pregunta(m2_slot_funciona, 'El slot M.2 reconoce SSD').
pregunta(bios_version_actualizada, 'La BIOS esta actualizada').
pregunta(fecha_hora_resetea, 'La fecha y hora se resetean al apagar').
pregunta(configuracion_bios_se_pierde, 'La configuracion BIOS se pierde').
pregunta(chipset_caliente, 'El chipset se siente muy caliente').

% --- CPU ---
pregunta(cpu_reconocido_correctamente, 'La CPU es reconocida correctamente').
pregunta(nucleos_detectados, 'Se detectan todos los nucleos threads').
pregunta(frecuencia_cpu_correcta, 'La CPU alcanza su frecuencia boost').
pregunta(cpu_throttling, 'La CPU reduce frecuencia por temperatura').
pregunta(uso_cpu_100, 'El uso de CPU esta siempre al 100').
pregunta(proceso_consume_cpu, 'Algun proceso especifico consume mucha CPU').

% --- CASOS ESPECIFICOS ---
pregunta(recientemente_instalo_hardware, 'Instalo hardware nuevo recientemente').
pregunta(recientemente_actualizo_drivers, 'Actualizo drivers recientemente').
pregunta(recientemente_actualizo_bios, 'Actualizo BIOS recientemente').
pregunta(derramo_liquido, 'Se derramo liquido en el equipo').
pregunta(golpe_caida, 'El equipo sufrio golpe o caida').
pregunta(tormenta_electrica, 'Hubo tormenta o corte de luz reciente').
pregunta(sobretension_electrica, 'Sospecha sobretension en la linea electrica').


% ========================================
% ÁRBOL DE DECISIÓN OPTIMIZADO Y COMPLETO
% Sin ramas rotas - Flujo garantizado
% ========================================

% ============================================================
% PUNTO DE ENTRADA PRINCIPAL - SIEMPRE COMIENZA AQUÍ
% ============================================================
siguiente_pregunta(inicio, _, enciende).

% ============================================================
% RAMA 1: EQUIPO NO ENCIENDE (CRÍTICO)
% ============================================================
siguiente_pregunta(enciende, no, led_power).
siguiente_pregunta(led_power, no, olor_quemado).
siguiente_pregunta(led_power, si, ventiladores).

% Sub-rama: Olor a quemado detectado
siguiente_pregunta(olor_quemado, si, chispa_electrica).
siguiente_pregunta(olor_quemado, no, voltaje_inestable).

siguiente_pregunta(chispa_electrica, si, componente_quemado_visible).
siguiente_pregunta(chispa_electrica, no, tormenta_electrica).

siguiente_pregunta(componente_quemado_visible, si, ejecutar_diagnostico).
siguiente_pregunta(componente_quemado_visible, no, tormenta_electrica).

% Sub-rama: Problemas eléctricos
siguiente_pregunta(voltaje_inestable, si, sobretension_electrica).
siguiente_pregunta(voltaje_inestable, no, tormenta_electrica).

siguiente_pregunta(sobretension_electrica, si, ejecutar_diagnostico).
siguiente_pregunta(sobretension_electrica, no, tormenta_electrica).

siguiente_pregunta(tormenta_electrica, si, ejecutar_diagnostico).
siguiente_pregunta(tormenta_electrica, no, ejecutar_diagnostico).

% Sub-rama: Ventiladores
siguiente_pregunta(ventiladores, no, ejecutar_diagnostico).
siguiente_pregunta(ventiladores, si, pitidos_post).

% ============================================================
% RAMA 2: EQUIPO ENCIENDE - EXPLORACIÓN COMPLETA
% ============================================================
siguiente_pregunta(enciende, si, pantalla_enciende).

% ------------------------------------------------------------
% RAMA 2A: PANTALLA NO ENCIENDE
% ------------------------------------------------------------
siguiente_pregunta(pantalla_enciende, no, pitidos_post).

siguiente_pregunta(pitidos_post, si, patron_pitidos).
siguiente_pregunta(pitidos_post, no, mensaje_no_signal).

% Patrones de pitidos
siguiente_pregunta(patron_pitidos, 1, ram_detectada).
siguiente_pregunta(patron_pitidos, 2, gpu_detectada).
siguiente_pregunta(patron_pitidos, 3, disco_detectado).
siguiente_pregunta(patron_pitidos, mas, cpu_reconocido_correctamente).
siguiente_pregunta(patron_pitidos, _, ram_detectada). % Catch-all para otros valores

% Mensaje No Signal
siguiente_pregunta(mensaje_no_signal, si, gpu_detectada).
siguiente_pregunta(mensaje_no_signal, no, ram_detectada).

% ------------------------------------------------------------
% RAMA 2B: PANTALLA ENCIENDE - EXPLORACIÓN SISTEMÁTICA
% ------------------------------------------------------------
siguiente_pregunta(pantalla_enciende, si, velocidad_lenta).

% Sub-rama: Sistema lento
siguiente_pregunta(velocidad_lenta, si, disco_detectado).
siguiente_pregunta(velocidad_lenta, no, pantalla_azul).

% Pantalla azul BSOD
siguiente_pregunta(pantalla_azul, si, codigo_error_bsod).
siguiente_pregunta(pantalla_azul, no, artefactos_visuales).

siguiente_pregunta(codigo_error_bsod, _, ram_detectada). % Cualquier código -> check RAM

% Artefactos visuales
siguiente_pregunta(artefactos_visuales, si, artifactos_gpu).
siguiente_pregunta(artefactos_visuales, no, reinicios_aleatorios).

% ============================================================
% RAMA 3: ALMACENAMIENTO (SIEMPRE SE EXPLORA)
% ============================================================
siguiente_pregunta(disco_detectado, no, ruidos_disco).
siguiente_pregunta(disco_detectado, si, smart_warnings).

% Sub-rama: Ruidos de disco
siguiente_pregunta(ruidos_disco, si, ruido_tipo).
siguiente_pregunta(ruidos_disco, no, ssd_no_reconocido).

siguiente_pregunta(ruido_tipo, click_repetitivo, smart_warnings).
siguiente_pregunta(ruido_tipo, chirrido_continuo, smart_warnings).
siguiente_pregunta(ruido_tipo, golpeteo, smart_warnings).
siguiente_pregunta(ruido_tipo, _, smart_warnings). % Catch-all

% SMART y salud del disco
siguiente_pregunta(smart_warnings, si, sectores_realocados).
siguiente_pregunta(smart_warnings, no, temperatura_disco).

siguiente_pregunta(sectores_realocados, si, archivos_corruptos).
siguiente_pregunta(sectores_realocados, no, temperatura_disco).

siguiente_pregunta(temperatura_disco, si, ssd_ralentizado).
siguiente_pregunta(temperatura_disco, no, ssd_ralentizado).

siguiente_pregunta(archivos_corruptos, si, ram_detectada).
siguiente_pregunta(archivos_corruptos, no, ram_detectada).

% SSD específico
siguiente_pregunta(ssd_no_reconocido, si, m2_slot_funciona).
siguiente_pregunta(ssd_no_reconocido, no, ram_detectada).

siguiente_pregunta(m2_slot_funciona, si, bios_version_actualizada).
siguiente_pregunta(m2_slot_funciona, no, bios_version_actualizada).

siguiente_pregunta(ssd_ralentizado, si, ram_detectada).
siguiente_pregunta(ssd_ralentizado, no, ram_detectada).

% ============================================================
% RAMA 4: MEMORIA RAM (CRÍTICA)
% ============================================================
siguiente_pregunta(ram_detectada, no, cantidad_ram_detectada).
siguiente_pregunta(ram_detectada, si, memtest_errores).

siguiente_pregunta(cantidad_ram_detectada, parcial, memtest_errores).
siguiente_pregunta(cantidad_ram_detectada, incorrecta, slots_ocupados).
siguiente_pregunta(cantidad_ram_detectada, _, memtest_errores). % Catch-all

siguiente_pregunta(memtest_errores, si, ubicacion_error_ram).
siguiente_pregunta(memtest_errores, no, xmp_activado).

siguiente_pregunta(ubicacion_error_ram, _, xmp_activado). % Cualquier ubicación

siguiente_pregunta(slots_ocupados, _, dual_channel_activo). % Cualquier número

siguiente_pregunta(xmp_activado, si, ram_a_velocidad_maxima).
siguiente_pregunta(xmp_activado, no, dual_channel_activo).

siguiente_pregunta(dual_channel_activo, si, ram_a_velocidad_maxima).
siguiente_pregunta(dual_channel_activo, no, ram_a_velocidad_maxima).

siguiente_pregunta(ram_a_velocidad_maxima, si, sobrecalentamiento).
siguiente_pregunta(ram_a_velocidad_maxima, no, sobrecalentamiento).

% ============================================================
% RAMA 5: TEMPERATURA Y REFRIGERACIÓN
% ============================================================
siguiente_pregunta(sobrecalentamiento, si, temp_cpu_idle).
siguiente_pregunta(sobrecalentamiento, no, reinicios_aleatorios).

siguiente_pregunta(temp_cpu_idle, si, temp_cpu_carga).
siguiente_pregunta(temp_cpu_idle, no, temp_gpu_idle).

siguiente_pregunta(temp_cpu_carga, si, apagado_termico).
siguiente_pregunta(temp_cpu_carga, no, temp_gpu_idle).

siguiente_pregunta(apagado_termico, si, pasta_termica_vieja).
siguiente_pregunta(apagado_termico, no, ventilador_ruidoso).

siguiente_pregunta(pasta_termica_vieja, si, polvo_acumulado).
siguiente_pregunta(pasta_termica_vieja, no, ventilador_ruidoso).

siguiente_pregunta(ventilador_ruidoso, si, ventilador_detenido).
siguiente_pregunta(ventilador_ruidoso, no, ventilador_vibra).

siguiente_pregunta(ventilador_detenido, si, polvo_acumulado).
siguiente_pregunta(ventilador_detenido, no, ventilador_vibra).

siguiente_pregunta(ventilador_vibra, si, polvo_acumulado).
siguiente_pregunta(ventilador_vibra, no, polvo_acumulado).

siguiente_pregunta(polvo_acumulado, si, flujo_aire_bloqueado).
siguiente_pregunta(polvo_acumulado, no, flujo_aire_bloqueado).

siguiente_pregunta(flujo_aire_bloqueado, si, gpu_detectada).
siguiente_pregunta(flujo_aire_bloqueado, no, gpu_detectada).

% Temperatura GPU
siguiente_pregunta(temp_gpu_idle, si, temp_gpu_carga).
siguiente_pregunta(temp_gpu_idle, no, gpu_detectada).

siguiente_pregunta(temp_gpu_carga, si, ventiladores_gpu_giran).
siguiente_pregunta(temp_gpu_carga, no, gpu_detectada).

% ============================================================
% RAMA 6: GPU Y GRÁFICOS
% ============================================================
siguiente_pregunta(gpu_detectada, no, driver_gpu_instalado).
siguiente_pregunta(gpu_detectada, si, artifactos_gpu).

siguiente_pregunta(driver_gpu_instalado, si, slots_pcie_funcionan).
siguiente_pregunta(driver_gpu_instalado, no, slots_pcie_funcionan).

siguiente_pregunta(artifactos_gpu, si, pantallazos_negros).
siguiente_pregunta(artifactos_gpu, no, fps_bajos).

siguiente_pregunta(pantallazos_negros, si, driver_crashed).
siguiente_pregunta(pantallazos_negros, no, gpu_throttling).

siguiente_pregunta(driver_crashed, si, fps_bajos).
siguiente_pregunta(driver_crashed, no, fps_bajos).

siguiente_pregunta(fps_bajos, si, gpu_throttling).
siguiente_pregunta(fps_bajos, no, ventiladores_gpu_giran).

siguiente_pregunta(gpu_throttling, si, ventiladores_gpu_giran).
siguiente_pregunta(gpu_throttling, no, ventiladores_gpu_giran).

siguiente_pregunta(ventiladores_gpu_giran, si, coil_whine_gpu).
siguiente_pregunta(ventiladores_gpu_giran, no, coil_whine_gpu).

siguiente_pregunta(coil_whine_gpu, si, cpu_reconocido_correctamente).
siguiente_pregunta(coil_whine_gpu, no, cpu_reconocido_correctamente).

% ============================================================
% RAMA 7: CPU Y MOTHERBOARD
% ============================================================
siguiente_pregunta(cpu_reconocido_correctamente, no, nucleos_detectados).
siguiente_pregunta(cpu_reconocido_correctamente, si, frecuencia_cpu_correcta).

siguiente_pregunta(nucleos_detectados, no, fecha_hora_resetea).
siguiente_pregunta(nucleos_detectados, si, frecuencia_cpu_correcta).

siguiente_pregunta(frecuencia_cpu_correcta, si, cpu_throttling).
siguiente_pregunta(frecuencia_cpu_correcta, no, cpu_throttling).

siguiente_pregunta(cpu_throttling, si, uso_cpu_100).
siguiente_pregunta(cpu_throttling, no, uso_cpu_100).

siguiente_pregunta(uso_cpu_100, si, proceso_consume_cpu).
siguiente_pregunta(uso_cpu_100, no, puertos_traseros_funcionan).

siguiente_pregunta(proceso_consume_cpu, _, puertos_traseros_funcionan).

% Motherboard
siguiente_pregunta(fecha_hora_resetea, si, configuracion_bios_se_pierde).
siguiente_pregunta(fecha_hora_resetea, no, bios_version_actualizada).

siguiente_pregunta(configuracion_bios_se_pierde, si, bios_version_actualizada).
siguiente_pregunta(configuracion_bios_se_pierde, no, bios_version_actualizada).

siguiente_pregunta(bios_version_actualizada, si, puertos_traseros_funcionan).
siguiente_pregunta(bios_version_actualizada, no, puertos_traseros_funcionan).

siguiente_pregunta(puertos_traseros_funcionan, si, slots_pcie_funcionan).
siguiente_pregunta(puertos_traseros_funcionan, no, slots_pcie_funcionan).

siguiente_pregunta(slots_pcie_funcionan, si, sata_ports_funcionan).
siguiente_pregunta(slots_pcie_funcionan, no, sata_ports_funcionan).

siguiente_pregunta(sata_ports_funcionan, si, red_funciona).
siguiente_pregunta(sata_ports_funcionan, no, red_funciona).

% ============================================================
% RAMA 8: RED Y CONECTIVIDAD
% ============================================================
siguiente_pregunta(red_funciona, no, wifi_detecta).
siguiente_pregunta(red_funciona, si, audio_funciona).

siguiente_pregunta(wifi_detecta, no, ethernet_funciona).
siguiente_pregunta(wifi_detecta, si, velocidad_red_baja).

siguiente_pregunta(ethernet_funciona, no, led_ethernet_parpadea).
siguiente_pregunta(ethernet_funciona, si, velocidad_red_baja).

siguiente_pregunta(velocidad_red_baja, si, ping_alto).
siguiente_pregunta(velocidad_red_baja, no, audio_funciona).

siguiente_pregunta(ping_alto, si, paquetes_perdidos).
siguiente_pregunta(ping_alto, no, conexion_intermitente).

siguiente_pregunta(paquetes_perdidos, si, conexion_intermitente).
siguiente_pregunta(paquetes_perdidos, no, conexion_intermitente).

siguiente_pregunta(conexion_intermitente, si, driver_red_actualizado).
siguiente_pregunta(conexion_intermitente, no, driver_red_actualizado).

siguiente_pregunta(led_ethernet_parpadea, si, driver_red_actualizado).
siguiente_pregunta(led_ethernet_parpadea, no, driver_red_actualizado).

siguiente_pregunta(driver_red_actualizado, si, audio_funciona).
siguiente_pregunta(driver_red_actualizado, no, audio_funciona).

% ============================================================
% RAMA 9: AUDIO Y USB
% ============================================================
siguiente_pregunta(audio_funciona, no, crackling_audio).
siguiente_pregunta(audio_funciona, si, usb_funciona).

siguiente_pregunta(crackling_audio, si, audio_distorsionado).
siguiente_pregunta(crackling_audio, no, audio_distorsionado).

siguiente_pregunta(audio_distorsionado, si, microfono_funciona).
siguiente_pregunta(audio_distorsionado, no, microfono_funciona).

siguiente_pregunta(microfono_funciona, si, usb_funciona).
siguiente_pregunta(microfono_funciona, no, usb_funciona).

% USB
siguiente_pregunta(usb_funciona, no, usb_intermitente).
siguiente_pregunta(usb_funciona, si, usb_3_no_funciona).

siguiente_pregunta(usb_intermitente, si, dispositivos_no_reconocidos).
siguiente_pregunta(usb_intermitente, no, usb_frontal_no_funciona).

siguiente_pregunta(dispositivos_no_reconocidos, si, usb_frontal_no_funciona).
siguiente_pregunta(dispositivos_no_reconocidos, no, usb_frontal_no_funciona).

siguiente_pregunta(usb_3_no_funciona, si, usb_velocidad_lenta).
siguiente_pregunta(usb_3_no_funciona, no, usb_frontal_no_funciona).

siguiente_pregunta(usb_velocidad_lenta, si, usb_frontal_no_funciona).
siguiente_pregunta(usb_velocidad_lenta, no, usb_frontal_no_funciona).

siguiente_pregunta(usb_frontal_no_funciona, si, usb_posterior_funciona).
siguiente_pregunta(usb_frontal_no_funciona, no, usb_posterior_funciona).

siguiente_pregunta(usb_posterior_funciona, si, reinicios_aleatorios).
siguiente_pregunta(usb_posterior_funciona, no, reinicios_aleatorios).

% ============================================================
% RAMA 10: ESTABILIDAD Y CASOS ESPECIALES
% ============================================================
siguiente_pregunta(reinicios_aleatorios, si, congelamientos).
siguiente_pregunta(reinicios_aleatorios, no, recientemente_instalo_hardware).

siguiente_pregunta(congelamientos, si, aplicaciones_crash).
siguiente_pregunta(congelamientos, no, recientemente_instalo_hardware).

siguiente_pregunta(aplicaciones_crash, si, recientemente_instalo_hardware).
siguiente_pregunta(aplicaciones_crash, no, recientemente_instalo_hardware).

% Casos especiales
siguiente_pregunta(recientemente_instalo_hardware, si, recientemente_actualizo_drivers).
siguiente_pregunta(recientemente_instalo_hardware, no, derramo_liquido).

siguiente_pregunta(recientemente_actualizo_drivers, si, recientemente_actualizo_bios).
siguiente_pregunta(recientemente_actualizo_drivers, no, derramo_liquido).

siguiente_pregunta(recientemente_actualizo_bios, si, derramo_liquido).
siguiente_pregunta(recientemente_actualizo_bios, no, derramo_liquido).

siguiente_pregunta(derramo_liquido, si, golpe_caida).
siguiente_pregunta(derramo_liquido, no, golpe_caida).

siguiente_pregunta(golpe_caida, si, ejecutar_diagnostico).
siguiente_pregunta(golpe_caida, no, ejecutar_diagnostico).

% ============================================================
% NODO TERMINAL - EJECUTAR DIAGNÓSTICO
% ============================================================
siguiente_pregunta(ejecutar_diagnostico, _, fin_diagnostico).

% ============================================================
% VALIDACIÓN: Verificar que todas las preguntas tienen salida
% ============================================================
% Esta regla asegura que ninguna pregunta quede sin siguiente paso
pregunta_sin_salida(Pregunta) :-
    pregunta(Pregunta, _),
    \+ siguiente_pregunta(Pregunta, _, _),
    Pregunta \= ejecutar_diagnostico,
    Pregunta \= fin_diagnostico.

% Listar todas las preguntas sin salida
listar_preguntas_sin_salida(Lista) :-
    findall(P, pregunta_sin_salida(P), Lista).

% Verificar integridad del árbol
verificar_arbol_completo :-
    listar_preguntas_sin_salida(Lista),
    (Lista = [] ->
        write('✓ Árbol completo: Todas las preguntas tienen siguiente paso'), nl
    ;
        write('✗ Preguntas sin salida: '), write(Lista), nl
    ).



% ========================================
% DIAGNÓSTICOS COMPLETOS - 240+ REGLAS
% Basado en árbol de decisión optimizado
% ========================================

% ========================================
% DIAGNÓSTICOS DE EMERGENCIA Y RESPALDO (MATCH FLEXIBLE)
% Sistema de Red de Seguridad para Cobertura Total
% ========================================

% ============================================================
% NIVEL 1: DIAGNÓSTICOS CRÍTICOS DE EMERGENCIA
% ============================================================

diagnostico(componente_quemado_critico) :-
    sintoma(componente_quemado_visible, si),
    sintoma(chispa_electrica, si).
explicacion(componente_quemado_critico, 
    'Componente visiblemente quemado con evidencia de chispa eléctrica - DAÑO CRÍTICO').
solucion(componente_quemado_critico, 
    'PELIGRO: NO encender el equipo. Inspeccionar visualmente PSU, Motherboard y GPU. 
    Buscar componentes quemados, capacitores hinchados, marcas de quemado en PCB. 
    Reemplazar componentes dañados. COSTO: $100-800 USD').
componente_afectado(componente_quemado_critico, 'PSU/Motherboard/GPU').

diagnostico(fallo_electrico_severo) :-
    sintoma(enciende, no),
    sintoma(led_power, no),
    sintoma(olor_quemado, si).
explicacion(fallo_electrico_severo, 
    'Fallo eléctrico severo - Sistema no enciende y hay olor a quemado').
solucion(fallo_electrico_severo, 
    'URGENTE: Desconectar de corriente. Inspeccionar PSU primero (paperclip test SOLO si no huele a quemado). 
    Verificar motherboard, GPU. Buscar capacitores hinchados, traces quemados. 
    Probable reemplazo PSU o Motherboard. COSTO: $60-400 USD').
componente_afectado(fallo_electrico_severo, 'PSU/Motherboard').

diagnostico(cortocircuito_detectado) :-
    sintoma(chispa_electrica, si),
    sintoma(enciende, no).
explicacion(cortocircuito_detectado, 
    'Cortocircuito detectado - Chispas eléctricas y sistema no arranca').
solucion(cortocircuito_detectado, 
    'Verificar: 1) Standoffs extra en motherboard, 2) Cables pelados tocando chasis, 
    3) Tornillos caídos dentro del case, 4) PSU defectuosa. 
    Probar motherboard fuera del case sobre superficie aislante. COSTO: $0-400 USD').
componente_afectado(cortocircuito_detectado, 'Sistema Completo').

diagnostico(dano_por_tormenta_electrica) :-
    sintoma(tormenta_electrica, si),
    sintoma(enciende, no).
explicacion(dano_por_tormenta_electrica, 
    'Daño por sobretensión eléctrica - Tormenta o corte de luz reciente').
solucion(dano_por_tormenta_electrica, 
    'Verificar múltiples componentes: PSU (paperclip test), Motherboard (inspección visual), 
    puertos Ethernet/USB quemados. Común: PSU y NIC muertos. Usar UPS/supresor futuro. 
    COSTO: $150-600 USD múltiples componentes').
componente_afectado(dano_por_tormenta_electrica, 'Múltiples Componentes').

diagnostico(dano_liquido_severo) :-
    sintoma(derramo_liquido, si),
    sintoma(enciende, no).
explicacion(dano_liquido_severo, 
    'Daño severo por líquido - Cortocircuito inmediato').
solucion(dano_liquido_severo, 
    'ACCIÓN INMEDIATA: 1) Desconectar corriente, 2) Remover batería CMOS, 3) Desmontar TODO, 
    4) Limpiar con alcohol isopropílico 99%, 5) Secar 72+ horas. Inspeccionar corrosión. 
    Probable pérdida total. COSTO: $200-1000 USD').
componente_afectado(dano_liquido_severo, 'Sistema Completo').

diagnostico(dano_impacto_fisico) :-
    sintoma(golpe_caida, si),
    sintoma(enciende, no).
explicacion(dano_impacto_fisico, 
    'Daño físico por impacto - Golpe o caída reciente').
solucion(dano_impacto_fisico, 
    'INSPECCIONAR: 1) HDD clicks (reemplazar urgente), 2) GPU mal asentada, 3) RAM suelta, 
    4) Cooler CPU desconectado, 5) Cables internos. Verificar integridad PCB. 
    COSTO: $0-500 USD según daño').
componente_afectado(dano_impacto_fisico, 'Múltiples Componentes').

% ============================================================
% NIVEL 2: SISTEMA NO ENCIENDE (SIN SIGNOS DE VIDA)
% ============================================================

diagnostico(psu_o_motherboard_muerta_simple) :-
    sintoma(enciende, no),
    sintoma(led_power, no),
    \+ sintoma(olor_quemado, si).
explicacion(psu_o_motherboard_muerta_simple, 
    'PSU o Motherboard completamente muerta - Sin señales de vida').
solucion(psu_o_motherboard_muerta_simple, 
    'PROBAR: 1) PSU con paperclip test (puentear pin 16-17 del ATX 24-pin), 
    2) Probar PSU conocida funcional en motherboard, 3) Probar motherboard con PSU externa. 
    Identificar componente fallido. COSTO: $60-400 USD').
componente_afectado(psu_o_motherboard_muerta_simple, 'PSU/Motherboard').

diagnostico(problema_boton_power) :-
    sintoma(enciende, no),
    sintoma(led_power, si).
explicacion(problema_boton_power, 
    'Botón power no funciona o cable desconectado - LED enciende pero sistema no arranca').
solucion(problema_boton_power, 
    'VERIFICAR: 1) Cable PWR_BTN conectado a motherboard, 2) Probar puenteando pines directamente 
    con destornillador, 3) Botón case defectuoso. COSTO: $0-20 USD').
componente_afectado(problema_boton_power, 'Case/Motherboard').

diagnostico(psu_proteccion_activa) :-
    sintoma(enciende, no),
    sintoma(ventiladores, si),
    sintoma(pantalla_enciende, no).
explicacion(psu_proteccion_activa, 
    'Protección PSU activada - Ventiladores giran por un momento y se apaga').
solucion(psu_proteccion_activa, 
    'PSU detecta sobrecarga/cortocircuito. DESCONECTAR todos los dispositivos. 
    Conectar solo: ATX 24-pin + EPS CPU. Agregar componentes uno por uno. 
    Componente que causa apagado = falla. COSTO: Variable').
componente_afectado(psu_proteccion_activa, 'PSU/Componente en Corto').

% ============================================================
% NIVEL 3: SISTEMA ENCIENDE PERO NO POST (SIN VIDEO)
% ============================================================

diagnostico(problema_post_sin_video) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, no),
    sintoma(pitidos_post, no).
explicacion(problema_post_sin_video, 
    'Sistema no pasa POST - Sin video ni códigos de error').
solucion(problema_post_sin_video, 
    'PROCEDIMIENTO: 1) Remover GPU, usar iGPU si disponible, 2) Un módulo RAM en slot A2, 
    3) Desconectar todos USB/periféricos, 4) Clear CMOS, 5) Verificar CPU bien instalado. 
    COSTO: Variable según componente').
componente_afectado(problema_post_sin_video, 'RAM/GPU/CPU/Motherboard').

diagnostico(problema_ram_no_post) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, no),
    sintoma(pitidos_post, si).
explicacion(problema_ram_no_post, 
    'Problema RAM detectado en POST - Beep codes indican fallo memoria').
solucion(problema_ram_no_post, 
    'VERIFICAR: 1) RAM correctamente instalada (click audible), 2) Probar un módulo a la vez en slot A2, 
    3) Limpiar contactos dorados con goma de borrar, 4) Probar RAM conocida funcional. 
    COSTO: $30-100 USD RAM nueva').
componente_afectado(problema_ram_no_post, 'RAM/Motherboard').

diagnostico(problema_gpu_no_detectada) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, no),
    sintoma(gpu_detectada, no).
explicacion(problema_gpu_no_detectada, 
    'GPU no detectada - Sistema no muestra video').
solucion(problema_gpu_no_detectada, 
    'VERIFICAR: 1) Todos los cables PCIe conectados (6+8 pin), 2) GPU firmemente insertada (click), 
    3) Monitor en puerto GPU (no motherboard), 4) Probar GPU en otro slot/PC. 
    COSTO: $0 o $200-1500 USD GPU nueva').
componente_afectado(problema_gpu_no_detectada, 'GPU/PSU/Motherboard').

diagnostico(problema_cpu_no_detectado) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, no),
    sintoma(cpu_reconocido_correctamente, no).
explicacion(problema_cpu_no_detectado, 
    'CPU no detectado correctamente - Fallo instalación o compatibilidad').
solucion(problema_cpu_no_detectado, 
    'VERIFICAR: 1) CPU correctamente instalado y bracket cerrado, 2) Pines CPU no doblados (AMD), 
    3) BIOS compatible con CPU (actualizar si necesario), 4) Cable EPS 12V CPU conectado. 
    COSTO: $0 o $150-600 USD CPU nuevo').
componente_afectado(problema_cpu_no_detectado, 'CPU/Motherboard').

% ============================================================
% NIVEL 4: SISTEMA ENCIENDE CON VIDEO PERO PROBLEMAS
% ============================================================

diagnostico(problema_arranque_lento) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, si),
    sintoma(velocidad_lenta, si).
explicacion(problema_arranque_lento, 
    'Sistema arranca pero extremadamente lento - Múltiples causas posibles').
solucion(problema_arranque_lento, 
    'VERIFICAR: 1) Disco duro funcionando (SMART, CrystalDiskInfo), 2) RAM suficiente y funcional, 
    3) Malware/software startup, 4) Temperatura normal, 5) Drivers actualizados. 
    COSTO: $0-200 USD según causa').
componente_afectado(problema_arranque_lento, 'Storage/RAM/Software').

diagnostico(problema_pantalla_azul_bsod) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, si),
    sintoma(pantalla_azul, si).
explicacion(problema_pantalla_azul_bsod, 
    'BSOD (Pantalla Azul) - Error crítico Windows').
solucion(problema_pantalla_azul_bsod, 
    'ANALIZAR código error BSOD con BlueScreenView. COMÚN: 1) Drivers conflictivos (DDU + reinstalar), 
    2) RAM defectuosa (MemTest86), 3) Storage fallando (SMART), 4) Overclock inestable. 
    COSTO: $0-200 USD según causa').
componente_afectado(problema_pantalla_azul_bsod, 'Drivers/RAM/Storage').

diagnostico(problema_artefactos_visuales) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, si),
    sintoma(artefactos_visuales, si).
explicacion(problema_artefactos_visuales, 
    'Artefactos visuales en pantalla - Pixeles, líneas, distorsión').
solucion(problema_artefactos_visuales, 
    'VERIFICAR: 1) Cable video firmemente conectado, 2) Probar otro cable/puerto, 
    3) Temperatura GPU normal, 4) GPU correctamente alimentada, 5) Drivers actualizados. 
    VRAM fallida si persiste. COSTO: $0-1500 USD GPU nueva').
componente_afectado(problema_artefactos_visuales, 'GPU/Monitor/Cable').

% ============================================================
% NIVEL 5: PROBLEMAS DE ESTABILIDAD
% ============================================================

diagnostico(problema_reinicios_aleatorios_general) :-
    sintoma(enciende, si),
    sintoma(reinicios_aleatorios, si).
explicacion(problema_reinicios_aleatorios_general, 
    'Reinicios aleatorios - Múltiples causas posibles').
solucion(problema_reinicios_aleatorios_general, 
    'CAUSAS COMUNES: 1) PSU insuficiente/defectuosa, 2) RAM defectuosa (MemTest86), 
    3) Sobrecalentamiento CPU/GPU, 4) Drivers conflictivos, 5) Malware. 
    Monitorear Event Viewer para pistas. COSTO: Variable').
componente_afectado(problema_reinicios_aleatorios_general, 'PSU/RAM/Temperatura/Software').

diagnostico(problema_congelamientos_general) :-
    sintoma(enciende, si),
    sintoma(congelamientos, si).
explicacion(problema_congelamientos_general, 
    'Sistema se congela (freeze) - Requiere reset forzado').
solucion(problema_congelamientos_general, 
    'VERIFICAR: 1) Temperatura CPU/GPU (HWiNFO64), 2) MemTest86 para RAM, 
    3) CrystalDiskInfo para disco, 4) Drivers GPU (DDU + reinstalar), 
    5) Malware scan. COSTO: Variable según causa').
componente_afectado(problema_congelamientos_general, 'CPU/GPU/RAM/Storage').

diagnostico(problema_aplicaciones_crash) :-
    sintoma(enciende, si),
    sintoma(aplicaciones_crash, si).
explicacion(problema_aplicaciones_crash, 
    'Aplicaciones se cierran inesperadamente - Inestabilidad software/hardware').
solucion(problema_aplicaciones_crash, 
    'VERIFICAR: 1) RAM con MemTest86, 2) Temperatura normal, 3) Drivers actualizados, 
    4) SFC /scannow para archivos Windows, 5) Overclock deshabilitado. 
    COSTO: $0-200 USD según causa').
componente_afectado(problema_aplicaciones_crash, 'RAM/CPU/Software').

% ============================================================
% NIVEL 6: PROBLEMAS TÉRMICOS
% ============================================================

diagnostico(problema_sobrecalentamiento_general) :-
    sintoma(enciende, si),
    sintoma(sobrecalentamiento, si).
explicacion(problema_sobrecalentamiento_general, 
    'Sobrecalentamiento general del sistema').
solucion(problema_sobrecalentamiento_general, 
    'ACCIÓN INMEDIATA: 1) Verificar todos los ventiladores giran, 2) Limpiar polvo con aire comprimido, 
    3) Reemplazar pasta térmica CPU (3+ años), 4) Mejorar airflow case, 
    5) Monitorear temperaturas (HWiNFO64). COSTO: $5-80 USD').
componente_afectado(problema_sobrecalentamiento_general, 'Sistema Refrigeración').

diagnostico(problema_apagado_termico) :-
    sintoma(enciende, si),
    sintoma(apagado_termico, si).
explicacion(problema_apagado_termico, 
    'Apagado por protección térmica - CPU/GPU alcanzan temperatura crítica').
solucion(problema_apagado_termico, 
    'URGENTE: 1) NO usar PC hasta resolver, 2) Verificar cooler CPU montado y funcionando, 
    3) Pasta térmica nueva, 4) Todos ventiladores giran, 5) Airflow no obstruido. 
    COSTO: $5-120 USD').
componente_afectado(problema_apagado_termico, 'Cooler/Pasta Térmica').

diagnostico(problema_ventiladores_ruido) :-
    sintoma(enciende, si),
    sintoma(ventilador_ruidoso, si).
explicacion(problema_ventiladores_ruido, 
    'Ventiladores hacen ruido excesivo - Rodamientos desgastados o polvo').
solucion(problema_ventiladores_ruido, 
    'VERIFICAR: 1) Limpiar polvo de aspas, 2) Cables no toquen aspas, 3) Rodamientos secos (lubricar o reemplazar), 
    4) Ajustar fan curves en BIOS. COSTO: $10-40 USD ventiladores nuevos').
componente_afectado(problema_ventiladores_ruido, 'Ventiladores').

diagnostico(problema_ventilador_detenido) :-
    sintoma(enciende, si),
    sintoma(ventilador_detenido, si).
explicacion(problema_ventilador_detenido, 
    'Ventilador no gira - Fallo mecánico o eléctrico').
solucion(problema_ventilador_detenido, 
    'IDENTIFICAR ventilador: CPU crítico, case menos crítico. 
    1) Conectar a otro header motherboard, 2) Probar ventilador directamente a PSU, 
    3) Reemplazar si no gira. COSTO: $10-80 USD según ventilador').
componente_afectado(problema_ventilador_detenido, 'Ventilador/Motherboard').

% ============================================================
% NIVEL 7: PROBLEMAS DE STORAGE
% ============================================================

diagnostico(problema_disco_no_detectado) :-
    sintoma(enciende, si),
    sintoma(disco_detectado, no).
explicacion(problema_disco_no_detectado, 
    'Disco duro/SSD no detectado en BIOS').
solucion(problema_disco_no_detectado, 
    'VERIFICAR: 1) Cable SATA/M.2 firmemente conectado, 2) Probar otro puerto SATA/M.2, 
    3) Probar cable SATA diferente, 4) Disco detectado en otro PC, 5) Alimentación SATA conectada. 
    COSTO: $0-200 USD disco nuevo').
componente_afectado(problema_disco_no_detectado, 'Storage/Motherboard/Cables').

diagnostico(problema_ruidos_disco) :-
    sintoma(enciende, si),
    sintoma(ruidos_disco, si).
explicacion(problema_ruidos_disco, 
    'Disco hace ruidos extraños - Clicks, chirridos, golpeteos').
solucion(problema_ruidos_disco, 
    'PELIGRO: BACKUP INMEDIATO. Ruidos = fallo mecánico inminente. 
    Click = cabezales, Chirrido = motor, Golpeteo = superficie dañada. 
    NO intentar reparar. REEMPLAZAR. COSTO: $50-200 USD HDD + recovery si necesario').
componente_afectado(problema_ruidos_disco, 'HDD').

diagnostico(problema_smart_warnings) :-
    sintoma(enciende, si),
    sintoma(smart_warnings, si).
explicacion(problema_smart_warnings, 
    'Alertas SMART del disco - Parámetros críticos detectados').
solucion(problema_smart_warnings, 
    'BACKUP URGENTE. Usar CrystalDiskInfo para análisis detallado. 
    CRÍTICOS: Reallocated Sectors > 50, Current Pending Sector > 0. 
    REEMPLAZAR disco preventivamente. COSTO: $50-200 USD disco nuevo').
componente_afectado(problema_smart_warnings, 'Storage').

diagnostico(problema_archivos_corruptos) :-
    sintoma(enciende, si),
    sintoma(archivos_corruptos, si).
explicacion(problema_archivos_corruptos, 
    'Archivos perdidos o corruptos - Problema storage o RAM').
solucion(problema_archivos_corruptos, 
    'VERIFICAR: 1) SMART disco (CrystalDiskInfo), 2) MemTest86 para RAM, 
    3) chkdsk /f /r para reparar filesystem, 4) SFC /scannow para archivos sistema. 
    COSTO: $0-200 USD según causa').
componente_afectado(problema_archivos_corruptos, 'Storage/RAM').

% ============================================================
% NIVEL 8: PROBLEMAS DE RED Y CONECTIVIDAD
% ============================================================

diagnostico(problema_red_no_funciona) :-
    sintoma(enciende, si),
    sintoma(red_funciona, no).
explicacion(problema_red_no_funciona, 
    'Conexión de red no funciona - Ethernet o WiFi').
solucion(problema_red_no_funciona, 
    'VERIFICAR: 1) Cable Ethernet conectado firmemente, 2) Drivers red actualizados, 
    3) Probar WiFi y Ethernet, 4) Reset router/modem, 5) Adaptador red habilitado en Windows. 
    COSTO: $0 o $25-60 USD adaptador USB/PCIe').
componente_afectado(problema_red_no_funciona, 'Network/Drivers').

diagnostico(problema_wifi_no_detecta) :-
    sintoma(enciende, si),
    sintoma(wifi_detecta, no).
explicacion(problema_wifi_no_detecta, 
    'WiFi no detecta redes - Adaptador no funciona').
solucion(problema_wifi_no_detecta, 
    'VERIFICAR: 1) Drivers WiFi instalados, 2) Antenas conectadas, 3) WiFi habilitado en BIOS, 
    4) Interruptor físico WiFi (laptops), 5) Probar adaptador USB WiFi. 
    COSTO: $15-50 USD adaptador WiFi').
componente_afectado(problema_wifi_no_detecta, 'WiFi/Drivers').

diagnostico(problema_velocidad_red_baja) :-
    sintoma(enciende, si),
    sintoma(velocidad_red_baja, si).
explicacion(problema_velocidad_red_baja, 
    'Velocidad de Internet muy baja - Problema ISP, router o adaptador').
solucion(problema_velocidad_red_baja, 
    'VERIFICAR: 1) Speedtest.net para medir real, 2) Cable Ethernet Cat5e/6, 
    3) Drivers actualizados, 4) QoS router no limitando, 5) Probar conexión directa modem. 
    COSTO: $0 o $10-50 USD cable/adaptador').
componente_afectado(problema_velocidad_red_baja, 'Network/ISP').

% ============================================================
% NIVEL 9: PROBLEMAS USB Y PERIFÉRICOS
% ============================================================

diagnostico(problema_usb_no_funciona) :-
    sintoma(enciende, si),
    sintoma(usb_funciona, no).
explicacion(problema_usb_no_funciona, 
    'Puertos USB no reconocen dispositivos').
solucion(problema_usb_no_funciona, 
    'VERIFICAR: 1) Probar todos los puertos USB (frontales y traseros), 
    2) Drivers chipset actualizados, 3) USB habilitado en BIOS, 
    4) Dispositivos funcionan en otro PC. COSTO: $0 o $20-50 USD tarjeta PCIe USB').
componente_afectado(problema_usb_no_funciona, 'USB/Motherboard').

diagnostico(problema_usb_intermitente) :-
    sintoma(enciende, si),
    sintoma(usb_intermitente, si).
explicacion(problema_usb_intermitente, 
    'Dispositivos USB se desconectan solos - Problema alimentación o driver').
solucion(problema_usb_intermitente, 
    'VERIFICAR: 1) PSU capacidad suficiente, 2) Deshabilitar "USB selective suspend" Windows, 
    3) Actualizar drivers chipset, 4) Hub USB alimentado externamente. 
    COSTO: $0 o $20-40 USD hub alimentado').
componente_afectado(problema_usb_intermitente, 'USB/PSU/Drivers').

% ============================================================
% NIVEL 10: PROBLEMAS DE AUDIO
% ============================================================

diagnostico(problema_audio_no_funciona) :-
    sintoma(enciende, si),
    sintoma(audio_funciona, no).
explicacion(problema_audio_no_funciona, 
    'Audio no se escucha - Problema drivers o hardware').
solucion(problema_audio_no_funciona, 
    'VERIFICAR: 1) Dispositivo audio correcto seleccionado Windows, 2) Drivers audio actualizados, 
    3) Audio habilitado en BIOS, 4) Probar altavoces/audífonos en otro dispositivo. 
    COSTO: $0 o $30-80 USD tarjeta audio USB/PCIe').
componente_afectado(problema_audio_no_funciona, 'Audio/Drivers').

diagnostico(problema_audio_crackling) :-
    sintoma(enciende, si),
    sintoma(crackling_audio, si).
explicacion(problema_audio_crackling, 
    'Audio con interferencias o chasquidos - Problema señal o drivers').
solucion(problema_audio_crackling, 
    'VERIFICAR: 1) Actualizar drivers audio, 2) Cambiar sample rate (44.1kHz/48kHz), 
    3) Deshabilitar audio enhancements, 4) Ground loop isolator si interferencia eléctrica. 
    COSTO: $0 o $30-80 USD DAC USB').
componente_afectado(problema_audio_crackling, 'Audio/Drivers').

% ============================================================
% NIVEL 11: PROBLEMAS POST-INSTALACIÓN
% ============================================================

diagnostico(problema_post_instalar_hardware) :-
    sintoma(enciende, si),
    sintoma(recientemente_instalo_hardware, si).
explicacion(problema_post_instalar_hardware, 
    'Problemas después de instalar hardware nuevo - Incompatibilidad o instalación incorrecta').
solucion(problema_post_instalar_hardware, 
    'VERIFICAR: 1) Hardware correctamente instalado, 2) BIOS actualizado para compatibilidad, 
    3) Drivers instalados, 4) Alimentación suficiente, 5) Probar sin hardware nuevo. 
    COSTO: Variable según componente').
componente_afectado(problema_post_instalar_hardware, 'Hardware Nuevo').

diagnostico(problema_post_actualizar_drivers) :-
    sintoma(enciende, si),
    sintoma(recientemente_actualizo_drivers, si),
    (sintoma(pantalla_azul, si) ; sintoma(congelamientos, si)).
explicacion(problema_post_actualizar_drivers, 
    'Problemas después de actualizar drivers - Driver incompatible o corrupto').
solucion(problema_post_actualizar_drivers, 
    'REVERTIR drivers: 1) Device Manager → Propiedades → Roll Back Driver, 
    2) DDU en modo seguro para drivers GPU, 3) Instalar versión estable anterior. 
    COSTO: $0').
componente_afectado(problema_post_actualizar_drivers, 'Drivers').

diagnostico(problema_post_actualizar_bios) :-
    sintoma(enciende, si),
    sintoma(recientemente_actualizo_bios, si).
explicacion(problema_post_actualizar_bios, 
    'Problemas después de actualizar BIOS - Configuración perdida o BIOS corrupta').
solucion(problema_post_actualizar_bios, 
    'VERIFICAR: 1) Clear CMOS, 2) Reconfigurar BIOS (XMP, boot order, etc), 
    3) Si no arranca: BIOS Flashback con versión anterior, 4) Dual BIOS switch si disponible. 
    COSTO: $0').
componente_afectado(problema_post_actualizar_bios, 'BIOS/Motherboard').

% ============================================================
% NIVEL 12: CATCH-ALL FINAL (ÚLTIMA RED DE SEGURIDAD)
% ============================================================

diagnostico(problema_hardware_no_especificado) :-
    sintoma(enciende, si),
    % Al menos 3 síntomas registrados pero ningún diagnóstico específico
    findall(S, sintoma(S, _), Sintomas),
    length(Sintomas, N),
    N >= 3.
explicacion(problema_hardware_no_especificado, 
    'Problema de hardware detectado - Requiere diagnóstico más profundo').
solucion(problema_hardware_no_especificado, 
    'DIAGNÓSTICO GENERAL: 1) Event Viewer para errores, 2) MemTest86 para RAM, 
    3) CrystalDiskInfo para storage, 4) HWiNFO64 para temperaturas/voltajes, 
    5) Stress tests (Prime95, FurMark). Consultar técnico si persiste. COSTO: Variable').
componente_afectado(problema_hardware_no_especificado, 'Hardware General').

diagnostico(sistema_funcional_con_sintomas_menores) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, si),
    % Menos de 3 síntomas críticos
    findall(S, sintoma(S, si), SintomasSi),
    length(SintomasSi, N),
    N < 3,
    N > 0.
explicacion(sistema_funcional_con_sintomas_menores, 
    'Sistema funcional con síntomas menores - Mantenimiento preventivo recomendado').
solucion(sistema_funcional_con_sintomas_menores, 
    'MANTENIMIENTO PREVENTIVO: 1) Limpieza polvo con aire comprimido, 
    2) Verificar temperaturas normales, 3) Actualizar drivers/BIOS, 
    4) BACKUP datos importantes, 5) Verificar SMART discos. COSTO: $0-20 USD').
componente_afectado(sistema_funcional_con_sintomas_menores, 'Mantenimiento General').

diagnostico(diagnostico_requiere_mas_informacion) :-
    % Muy pocos síntomas para diagnóstico preciso
    findall(S, sintoma(S, _), Sintomas),
    length(Sintomas, N),
    N > 0,
    N < 3.
explicacion(diagnostico_requiere_mas_informacion, 
    'Información insuficiente para diagnóstico preciso - Se necesitan más respuestas').
solucion(diagnostico_requiere_mas_informacion, 
    'CONTINUAR CUESTIONARIO: Por favor responda más preguntas del árbol de decisión. 
    El sistema cuenta con 70+ preguntas específicas para diagnóstico preciso. 
    Mínimo recomendado: 10-15 respuestas para análisis completo').
componente_afectado(diagnostico_requiere_mas_informacion, 'Evaluación en Proceso').

% ============================================================
% NIVEL 13: PROBLEMAS ESPECÍFICOS AVANZADOS
% ============================================================

diagnostico(problema_dual_channel_ram_no_activo) :-
    sintoma(enciende, si),
    sintoma(ram_detectada, si),
    sintoma(dual_channel_activo, no).
explicacion(problema_dual_channel_ram_no_activo, 
    'Dual Channel RAM no activo - Performance reducida 30-50%').
solucion(problema_dual_channel_ram_no_activo, 
    'CORREGIR: 1) Usar slots A2 + B2 (segundo y cuarto desde CPU), 
    2) Módulos idénticos (misma capacidad/velocidad), 3) Verificar Task Manager → Memory → Channels. 
    Manual motherboard para configuración correcta. COSTO: $0').
componente_afectado(problema_dual_channel_ram_no_activo, 'RAM/Configuración').

diagnostico(problema_xmp_no_activado) :-
    sintoma(enciende, si),
    sintoma(ram_detectada, si),
    sintoma(xmp_activado, no),
    sintoma(ram_a_velocidad_maxima, no).
explicacion(problema_xmp_no_activado, 
    'Perfil XMP/DOCP no activado - RAM corriendo a velocidad mínima JEDEC').
solucion(problema_xmp_no_activado, 
    'ACTIVAR XMP: 1) Entrar BIOS (DEL/F2 al iniciar), 2) Buscar opción "XMP" o "DOCP" (AMD), 
    3) Seleccionar Profile 1, 4) Save & Exit. Verificar velocidad con CPU-Z tab Memory. 
    COSTO: $0').
componente_afectado(problema_xmp_no_activado, 'RAM/BIOS Configuración').

diagnostico(problema_bios_desactualizada) :-
    sintoma(enciende, si),
    sintoma(bios_version_actualizada, no),
    (sintoma(cpu_reconocido_correctamente, no) ; sintoma(ram_detectada, parcial)).
explicacion(problema_bios_desactualizada, 
    'BIOS desactualizada - Causa problemas compatibilidad CPU/RAM').
solucion(problema_bios_desactualizada, 
    'ACTUALIZAR BIOS: 1) Descargar versión más reciente del sitio fabricante motherboard, 
    2) Usar Q-Flash/EZ Flash desde BIOS, 3) BACKUP PRIMERO, 4) NO interrumpir proceso. 
    Mejora compatibilidad y estabilidad. COSTO: $0').
componente_afectado(problema_bios_desactualizada, 'Motherboard BIOS').

diagnostico(problema_cmos_battery_low) :-
    sintoma(enciende, si),
    sintoma(fecha_hora_resetea, si).
explicacion(problema_cmos_battery_low, 
    'Batería CMOS baja/agotada - Fecha/hora y configuración BIOS se pierden').
solucion(problema_cmos_battery_low, 
    'REEMPLAZAR batería CR2032: 1) Apagar PC, desconectar corriente, 2) Remover batería vieja, 
    3) Instalar CR2032 nueva (3V), 4) Reconfigurar BIOS (fecha/hora, boot order, XMP). 
    DURACIÓN: 3-5 años típico. COSTO: $3-5 USD').
componente_afectado(problema_cmos_battery_low, 'Motherboard CMOS').

diagnostico(problema_gpu_throttling_temperatura) :-
    sintoma(enciende, si),
    sintoma(gpu_detectada, si),
    sintoma(gpu_throttling, si),
    sintoma(temp_gpu_carga, si).
explicacion(problema_gpu_throttling_temperatura, 
    'GPU throttling por temperatura alta - Performance reducida para evitar daño').
solucion(problema_gpu_throttling_temperatura, 
    'REFRIGERACIÓN GPU: 1) Limpiar polvo ventiladores/heatsink, 2) Pasta térmica nueva, 
    3) Mejorar airflow case, 4) Fan curve más agresivo (MSI Afterburner), 
    5) Undervolt para reducir calor. COSTO: $5-50 USD').
componente_afectado(problema_gpu_throttling_temperatura, 'GPU Cooling').

diagnostico(problema_cpu_throttling_temperatura) :-
    sintoma(enciende, si),
    sintoma(cpu_throttling, si),
    sintoma(temp_cpu_carga, si).
explicacion(problema_cpu_throttling_temperatura, 
    'CPU throttling por temperatura alta - Reduce frecuencia para evitar daño').
solucion(problema_cpu_throttling_temperatura, 
    'REFRIGERACIÓN CPU: 1) Verificar cooler montado correctamente, 2) Pasta térmica nueva, 
    3) Todos ventiladores girando, 4) Airflow case adecuado, 5) Cooler más potente si necesario. 
    COSTO: $5-120 USD').
componente_afectado(problema_cpu_throttling_temperatura, 'CPU Cooling').

diagnostico(problema_ssd_trim_deshabilitado) :-
    sintoma(enciende, si),
    sintoma(disco_detectado, si),
    sintoma(ssd_ralentizado, si),
    sintoma(trim_no_funciona, si).
explicacion(problema_ssd_trim_deshabilitado, 
    'TRIM deshabilitado en SSD - Garbage collection ineficiente, performance degradada').
solucion(problema_ssd_trim_deshabilitado, 
    'HABILITAR TRIM: 1) CMD como admin: "fsutil behavior query DisableDeleteNotify", 
    2) Si = 1: "fsutil behavior set DisableDeleteNotify 0", 3) Optimize Drives (defragmenter), 
    4) Verificar AHCI mode en BIOS. COSTO: $0').
componente_afectado(problema_ssd_trim_deshabilitado, 'SSD/Windows').

diagnostico(problema_disco_lleno_performance) :-
    sintoma(enciende, si),
    sintoma(velocidad_lenta, si),
    sintoma(disco_detectado, si).
explicacion(problema_disco_lleno_performance, 
    'Disco casi lleno - Performance degradada especialmente en SSD >80% capacidad').
solucion(problema_disco_lleno_performance, 
    'LIBERAR ESPACIO: 1) Disk Cleanup (Windows), 2) Eliminar archivos temp, 
    3) Desinstalar programas no usados, 4) Mover archivos grandes a otro disco, 
    5) Mantener SSD <75% capacidad para performance óptima. COSTO: $0 o $50-200 USD disco adicional').
componente_afectado(problema_disco_lleno_performance, 'Storage').

diagnostico(problema_overclock_inestable) :-
    sintoma(enciende, si),
    sintoma(overclock_activo, si),
    (sintoma(reinicios_aleatorios, si) ; sintoma(congelamientos, si) ; sintoma(pantalla_azul, si)).
explicacion(problema_overclock_inestable, 
    'Overclock inestable - Voltajes/frecuencias demasiado altos o agresivos').
solucion(problema_overclock_inestable, 
    'REVERTIR A STOCK: 1) BIOS → Load Optimized Defaults, 2) Clear CMOS si no arranca, 
    3) Testear estabilidad stock, 4) Si estable: OC más conservador con stress tests. 
    REGLA: Prime95 12h + MemTest86 4 passes. COSTO: $0').
componente_afectado(problema_overclock_inestable, 'CPU/RAM/Overclock').

diagnostico(problema_psu_capacidad_insuficiente) :-
    sintoma(enciende, si),
    sintoma(gpu_detectada, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(apagado_subito, si).
explicacion(problema_psu_capacidad_insuficiente, 
    'PSU sin capacidad suficiente - Se apaga bajo carga alta (juegos, renders)').
solucion(problema_psu_capacidad_insuficiente, 
    'CALCULAR CONSUMO: GPU (TDP) + CPU (TDP) + 100W resto. EJEMPLO: RTX 4070 Ti (285W) + Ryzen 7 7700X (105W) + 100W = 490W. 
    PSU recomendada: 650W+ (20% margen). UPGRADE PSU calidad (80+ Gold). COSTO: $80-200 USD').
componente_afectado(problema_psu_capacidad_insuficiente, 'PSU').

diagnostico(problema_polvo_acumulado_general) :-
    sintoma(enciende, si),
    sintoma(polvo_acumulado, si),
    (sintoma(sobrecalentamiento, si) ; sintoma(ventilador_ruidoso, si)).
explicacion(problema_polvo_acumulado_general, 
    'Acumulación excesiva de polvo - Obstruye flujo aire y causa sobrecalentamiento').
solucion(problema_polvo_acumulado_general, 
    'LIMPIEZA PROFUNDA: 1) Apagar PC y desconectar, 2) Aire comprimido en ventiladores/heatsinks/filtros, 
    3) Limpiar aspas ventilador con toalla micro-fibra, 4) Limpiar GPU, 5) Instalar filtros polvo case. 
    FRECUENCIA: Cada 3-6 meses. COSTO: $10-30 USD kit limpieza + filtros').
componente_afectado(problema_polvo_acumulado_general, 'Sistema Completo').

diagnostico(problema_pasta_termica_vieja) :-
    sintoma(enciende, si),
    sintoma(pasta_termica_vieja, si),
    sintoma(temp_cpu_idle, si).
explicacion(problema_pasta_termica_vieja, 
    'Pasta térmica seca/degradada - Conductividad térmica reducida >70%').
solucion(problema_pasta_termica_vieja, 
    'REEMPLAZO PASTA: 1) Remover cooler, 2) Limpiar IHS y base cooler con alcohol 99%, 
    3) Aplicar grano tamaño arveja pasta calidad (Arctic MX-6, Thermal Grizzly Kryonaut), 
    4) Montar cooler presión uniforme. FRECUENCIA: Cada 2-3 años. COSTO: $5-15 USD').
componente_afectado(problema_pasta_termica_vieja, 'CPU/Cooler').

diagnostico(problema_driver_gpu_viejo) :-
    sintoma(enciende, si),
    sintoma(gpu_detectada, si),
    sintoma(driver_gpu_instalado, no).
explicacion(problema_driver_gpu_viejo, 
    'Drivers GPU no instalados o muy desactualizados - Performance reducida').
solucion(problema_driver_gpu_viejo, 
    'INSTALAR DRIVERS: NVIDIA → GeForce Experience o nvidia.com, AMD → Adrenalin o amd.com. 
    LIMPIO: DDU en modo seguro, luego instalar driver estable (NO beta). 
    ACTUALIZAR cada 2-3 meses. COSTO: $0').
componente_afectado(problema_driver_gpu_viejo, 'GPU Drivers').

diagnostico(problema_conflicto_drivers) :-
    sintoma(enciende, si),
    sintoma(recientemente_actualizo_drivers, si),
    sintoma(pantalla_azul, si).
explicacion(problema_conflicto_drivers, 
    'Conflicto entre drivers - Múltiples versiones o drivers incompatibles').
solucion(problema_conflicto_drivers, 
    'LIMPIEZA DRIVERS: 1) DDU modo seguro para GPU, 2) Device Manager → Desinstalar conflictivos, 
    3) Reinstalar drivers uno por uno, 4) Evitar múltiples software RGB/monitoring. 
    BlueScreenView para identificar driver causante. COSTO: $0').
componente_afectado(problema_conflicto_drivers, 'Drivers/Software').

diagnostico(problema_malware_performance) :-
    sintoma(enciende, si),
    sintoma(velocidad_lenta, si),
    sintoma(uso_cpu_100, si),
    sintoma(proceso_consume_cpu, si).
explicacion(problema_malware_performance, 
    'Posible malware consumiendo recursos - Proceso sospechoso usa CPU/memoria excesiva').
solucion(problema_malware_performance, 
    'ESCANEO MALWARE: 1) Malwarebytes scan completo, 2) Windows Defender full scan, 
    3) Task Manager identificar procesos sospechosos, 4) Autoruns desactivar startup malicioso, 
    5) Reset browser si adware. COSTO: $0 (free tools)').
componente_afectado(problema_malware_performance, 'Software/Malware').

diagnostico(problema_windows_corrupto) :-
    sintoma(enciende, si),
    sintoma(pantalla_azul, si),
    sintoma(archivos_corruptos, si).
explicacion(problema_windows_corrupto, 
    'Archivos sistema Windows corruptos - Causa errores y crashes').
solucion(problema_windows_corrupto, 
    'REPARAR WINDOWS: 1) CMD admin: "sfc /scannow" (30+ min), 2) Si falla: "DISM /Online /Cleanup-Image /RestoreHealth", 
    3) Repetir sfc /scannow, 4) Si persiste: Reset Windows manteniendo archivos. COSTO: $0').
componente_afectado(problema_windows_corrupto, 'Windows/Sistema Operativo').

diagnostico(problema_fast_boot_causa_problemas) :-
    sintoma(enciende, si),
    sintoma(disco_detectado, intermitente),
    sintoma(usb_funciona, intermitente).
explicacion(problema_fast_boot_causa_problemas, 
    'Fast Boot causando problemas inicialización - Dispositivos no inicializan correctamente').
solucion(problema_fast_boot_causa_problemas, 
    'DESHABILITAR FAST BOOT: 1) BIOS → Fast Boot = Disabled, 2) Windows: Panel Control → Opciones Energía → 
    Cambiar comportamiento botones encendido → Desmarcar "Inicio rápido", 3) Restart completo. COSTO: $0').
componente_afectado(problema_fast_boot_causa_problemas, 'BIOS/Windows Configuración').

% ============================================================
% NIVEL 14: CASOS EDGE Y SÍNTOMAS ÚNICOS
% ============================================================

diagnostico(problema_coil_whine_psu_gpu) :-
    sintoma(enciende, si),
    (sintoma(zumbido_bobinas, si) ; sintoma(coil_whine_gpu, si)).
explicacion(problema_coil_whine_psu_gpu, 
    'Coil whine (zumbido bobinas) - Frecuencias resonantes en inductores, normal pero molesto').
solucion(problema_coil_whine_psu_gpu, 
    'MITIGAR: 1) Limitar FPS (reduce carga), 2) V-Sync activado, 3) PSU mejor calidad (menos ripple), 
    4) RMA si excesivamente fuerte. NO daña hardware. WORKAROUND: Audífonos. COSTO: $0 o $80-200 USD PSU nueva').
componente_afectado(problema_coil_whine_psu_gpu, 'PSU/GPU - Normal').

diagnostico(problema_screen_tearing) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, si),
    sintoma(screen_tearing, si).
explicacion(problema_screen_tearing, 
    'Screen tearing - GPU renderiza más FPS que refresh rate monitor').
solucion(problema_screen_tearing, 
    'SOLUCIONES: 1) V-Sync activado (input lag leve), 2) G-Sync/FreeSync si compatible, 
    3) Limitar FPS ligeramente bajo refresh rate monitor, 4) Triple buffering. 
    HARDWARE: Monitor G-Sync/FreeSync soluciona definitivamente. COSTO: $0-300 USD monitor nuevo').
componente_afectado(problema_screen_tearing, 'GPU/Monitor').

diagnostico(problema_no_signal_monitor) :-
    sintoma(enciende, si),
    sintoma(mensaje_no_signal, si).
explicacion(problema_no_signal_monitor, 
    'Monitor muestra "No Signal" - Problema conexión video o configuración').
solucion(problema_no_signal_monitor, 
    'VERIFICAR: 1) Monitor conectado a GPU (NO motherboard si hay GPU dedicada), 
    2) Cable video firmemente conectado ambos lados, 3) Entrada monitor correcta (HDMI/DP), 
    4) Monitor encendido, 5) Probar otro cable/puerto. COSTO: $0-20 USD cable nuevo').
componente_afectado(problema_no_signal_monitor, 'GPU/Monitor/Cable').

diagnostico(problema_resolucion_incorrecta) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, si),
    sintoma(resolucion_incorrecta, si).
explicacion(problema_resolucion_incorrecta, 
    'Resolución pantalla incorrecta o borrosa - Driver o configuración Windows').
solucion(problema_resolucion_incorrecta, 
    'CORREGIR: 1) Click derecho escritorio → Display Settings → Resolución nativa monitor, 
    2) Scaling 100%, 3) Drivers GPU actualizados, 4) Cable calidad (HDMI 2.0+ o DP 1.4+ para 4K). 
    COSTO: $0 o $15-30 USD cable premium').
componente_afectado(problema_resolucion_incorrecta, 'GPU/Windows/Monitor').

diagnostico(problema_colores_distorsionados) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, si),
    sintoma(colores_distorsionados, si).
explicacion(problema_colores_distorsionados, 
    'Colores incorrectos o invertidos - Cable mal conectado o configuración RGB/YCbCr').
solucion(problema_colores_distorsionados, 
    'VERIFICAR: 1) Cable video firmemente conectado, 2) Drivers GPU actualizados, 
    3) Control Panel NVIDIA/AMD → Color Settings → RGB Full Range, 4) Monitor color profile correcto Windows. 
    Si persiste: Cable defectuoso o GPU/monitor dañado. COSTO: $0-30 USD cable nuevo').
componente_afectado(problema_colores_distorsionados, 'GPU/Monitor/Cable').

diagnostico(problema_parpadeo_pantalla) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, si),
    sintoma(parpadeo_pantalla, si).
explicacion(problema_parpadeo_pantalla, 
    'Pantalla parpadea o titila - Problema refresh rate, cable o GPU').
solucion(problema_parpadeo_pantalla, 
    'SOLUCIONES: 1) Ajustar refresh rate Windows (60Hz/144Hz según monitor), 
    2) Cable HDMI/DP certificado, 3) Deshabilitar G-Sync/FreeSync temporalmente, 
    4) Drivers GPU actualizados. COSTO: $0 o $15-40 USD cable certificado').
componente_afectado(problema_parpadeo_pantalla, 'GPU/Monitor/Cable').

diagnostico(problema_microfono_no_funciona) :-
    sintoma(enciende, si),
    sintoma(microfono_funciona, no).
explicacion(problema_microfono_no_funciona, 'Micrófono no detectado o no funciona - Problema permisos o hardware').
solucion(problema_microfono_no_funciona, 
    'VERIFICAR: 1) Windows Privacy → Microphone → Allow apps, 2) Sound Settings → Input device correcto, 
    3) Probar micrófono en otro dispositivo, 4) Drivers audio actualizados. COSTO: $0 o $20-60 USD micrófono USB').
componente_afectado(problema_microfono_no_funciona, 'Audio/Micrófono').

diagnostico(problema_nivel_audio_bajo) :-
    sintoma(enciende, si),
    sintoma(audio_funciona, si),
    sintoma(nivel_audio_bajo, si).
explicacion(problema_nivel_audio_bajo, 
    'Volumen muy bajo al máximo - Problema configuración o amplificación insuficiente').
solucion(problema_nivel_audio_bajo, 
    'SOLUCIONES: 1) Sound Settings → Device Properties → Volumen 100%, 2) Audio enhancements → Loudness Equalization, 
    3) Actualizar drivers audio, 4) Amplificador/DAC externo si impedancia audífonos alta. COSTO: $0 o $50-150 USD DAC/amp').
componente_afectado(problema_nivel_audio_bajo, 'Audio/Configuración').

diagnostico(problema_detectado_consultar_tecnico) :-
    sintoma(_, _),
    \+ diagnostico(componente_quemado_critico),
    \+ diagnostico(fallo_electrico_severo),
    \+ diagnostico(problema_hardware_no_especificado).
explicacion(problema_detectado_consultar_tecnico, 
    'Problema detectado que requiere evaluación técnica profesional - Caso complejo o poco común').
solucion(problema_detectado_consultar_tecnico, 
    'RECOMENDACIÓN: Consultar técnico certificado para diagnóstico en persona. 
    Preparar: 1) Lista síntomas detallada, 2) Historial cambios recientes, 3) Logs Event Viewer, 
    4) Resultados stress tests si aplicable. CONSULTA: $30-60 USD diagnóstico. COSTO REPARACIÓN: Variable').

componente_afectado(problema_detectado_consultar_tecnico, 'Requiere Evaluación Profesional').


% ========================================
% PSU - 14 DIAGNÓSTICOS ESPECÍFICOS
% ========================================

diagnostico(psu_rail_12v_totalmente_muerto) :-
    sintoma(enciende, no),
    sintoma(led_power, no),
    sintoma(ventiladores, no),
    sintoma(olor_quemado, no),
    sintoma(chispa_electrica, no).
explicacion(psu_rail_12v_totalmente_muerto, 'Rail 12V PSU completamente muerto - Sin voltaje en CPU, GPU, ventiladores').
solucion(psu_rail_12v_totalmente_muerto, 'MEDIR con multímetro: Conector 24-pin pin 10 (+12V) - Debe mostrar 11.4-12.6V. Si 0V: Reemplazar PSU inmediatamente. COSTO: $60-200 USD').
componente_afectado(psu_rail_12v_totalmente_muerto, 'PSU').

diagnostico(psu_rail_5v_standby_muerto) :-
    sintoma(enciende, no),
    sintoma(led_power, no),
    sintoma(ventiladores, no).
explicacion(psu_rail_5v_standby_muerto, 'Rail 5VSB (standby) muerto - No hay poder para botón de encendido').
solucion(psu_rail_5v_standby_muerto, 'MEDIR: Pin 9 del conector 24-pin (+5VSB) - Debe ser 4.75-5.25V. Test: Puentear pin 16 (PS_ON) a tierra (pin 17-18). Si no enciende: PSU muerta. COSTO: $60-200 USD').
componente_afectado(psu_rail_5v_standby_muerto, 'PSU').

diagnostico(psu_voltaje_inestable_12v) :-
    sintoma(enciende, si),
    sintoma(voltaje_inestable, si),
    sintoma(reinicios_aleatorios, si).
explicacion(psu_voltaje_inestable_12v, 'Rail 12V oscila entre 10V-14V - Capacitores de filtro agotados').
solucion(psu_voltaje_inestable_12v, 'MEDIR ripple con osciloscopio >50mV pico-pico. Reemplazar capacitores electrolíticos 2200uF 16V o PSU completa. URGENCIA: ALTA. COSTO: $60-200 USD').
componente_afectado(psu_voltaje_inestable_12v, 'PSU').

diagnostico(psu_overcurrent_protection) :-
    sintoma(enciende, si),
    sintoma(enciende, no),
    sintoma(ventiladores, si).
explicacion(psu_overcurrent_protection, 'Protección OCP activada - Exceso de corriente en algún rail').
solucion(psu_overcurrent_protection, 'DESCONECTAR todos los dispositivos. Probar PSU sola (paperclip test). Conectar uno por uno hasta identificar componente en corto. GPU y motherboard comunes. COSTO: Variable').
componente_afectado(psu_overcurrent_protection, 'PSU/Componente en corto').

diagnostico(psu_power_good_signal_fallo) :-
    sintoma(enciende, si),
    sintoma(ventiladores, si),
    sintoma(pantalla_enciende, no),
    sintoma(pitidos_post, no).
explicacion(psu_power_good_signal_fallo, 'Señal Power Good no se genera - Motherboard no recibe señal de "todo OK"').
solucion(psu_power_good_signal_fallo, 'MEDIR: Pin 8 del conector 24-pin (PWR_OK) - Debe ser 3-5V después de 100-500ms del encendido. Si 0V: PSU defectuosa. COSTO: $60-200 USD PSU nueva').
componente_afectado(psu_power_good_signal_fallo, 'PSU').

diagnostico(psu_ventilador_bloqueado_polvo) :-
    sintoma(enciende, si),
    sintoma(sobrecalentamiento, si),
    sintoma(polvo_acumulado, si),
    sintoma(olor_quemado, no).
explicacion(psu_ventilador_bloqueado_polvo, 'Ventilador PSU bloqueado por polvo - Sobrecalentamiento interno').
solucion(psu_ventilador_bloqueado_polvo, 'LIMPIAR PSU con aire comprimido. ATENCIÓN: Capacitores pueden mantener carga mortal. Si no gira: Reemplazar ventilador 120/140mm. COSTO: $10-30 USD').
componente_afectado(psu_ventilador_bloqueado_polvo, 'PSU').

diagnostico(psu_capacitores_hinchados_visibles) :-
    sintoma(enciende, si),
    sintoma(olor_quemado, si),
    sintoma(reinicios_aleatorios, si).
explicacion(psu_capacitores_hinchados_visibles, 'Capacitores electrolíticos hinchados o con fugas - Filtrado insuficiente').
solucion(psu_capacitores_hinchados_visibles, 'INSPECCIONAR visualmente capacitores en PCB PSU. Buscar tops hinchados, bases con residuos marrones. Reemplazar con mismos valores (uF, V, temperatura). COSTO: $60-200 USD PSU nueva').
componente_afectado(psu_capacitores_hinchados_visibles, 'PSU').

diagnostico(psu_ripple_excesivo) :-
    sintoma(enciende, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(congelamientos, si).
explicacion(psu_ripple_excesivo, 'Ripple excesivo en voltajes - Afecta estabilidad de componentes').
solucion(psu_ripple_excesivo, 'MEDIR con osciloscopio ripple en rails 12V/5V/3.3V. Si >50mV: PSU defectuosa. Reemplazar con PSU de mejor calidad (Tier B o superior). COSTO: $80-200 USD').
componente_afectado(psu_ripple_excesivo, 'PSU').

diagnostico(psu_potencia_insuficiente) :-
    sintoma(enciende, si),
    sintoma(gpu_detectada, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(sobrecalentamiento, no).
explicacion(psu_potencia_insuficiente, 'PSU sin potencia suficiente - Se apaga bajo carga (juegos, renders)').
solucion(psu_potencia_insuficiente, 'CALCULAR consumo: GPU high-end (250-450W) + CPU (65-250W) + resto (100W). PSU debe tener 20-30% margen. EJEMPLO: RTX 4070 (200W) + Ryzen 7 (105W) + 100W = 405W → Necesita PSU 550W mínimo. COSTO: $80-200 USD').
componente_afectado(psu_potencia_insuficiente, 'PSU').

diagnostico(psu_ocp_activado) :-
    sintoma(enciende, no),
    sintoma(ventiladores, si).
explicacion(psu_ocp_activado, 'Protección OCP (Over Current Protection) activándose - Algún componente demanda corriente excesiva').
solucion(psu_ocp_activado, 'DIAGNÓSTICO: Desconectar componentes uno por uno y probar. ORDEN: 1) GPU, 2) Discos secundarios, 3) RAM adicional, 4) Periféricos USB. Componente que causa apagado = corto o falla. COMÚN: GPU con VRM dañado, disco en corto').
componente_afectado(psu_ocp_activado, 'PSU/Componente en corto').


diagnostico(psu_modular_conector_flojo) :-
    sintoma(enciende, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(pantalla_enciende, intermitente).
explicacion(psu_modular_conector_flojo, 'Conectores modulares flojos - Conexión intermitente').
solucion(psu_modular_conector_flojo, 'VERIFICAR que todos los cables modulares estén completamente insertados en PSU. Reconectar firmemente. Si persiste: Cables defectuosos. COSTO: $20-40 USD cables nuevos').
componente_afectado(psu_modular_conector_flojo, 'PSU/Cables').

diagnostico(psu_cable_cpu_danado) :-
    sintoma(enciende, si),
    sintoma(cpu_reconocido_correctamente, no),
    sintoma(olor_quemado, no).
explicacion(psu_cable_cpu_danado, 'Cable EPS 12V CPU dañado - CPU no recibe poder estable').
solucion(psu_cable_cpu_danado, 'VERIFICAR cable EPS 4+4 pin conectado a CPU_PWR. Probar con otro cable si PSU modular. Buscar daño físico en cable. COSTO: $15-30 USD cable nuevo').
componente_afectado(psu_cable_cpu_danado, 'PSU/Cables').

diagnostico(psu_cable_pcie_insuficiente) :-
    sintoma(enciende, si),
    sintoma(gpu_detectada, no),
    sintoma(pantalla_enciende, no).
explicacion(psu_cable_pcie_insuficiente, 'Cables PCIe GPU insuficientes o no conectados').
solucion(psu_cable_pcie_insuficiente, 'VERIFICAR que TODOS los conectores PCIe requeridos estén conectados. GPUs high-end requieren 2-3 cables separados (NO daisy-chain). EJEMPLO: RTX 4080 = 3x 8-pin. COSTO: $0 si solo reconectar').
componente_afectado(psu_cable_pcie_insuficiente, 'PSU/GPU').

diagnostico(psu_ovp_activado) :-
    sintoma(enciende, no),
    sintoma(tormenta_electrica, si).
explicacion(psu_ovp_activado, 'Protección OVP (Over Voltage Protection) activada por sobretensión').
solucion(psu_ovp_activado, 'Desconectar PSU 30 minutos para reset protección. Si no enciende: PSU protegió sistema correctamente pero puede estar dañada. VERIFICAR otros componentes. COSTO: $60-200 USD PSU nueva').
componente_afectado(psu_ovp_activado, 'PSU').

% ========================================
% MOTHERBOARD - 35 DIAGNÓSTICOS
% ========================================

diagnostico(mobo_muerte_total) :-
    sintoma(enciende, no),
    sintoma(led_power, no),
    sintoma(ventiladores, no),
    sintoma(olor_quemado, si),
    sintoma(componente_quemado_visible, si).
explicacion(mobo_muerte_total, 'Motherboard completamente muerta - Sin señales de vida').
solucion(mobo_muerte_total, 'VERIFICAR: 1) PSU funcional (paperclip test), 2) Componentes visiblemente quemados, 3) Olor a quemado. Si motherboard quemada: REEMPLAZO necesario. COSTO: $100-400 USD').
componente_afectado(mobo_muerte_total, 'Motherboard').

diagnostico(mobo_cortocircuito_standoffs) :-
    sintoma(enciende, no),
    sintoma(chispa_electrica, si),
    sintoma(componente_quemado_visible, no).
explicacion(mobo_cortocircuito_standoffs, 'Cortocircuito por standoff extra - PCB hace contacto con chasis').
solucion(mobo_cortocircuito_standoffs, 'REMOVER motherboard del case. Verificar que solo hay standoffs en agujeros de montaje. Probar motherboard fuera del case sobre superficie aislante. COSTO: $0 si no hay daño').
componente_afectado(mobo_cortocircuito_standoffs, 'Motherboard').

diagnostico(mobo_bateria_cmos_muerta) :-
    sintoma(enciende, si),
    sintoma(fecha_hora_resetea, si),
    sintoma(configuracion_bios_se_pierde, si).
explicacion(mobo_bateria_cmos_muerta, 'Batería CR2032 agotada - No mantiene configuración CMOS').
solucion(mobo_bateria_cmos_muerta, 'REEMPLAZAR batería CR2032. Verificar voltaje > 3.0V con multímetro. Resetear BIOS después del reemplazo. Configurar fecha/hora y settings. COSTO: $3-5 USD').
componente_afectado(mobo_bateria_cmos_muerta, 'Motherboard').

diagnostico(mobo_bios_corrupta) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, no),
    sintoma(pitidos_post, no),
    sintoma(led_power, si).
explicacion(mobo_bios_corrupta, 'BIOS/UEFI corrupta - No pasa POST, no hay beep codes').
solucion(mobo_bios_corrupta, 'USAR BIOS recovery: Botón Flash BIOS (si disponible), o reprogramar chip BIOS con hardware CH341A. Verificar versión compatible con CPU. COSTO: $0-50 USD si DIY').
componente_afectado(mobo_bios_corrupta, 'Motherboard').

diagnostico(mobo_bios_desactualizada_cpu) :-
    sintoma(enciende, si),
    sintoma(cpu_reconocido_correctamente, no),
    sintoma(recientemente_instalo_hardware, si).
explicacion(mobo_bios_desactualizada_cpu, 'BIOS no soporta CPU instalado - Requiere actualización').
solucion(mobo_bios_desactualizada_cpu, 'ACTUALIZAR BIOS con CPU compatible viejo. Usar Q-Flash Plus/BIOS Flashback si disponible, o CPU loaner program de fabricante. EJEMPLO: Ryzen 5000 necesita BIOS específico en B450. COSTO: $0').
componente_afectado(mobo_bios_desactualizada_cpu, 'Motherboard/CPU').

diagnostico(mobo_slot_ram_muerto) :-
    sintoma(enciende, si),
    sintoma(ram_detectada, parcial),
    sintoma(memtest_errores, si).
explicacion(mobo_slot_ram_muerto, 'Slot DIMM físico dañado - Pines doblados o trazas rotas').
solucion(mobo_slot_ram_muerto, 'PROBAR mismos módulos en diferentes slots. Si errores persisten en mismo slot físico: Slot dañado. Usar otros slots o reemplazar motherboard. COSTO: $100-400 USD motherboard nueva').
componente_afectado(mobo_slot_ram_muerto, 'Motherboard').

diagnostico(mobo_controlador_ram_danado) :-
    sintoma(enciende, si),
    sintoma(ram_detectada, no),
    sintoma(pitidos_post, si),
    sintoma(patron_pitidos, 3).
explicacion(mobo_controlador_ram_danado, 'Controlador memoria motherboard dañado - No detecta RAM funcional').
solucion(mobo_controlador_ram_danado, 'PROBAR RAM conocida funcional en todos los slots. Si ninguno detecta: Controlador motherboard muerto. REEMPLAZO motherboard necesario. COSTO: $100-400 USD').
componente_afectado(mobo_controlador_ram_danado, 'Motherboard').

diagnostico(mobo_slot_pcie_x16_muerto) :-
    sintoma(enciende, si),
    sintoma(gpu_detectada, no),
    sintoma(slots_pcie_funcionan, no).
explicacion(mobo_slot_pcie_x16_muerto, 'Slot PCIe x16 muerto - GPU no detectada en slot principal').
solucion(mobo_slot_pcie_x16_muerto, 'PROBAR GPU en otro slot PCIe x16 (si disponible). Verificar pines slot no doblados. Si GPU funciona en otro slot: Slot principal muerto. COSTO: $100-400 USD motherboard nueva').
componente_afectado(mobo_slot_pcie_x16_muerto, 'Motherboard').

diagnostico(mobo_puertos_sata_muertos) :-
    sintoma(enciende, si),
    sintoma(disco_detectado, no),
    sintoma(sata_ports_funcionan, no).
explicacion(mobo_puertos_sata_muertos, 'Puertos SATA no funcionan - Discos no detectados').
solucion(mobo_puertos_sata_muertos, 'PROBAR disco en todos los puertos SATA. Verificar cables. Si ningún puerto funciona: Controlador SATA muerto. Usar adaptador PCIe SATA o reemplazar motherboard. COSTO: $25-400 USD').
componente_afectado(mobo_puertos_sata_muertos, 'Motherboard').

diagnostico(mobo_slot_m2_muerto) :-
    sintoma(enciende, si),
    sintoma(ssd_no_reconocido, si),
    sintoma(m2_slot_funciona, no).
explicacion(mobo_slot_m2_muerto, 'Slot M.2 no funciona - SSD NVMe no detectado').
solucion(mobo_slot_m2_muerto, 'PROBAR SSD en otro slot M.2 (si disponible). Verificar BIOS tiene M.2 habilitado. Actualizar BIOS. Si persiste: Slot muerto. COSTO: $25-400 USD adaptador o motherboard').
componente_afectado(mobo_slot_m2_muerto, 'Motherboard').

diagnostico(mobo_chipset_sobrecalentado) :-
    sintoma(enciende, si),
    sintoma(sobrecalentamiento, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(polvo_acumulado, si).
explicacion(mobo_chipset_sobrecalentado, 'Chipset sobrecalentado - >90°C causa throttling e inestabilidad').
solucion(mobo_chipset_sobrecalentado, 'AGREGAR heatsink a chipset o mejorar existente. Limpiar polvo. Agregar ventilador directo si necesario. Monitorear temperatura con HWiNFO64. COSTO: $10-30 USD heatsink').
componente_afectado(mobo_chipset_sobrecalentado, 'Motherboard').

diagnostico(mobo_vrm_sobrecalentado) :-
    sintoma(enciende, si),
    sintoma(cpu_throttling, si),
    sintoma(sobrecalentamiento, si),
    sintoma(temp_cpu_carga, no).
explicacion(mobo_vrm_sobrecalentado, 'VRM motherboard sobrecalentado - MOSFETs > 100°C, throttling CPU').
solucion(mobo_vrm_sobrecalentado, 'MEJORAR refrigeración VRM: Instalar heatsinks en MOSFETs, agregar ventilador directo, reducir voltaje CPU, upgrade motherboard con mejor VRM. COSTO: $10-400 USD').
componente_afectado(mobo_vrm_sobrecalentado, 'Motherboard').

diagnostico(mobo_capacitores_hinchados) :-
    sintoma(enciende, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(voltaje_inestable, si).
explicacion(mobo_capacitores_hinchados, 'Capacitores VRM hinchados/fugando - Filtrado insuficiente, ripple excesivo').
solucion(mobo_capacitores_hinchados, 'INSPECCIONAR capacitores cerca socket CPU y VRM. Reemplazar con mismos valores (uF, V, low ESR). Requiere soldadura SMD profesional. COSTO: $50-200 USD reparación o motherboard nueva').
componente_afectado(mobo_capacitores_hinchados, 'Motherboard').

diagnostico(mobo_puertos_usb_quemados) :-
    sintoma(enciende, si),
    sintoma(usb_funciona, no),
    sintoma(olor_quemado, si).
explicacion(mobo_puertos_usb_quemados, 'Puertos USB quemados por cortocircuito - Dispositivo USB defectuoso causó daño').
solucion(mobo_puertos_usb_quemados, 'IDENTIFICAR puerto dañado. Deshabilitar en BIOS si posible. Usar tarjeta PCIe USB para puertos adicionales. COSTO: $20-50 USD tarjeta USB').
componente_afectado(mobo_puertos_usb_quemados, 'Motherboard').

diagnostico(mobo_controlador_red_muerto) :-
    sintoma(enciende, si),
    sintoma(red_funciona, no),
    sintoma(ethernet_funciona, no),
    sintoma(led_ethernet_parpadea, no).
explicacion(mobo_controlador_red_muerto, 'Controlador red integrado (Intel/Realtek) muerto - Generalmente por sobretensión').
solucion(mobo_controlador_red_muerto, 'USAR adaptador PCIe network card (Intel i350) o USB Ethernet. Verificar drivers actualizados. Reparación generalmente no económica. COSTO: $25-60 USD adaptador').
componente_afectado(mobo_controlador_red_muerto, 'Motherboard').

diagnostico(mobo_audio_codec_muerto) :-
    sintoma(enciende, si),
    sintoma(audio_funciona, no),
    sintoma(crackling_audio, si).
explicacion(mobo_audio_codec_muerto, 'Chip audio integrado (Realtek ALC) dañado - Generalmente por corto en jack 3.5mm').
solucion(mobo_audio_codec_muerto, 'USAR audio externo: Tarjeta PCIe sound card o DAC USB. Deshabilitar audio integrado en BIOS. Reparación chip requiere microsoldadura. COSTO: $30-80 USD tarjeta audio').
componente_afectado(mobo_audio_codec_muerto, 'Motherboard').

diagnostico(mobo_socket_cpu_pines_doblados_amd) :-
    sintoma(enciende, si),
    sintoma(cpu_reconocido_correctamente, no),
    sintoma(recientemente_instalo_hardware, si).
explicacion(mobo_socket_cpu_pines_doblados_amd, 'Socket AMD con pines doblados - CPU no hace contacto correcto').
solucion(mobo_socket_cpu_pines_doblados_amd, 'INSPECCIONAR socket con lupa. Enderezar pines con tarjeta plástica o aguja mecánica. EXTREMO CUIDADO: Pines se rompen fácilmente. COSTO: $0-300 USD si requiere motherboard nueva').
componente_afectado(mobo_socket_cpu_pines_doblados_amd, 'Motherboard').

diagnostico(mobo_socket_lga_contactos_danados_intel) :-
    sintoma(enciende, si),
    sintoma(cpu_reconocido_correctamente, no),
    sintoma(nucleos_detectados, no).
explicacion(mobo_socket_lga_contactos_danados_intel, 'Socket Intel LGA con contactos dañados - Pins sucios u oxidados').
solucion(mobo_socket_lga_contactos_danados_intel, 'LIMPIAR contactos socket con alcohol isopropílico 99% y bastoncillo. NO usar objetos metálicos. Si contactos visiblemente dañados: Reemplazo motherboard. COSTO: $0-300 USD').
componente_afectado(mobo_socket_lga_contactos_danados_intel, 'Motherboard').

diagnostico(mobo_backplate_io_flojo) :-
    sintoma(enciende, si),
    sintoma(puertos_traseros_funcionan, intermitente).
explicacion(mobo_backplate_io_flojo, 'Backplate I/O flojo - Puertos traseros con conexión intermitente').
solucion(mobo_backplate_io_flojo, 'VERIFICAR que backplate I/O esté correctamente asentado. Reinstalar motherboard asegurando presión correcta. COSTO: $0').
componente_afectado(mobo_backplate_io_flojo, 'Motherboard').

diagnostico(mobo_traces_quemados) :-
    sintoma(enciende, si),
    sintoma(componente_quemado_visible, si),
    sintoma(tormenta_electrica, si).
explicacion(mobo_traces_quemados, 'Traces PCB quemados por sobretensión - Circuitos abiertos').
solucion(mobo_traces_quemados, 'INSPECCIONAR PCB con lupa bajo luz. Buscar traces quemados (líneas negras en PCB). Reparación requiere jumper wires y microsoldadura. Generalmente no económico. COSTO: $100-400 USD motherboard nueva').
componente_afectado(mobo_traces_quemados, 'Motherboard').

diagnostico(mobo_post_code_55) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, no),
    sintoma(ram_detectada, no).
explicacion(mobo_post_code_55, 'POST Code 55 - Fallo detección RAM').
solucion(mobo_post_code_55, 'VERIFICAR: 1) RAM correctamente instalada, 2) Probar un módulo a la vez, 3) Limpiar slots RAM, 4) Clear CMOS. Si persiste con RAM conocida funcional: Controlador RAM motherboard muerto. COSTO: $0-400 USD').
componente_afectado(mobo_post_code_55, 'Motherboard/RAM').

diagnostico(mobo_bios_loop_infinito) :-
    sintoma(enciende, si),
    sintoma(recientemente_actualizo_bios, si),
    sintoma(pantalla_enciende, intermitente).
explicacion(mobo_bios_loop_infinito, 'BIOS en loop infinito - Update fallido o corrupción').
solucion(mobo_bios_loop_infinito, 'CLEAR CMOS. Usar BIOS Flashback si disponible. Reprogramar chip BIOS con CH341A. ÚLTIMO RECURSO: RMA motherboard. COSTO: $0-50 USD si DIY').
componente_afectado(mobo_bios_loop_infinito, 'Motherboard').

diagnostico(mobo_rgb_fusion_conflicto) :-
    sintoma(enciende, si),
    sintoma(congelamientos, si),
    sintoma(recientemente_instalo_hardware, no),
    sintoma(recientemente_actualizo_drivers, si).
explicacion(mobo_rgb_fusion_conflicto, 'Software RGB causa conflictos - iCUE, Aura Sync, RGB Fusion conflictos').
solucion(mobo_rgb_fusion_conflicto, 'DESINSTALAR todo software RGB (iCUE, Aura, RGB Fusion). Probar estabilidad. Reinstalar uno por uno. Usar OpenRGB como alternativa unificada. COSTO: $0').
componente_afectado(mobo_rgb_fusion_conflicto, 'Software').

diagnostico(motherboard_bios_corruption) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, no),
    sintoma(pitidos_post, no).
explicacion(motherboard_bios_corruption, 'BIOS/UEFI corrupta - No pasa POST, sin códigos de error').
solucion(motherboard_bios_corruption, 'USAR BIOS recovery: Botón Flash BIOS, Q-Flash Plus, o reprogramar chip. COSTO: $0-50 USD').
componente_afectado(motherboard_cmos_battery_dead, 'Motherboard').

diagnostico(motherboard_cpu_compatibility_issue) :-
    sintoma(cpu_reconocido_correctamente, no),
    sintoma(recientemente_instalo_hardware, si),
    sintoma(bios_version_actualizada, no).
explicacion(motherboard_cpu_compatibility_issue, 'CPU incompatible con versión BIOS actual - Requiere actualización').
solucion(motherboard_cpu_compatibility_issue, 'ACTUALIZAR BIOS con CPU compatible o usar BIOS Flashback. COSTO: $0').
componente_afectado(motherboard_cpu_compatibility_issue, 'Motherboard/CPU').

diagnostico(motherboard_vrm_overheating) :-
    sintoma(cpu_throttling, si),
    sintoma(sobrecalentamiento, si),
    sintoma(temp_cpu_carga, no).
explicacion(motherboard_vrm_overheating, 'VRM motherboard sobrecalentado - Throttling CPU por falta de potencia estable').
solucion(motherboard_vrm_overheating, 'AGREGAR heatsinks VRM, ventilador directo, reducir voltaje CPU. COSTO: $10-50 USD').
componente_afectado(motherboard_vrm_overheating, 'Motherboard').

diagnostico(motherboard_vrm_capacitor_failure) :-
    sintoma(reinicios_aleatorios, si),
    sintoma(voltaje_inestable, si),
    sintoma(olor_quemado, si).
explicacion(motherboard_vrm_capacitor_failure, 'Capacitores VRM hinchados/fallidos - Ripple excesivo').
solucion(motherboard_vrm_capacitor_failure, 'REEMPLAZAR capacitores con soldadura SMD profesional o motherboard completa. COSTO: $50-400 USD').
componente_afectado(motherboard_vrm_capacitor_failure, 'Motherboard').

diagnostico(motherboard_usb_overcurrent_protection) :-
    sintoma(usb_funciona, no),
    sintoma(dispositivos_no_reconocidos, si).
explicacion(motherboard_usb_overcurrent_protection, 'Protección overcurrent USB activada - Cortocircuito en dispositivo USB').
solucion(motherboard_usb_overcurrent_protection, 'DESCONECTAR todos USB. Conectar uno por uno para identificar culpable. COSTO: $0').
componente_afectado(motherboard_usb_overcurrent_protection, 'Motherboard').

diagnostico(motherboard_audio_codec_failure) :-
    sintoma(audio_funciona, no),
    sintoma(audio_distorsionado, si),
    sintoma(crackling_audio, si).
explicacion(motherboard_audio_codec_failure, 'Codec audio integrado dañado - Generalmente por corto en jack 3.5mm').
solucion(motherboard_audio_codec_failure, 'USAR tarjeta audio PCIe o DAC USB. Deshabilitar audio integrado en BIOS. COSTO: $30-80 USD').
componente_afectado(motherboard_audio_codec_failure, 'Motherboard').

diagnostico(motherboard_network_controller_failure) :-
    sintoma(ethernet_funciona, no),
    sintoma(led_ethernet_parpadea, no),
    sintoma(driver_red_actualizado, si).
explicacion(motherboard_network_controller_failure, 'Controlador red integrado muerto - Sobretensión común').
solucion(motherboard_network_controller_failure, 'USAR adaptador PCIe o USB Ethernet. COSTO: $25-60 USD').
componente_afectado(motherboard_network_controller_failure, 'Motherboard').

diagnostico(motherboard_pcie_slot_wear) :-
    sintoma(gpu_detectada, intermitente),
    sintoma(artifactos_gpu, si),
    sintoma(slots_pcie_funcionan, parcial).
explicacion(motherboard_pcie_slot_wear, 'Slot PCIe desgastado por GPU pesada - Contactos flojos').
solucion(motherboard_pcie_slot_wear, 'USAR soporte anti-sag GPU. Probar otro slot PCIe. COSTO: $10-400 USD').
componente_afectado(motherboard_pcie_slot_wear, 'Motherboard').

diagnostico(motherboard_ram_slot_timing_issues) :-
    sintoma(memtest_errores, si),
    sintoma(xmp_activado, si),
    sintoma(dual_channel_activo, no).
explicacion(motherboard_ram_slot_timing_issues, 'Problemas timing entre slots RAM - Topología daisy chain vs T-topology').
solucion(motherboard_ram_slot_timing_issues, 'USAR slots A2+B2 para 2 módulos. Ajustar ProcODT, RTT en BIOS. COSTO: $0').
componente_afectado(motherboard_ram_slot_timing_issues, 'Motherboard').

diagnostico(motherboard_standoff_short_circuit) :-
    sintoma(enciende, no),
    sintoma(chispa_electrica, si),
    sintoma(componente_quemado_visible, no).
explicacion(motherboard_standoff_short_circuit, 'Cortocircuito por standoff extra - PCB toca chasis').
solucion(motherboard_standoff_short_circuit, 'REMOVER motherboard. Verificar standoffs solo en agujeros correctos. Probar fuera del case. COSTO: $0').
componente_afectado(motherboard_standoff_short_circuit, 'Motherboard').

% ========================================
% CPU - 30 DIAGNÓSTICOS
% ========================================

diagnostico(cpu_muerte_total) :-
    sintoma(enciende, si),
    sintoma(cpu_reconocido_correctamente, no),
    sintoma(nucleos_detectados, no),
    sintoma(olor_quemado, si).
explicacion(cpu_muerte_total, 'CPU completamente muerto - Daño físico irreparable').
solucion(cpu_muerte_total, 'REEMPLAZO CPU necesario. Verificar causa: Sobrevoltaje, sobrecalentamiento extremo, defecto de fábrica. COSTO: $150-600 USD CPU nuevo').
componente_afectado(cpu_muerte_total, 'CPU').

diagnostico(cpu_no_detectado_socket_sucio) :-
    sintoma(cpu_reconocido_correctamente, no),
    sintoma(enciende, si),
    sintoma(olor_quemado, no).
explicacion(cpu_no_detectado_socket_sucio, 'Socket CPU con pines/pads sucios u oxidados - Contacto eléctrico pobre').
solucion(cpu_no_detectado_socket_sucio, 'LIMPIAR: Intel LGA - pads CPU con alcohol isopropílico 99%. AMD PGA - pines socket con aire comprimido. NO usar líquidos en socket. COSTO: $0').
componente_afectado(cpu_no_detectado_socket_sucio, 'CPU/Motherboard').

diagnostico(cpu_pines_doblados_amd) :-
    sintoma(cpu_reconocido_correctamente, no),
    sintoma(nucleos_detectados, no),
    sintoma(recientemente_instalo_hardware, si).
explicacion(cpu_pines_doblados_amd, 'Pines doblados en CPU AMD - Contactos críticos sin conexión').
solucion(cpu_pines_doblados_amd, 'INSPECCIONAR con lupa. Enderezar con tarjeta plástica o aguja mecánica. EXTREMO CUIDADO: Pines se rompen fácilmente. COSTO: $0-300 USD si requiere CPU nuevo').
componente_afectado(cpu_pines_doblados_amd, 'CPU').

diagnostico(cpu_sobrecalentamiento_pasta_secada) :-
    sintoma(temp_cpu_idle, si),
    sintoma(temp_cpu_carga, si),
    sintoma(pasta_termica_vieja, si),
    sintoma(apagado_termico, si).
explicacion(cpu_sobrecalentamiento_pasta_secada, 'Pasta térmica completamente seca - Conductividad térmica <10% del original').
solucion(cpu_sobrecalentamiento_pasta_secada, 'REEMPLAZAR pasta térmica: Limpiar IHS y cooler con alcohol. Aplicar grano tamaño arveja. Montar cooler con presión uniforme. PASTA: Arctic MX-6, Thermal Grizzly Kryonaut. COSTO: $5-15 USD').
componente_afectado(cpu_sobrecalentamiento_pasta_secada, 'CPU/Cooler').

diagnostico(cpu_cooler_montaje_incorrecto) :-
    sintoma(temp_cpu_idle, si),
    sintoma(sobrecalentamiento, si),
    sintoma(recientemente_instalo_hardware, si),
    sintoma(pasta_termica_vieja, no).
explicacion(cpu_cooler_montaje_incorrecto, 'Cooler mal montado - Contacto irregular IHS/cooler').
solucion(cpu_cooler_montaje_incorrecto, 'REMONTAR cooler: Verificar que plástico protector fue removido. Apretar tornillos en patrón X cruzado. Presión uniforme. COSTO: $0').
componente_afectado(cpu_cooler_montaje_incorrecto, 'Cooler').

diagnostico(cpu_voltage_regulation_module_fallo) :-
    sintoma(cpu_throttling, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(frecuencia_cpu_correcta, no).
explicacion(cpu_voltage_regulation_module_fallo, 'VRM motherboard no puede mantener voltaje estable al CPU').
solucion(cpu_voltage_regulation_module_fallo, 'MONITOREAR voltajes con HWiNFO64. Si Vcore oscila >0.1V: Problema motherboard. Agregar ventilación a VRM o reducir consumo CPU. COSTO: $0-400 USD motherboard nueva').
componente_afectado(cpu_voltage_regulation_module_fallo, 'Motherboard/CPU').

diagnostico(cpu_degradacion_silicio) :-
    sintoma(congelamientos, si),
    sintoma(aplicaciones_crash, si),
    sintoma(reinicios_aleatorios, si).
explicacion(cpu_degradacion_silicio, 'Degradación por overclock/voltaje excesivo - Transistores internos dañados').
solucion(cpu_degradacion_silicio, 'REDUCIR frecuencia y voltaje a valores stock. Si persiste: CPU permanentemente dañado. REEMPLAZAR. Prevención: No exceder 1.4V en CPUs modernos. COSTO: $150-600 USD CPU nuevo').
componente_afectado(cpu_degradacion_silicio, 'CPU').

diagnostico(cpu_sobrecalentamiento_critico) :-
    sintoma(temp_cpu_carga, si),
    sintoma(apagado_termico, si),
    sintoma(sobrecalentamiento, si).
explicacion(cpu_sobrecalentamiento_critico, 'CPU en temperaturas críticas >100°C - Daño inminente').
solucion(cpu_sobrecalentamiento_critico, 'URGENTE: NO usar PC. VERIFICAR: 1) Cooler montado, 2) Pasta térmica, 3) Ventilador girando, 4) Airflow case. COSTO: $5-80 USD').
componente_afectado(cpu_sobrecalentamiento_critico, 'CPU/Cooler').

diagnostico(cpu_cooler_mal_montado) :-
    sintoma(temp_cpu_idle, si),
    sintoma(recientemente_instalo_hardware, si).
explicacion(cpu_cooler_mal_montado, 'Cooler instalado incorrectamente - Presión insuficiente o desigual').
solucion(cpu_cooler_mal_montado, 'REINSTALAR: Apretar tornillos en patrón cruzado X. Presión uniforme. Verificar brackets correctos. COSTO: $0').
componente_afectado(cpu_cooler_mal_montado, 'Cooler').

diagnostico(cpu_ihs_delaminado) :-
    sintoma(temp_cpu_carga, si),
    sintoma(apagado_termico, si),
    sintoma(pasta_termica_vieja, no).
explicacion(cpu_ihs_delaminado, 'IHS separado del die - TIM interno degradado (común en Intel Gen 8-10)').
solucion(cpu_ihs_delaminado, 'DELID CPU (proceso avanzado): Remover IHS, limpiar TIM viejo, aplicar metal líquido (Conductonaut). O RMA si bajo garantía. COSTO: $0-20 USD si DIY, $50-100 USD servicio').
componente_afectado(cpu_ihs_delaminado, 'CPU').

diagnostico(cpu_throttling_termico) :-
    sintoma(cpu_throttling, si),
    sintoma(temp_cpu_carga, si).
explicacion(cpu_throttling_termico, 'CPU reduciendo frecuencia por protección térmica - >85°C').
solucion(cpu_throttling_termico, 'MEJORAR refrigeración: Pasta térmica nueva, cooler más potente, airflow case. COSTO: $5-80 USD').
componente_afectado(cpu_throttling_termico, 'CPU/Cooler').

diagnostico(cpu_throttling_vrm) :-
    sintoma(cpu_throttling, si),
    sintoma(temp_cpu_carga, no),
    sintoma(sobrecalentamiento, si).
explicacion(cpu_throttling_vrm, 'Throttling por VRM sobrecalentado - No por temperatura CPU').
solucion(cpu_throttling_vrm, 'ENFRIAR VRM: Heatsinks, ventilador directo, reducir voltaje CPU. COSTO: $10-50 USD').
componente_afectado(cpu_throttling_vrm, 'Motherboard VRM').

diagnostico(cpu_nucleos_muertos) :-
    sintoma(nucleos_detectados, no),
    sintoma(cpu_reconocido_correctamente, si).
explicacion(cpu_nucleos_muertos, 'Núcleos/threads CPU no detectados - Daño físico en cores').
solucion(cpu_nucleos_muertos, 'VERIFICAR BIOS detecta todos cores. Si no: CPU dañado. REEMPLAZO necesario. COSTO: $150-600 USD CPU nuevo').
componente_afectado(cpu_nucleos_muertos, 'CPU').

diagnostico(cpu_cache_corrupta) :-
    sintoma(aplicaciones_crash, si),
    sintoma(congelamientos, si),
    sintoma(cpu_reconocido_correctamente, si).
explicacion(cpu_cache_corrupta, 'Cache L2/L3 CPU corrupta - Errores intermitentes').
solucion(cpu_cache_corrupta, 'TEST: Prime95 Small FFTs, stress test cache. Si falla: CPU defectuoso. REEMPLAZO bajo garantía si aplica. COSTO: $150-600 USD CPU nuevo').
componente_afectado(cpu_cache_corrupta, 'CPU').

diagnostico(cpu_degradacion_electromigracion) :-
    sintoma(congelamientos, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(frecuencia_cpu_correcta, no).
explicacion(cpu_degradacion_electromigracion, 'Electromigración por voltaje alto prolongado - Átomos metal migran, circuitos se degradan').
solucion(cpu_degradacion_electromigracion, 'REDUCIR voltaje y frecuencia a stock. Si inestable en stock: CPU permanentemente dañado. REEMPLAZAR. COSTO: $150-600 USD').
componente_afectado(cpu_degradacion_electromigracion, 'CPU').

diagnostico(cpu_pads_danados_intel) :-
    sintoma(cpu_reconocido_correctamente, no),
    sintoma(nucleos_detectados, no).
explicacion(cpu_pads_danados_intel, 'Pads contacto CPU Intel dañados - Instalación incorrecta repetida').
solucion(cpu_pads_danados_intel, 'INSPECCIONAR pads CPU con lupa. Si dañados: CPU irreparable. REEMPLAZAR. PREVENCIÓN: No forzar CPU en socket. COSTO: $150-600 USD CPU nuevo').
componente_afectado(cpu_pads_danados_intel, 'CPU').

diagnostico(cpu_imc_degradado) :-
    sintoma(memtest_errores, si),
    sintoma(ram_detectada, parcial),
    sintoma(xmp_activado, si).
explicacion(cpu_imc_degradado, 'Integrated Memory Controller degradado - No soporta frecuencias altas RAM').
solucion(cpu_imc_degradado, 'REDUCIR frecuencia RAM. Aumentar voltaje VCCSA/VCCIO (Intel) o VSOC (AMD). Si persiste: IMC dañado. COSTO: $150-600 USD CPU nuevo').
componente_afectado(cpu_imc_degradado, 'CPU').

diagnostico(cpu_avx_offset_insuficiente) :-
    sintoma(aplicaciones_crash, si),
    sintoma(uso_cpu_100, si),
    sintoma(temp_cpu_carga, si).
explicacion(cpu_avx_offset_insuficiente, 'AVX offset insuficiente para cargas AVX-512/AVX2 - Voltaje insuficiente bajo carga AVX').
solucion(cpu_avx_offset_insuficiente, 'AUMENTAR AVX offset en BIOS (reduce frecuencia en cargas AVX). O aumentar voltaje core. COSTO: $0').
componente_afectado(cpu_avx_offset_insuficiente, 'CPU/Configuración').

diagnostico(cpu_hyperthreading_inestable) :-
    sintoma(aplicaciones_crash, si),
    sintoma(nucleos_detectados, si).
explicacion(cpu_hyperthreading_inestable, 'Hyperthreading/SMT causando inestabilidad - Threads lógicos con errores').
solucion(cpu_hyperthreading_inestable, 'DESHABILITAR Hyperthreading/SMT en BIOS. Reduce performance ~15-25% pero mejora estabilidad. Si persiste: CPU defectuoso. COSTO: $0 o $150-600 USD CPU nuevo').
componente_afectado(cpu_hyperthreading_inestable, 'CPU').

diagnostico(cpu_voltaje_vdroop_excesivo) :-
    sintoma(cpu_throttling, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(frecuencia_cpu_correcta, no).
explicacion(cpu_voltaje_vdroop_excesivo, 'Vdroop excesivo - Voltaje CPU cae demasiado bajo carga').
solucion(cpu_voltaje_vdroop_excesivo, 'AJUSTAR Load Line Calibration (LLC) en BIOS a nivel medio (Level 4-6). No usar LLC extremo (daña VRM). COSTO: $0').
componente_afectado(cpu_voltaje_vdroop_excesivo, 'Motherboard VRM').

diagnostico(cpu_tjmax_alcanzado) :-
    sintoma(temp_cpu_carga, si),
    sintoma(apagado_termico, si),
    sintoma(cpu_throttling, si).
explicacion(cpu_tjmax_alcanzado, 'CPU alcanzó Tjmax (temperatura junction máxima) - Apagado térmico de emergencia').
solucion(cpu_tjmax_alcanzado, 'URGENTE: Mejorar refrigeración inmediatamente. Pasta térmica, cooler potente, airflow. CPU puede dañarse permanentemente. COSTO: $5-120 USD').
componente_afectado(cpu_tjmax_alcanzado, 'CPU/Cooler').

diagnostico(cpu_boost_no_funciona) :-
    sintoma(frecuencia_cpu_correcta, no),
    sintoma(cpu_reconocido_correctamente, si).
explicacion(cpu_boost_no_funciona, 'Turbo Boost/Precision Boost no activa - CPU stuck en frecuencia base').
solucion(cpu_boost_no_funciona, 'VERIFICAR BIOS: Turbo/Boost habilitado, power limits no restrictivos, temperaturas OK. Actualizar BIOS. COSTO: $0').
componente_afectado(cpu_boost_no_funciona, 'CPU/BIOS').

diagnostico(cpu_c_states_causan_crash) :-
    sintoma(congelamientos, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(cpu_reconocido_correctamente, si).
explicacion(cpu_c_states_causan_crash, 'C-States (estados ahorro energía) causan inestabilidad').
solucion(cpu_c_states_causan_crash, 'DESHABILITAR C-States en BIOS. Aumenta consumo idle pero mejora estabilidad. COSTO: $0').
componente_afectado(cpu_c_states_causan_crash, 'CPU/BIOS').

diagnostico(cpu_ring_ratio_desbalanceado) :-
    sintoma(aplicaciones_crash, si),
    sintoma(frecuencia_cpu_correcta, no).
explicacion(cpu_ring_ratio_desbalanceado, 'Ring/Uncore ratio mal configurado - Cache ratio vs core ratio desbalanceado').
solucion(cpu_ring_ratio_desbalanceado, 'AJUSTAR ring ratio en BIOS. Regla: Ring ratio = Core ratio - 300-500MHz. EJEMPLO: Core 5.0GHz → Ring 4.5-4.7GHz. COSTO: $0').
componente_afectado(cpu_ring_ratio_desbalanceado, 'CPU/Configuración').

% ========================================
% RAM - 30 DIAGNÓSTICOS
% ========================================

diagnostico(ram_modulo_completamente_muerto) :-
    sintoma(ram_detectada, no),
    sintoma(pitidos_post, si),
    sintoma(patron_pitidos, 3).
explicacion(ram_modulo_completamente_muerto, 'Módulo RAM completamente sin respuesta - No detectado en POST').
solucion(ram_modulo_completamente_muerto, 'PROBAR cada módulo individualmente en slot A2. Si ninguno detecta: Verificar voltaje DRAM en BIOS (1.2V JEDEC, 1.35V XMP). REEMPLAZAR módulo muerto. COSTO: $30-100 USD módulo nuevo').
componente_afectado(ram_modulo_completamente_muerto, 'RAM').

diagnostico(ram_slot_motherboard_danado) :-
    sintoma(ram_detectada, parcial),
    sintoma(memtest_errores, si).
explicacion(ram_slot_motherboard_danado, 'Slot DIMM físico dañado - Pines doblados o trazas rotas').
solucion(ram_slot_motherboard_danado, 'PROBAR mismos módulos en diferentes slots. Si errores persisten en mismo slot físico: Slot dañado. Usar otros slots. COSTO: $0 o $100-400 USD motherboard nueva').
componente_afectado(ram_slot_motherboard_danado, 'Motherboard').

diagnostico(ram_incompatible_jedec_profile) :-
    sintoma(ram_detectada, si),
    sintoma(ram_a_velocidad_maxima, no),
    sintoma(xmp_activado, no).
explicacion(ram_incompatible_jedec_profile, 'RAM corriendo a velocidad mínima (2133MHz) - Perfiles JEDEC no compatibles').
solucion(ram_incompatible_jedec_profile, 'ACTIVAR XMP/DOCP en BIOS. Si inestable: Configurar manualmente frecuencia, timings y voltaje según especificaciones. COSTO: $0').
componente_afectado(ram_incompatible_jedec_profile, 'RAM/BIOS').

diagnostico(ram_xmp_inestable_imc_debil) :-
    sintoma(xmp_activado, si),
    sintoma(memtest_errores, si),
    sintoma(reinicios_aleatorios, si).
explicacion(ram_xmp_inestable_imc_debil, 'Integrated Memory Controller no soporta frecuencia/timings XMP').
solucion(ram_xmp_inestable_imc_debil, 'REDUCIR frecuencia RAM en incrementos de 100MHz. Aumentar voltaje VCCSA/VDDQ (Intel) o VSOC (AMD) +0.05V. Probar estabilidad con TestMem5. COSTO: $0').
componente_afectado(ram_xmp_inestable_imc_debil, 'RAM/CPU IMC').

diagnostico(ram_timings_muy_apretados) :-
    sintoma(memtest_errores, si),
    sintoma(xmp_activado, si),
    sintoma(congelamientos, si).
explicacion(ram_timings_muy_apretados, 'Timings primarios (CL-tRCD-tRP-tRAS) demasiado agresivos para los chips').
solucion(ram_timings_muy_apretados, 'AFLOJAR timings: CL+2, tRCD+2, tRP+2, tRAS+4. EJEMPLO: CL16-18-18-38 → CL18-20-20-42. Verificar estabilidad. COSTO: $0').
componente_afectado(ram_timings_muy_apretados, 'RAM/Configuración').

diagnostico(ram_temperature_related_errors) :-
    sintoma(memtest_errores, si),
    sintoma(sobrecalentamiento, si),
    sintoma(congelamientos, si).
explicacion(ram_temperature_related_errors, 'RAM supera 50°C - Errores aumentan exponencialmente con temperatura').
solucion(ram_temperature_related_errors, 'INSTALAR heatsinks RAM o ventilador directo. Reducir voltaje DRAM si posible. Monitorear temp con HWiNFO64. COSTO: $10-30 USD').
componente_afectado(ram_temperature_related_errors, 'RAM').

diagnostico(ram_rank_interleave_problema) :-
    sintoma(dual_channel_activo, no),
    sintoma(ram_detectada, si).
explicacion(ram_rank_interleave_problema, 'Problema con interleaving entre ranks - Performance degradada').
solucion(ram_rank_interleave_problema, 'VERIFICAR manual motherboard slots correctos para configuración. Usar módulos idénticos. Mejorar flujo aire sobre RAM. COSTO: $0').
componente_afectado(ram_rank_interleave_problema, 'RAM/Configuración').

diagnostico(ram_power_delivery_insuficiente) :-
    sintoma(memtest_errores, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(xmp_activado, si).
explicacion(ram_power_delivery_insuficiente, 'Voltaje DRAM insuficiente bajo carga - Drops de voltaje').
solucion(ram_power_delivery_insuficiente, 'AUMENTAR voltaje DRAM de 1.35V a 1.40V (máximo seguro daily). Verificar con osciloscopio si hay droop. COSTO: $0').
componente_afectado(ram_power_delivery_insuficiente, 'RAM/Motherboard').

diagnostico(ram_refresh_rate_problema) :-
    sintoma(memtest_errores, si),
    sintoma(aplicaciones_crash, si).
explicacion(ram_refresh_rate_problema, 'tREFI demasiado alto - Celdas no se refrescan a tiempo').
solucion(ram_refresh_rate_problema, 'REDUCIR tREFI de 65535 a 32767 o menos. Aumentar tRFC proporcionalmente. Trade-off: menor latency vs mayor estabilidad. COSTO: $0').
componente_afectado(ram_refresh_rate_problema, 'RAM/Configuración').

diagnostico(ram_contactos_sucios) :-
    sintoma(ram_detectada, intermitente),
    sintoma(reinicios_aleatorios, si).
explicacion(ram_contactos_sucios, 'Contactos dorados oxidados/sucios - Resistencia eléctrica alta').
solucion(ram_contactos_sucios, 'LIMPIAR contactos con goma de borrar blanca y alcohol isopropílico 99%. Secar completamente antes de reinstalar. COSTO: $0').
componente_afectado(ram_contactos_sucios, 'RAM').

diagnostico(ram_errores_ecc) :-
    sintoma(memtest_errores, si),
    sintoma(aplicaciones_crash, si).
explicacion(ram_errores_ecc, 'RAM ECC detectando errores corregibles/no-corregibles').
solucion(ram_errores_ecc, 'VERIFICAR logs ECC en Event Viewer. Si errores frecuentes: REEMPLAZAR módulo. RAM ECC debe ser altamente confiable. COSTO: $60-200 USD módulo ECC').
componente_afectado(ram_errores_ecc, 'RAM ECC').

diagnostico(ram_xmp_inestable) :-
    sintoma(xmp_activado, si),
    sintoma(reinicios_aleatorios, si).
explicacion(ram_xmp_inestable, 'Perfil XMP causando inestabilidad - IMC CPU no soporta configuración').
solucion(ram_xmp_inestable, 'DESHABILITAR XMP. Reducir frecuencia manualmente (ej: 3600→3200 MHz). Aumentar voltaje DRAM a 1.40V. COSTO: $0').
componente_afectado(ram_xmp_inestable, 'RAM/CPU IMC').

diagnostico(ram_dual_channel_roto) :-
    sintoma(dual_channel_activo, no),
    sintoma(ram_detectada, si).
explicacion(ram_dual_channel_roto, 'Dual Channel no funciona - Performance reducida 30-50%').
solucion(ram_dual_channel_roto, 'USAR slots A2+B2 (segundo y cuarto desde CPU). Verificar Task Manager → Memory → Channels. COSTO: $0').
componente_afectado(ram_dual_channel_roto, 'RAM/Configuración').

diagnostico(ram_densidad_incompatible) :-
    sintoma(ram_detectada, parcial),
    sintoma(memtest_errores, no).
explicacion(ram_densidad_incompatible, 'Densidad RAM incompatible - Mixing diferentes capacidades causa problemas').
solucion(ram_densidad_incompatible, 'USAR módulos idénticos (mismo GB, frecuencia, marca). Si mixing necesario: Misma densidad en canales. COSTO: $30-100 USD módulos compatibles').
componente_afectado(ram_densidad_incompatible, 'RAM').

diagnostico(ram_voltaje_insuficiente) :-
    sintoma(memtest_errores, si),
    sintoma(xmp_activado, si).
explicacion(ram_voltaje_insuficiente, 'Voltaje DRAM insuficiente para frecuencia/timings configurados').
solucion(ram_voltaje_insuficiente, 'AUMENTAR voltaje DRAM: 1.35V→1.40V máximo seguro. Monitorear temperaturas RAM. COSTO: $0').
componente_afectado(ram_voltaje_insuficiente, 'RAM/Configuración').

diagnostico(ram_rank_mismatch) :-
    sintoma(memtest_errores, si),
    sintoma(dual_channel_activo, no).
explicacion(ram_rank_mismatch, 'Mixing single-rank y dual-rank - Problemas de timing').
solucion(ram_rank_mismatch, 'USAR módulos misma configuración rank. Verificar con Thaiphoon Burner. Ajustar timings manualmente. COSTO: $0 o $30-100 USD módulos compatibles').
componente_afectado(ram_rank_mismatch, 'RAM').

diagnostico(ram_subtimings_mal_configurados) :-
    sintoma(memtest_errores, si),
    sintoma(congelamientos, si).
explicacion(ram_subtimings_mal_configurados, 'Subtimings secundarios mal configurados - tRFC, tREFI problemáticos').
solucion(ram_subtimings_mal_configurados, 'USAR calculator DRAM (Ryzen DRAM Calculator). Aplicar timings SAFE preset. COSTO: $0').
componente_afectado(ram_subtimings_mal_configurados, 'RAM/Configuración').

diagnostico(ram_procodt_incorrecto) :-
    sintoma(memtest_errores, si),
    sintoma(xmp_activado, si).
explicacion(ram_procodt_incorrecto, 'ProcODT (AMD) incorrecto - Impedancia no optimizada').
solucion(ram_procodt_incorrecto, 'AJUSTAR ProcODT en BIOS: 40-60 ohm típico. Usar DRAM Calculator para valor recomendado. COSTO: $0').
componente_afectado(ram_procodt_incorrecto, 'RAM/Configuración AMD').

diagnostico(ram_gear_mode_incorrecto) :-
    sintoma(memtest_errores, si),
    sintoma(ram_a_velocidad_maxima, no).
explicacion(ram_gear_mode_incorrecto, 'Gear Mode (Intel) incorrecto - Gear 1 vs Gear 2 stability').
solucion(ram_gear_mode_incorrecto, 'Intel 11th+ gen: >3600MHz usar Gear 2. <3600MHz Gear 1. Ajustar en BIOS. COSTO: $0').
componente_afectado(ram_gear_mode_incorrecto, 'RAM/Configuración Intel').

diagnostico(ram_command_rate_incorrecto) :-
    sintoma(memtest_errores, si).
explicacion(ram_command_rate_incorrecto, 'Command Rate (CR) 1T vs 2T - 1T más rápido pero menos estable').
solucion(ram_command_rate_incorrecto, 'CAMBIAR Command Rate a 2T en BIOS. Sacrifica ~1-2ns latencia por estabilidad. COSTO: $0').
componente_afectado(ram_command_rate_incorrecto, 'RAM/Configuración').

diagnostico(ram_rowhammer_bit_flips) :-
    sintoma(memtest_errores, si),
    sintoma(aplicaciones_crash, si),
    sintoma(archivos_corruptos, si).
explicacion(ram_rowhammer_bit_flips, 'Rowhammer vulnerability - Bit flips por acceso repetido a filas adyacentes').
solucion(ram_rowhammer_bit_flips, 'AUMENTAR tREFI refresh rate. Reducir tRFC. Actualizar BIOS (mitigaciones). REEMPLAZAR RAM si vulnerable. COSTO: $30-100 USD RAM nueva').
componente_afectado(ram_rowhammer_bit_flips, 'RAM').

diagnostico(ram_slot_retencion_rota) :-
    sintoma(ram_detectada, intermitente),
    sintoma(reinicios_aleatorios, si).
explicacion(ram_slot_retencion_rota, 'Retención slot RAM rota - Módulo no queda firmemente insertado').
solucion(ram_slot_retencion_rota, 'VERIFICAR clips laterales DIMM hacen click. Si rotos: Usar otro slot o reemplazar motherboard. Tape NO recomendado. COSTO: $0-400 USD').
componente_afectado(ram_slot_retencion_rota, 'Motherboard').

diagnostico(ram_chips_ic_diferentes) :-
    sintoma(memtest_errores, si),
    sintoma(xmp_activado, si).
explicacion(ram_chips_ic_diferentes, 'Mixing diferentes ICs RAM - Samsung B-Die vs Hynix vs Micron incompatibles').
solucion(ram_chips_ic_diferentes, 'USAR módulos mismo IC chip. Verificar con Thaiphoon Burner. REEMPLAZAR con kit matched. COSTO: $60-200 USD kit matched').
componente_afectado(ram_chips_ic_diferentes, 'RAM').

diagnostico(ram_revision_diferente) :-
    sintoma(memtest_errores, si),
    sintoma(dual_channel_activo, si).
explicacion(ram_revision_diferente, 'Mixing diferentes revisiones mismo modelo RAM - Bins diferentes').
solucion(ram_revision_diferente, 'USAR módulos misma revisión/bin. Comprar kits pre-matched (2x8GB vs 2x 1x8GB separados). COSTO: $60-200 USD kit matched').
componente_afectado(ram_revision_diferente, 'RAM').

diagnostico(ram_b_die_degradado) :-
    sintoma(memtest_errores, si),
    sintoma(xmp_activado, si),
    sintoma(ram_a_velocidad_maxima, no).
explicacion(ram_b_die_degradado, 'Samsung B-Die degradado por voltaje alto prolongado - Performance reducida').
solucion(ram_b_die_degradado, 'REDUCIR voltaje a 1.35V. Aflojar timings. Si inestable en stock: B-Die muerto, REEMPLAZAR. COSTO: $80-200 USD RAM nueva').
componente_afectado(ram_b_die_degradado, 'RAM').

diagnostico(ram_daisy_chain_topology) :-
    sintoma(memtest_errores, si),
    sintoma(ram_detectada, si).
explicacion(ram_daisy_chain_topology, 'Topología Daisy Chain problemática - 4 DIMMs difícil estabilizar en frecuencias altas').
solucion(ram_daisy_chain_topology, 'REDUCIR frecuencia RAM cuando usando 4 DIMMs. Aumentar voltajes VCCSA/VCCIO. Usar 2 DIMMs dual-rank para mejor stability. COSTO: $0').
componente_afectado(ram_daisy_chain_topology, 'RAM/Motherboard').

% ========================================
% STORAGE HDD/SSD - 35 DIAGNÓSTICOS
% ========================================

diagnostico(hdd_click_of_death) :-
    sintoma(ruidos_disco, si),
    sintoma(ruido_tipo, click_repetitivo),
    sintoma(disco_detectado, no).
explicacion(hdd_click_of_death, 'Cabezales HDD atascados - No pueden posicionarse en pistas - CLICK OF DEATH').
solucion(hdd_click_of_death, 'APAGAR inmediatamente. NO intentar recuperación DIY. Servicio profesional clean room required. COSTO: $300-2000 USD data recovery').
componente_afectado(hdd_click_of_death, 'HDD').

diagnostico(hdd_motor_spindle_muerto) :-
    sintoma(ruidos_disco, no),
    sintoma(disco_detectado, no).
explicacion(hdd_motor_spindle_muerto, 'Motor spindle no gira - Platos inmóviles').
solucion(hdd_motor_spindle_muerto, 'PROBAR con fuente de poder externa. Si motor no arranca: REEMPLAZAR HDD. Recovery posible con reemplazo de PCB + transferencia ROM. COSTO: $50-200 USD HDD nuevo + $300-1000 USD recovery').
componente_afectado(hdd_motor_spindle_muerto, 'HDD').

diagnostico(hdd_motor_spindle_fallo) :-
    sintoma(ruidos_disco, si),
    sintoma(disco_detectado, intermitente).
explicacion(hdd_motor_spindle_fallo, 'Motor spindle fallando - Giro inconsistente').
solucion(hdd_motor_spindle_fallo, 'BACKUP inmediato. REEMPLAZAR HDD. Cada encendido acelera fallo. COSTO: $50-200 USD HDD nuevo').
componente_afectado(hdd_motor_spindle_fallo, 'HDD').

diagnostico(hdd_cabezales_crashed) :-
    sintoma(ruidos_disco, si),
    sintoma(ruido_tipo, chirrido_continuo),
    sintoma(golpe_caida, si).
explicacion(hdd_cabezales_crashed, 'Cabezales contactaron superficie platos - Rayones físicos - HEAD CRASH').
solucion(hdd_cabezales_crashed, 'DETENER uso inmediatamente. Cada encendido empeora daño. Recovery profesional solamente. NO abrir HDD. COSTO: $500-2500 USD data recovery').
componente_afectado(hdd_cabezales_crashed, 'HDD').

diagnostico(hdd_head_crash) :-
    sintoma(ruidos_disco, si),
    sintoma(ruido_tipo, chirrido_continuo),
    sintoma(archivos_corruptos, si).
explicacion(hdd_head_crash, 'Head Crash - Cabezales estrellados contra platos').
solucion(hdd_head_crash, 'APAGAR inmediatamente. Recovery profesional clean room. NO reintentar acceso. COSTO: $500-2500 USD recovery').
componente_afectado(hdd_head_crash, 'HDD').

diagnostico(hdd_sectores_bad_growth) :-
    sintoma(smart_warnings, si),
    sintoma(sectores_realocados, si),
    sintoma(velocidad_lenta, si).
explicacion(hdd_sectores_bad_growth, 'Sectores defectuosos creciendo - Superficie magnética degradándose').
solucion(hdd_sectores_bad_growth, 'BACKUP urgente. Monitorear SMART "Reallocated Sectors Count" y "Current Pending Sector". Si >50: REEMPLAZAR. COSTO: $50-200 USD HDD nuevo').
componente_afectado(hdd_sectores_bad_growth, 'HDD').

diagnostico(hdd_smart_critical_parameters) :-
    sintoma(smart_warnings, si),
    sintoma(sectores_realocados, si),
    sintoma(errores_lectura, si).
explicacion(hdd_smart_critical_parameters, 'Parámetros SMART críticos: Reallocated Sectors > 100, Current Pending Sector Count > 0').
solucion(hdd_smart_critical_parameters, 'BACKUP urgente. REEMPLAZAR HDD inmediatamente. Usar CrystalDiskInfo para monitoreo. COSTO: $50-200 USD HDD nuevo').
componente_afectado(hdd_smart_critical_parameters, 'HDD').

diagnostico(hdd_firmware_corrupto) :-
    sintoma(disco_detectado, no),
    sintoma(ruidos_disco, no).
explicacion(hdd_firmware_corrupto, 'Firmware HDD corrupto - Disco no inicializa correctamente').
solucion(hdd_firmware_corrupto, 'Reflash firmware con herramientas específicas fabricante (Seagate Seatools, WD Data Lifeguard). Si falla: RMA o data recovery. COSTO: $0-500 USD').
componente_afectado(hdd_firmware_corrupto, 'HDD').

diagnostico(hdd_pcb_quemado) :-
    sintoma(disco_detectado, no),
    sintoma(olor_quemado, si).
explicacion(hdd_pcb_quemado, 'PCB HDD quemado - Componentes visiblemente dañados').
solucion(hdd_pcb_quemado, 'REEMPLAZAR PCB (debe ser modelo EXACTO + transferir ROM chip). O servicio profesional. COSTO: $50-500 USD PCB + recovery').
componente_afectado(hdd_pcb_quemado, 'HDD').

diagnostico(hdd_cache_ram_muerta) :-
    sintoma(velocidad_lenta, si),
    sintoma(disco_detectado, si).
explicacion(hdd_cache_ram_muerta, 'Cache DRAM HDD muerta - Performance severamente degradada').
solucion(hdd_cache_ram_muerta, 'No reparable económicamente. BACKUP y REEMPLAZAR HDD. COSTO: $50-200 USD HDD nuevo').
componente_afectado(hdd_cache_ram_muerta, 'HDD').

diagnostico(hdd_temperatura_excesiva) :-
    sintoma(temperatura_disco, si),
    sintoma(smart_warnings, si).
explicacion(hdd_temperatura_excesiva, 'HDD >50°C - Reduce vida útil, aumenta tasa errores').
solucion(hdd_temperatura_excesiva, 'MEJORAR ventilación: Ventilador directo HDD, reposicionar en case, mejorar airflow. Monitorear con CrystalDiskInfo. COSTO: $10-30 USD ventilador').
componente_afectado(hdd_temperatura_excesiva, 'HDD/Cooling').

diagnostico(hdd_power_on_hours_critico) :-
    sintoma(smart_warnings, si),
    sintoma(velocidad_lenta, si).
explicacion(hdd_power_on_hours_critico, 'HDD con >40,000 horas uso - Fin de vida útil cerca').
solucion(hdd_power_on_hours_critico, 'BACKUP completo. Considerar REEMPLAZO preventivo. HDDs típicamente fallan 40k-80k horas. COSTO: $50-200 USD HDD nuevo').
componente_afectado(hdd_power_on_hours_critico, 'HDD').

diagnostico(ssd_controller_muerto) :-
    sintoma(ssd_no_reconocido, si),
    sintoma(disco_detectado, no),
    sintoma(olor_quemado, no).
explicacion(ssd_controller_muerto, 'Controlador SSD (Phison/Samsung/SMI) falló - No responde a comandos').
solucion(ssd_controller_muerto, 'PROBAR en otro puerto/PC. Si no detecta: Controller muerto. Recovery a nivel chip posible pero costoso. COSTO: $400-1500 USD recovery profesional').
componente_afectado(ssd_controller_muerto, 'SSD').

diagnostico(ssd_nand_wear_out) :-
    sintoma(ssd_ralentizado, si),
    sintoma(smart_warnings, si),
    sintoma(velocidad_lenta, si).
explicacion(ssd_nand_wear_out, 'Celdas NAND agotadas - Media Wearout Indicator (SMART E9) > 90%').
solucion(ssd_nand_wear_out, 'VERIFICAR SMART atributo 233 "Media Wearout Indicator". Si > 90%: BACKUP urgente y REEMPLAZAR SSD. COSTO: $50-200 USD SSD nuevo').
componente_afectado(ssd_nand_wear_out, 'SSD').

diagnostico(ssd_dram_cache_corrupto) :-
    sintoma(ssd_ralentizado, si),
    sintoma(congelamientos, si),
    sintoma(disco_detectado, intermitente).
explicacion(ssd_dram_cache_corrupto, 'Cache DRAM del SSD corrupto - Mapping table errors').
solucion(ssd_dram_cache_corrupto, 'ACTUALIZAR firmware SSD. Ejecutar Secure Erase. Si persiste: SSD defectuoso, REEMPLAZAR. COSTO: $50-200 USD SSD nuevo').
componente_afectado(ssd_dram_cache_corrupto, 'SSD').

diagnostico(ssd_firmware_bug) :-
    sintoma(disco_detectado, intermitente),
    sintoma(congelamientos, si).
explicacion(ssd_firmware_bug, 'Bug firmware SSD conocido - Verificar lista fabricante').
solucion(ssd_firmware_bug, 'ACTUALIZAR firmware SSD con herramienta fabricante (Samsung Magician, Crucial Storage Executive). BACKUP antes. COSTO: $0').
componente_afectado(ssd_firmware_bug, 'SSD').

diagnostico(ssd_trim_no_funcional) :-
    sintoma(ssd_ralentizado, si),
    sintoma(velocidad_lenta, si).
explicacion(ssd_trim_no_funcional, 'TRIM no funciona - Garbage collection ineficiente, performance degradada').
solucion(ssd_trim_no_funcional, 'VERIFICAR TRIM habilitado: cmd "fsutil behavior query DisableDeleteNotify" (0=habilitado). Ejecutar Optimize Drives. COSTO: $0').
componente_afectado(ssd_trim_no_funcional, 'SSD/Windows').

diagnostico(ssd_over_provisioning_insuficiente) :-
    sintoma(ssd_ralentizado, si),
    sintoma(smart_warnings, si).
explicacion(ssd_over_provisioning_insuficiente, 'Over-provisioning SSD insuficiente - SSD >80% lleno, performance cae').
solucion(ssd_over_provisioning_insuficiente, 'MANTENER SSD <75% capacidad. Crear partición unallocated 10-20% para OP. COSTO: $0 o $50-200 USD SSD más grande').
componente_afectado(ssd_over_provisioning_insuficiente, 'SSD').

diagnostico(ssd_dram_cache_ausente) :-
    sintoma(ssd_ralentizado, si),
    sintoma(velocidad_lenta, si).
explicacion(ssd_dram_cache_ausente, 'SSD sin cache DRAM - DRAMless SSD con performance limitada').
solucion(ssd_dram_cache_ausente, 'Características del modelo. UPGRADE a SSD con DRAM cache para mejor performance (Samsung 870 EVO, WD Blue). COSTO: $60-200 USD SSD con DRAM').
componente_afectado(ssd_dram_cache_ausente, 'SSD').

diagnostico(nvme_thermal_throttling) :-
    sintoma(ssd_ralentizado, si),
    sintoma(sobrecalentamiento, si),
    sintoma(temperatura_disco, si).
explicacion(nvme_thermal_throttling, 'NVMe SSD >70°C - Throttling reduce velocidad').
solucion(nvme_thermal_throttling, 'INSTALAR heatsink M.2 con thermal pads. Mejorar airflow. Monitorear con CrystalDiskInfo. COSTO: $10-25 USD heatsink M.2').
componente_afectado(nvme_thermal_throttling, 'SSD NVMe').

diagnostico(nvme_thermal_throttling_severo) :-
    sintoma(ssd_ralentizado, si),
    sintoma(sobrecalentamiento, si),
    sintoma(temperatura_disco, si),
    sintoma(velocidad_lenta, si).
explicacion(nvme_thermal_throttling_severo, 'NVMe SSD > 80°C - Throttling severo, velocidad 1/3 capacidad').
solucion(nvme_thermal_throttling_severo, 'URGENTE: INSTALAR heatsink M.2 de calidad con thermal pads alta conductividad. Considerar SSD con heatsink integrado. COSTO: $15-30 USD heatsink premium').
componente_afectado(nvme_thermal_throttling_severo, 'SSD NVMe').

diagnostico(nvme_pcie_lanes_insuficientes) :-
    sintoma(ssd_ralentizado, si),
    sintoma(velocidad_lenta, si).
explicacion(nvme_pcie_lanes_insuficientes, 'NVMe corriendo en x2 en vez de x4 - Velocidad 50% reducida').
solucion(nvme_pcie_lanes_insuficientes, 'VERIFICAR slot M.2 corre x4. Consultar manual motherboard. Mover a slot con x4 lanes dedicados. COSTO: $0').
componente_afectado(nvme_pcie_lanes_insuficientes, 'SSD NVMe/Motherboard').

diagnostico(nvme_pcie_gen_incorrecto) :-
    sintoma(velocidad_lenta, si),
    sintoma(disco_detectado, si).
explicacion(nvme_pcie_gen_incorrecto, 'NVMe Gen 4 corriendo en Gen 3 - Velocidad 50% reducida').
solucion(nvme_pcie_gen_incorrecto, 'VERIFICAR BIOS: PCIe configurado Gen 4. Actualizar BIOS si necesario. CPU/Motherboard deben soportar Gen 4. COSTO: $0').
componente_afectado(nvme_pcie_gen_incorrecto, 'SSD NVMe/Motherboard').

diagnostico(ssd_write_amplification_alta) :-
    sintoma(ssd_ralentizado, si),
    sintoma(smart_warnings, si).
explicacion(ssd_write_amplification_alta, 'Write Amplification >3.0 - SSD escribiendo 3x datos necesarios, desgaste acelerado').
solucion(ssd_write_amplification_alta, 'REDUCIR writes innecesarios: Deshabilitar hibernación, mover temp files, reducir page file. Verificar SMART. COSTO: $0').
componente_afectado(ssd_write_amplification_alta, 'SSD').

diagnostico(ssd_garbage_collection_lento) :-
    sintoma(ssd_ralentizado, si),
    sintoma(congelamientos, si).
explicacion(ssd_garbage_collection_lento, 'Garbage collection lento - SSD lleno, GC no puede mantener ritmo').
solucion(ssd_garbage_collection_lento, 'LIBERAR espacio: Mantener <75% capacidad. TRIM manual (Optimize Drives). Secure Erase si grave. COSTO: $0').
componente_afectado(ssd_garbage_collection_lento, 'SSD').

diagnostico(cable_sata_defectuoso) :-
    sintoma(disco_detectado, intermitente),
    sintoma(errores_lectura, si).
explicacion(cable_sata_defectuoso, 'Cable SATA con conductores rotos/intermitentes - Error rate alto').
solucion(cable_sata_defectuoso, 'REEMPLAZAR cable SATA. Usar cables con conectores metálicos y trabas. Máximo 50cm longitud. COSTO: $5-10 USD cable nuevo').
componente_afectado(cable_sata_defectuoso, 'Cables SATA').

diagnostico(puerto_sata_sucio) :-
    sintoma(disco_detectado, intermitente),
    sintoma(velocidad_lenta, si).
explicacion(puerto_sata_sucio, 'Puerto SATA motherboard con polvo/oxidación - Contacto pobre').
solucion(puerto_sata_sucio, 'LIMPIAR puerto SATA con aire comprimido y alcohol isopropílico. Probar otro puerto. COSTO: $0').
componente_afectado(puerto_sata_sucio, 'Motherboard').

diagnostico(ssd_secure_erase_necesario) :-
    sintoma(ssd_ralentizado, si),
    sintoma(velocidad_lenta, si).
explicacion(ssd_secure_erase_necesario, 'SSD degradado por uso - Secure Erase restaura performance factory').
solucion(ssd_secure_erase_necesario, 'BACKUP datos. Ejecutar Secure Erase con herramienta fabricante o Parted Magic. RESTAURA performance original. COSTO: $0').
componente_afectado(ssd_secure_erase_necesario, 'SSD').

diagnostico(sata_cable_defectuoso) :-
    sintoma(disco_detectado, intermitente),
    sintoma(errores_lectura, si),
    sintoma(velocidad_lenta, si).
explicacion(sata_cable_defectuoso, 'Cable SATA defectuoso - Conexión intermitente, errores').
solucion(sata_cable_defectuoso, 'REEMPLAZAR cable SATA con cable calidad (trabas metálicas). Verificar conexión firme ambos extremos. COSTO: $5-10 USD').
componente_afectado(sata_cable_defectuoso, 'Cables').

diagnostico(m2_slot_pcie_lanes_conflicto) :-
    sintoma(ssd_no_reconocido, si),
    sintoma(m2_slot_funciona, no),
    sintoma(sata_ports_funcionan, no).
explicacion(m2_slot_pcie_lanes_conflicto, 'Slot M.2 comparte lanes PCIe con puertos SATA - Conflicto de recursos').
solucion(m2_slot_pcie_lanes_conflicto, 'CONSULTAR manual motherboard. Algunos slots M.2 deshabilitan puertos SATA específicos. Usar slot M.2 que no comparta recursos. COSTO: $0').
componente_afectado(m2_slot_pcie_lanes_conflicto, 'Motherboard').

diagnostico(usb_external_disk_power_insufficient) :-
    sintoma(disco_detectado, intermitente),
    sintoma(usb_velocidad_lenta, si),
    sintoma(dispositivos_no_reconocidos, si).
explicacion(usb_external_disk_power_insufficient, 'Disco externo no recibe suficiente potencia por USB - Drops de voltaje').
solucion(usb_external_disk_power_insufficient, 'USAR cable Y-splitter con dos puertos USB. Conectar a puertos USB posteriores (más potencia). Evitar hubs USB no alimentados. COSTO: $10-20 USD cable Y').
componente_afectado(usb_external_disk_power_insufficient, 'USB/Disco Externo').

diagnostico(ssd_ralentizado) :-
    sintoma(ssd_ralentizado, si),
    sintoma(velocidad_lenta, si).
explicacion(ssd_ralentizado, 'SSD con performance degradada - Múltiples causas posibles').
solucion(ssd_ralentizado, 'VERIFICAR: 1) TRIM habilitado, 2) <75% capacidad, 3) SMART health, 4) Actualizar firmware, 5) Temperatura. COSTO: $0').
componente_afectado(ssd_ralentizado, 'SSD').

diagnostico(ssd_no_reconocido) :-
    sintoma(ssd_no_reconocido, si),
    sintoma(disco_detectado, no).
explicacion(ssd_no_reconocido, 'SSD no detectado en BIOS - Problema conexión o SSD fallido').
solucion(ssd_no_reconocido, 'VERIFICAR: 1) Cable/slot bien conectado, 2) Probar otro puerto, 3) Detectado en otro PC, 4) BIOS actualizado. COSTO: $0-200 USD SSD nuevo').
componente_afectado(ssd_no_reconocido, 'SSD').

% ========================================
% GPU - 20 DIAGNÓSTICOS
% ========================================

diagnostico(gpu_muerte_total) :-
    sintoma(gpu_detectada, no),
    sintoma(pantalla_enciende, no),
    sintoma(olor_quemado, si).
explicacion(gpu_muerte_total, 'GPU completamente muerta - Daño físico irreparable').
solucion(gpu_muerte_total, 'PROBAR en otro PC. Si no detecta: GPU muerta. REEMPLAZO necesario. Verificar causa: PSU, sobrevoltaje. COSTO: $200-1500 USD GPU nueva').
componente_afectado(gpu_muerte_total, 'GPU').

diagnostico(gpu_no_detectada_power_insuficiente) :-
    sintoma(gpu_detectada, no),
    sintoma(pantalla_enciende, no),
    sintoma(olor_quemado, no).
explicacion(gpu_no_detectada_power_insuficiente, 'GPU no recibe suficiente potencia - Cables PCIe incompletos o PSU insuficiente').
solucion(gpu_no_detectada_power_insuficiente, 'VERIFICAR todos cables PCIe: 6-pin + 8-pin requeridos. Usar cables separados, NO daisy-chain. PSU mínimo: 550W mid-range, 750W+ high-end. COSTO: $0-200 USD PSU nueva').
componente_afectado(gpu_no_detectada_power_insuficiente, 'GPU/PSU').

diagnostico(gpu_pcie_slot_compatibility_issue) :-
    sintoma(gpu_detectada, no),
    sintoma(slots_pcie_funcionan, parcial).
explicacion(gpu_pcie_slot_compatibility_issue, 'GPU en slot PCIe incorrecto - Slot x16 físico pero eléctrico x4, o PCIe gen mismatch').
solucion(gpu_pcie_slot_compatibility_issue, 'USAR slot PCIe x16 superior (más cercano a CPU). Verificar en BIOS corre x16. Forzar PCIe Gen3 si GPU Gen4 en motherboard vieja. COSTO: $0').
componente_afectado(gpu_pcie_slot_compatibility_issue, 'GPU/Motherboard').

diagnostico(gpu_vram_muerta) :-
    sintoma(artifactos_gpu, si),
    sintoma(pantallazos_negros, si),
    sintoma(driver_crashed, si).
explicacion(gpu_vram_muerta, 'VRAM GPU completamente muerta - No puede almacenar texturas/buffers').
solucion(gpu_vram_muerta, 'GPU irreparable para uso normal. Puede funcionar con resoluciones bajas. REEMPLAZO necesario. COSTO: $200-1500 USD GPU nueva').
componente_afectado(gpu_vram_muerta, 'GPU').

diagnostico(gpu_vram_failure_specific_chip) :-
    sintoma(artifactos_gpu, si),
    sintoma(artifactos_3d, si),
    sintoma(pantallazos_negros, si).
explicacion(gpu_vram_failure_specific_chip, 'Chip VRAM específico fallando - Artefactos consistentes en misma ubicación pantalla').
solucion(gpu_vram_failure_specific_chip, 'EJECUTAR MATS/MODS memory test para identificar chip. Reparación requiere reballing BGA profesional. COSTO: $150-400 USD reparación o $200-1500 USD GPU nueva').
componente_afectado(gpu_vram_failure_specific_chip, 'GPU').

diagnostico(gpu_die_sobrecalentado) :-
    sintoma(temp_gpu_carga, si),
    sintoma(gpu_throttling, si),
    sintoma(pantallazos_negros, si).
explicacion(gpu_die_sobrecalentado, 'Die GPU sobrecalentado >95°C - Throttling severo, artifacts').
solucion(gpu_die_sobrecalentado, 'URGENTE: Mejorar refrigeración. Pasta térmica nueva, limpiar polvo, ventiladores funcionando. COSTO: $5-50 USD').
componente_afectado(gpu_die_sobrecalentado, 'GPU').

diagnostico(gpu_thermal_paste_dried_out) :-
    sintoma(temp_gpu_idle, si),
    sintoma(temp_gpu_carga, si),
    sintoma(gpu_throttling, si).
explicacion(gpu_thermal_paste_dried_out, 'Pasta térmica GPU seca - Delta >40°C entre idle y carga').
solucion(gpu_thermal_paste_dried_out, 'REPASTAR GPU: Remover cooler, limpiar die y base con alcohol 99%, aplicar pasta alta conductividad (Thermal Grizzly, Arctic MX-6). COSTO: $5-15 USD pasta').
componente_afectado(gpu_thermal_paste_dried_out, 'GPU').

diagnostico(gpu_vrm_overheating) :-
    sintoma(gpu_throttling, si),
    sintoma(temp_gpu_carga, no),
    sintoma(pantallazos_negros, si).
explicacion(gpu_vrm_overheating, 'VRM GPU sobrecalentado - Throttling antes de GPU alcanzar temperatura crítica').
solucion(gpu_vrm_overheating, 'MEJORAR refrigeración VRM: Agregar thermal pads a fases VRM, ventilador directo, o waterblock completo. Monitorear con HWiNFO64. COSTO: $15-150 USD').
componente_afectado(gpu_vrm_overheating, 'GPU').

diagnostico(gpu_fan_bearing_failure) :-
    sintoma(ventilador_ruidoso, si),
    sintoma(ventilador_vibra, si),
    sintoma(temp_gpu_idle, si).
explicacion(gpu_fan_bearing_failure, 'Rodamientos ventilador GPU desgastados - Ruido mecánico y vibración').
solucion(gpu_fan_bearing_failure, 'REEMPLAZAR ventiladores GPU. Buscar modelo específico en AliExpress/Amazon, o instalar cooler aftermarket (Arctic Accelero, Raijintek Morpheus). COSTO: $20-80 USD').
componente_afectado(gpu_fan_bearing_failure, 'GPU').

diagnostico(gpu_ventiladores_muertos) :-
    sintoma(ventiladores_gpu_giran, no),
    sintoma(temp_gpu_carga, si).
explicacion(gpu_ventiladores_muertos, 'Ventiladores GPU no giran - Sobrecalentamiento inevitable').
solucion(gpu_ventiladores_muertos, 'VERIFICAR: 1) Fan curve en software, 2) Cable ventilador conectado, 3) Probar ventiladores manualmente. REEMPLAZAR si muertos. COSTO: $20-80 USD ventiladores nuevos').
componente_afectado(gpu_ventiladores_muertos, 'GPU').

diagnostico(gpu_power_limit_activado) :-
    sintoma(gpu_throttling, si),
    sintoma(fps_bajos, si),
    sintoma(temp_gpu_carga, no).
explicacion(gpu_power_limit_activado, 'GPU alcanza power limit - Reduce clocks para mantenerse dentro TDP').
solucion(gpu_power_limit_activado, 'AUMENTAR power limit en MSI Afterburner (+10-20%). Verificar cables PCIe, PSU capacidad. Undervolt para mejor eficiencia. COSTO: $0').
componente_afectado(gpu_power_limit_activado, 'GPU').

diagnostico(gpu_vbios_corrupto) :-
    sintoma(gpu_detectada, no),
    sintoma(pantalla_enciende, no),
    sintoma(recientemente_actualizo_bios, si).
explicacion(gpu_vbios_corrupto, 'VBIOS GPU corrupto - Update fallido o flash incorrecto').
solucion(gpu_vbios_corrupto, 'REFLASH VBIOS con versión correcta desde TechPowerUp. Usar dual BIOS switch si disponible. COSTO: $0 si reparable').
componente_afectado(gpu_vbios_corrupto, 'GPU').

diagnostico(gpu_artifacts_memory_oc) :-
    sintoma(artifactos_gpu, si),
    sintoma(artifactos_3d, si).
explicacion(gpu_artifacts_memory_oc, 'Artefactos por Memory OC - VRAM overclockeada inestable').
solucion(gpu_artifacts_memory_oc, 'REDUCIR memory clock en MSI Afterburner. Bajar -100MHz incremental hasta estable. COSTO: $0').
componente_afectado(gpu_artifacts_memory_oc, 'GPU/Overclock').

diagnostico(gpu_core_degradado) :-
    sintoma(driver_crashed, si),
    sintoma(fps_bajos, si),
    sintoma(artifactos_gpu, intermitente).
explicacion(gpu_core_degradado, 'Core GPU degradado - Silicio perdió propiedades por uso intensivo/voltaje alto').
solucion(gpu_core_degradado, 'APLICAR undervolting: Reducir voltaje core 50-100mV, reducir frecuencia 100-200MHz. Si persiste: GPU permanentemente dañada. COSTO: $0 o $200-1500 USD GPU nueva').
componente_afectado(gpu_core_degradado, 'GPU').

diagnostico(gpu_core_degradation_from_mining) :-
    sintoma(driver_crashed, si),
    sintoma(fps_bajos, si),
    sintoma(gpu_throttling, si).
explicacion(gpu_core_degradation_from_mining, 'Core GPU degradado por mining 24/7 - Uso intensivo prolongado').
solucion(gpu_core_degradation_from_mining, 'APLICAR undervolting: -50-100mV core, -100-200MHz frecuencia. Si inestable: GPU dañada permanentemente. COSTO: $0 o $200-1500 USD GPU nueva').
componente_afectado(gpu_core_degradation_from_mining, 'GPU').

diagnostico(gpu_driver_conflict_cleanup_needed) :-
    sintoma(driver_crashed, si),
    sintoma(pantallazos_negros, si),
    sintoma(recientemente_actualizo_drivers, si).
explicacion(gpu_driver_conflict_cleanup_needed, 'Conflictos entre versiones driver - Archivos residuales causan inestabilidad').
solucion(gpu_driver_conflict_cleanup_needed, 'DDU (Display Driver Uninstaller) en modo seguro. Reinstalar drivers estables (NO beta). Verificar no hay conflictos Intel/NVIDIA o AMD/NVIDIA. COSTO: $0').
componente_afectado(gpu_driver_conflict_cleanup_needed, 'GPU/Software').

diagnostico(gpu_power_limit_throttling) :-
    sintoma(gpu_throttling, si),
    sintoma(fps_bajos, si),
    sintoma(temp_gpu_carga, no).
explicacion(gpu_power_limit_throttling, 'GPU throttling por power limit - TDP insuficiente para boost completo').
solucion(gpu_power_limit_throttling, 'AUMENTAR power limit +10-20% MSI Afterburner. Mejorar alimentación: cables PCIe separados, PSU capacidad. Undervolt para eficiencia. COSTO: $0').
componente_afectado(gpu_power_limit_throttling, 'GPU').

diagnostico(gpu_pcie_bus_contention) :-
    sintoma(fps_bajos, si),
    sintoma(velocidad_lenta, si).
explicacion(gpu_pcie_bus_contention, 'GPU compite por ancho de banda PCIe con otros dispositivos').
solucion(gpu_pcie_bus_contention, 'MOVER GPU a slot x16 dedicado. Mover NVMe a slot que no comparta lanes. Deshabilitar dispositivos PCIe no esenciales. COSTO: $0').
componente_afectado(gpu_pcie_bus_contention, 'GPU/Motherboard').

diagnostico(gpu_pcie_riser_defectuoso) :-
    sintoma(gpu_detectada, intermitente),
    sintoma(artifactos_gpu, si).
explicacion(gpu_pcie_riser_defectuoso, 'Riser cable PCIe defectuoso - Conexión intermitente, errores señal').
solucion(gpu_pcie_riser_defectuoso, 'PROBAR GPU directamente en motherboard sin riser. Si funciona: Riser defectuoso. REEMPLAZAR con riser PCIe 4.0 calidad. COSTO: $20-50 USD riser nuevo').
componente_afectado(gpu_pcie_riser_defectuoso, 'Riser PCIe').

diagnostico(gpu_sag_estres_pcb) :-
    sintoma(artifactos_gpu, intermitente),
    sintoma(gpu_detectada, intermitente).
explicacion(gpu_sag_estres_pcb, 'GPU sag - Peso GPU estresa PCB y slot PCIe, conexión intermitente').
solucion(gpu_sag_estres_pcb, 'INSTALAR soporte anti-sag GPU. Vertical mount si posible. Reduce estrés en PCB y slot. COSTO: $10-30 USD soporte').
componente_afectado(gpu_sag_estres_pcb, 'GPU/Motherboard').

% ========================================
% REFRIGERACIÓN - 8 DIAGNÓSTICOS
% ========================================

diagnostico(aio_pump_failure) :-
    sintoma(sobrecalentamiento, si),
    sintoma(temp_cpu_idle, si),
    sintoma(temp_cpu_carga, si),
    sintoma(apagado_termico, si).
explicacion(aio_pump_failure, 'Bomba AIO falló - No circula líquido, CPU sobrecalienta rápidamente').
solucion(aio_pump_failure, 'VERIFICAR bomba conectada a header PUMP_FAN o CPU_FAN. Escuchar si hace ruido. REEMPLAZAR AIO completo si bomba muerta. Garantía 5-6 años. COSTO: $60-150 USD AIO nuevo').
componente_afectado(aio_pump_failure, 'Cooler CPU AIO').

diagnostico(aio_fluid_evaporation) :-
    sintoma(sobrecalentamiento, si),
    sintoma(temp_cpu_carga, si),
    sintoma(ventilador_ruidoso, si).
explicacion(aio_fluid_evaporation, 'Líquido AIO evaporado - Nivel bajo, burbujas aire en bomba').
solucion(aio_fluid_evaporation, 'REEMPLAZAR AIO completo. NO intentar rellenar - sellos comprometidos. Prevención: Reemplazar AIO cada 5-6 años preventivamente. COSTO: $60-150 USD AIO nuevo').
componente_afectado(aio_fluid_evaporation, 'Cooler CPU AIO').

diagnostico(custom_loop_air_bubble) :-
    sintoma(sobrecalentamiento, si),
    sintoma(temp_cpu_carga, si),
    sintoma(gpu_throttling, si).
explicacion(custom_loop_air_bubble, 'Burbuja aire en custom loop - Bloquea flujo, reduce transferencia térmica').
solucion(custom_loop_air_bubble, 'BLEED loop: Inclinar case todas direcciones, encender/apagar bombas intermitentemente. Agregar reservoir fillport. Bomba siempre abajo del radiador. COSTO: $0').
componente_afectado(custom_loop_air_bubble, 'Custom Loop').

diagnostico(radiator_fins_clogged_dust) :-
    sintoma(sobrecalentamiento, si),
    sintoma(temp_cpu_carga, si),
    sintoma(polvo_acumulado, si).
explicacion(radiator_fins_clogged_dust, 'Aletas radiador obstruidas por polvo - Flujo aire reducido >70%').
solucion(radiator_fins_clogged_dust, 'LIMPIAR radiador con aire comprimido (dirección contraria a flujo normal). Considerar filtros polvo magnéticos. Limpieza cada 3-6 meses. COSTO: $0-20 USD filtros').
componente_afectado(radiator_fins_clogged_dust, 'Radiador').

diagnostico(tower_cooler_mounting_pressure_issue) :-
    sintoma(sobrecalentamiento, si),
    sintoma(temp_cpu_idle, si),
    sintoma(recientemente_instalo_hardware, si).
explicacion(tower_cooler_mounting_pressure_issue, 'Cooler torre con presión desigual - Contacto térmico pobre en áreas del IHS').
solucion(tower_cooler_mounting_pressure_issue, 'REINSTALAR cooler: Apretar tornillos en patrón X cruzado (NO circular). Presión uniforme. Verificar brackets correctamente orientados. COSTO: $0').
componente_afectado(tower_cooler_mounting_pressure_issue, 'Cooler CPU').

diagnostico(heatpipe_phase_change_failure) :-
    sintoma(sobrecalentamiento, si),
    sintoma(temp_cpu_carga, si),
    sintoma(pasta_termica_vieja, no).
explicacion(heatpipe_phase_change_failure, 'Heatpipes perdieron vacío/fluido - Transferencia térmica degradada').
solucion(heatpipe_phase_change_failure, 'REEMPLAZAR cooler completo. Heatpipes NO reparables. Síntoma: Heatpipes frías mientras CPU caliente. COSTO: $30-80 USD cooler nuevo').
componente_afectado(heatpipe_phase_change_failure, 'Cooler CPU').

diagnostico(case_airflow_negative_pressure) :-
    sintoma(sobrecalentamiento, si),
    sintoma(polvo_acumulado, si),
    sintoma(temp_gpu_carga, si).
explicacion(case_airflow_negative_pressure, 'Presión negativa en case - Más exhaust que intake, acumulación polvo rápida').
solucion(case_airflow_negative_pressure, 'BALANCEAR airflow: Mismo número fans intake/exhaust, o ligeramente positivo. Velocidad intake ≥ exhaust. Verificar dirección flujo. COSTO: $0-40 USD fans adicionales').
componente_afectado(case_airflow_negative_pressure, 'Case/Fans').

diagnostico(pwm_fan_controller_failure) :-
    sintoma(ventilador_ruidoso, si),
    sintoma(ventilador_detenido, si).
explicacion(pwm_fan_controller_failure, 'Controlador PWM motherboard defectuoso - Fans full speed o detenidos').
solucion(pwm_fan_controller_failure, 'PROBAR fans en otro header. Usar controlador fan hub externo. Reparación motherboard requiere reemplazo IC PWM. COSTO: $20-50 USD fan hub o $100-400 USD motherboard').
componente_afectado(pwm_fan_controller_failure, 'Motherboard').

% ========================================
% CASOS ESPECIALES - 5 DIAGNÓSTICOS
% ========================================

diagnostico(liquid_spill_immediate_damage) :-
    sintoma(derramo_liquido, si),
    sintoma(enciende, no),
    sintoma(olor_quemado, si).
explicacion(liquid_spill_immediate_damage, 'Cortocircuito inmediato por líquido - Múltiples componentes afectados').
solucion(liquid_spill_immediate_damage, 'ACCIÓN INMEDIATA: Desconectar poder, remover batería CMOS. Limpiar con alcohol isopropílico 99%. Secar 72+ horas. Probar componentes uno por uno. Esperar pérdida total. COSTO: Variable').
componente_afectado(liquid_spill_immediate_damage, 'Múltiples Componentes').

diagnostico(liquid_spill_corrosion_long_term) :-
    sintoma(derramo_liquido, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(congelamientos, si).
explicacion(liquid_spill_corrosion_long_term, 'Corrosión progresiva por residuos líquidos - Fallos intermitentes que empeoran').
solucion(liquid_spill_corrosion_long_term, 'LIMPIAR profundamente con ultrasonido o cepillo + isopropílico. Inspeccionar corrosión en trazas. REEMPLAZAR componentes afectados. Motherboard generalmente no reparable. COSTO: $100-800 USD').
componente_afectado(liquid_spill_corrosion_long_term, 'Motherboard/GPU').

diagnostico(physical_impact_bga_failure) :-
    sintoma(golpe_caida, si),
    sintoma(artifactos_gpu, si),
    sintoma(gpu_detectada, intermitente).
explicacion(physical_impact_bga_failure, 'Balls BGA fracturados por impacto - Conexiones intermitentes en GPU/CPU').
solucion(physical_impact_bga_failure, 'REBALLING profesional requerido. Diagnóstico: Presionar suavemente GPU/CPU mientras funciona - si cambia comportamiento, confirma BGA. COSTO: $100-300 USD reballing').
componente_afectado(physical_impact_bga_failure, 'GPU/CPU').

diagnostico(pcb_flex_cracked_traces) :-
    sintoma(golpe_caida, si),
    sintoma(enciende, no),
    sintoma(ventiladores, si).
explicacion(pcb_flex_cracked_traces, 'Traces PCB rotos por flexión - Circuitos abiertos en motherboard/GPU').
solucion(pcb_flex_cracked_traces, 'INSPECCIONAR visualmente con lupa bajo luz. Buscar cracks finos. Reparación requiere microsoldadura y jumper wires. Generalmente NO económico. COSTO: $100-500 USD reparación o reemplazo').
componente_afectado(pcb_flex_cracked_traces, 'Motherboard/GPU').

diagnostico(power_surge_multiple_failures) :-
    sintoma(tormenta_electrica, si),
    sintoma(sobretension_electrica, si),
    sintoma(enciende, no).
explicacion(power_surge_multiple_failures, 'Sobretensión dañó múltiples componentes - PSU, motherboard, dispositivos USB/ethernet').
solucion(power_surge_multiple_failures, 'PROBAR PSU sola (paperclip test). Verificar todos componentes. Usar protector sobretensiones/UPS futuro. Pérdida generalmente extensa. COSTO: $300-1500 USD múltiples componentes').
componente_afectado(power_surge_multiple_failures, 'Múltiples Componentes').

% ========================================
% DIAGNÓSTICOS CRUZADOS - 7 DIAGNÓSTICOS
% ========================================

diagnostico(imc_motherboard_ram_incompatibility) :-
    sintoma(memtest_errores, si),
    sintoma(xmp_activado, si),
    sintoma(ram_a_velocidad_maxima, no).
explicacion(imc_motherboard_ram_incompatibility, 'IMC CPU no puede manejar topología motherboard + densidad RAM').
solucion(imc_motherboard_ram_incompatibility, 'ACTUALIZAR BIOS. Reducir frecuencia RAM. Aumentar voltajes VDDQ/VDDQ2 (Intel) o VSOC/VDDG (AMD). Consultar QVL motherboard. COSTO: $0').
componente_afectado(imc_motherboard_ram_incompatibility, 'CPU/Motherboard/RAM').

diagnostico(vrm_insufficient_for_cpu_boost) :-
    sintoma(cpu_throttling, si),
    sintoma(frecuencia_cpu_correcta, no),
    sintoma(temp_cpu_carga, no).
explicacion(vrm_insufficient_for_cpu_boost, 'VRM motherboard no puede sostener potencia para turbo boost CPU').
solucion(vrm_insufficient_for_cpu_boost, 'REDUCIR power limits en BIOS. Mejorar refrigeración VRM. UPGRADE motherboard con mejor VRM (más fases, MOSFETs calidad). COSTO: $10-400 USD').
componente_afectado(vrm_insufficient_for_cpu_boost, 'Motherboard/CPU').

diagnostico(psu_ripple_affecting_stability) :-
    sintoma(reinicios_aleatorios, si),
    sintoma(congelamientos, si),
    sintoma(memtest_errores, si).
explicacion(psu_ripple_affecting_stability, 'Ripple PSU excesivo afecta múltiples componentes - Errores memoria, inestabilidad GPU').
solucion(psu_ripple_affecting_stability, 'MEDIR ripple con osciloscopio (>50mV inaceptable). REEMPLAZAR PSU con mejor regulación y filtrado. PSU tier B o superior. COSTO: $80-200 USD PSU calidad').
componente_afectado(psu_ripple_affecting_stability, 'PSU/Múltiples').

diagnostico(transient_response_psu_issue) :-
    sintoma(reinicios_aleatorios, si),
    sintoma(gpu_detectada, si).
explicacion(transient_response_psu_issue, 'Respuesta transiente PSU pobre - No maneja cambios rápidos carga (GPU boosting)').
solucion(transient_response_psu_issue, 'UPGRADE PSU con mejor respuesta transiente (mayor calidad, NO necesariamente mayor wattage). Verificar reviews técnicas. COSTO: $80-200 USD PSU calidad').
componente_afectado(transient_response_psu_issue, 'PSU/GPU').

diagnostico(ground_loop_audio_network_issues) :-
    sintoma(crackling_audio, si),
    sintoma(conexion_intermitente, si).
explicacion(ground_loop_audio_network_issues, 'Ground loops causando interferencia - Múltiples problemas señal/ruido').
solucion(ground_loop_audio_network_issues, 'CONECTAR todo a misma toma tierra. Usar aisladores audio USB/3.5mm. Verificar cableado eléctrico casa. UPS con filtro. COSTO: $30-150 USD UPS/aisladores').
componente_afectado(ground_loop_audio_network_issues, 'Sistema Completo').

diagnostico(thermal_runaway_scenario) :-
    sintoma(sobrecalentamiento, si),
    sintoma(apagado_termico, si),
    sintoma(temp_cpu_carga, si),
    sintoma(temp_gpu_carga, si).
explicacion(thermal_runaway_scenario, 'Fallo múltiple refrigeración - Temperaturas aumentan exponencialmente').
solucion(thermal_runaway_scenario, 'SHUTDOWN inmediato. Revisar todos fans, bombas, pastas térmicas. REEMPLAZAR componentes fallados. Verificar curves fan BIOS/software. COSTO: $20-200 USD').
componente_afectado(thermal_runaway_scenario, 'Sistema Refrigeración').

diagnostico(compatibility_chain_reaction) :-
    sintoma(recientemente_instalo_hardware, si),
    sintoma(memtest_errores, si),
    sintoma(gpu_detectada, no).
explicacion(compatibility_chain_reaction, 'Nuevo hardware causa conflictos en cadena - Incompatibilidades múltiples').
solucion(compatibility_chain_reaction, 'REVERTIR a configuración anterior estable. Actualizar BIOS. Instalar un componente a la vez, verificando estabilidad. Consultar compatibilidades. COSTO: $0').
componente_afectado(compatibility_chain_reaction, 'Múltiples Componentes').

% ========================================
% DIAGNÓSTICOS GENÉRICOS (CATCH-ALL)
% ========================================

diagnostico(no_faults_detected) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, si),
    sintoma(velocidad_lenta, no),
    sintoma(sobrecalentamiento, no),
    sintoma(reinicios_aleatorios, no),
    sintoma(congelamientos, no).
explicacion(no_faults_detected, 'Sistema funcionando correctamente - No se detectaron fallas críticas').
solucion(no_faults_detected, 'Realizar mantenimiento preventivo: Limpieza polvo, verificar temperaturas, actualizar drivers, backup datos. Sistema saludable. COSTO: $0').
componente_afectado(no_faults_detected, 'Ninguno').

diagnostico(insufficient_symptoms) :-
    \+ sintoma(enciende, _).
explicacion(insufficient_symptoms, 'Síntomas insuficientes para diagnóstico específico - Se necesitan más respuestas').
solucion(insufficient_symptoms, 'Continuar con cuestionario para diagnóstico más preciso. Responder al menos 15 preguntas para análisis completo. COSTO: Variable').
componente_afectado(insufficient_symptoms, 'Desconocido').

diagnostico(problema_general_hardware) :-
    sintoma(enciende, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(congelamientos, si).
explicacion(problema_general_hardware, 'Problema general de hardware detectado - Requiere análisis más profundo').
solucion(problema_general_hardware, 'VERIFICAR: 1) Event Viewer errores, 2) MemTest86, 3) Temperaturas, 4) PSU estable, 5) Drivers actualizados. COSTO: Variable según componente').
componente_afectado(problema_general_hardware, 'Múltiples Posibles').

diagnostico(diagnostico_incompleto_pocos_sintomas) :-
    findall(S, sintoma(S, _), Sintomas),
    length(Sintomas, N),
    N > 0,
    N < 5.
explicacion(diagnostico_incompleto_pocos_sintomas,
    'DiagnÃ³stico preliminar - Se detectaron sÃ­ntomas pero se necesitan mÃ¡s datos').
solucion(diagnostico_incompleto_pocos_sintomas,
    'CONTINUAR cuestionario: Responder al menos 10 preguntas para diagnÃ³stico preciso. Sistema cuenta con 70+ preguntas especÃ­ficas').
componente_afectado(diagnostico_incompleto_pocos_sintomas, 'EvaluaciÃ³n en Proceso').

diagnostico(motherboard_cmos_battery_dead) :-
    sintoma(fecha_hora_resetea, si),
    sintoma(configuracion_bios_se_pierde, si),
    sintoma(enciende, si),
    sintoma(bios_version_actualizada, no).
explicacion(motherboard_cmos_battery_dead, 'BaterÃ­a CR2032 agotada - No mantiene configuraciÃ³n CMOS').
solucion(motherboard_cmos_battery_dead, 'REEMPLAZAR baterÃ­a CR2032. Verificar voltaje > 3.0V. Resetear BIOS despuÃ©s del reemplazo. Configurar fecha/hora y settings').
componente_afectado(motherboard_cmos_battery_dead, 'Motherboard').








