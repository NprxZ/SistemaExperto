:- dynamic(sintoma/2).
:- dynamic(medicion/3).
:- discontiguous diagnostico/1.
:- discontiguous explicacion/2.
:- discontiguous solucion/2.
:- discontiguous componente_afectado/2.
:- discontiguous siguiente_pregunta/3.

% ========================================
% CATEGORIAS DE SINTOMAS EXPANDIDAS
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
% ARBOL DE DECISION
% ========================================

% --- RUTA PRINCIPAL: NO ENCIENDE ---
siguiente_pregunta(enciende, no, led_power).
siguiente_pregunta(led_power, no, ventiladores).
siguiente_pregunta(led_power, si, pitidos_post).
siguiente_pregunta(ventiladores, no, olor_quemado).
siguiente_pregunta(ventiladores, si, pitidos_post).
siguiente_pregunta(olor_quemado, si, chispa_electrica).
siguiente_pregunta(olor_quemado, no, voltaje_inestable).
siguiente_pregunta(chispa_electrica, si, componente_quemado_visible).
siguiente_pregunta(componente_quemado_visible, si, ejecutar_diagnostico).
siguiente_pregunta(componente_quemado_visible, no, reinicios_espontaneos).
siguiente_pregunta(chispa_electrica, no, reinicios_espontaneos).
siguiente_pregunta(voltaje_inestable, si, zumbido_bobinas).
siguiente_pregunta(voltaje_inestable, no, sobretension_electrica).

% --- RUTA PRINCIPAL: ENCIENDE PERO NO DISPLAY ---
siguiente_pregunta(enciende, si, pantalla_enciende).
siguiente_pregunta(pantalla_enciende, no, mensaje_no_signal).
siguiente_pregunta(pantalla_enciende, si, velocidad_lenta).
siguiente_pregunta(mensaje_no_signal, si, gpu_detectada).
siguiente_pregunta(mensaje_no_signal, no, pantalla_negra_post).
siguiente_pregunta(gpu_detectada, no, driver_gpu_instalado).
siguiente_pregunta(gpu_detectada, si, artifactos_gpu).
siguiente_pregunta(pantalla_negra_post, si, pitidos_post).
siguiente_pregunta(pantalla_negra_post, no, disco_detectado).

% --- RUTA PITIDOS POST ---
siguiente_pregunta(pitidos_post, si, patron_pitidos).
siguiente_pregunta(pitidos_post, no, disco_detectado).
siguiente_pregunta(patron_pitidos, 1, ram_detectada).
siguiente_pregunta(patron_pitidos, 2, gpu_detectada).
siguiente_pregunta(patron_pitidos, 3, disco_detectado).
siguiente_pregunta(patron_pitidos, mas, cpu_reconocido_correctamente).

% --- RUTA ALMACENAMIENTO ---
siguiente_pregunta(disco_detectado, no, ruidos_disco).
siguiente_pregunta(disco_detectado, si, ram_detectada).
siguiente_pregunta(ruidos_disco, si, ruido_tipo).
siguiente_pregunta(ruidos_disco, no, ssd_no_reconocido).
siguiente_pregunta(ruido_tipo, click_repetitivo, smart_warnings).
siguiente_pregunta(ruido_tipo, chirrido_continuo, sectores_realocados).
siguiente_pregunta(ruido_tipo, golpeteo, archivos_corruptos).
siguiente_pregunta(ssd_no_reconocido, si, m2_slot_funciona).
siguiente_pregunta(ssd_no_reconocido, no, velocidad_lenta).

% --- RUTA MEMORIA RAM ---
siguiente_pregunta(ram_detectada, no, cantidad_ram_detectada).
siguiente_pregunta(ram_detectada, si, sobrecalentamiento).
siguiente_pregunta(cantidad_ram_detectada, parcial, memtest_errores).
siguiente_pregunta(cantidad_ram_detectada, incorrecta, slots_ocupados).
siguiente_pregunta(memtest_errores, si, ubicacion_error_ram).
siguiente_pregunta(memtest_errores, no, xmp_activado).
siguiente_pregunta(xmp_activado, si, ram_a_velocidad_maxima).
siguiente_pregunta(xmp_activado, no, dual_channel_activo).

% --- RUTA TEMPERATURA/REFRIGERACION ---
siguiente_pregunta(sobrecalentamiento, si, temp_cpu_idle).
siguiente_pregunta(sobrecalentamiento, no, red_funciona).
siguiente_pregunta(temp_cpu_idle, si, temp_cpu_carga).
siguiente_pregunta(temp_cpu_idle, no, temp_gpu_idle).
siguiente_pregunta(temp_cpu_carga, si, apagado_termico).
siguiente_pregunta(temp_cpu_carga, no, ventilador_ruidoso).
siguiente_pregunta(apagado_termico, si, pasta_termica_vieja).
siguiente_pregunta(apagado_termico, no, polvo_acumulado).
siguiente_pregunta(ventilador_ruidoso, si, ventilador_detenido).
siguiente_pregunta(ventilador_ruidoso, no, ventilador_vibra).
siguiente_pregunta(pasta_termica_vieja, si, polvo_acumulado).
siguiente_pregunta(pasta_termica_vieja, no, flujo_aire_bloqueado).

% --- RUTA RED/CONECTIVIDAD ---
siguiente_pregunta(red_funciona, no, wifi_detecta).
siguiente_pregunta(red_funciona, si, audio_funciona).
siguiente_pregunta(wifi_detecta, no, ethernet_funciona).
siguiente_pregunta(wifi_detecta, si, velocidad_red_baja).
siguiente_pregunta(ethernet_funciona, no, led_ethernet_parpadea).
siguiente_pregunta(ethernet_funciona, si, ping_alto).
siguiente_pregunta(velocidad_red_baja, si, paquetes_perdidos).
siguiente_pregunta(velocidad_red_baja, no, conexion_intermitente).

% --- RUTA USB/AUDIO ---
siguiente_pregunta(audio_funciona, no, crackling_audio).
siguiente_pregunta(audio_funciona, si, usb_funciona).
siguiente_pregunta(crackling_audio, si, audio_solo_un_lado).
siguiente_pregunta(crackling_audio, no, audio_distorsionado).
siguiente_pregunta(usb_funciona, no, usb_intermitente).
siguiente_pregunta(usb_funciona, si, usb_3_no_funciona).
siguiente_pregunta(usb_intermitente, si, dispositivos_no_reconocidos).
siguiente_pregunta(usb_intermitente, no, usb_frontal_no_funciona).

% --- RUTA GPU AVANZADA ---
siguiente_pregunta(artifactos_gpu, si, pantallazos_negros).
siguiente_pregunta(artifactos_gpu, no, fps_bajos).
siguiente_pregunta(pantallazos_negros, si, driver_crashed).
siguiente_pregunta(pantallazos_negros, no, gpu_throttling).
siguiente_pregunta(driver_crashed, si, ventiladores_gpu_giran).
siguiente_pregunta(fps_bajos, si, gpu_throttling).
siguiente_pregunta(fps_bajos, no, temp_gpu_carga).
siguiente_pregunta(gpu_throttling, si, ventiladores_gpu_giran).
siguiente_pregunta(gpu_throttling, no, coil_whine_gpu).

% --- RUTA MOTHERBOARD DETALLADA ---
siguiente_pregunta(cpu_reconocido_correctamente, no, nucleos_detectados).
siguiente_pregunta(cpu_reconocido_correctamente, si, frecuencia_cpu_correcta).
siguiente_pregunta(nucleos_detectados, no, fecha_hora_resetea).
siguiente_pregunta(nucleos_detectados, si, puertos_traseros_funcionan).
siguiente_pregunta(fecha_hora_resetea, si, configuracion_bios_se_pierde).
siguiente_pregunta(fecha_hora_resetea, no, bios_version_actualizada).
siguiente_pregunta(puertos_traseros_funcionan, no, slots_pcie_funcionan).
siguiente_pregunta(puertos_traseros_funcionan, si, sata_ports_funcionan).

% --- RUTA CASOS ESPECIALES ---
siguiente_pregunta(recientemente_instalo_hardware, si, recientemente_actualizo_drivers).
siguiente_pregunta(recientemente_instalo_hardware, no, derramo_liquido).
siguiente_pregunta(recientemente_actualizo_drivers, si, recientemente_actualizo_bios).
siguiente_pregunta(recientemente_actualizo_drivers, no, golpe_caida).
siguiente_pregunta(derramo_liquido, si, golpe_caida).
siguiente_pregunta(derramo_liquido, no, tormenta_electrica).
siguiente_pregunta(golpe_caida, si, sintoma_actual_mas_especifico).
siguiente_pregunta(golpe_caida, no, sintoma_actual_mas_especifico).

% Puntos finales del árbol - ejecutan diagnóstico
% siguiente_pregunta(sintoma_actual_mas_especifico, _, fin_arbol).
% siguiente_pregunta(fin_arbol, _, ejecutar_diagnostico).


% ========================================
% REGLAS PSU - 30 DIAGNÓSTICOS ESPECÍFICOS
% ========================================

% 1-10: FALLAS DE VOLTAJE
diagnostico(psu_rail_12v_totalmente_muerto) :-
    sintoma(enciende, no),
    sintoma(led_power, no),
    sintoma(ventiladores, no),
    sintoma(olor_quemado, no),
    sintoma(chispa_electrica, no).
explicacion(psu_rail_12v_totalmente_muerto, 'Rail 12V completamente muerto - Sin voltaje en CPU, GPU, ventiladores').
solucion(psu_rail_12v_totalmente_muerto, 'MEDIR con multimetro: Conector 24-pin pin 10 (+12V) - Debe mostrar 11.4-12.6V. Si 0V: Reemplazar PSU inmediatamente. Costo: $60-200 USD').
componente_afectado(psu_rail_12v_totalmente_muerto, 'PSU').

diagnostico(psu_rail_5v_standby_muerto) :-
    sintoma(enciende, no),
    sintoma(led_power, no),
    sintoma(ventiladores, no),
    sintoma(olor_quemado, no).
explicacion(psu_rail_5v_standby_muerto, 'Rail 5VSB (standby) muerto - No hay poder para botón de encendido').
solucion(psu_rail_5v_standby_muerto, 'MEDIR: Pin 9 del conector 24-pin (+5VSB) - Debe ser 4.75-5.25V. Test: Puentear pin 16 (PS_ON) a tierra (pin 17-18). Si no enciende: PSU muerta').
componente_afectado(psu_rail_5v_standby_muerto, 'PSU').

diagnostico(psu_voltaje_inestable_12v) :-
    sintoma(reinicios_espontaneos, si),
    sintoma(apagado_subito, si),
    sintoma(voltaje_inestable, si),
    sintoma(zumbido_bobinas, si).
explicacion(psu_voltaje_inestable_12v, 'Rail 12V oscila entre 10V-14V - Capacitores de filtro agotados').
solucion(psu_voltaje_inestable_12v, 'MEDIR ripple con osciloscopio >50mV pico-pico. Reemplazar capacitores electrolíticos 2200uF 16V o PSU completa. Urgencia: ALTA').
componente_afectado(psu_voltaje_inestable_12v, 'PSU').

% 11-20: PROBLEMAS DE CARGA/CORRIENTE
diagnostico(psu_overcurrent_protection) :-
    sintoma(apagado_subito, si),
    sintoma(enciende, si),
    sintoma(reinicios_espontaneos, si),
    sintoma(olor_quemado, no).
explicacion(psu_overcurrent_protection, 'Protección OCP activada - Exceso de corriente en algún rail').
solucion(psu_overcurrent_protection, 'DESCONECTAR todos los dispositivos. Probar PSU sola. Conectar uno por uno hasta identificar componente en corto. GPU y motherboard comunes').
componente_afectado(psu_overcurrent_protection, 'PSU').

diagnostico(psu_power_good_signal_fallo) :-
    sintoma(enciende, si),
    sintoma(ventiladores, si),
    sintoma(pantalla_enciende, no),
    sintoma(pitidos_post, no).
explicacion(psu_power_good_signal_fallo, 'Señal Power Good no se genera - Motherboard no recibe señal de "todo OK"').
solucion(psu_power_good_signal_fallo, 'MEDIR: Pin 8 del conector 24-pin (PWR_OK) - Debe ser 3-5V después de 100-500ms del encendido. Si 0V: PSU defectuosa').
componente_afectado(psu_power_good_signal_fallo, 'PSU').

% 21-30: PROBLEMAS FÍSICOS/MECÁNICOS
diagnostico(psu_ventilador_bloqueado_polvo) :-
    sintoma(sobrecalentamiento, si),
    sintoma(apagado_termico, si),
    sintoma(ventilador_ruidoso, si),
    sintoma(polvo_acumulado, si).
explicacion(psu_ventilador_bloqueado_polvo, 'Ventilador PSU bloqueado por polvo - Sobrecalentamiento interno').
solucion(psu_ventilador_bloqueado_polvo, 'LIMPIAR PSU con aire comprimido. ATENCIÓN: Capacitores pueden mantener carga mortal. Si no gira: Reemplazar ventilador 120/140mm').
componente_afectado(psu_ventilador_bloqueado_polvo, 'PSU').

diagnostico(psu_capacitores_hinchados_visibles) :-
    sintoma(olor_ozono, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(voltaje_inestable, si).
explicacion(psu_capacitores_hinchados_visibles, 'Capacitores electrolíticos hinchados o con fugas - Filtrado insuficiente').
solucion(psu_capacitores_hinchados_visibles, 'INSPECCIONAR visualmente capacitores en PCB PSU. Buscar tops hinchados, bases con residuos marrones. Reemplazar con mismos valores (uF, V, temperatura)').
componente_afectado(psu_capacitores_hinchados_visibles, 'PSU').

% ========================================
% PSU - VERSIONES FLEXIBLES
% ========================================

% PSU muerta - versión flexible (solo 3 síntomas)
diagnostico(psu_posiblemente_muerta) :-
    sintoma(enciende, no),
    sintoma(led_power, no),
    sintoma(ventiladores, no).
explicacion(psu_posiblemente_muerta, 'PSU probablemente muerta - No llega voltaje a componentes principales').
solucion(psu_posiblemente_muerta, 'TEST PAPERCLIP: 1) Desconectar PSU del motherboard, 2) Puentear pin 16 (verde/PS_ON) con pin 17-18 (negro/GND) en conector 24-pin, 3) Enchufar PSU, 4) Si ventilador PSU NO gira = PSU muerta. MEDIR con multímetro voltajes en conector 24-pin. COSTO: $60-200 USD nueva PSU').
componente_afectado(psu_posiblemente_muerta, 'PSU').

% PSU con voltaje inestable - versión flexible
diagnostico(psu_voltaje_inestable) :-
    sintoma(reinicios_espontaneos, si),
    sintoma(enciende, si).
explicacion(psu_voltaje_inestable, 'PSU con voltajes inestables - Causa reinicios aleatorios').
solucion(psu_voltaje_inestable, 'VERIFICAR: 1) PSU tiene potencia suficiente para componentes, 2) Calcular consumo total (CPU+GPU+resto), 3) Probar con otra PSU conocida, 4) Revisar Event Viewer para error Kernel-Power 41. COSTO: $60-200 USD PSU nueva').
componente_afectado(psu_voltaje_inestable, 'PSU').

% PSU insuficiente para componentes
diagnostico(psu_potencia_insuficiente) :-
    sintoma(apagado_subito, si),
    sintoma(gpu_detectada, si).
explicacion(psu_potencia_insuficiente, 'PSU sin potencia suficiente - Se apaga bajo carga (juegos, renders)').
solucion(psu_potencia_insuficiente, 'CALCULAR consumo: GPU high-end (250-450W) + CPU (65-250W) + resto (100W). PSU debe tener 20-30% margen. EJEMPLO: RTX 4070 (200W) + Ryzen 7 (105W) + 100W = 405W → Necesita PSU 550W mínimo. UPGRADE PSU recomendado').
componente_afectado(psu_potencia_insuficiente, 'PSU').

% PSU con olor a quemado
diagnostico(psu_componente_quemado) :-
    sintoma(olor_quemado, si),
    sintoma(enciende, no).
explicacion(psu_componente_quemado, 'Componente quemado en PSU - Olor característico a electrónica quemada').
solucion(psu_componente_quemado, 'PELIGRO: NO encender equipo. PSU con componente quemado puede dañar motherboard/GPU. INSPECCIONAR PSU visualmente (capacitores hinchados, marcas de quemado). REEMPLAZAR PSU inmediatamente. NO reparar DIY - riesgo eléctrico alto').
componente_afectado(psu_componente_quemado, 'PSU').

% PSU con protección OCP activada
diagnostico(psu_proteccion_ocp_activada) :-
    sintoma(apagado_subito, si),
    sintoma(enciende, si).
explicacion(psu_proteccion_ocp_activada, 'Protección OCP (Over Current Protection) activándose - Algún componente demanda corriente excesiva').
solucion(psu_proteccion_ocp_activada, 'DIAGNÓSTICO: Desconectar componentes uno por uno y probar. ORDEN: 1) GPU, 2) Discos secundarios, 3) RAM adicional, 4) Periféricos USB. Componente que causa apagado = corto o falla. COMÚN: GPU con VRM dañado, disco en corto').
componente_afectado(psu_proteccion_ocp_activada, 'PSU/Componente en corto').

% ========================================
% REGLAS CPU - 30 DIAGNÓSTICOS ESPECÍFICOS  
% ========================================

% 1-10: PROBLEMAS DE DETECCIÓN/POST
diagnostico(cpu_no_detectado_socket_sucio) :-
    sintoma(cpu_reconocido_correctamente, no),
    sintoma(enciende, si),
    sintoma(pitidos_post, si),
    sintoma(patron_pitidos, 5).
explicacion(cpu_no_detectado_socket_sucio, 'Socket CPU con pines/pads sucios/oxidados - Contacto eléctrico pobre').
solucion(cpu_no_detectado_socket_sucio, 'LIMPIAR: Para Intel LGA: Limpiar pads CPU con alcohol isopropílico 99%. Para AMD PGA: Limpiar pines socket con aire comprimido. NO USAR líquidos en socket').
componente_afectado(cpu_no_detectado_socket_sucio, 'CPU').

diagnostico(cpu_pines_doblados_amd) :-
    sintoma(cpu_reconocido_correctamente, no),
    sintoma(nucleos_detectados, no),
    sintoma(recientemente_instalo_hardware, si).
explicacion(cpu_pines_doblados_amd, 'Pines doblados en CPU AMD - Contactos críticos sin conexión').
solucion(cpu_pines_doblados_amd, 'INSPECCIONAR con lupa. Enderezar con tarjeta plástica o aguja mecánica. EXTREMO CUIDADO: Pines se rompen fácilmente. Costo reparación: $0-300 USD').
componente_afectado(cpu_pines_doblados_amd, 'CPU').

% 11-20: PROBLEMAS TÉRMICOS ESPECÍFICOS
diagnostico(cpu_sobrecalentamiento_pasta_secada) :-
    sintoma(temp_cpu_idle, si),
    sintoma(temp_cpu_carga, si),
    sintoma(pasta_termica_vieja, si),
    sintoma(apagado_termico, si).
explicacion(cpu_sobrecalentamiento_pasta_secada, 'Pasta térmica completamente seca - Conductividad térmica <10% del original').
solucion(cpu_sobrecalentamiento_pasta_secada, 'REMPLAZAR pasta térmica: Limpiar IHS y cooler con alcohol. Aplicar grano tamaño arveja. Montar cooler con presión uniforme. Recomendado: Arctic MX-6, Thermal Grizzly Kryonaut').
componente_afectado(cpu_sobrecalentamiento_pasta_secada, 'CPU').

diagnostico(cpu_cooler_montaje_incorrecto) :-
    sintoma(temp_cpu_idle, si),
    sintoma(sobrecalentamiento, si),
    sintoma(recientemente_instalo_hardware, si).
explicacion(cpu_cooler_montaje_incorrecto, 'Cooler mal montado - Contacto irregular IHS/cooler').
solucion(cpu_cooler_montaje_incorrecto, 'REMONTAR cooler: Verificar que plástico protector fue removido. Apretar tornillos en patrón X (no circular). Presión debe ser uniforme').
componente_afectado(cpu_cooler_montaje_incorrecto, 'CPU').

% 21-30: PROBLEMAS ELÉCTRICOS/PERFORMANCE
diagnostico(cpu_voltage_regulation_module_fallo) :-
    sintoma(cpu_throttling, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(frecuencia_cpu_correcta, no).
explicacion(cpu_voltage_regulation_module_fallo, 'VRM motherboard no puede mantener voltaje estable al CPU').
solucion(cpu_voltage_regulation_module_fallo, 'MONITOREAR voltajes con HWiNFO64. Si Vcore oscila >0.1V: Problema de motherboard. Agregar ventilación a VRM o reducir consumo CPU').
componente_afectado(cpu_voltage_regulation_module_fallo, 'CPU').

diagnostico(cpu_degradacion_silicio) :-
    sintoma(congelamientos, si),
    sintoma(aplicaciones_crash, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(overclock_activo, si).
explicacion(cpu_degradacion_silicio, 'Degradación por overclock/voltaje excesivo - Transistores internos dañados').
solucion(cpu_degradacion_silicio, 'REDUCIR frecuencia y voltaje a valores stock. Si persiste: CPU permanentemente dañado. Reemplazar. Prevención: No exceder 1.4V en CPUs modernos').
componente_afectado(cpu_degradacion_silicio, 'CPU').


% ========================================
% CPU - VERSIONES FLEXIBLES
% ========================================

% CPU no detectado - versión flexible
diagnostico(cpu_no_detectado) :-
    sintoma(cpu_reconocido_correctamente, no),
    sintoma(enciende, si).
explicacion(cpu_no_detectado, 'CPU no reconocido correctamente - Problema de detección o compatibilidad').
solucion(cpu_no_detectado, 'VERIFICAR: 1) BIOS actualizado (CPU nuevos requieren BIOS específico), 2) CPU bien insertado, 3) Pines CPU (AMD) o socket (Intel) sin daño, 4) Limpiar contactos con alcohol isopropílico 99%, 5) Probar con BIOS flashback si disponible. COSTO: $0 si solo es BIOS, $300+ si CPU/motherboard dañado').
componente_afectado(cpu_no_detectado, 'CPU/Motherboard').

% CPU sobrecalentado - versión flexible
diagnostico(cpu_sobrecalentado) :-
    sintoma(temp_cpu_carga, si),
    sintoma(enciende, si).
explicacion(cpu_sobrecalentado, 'CPU con temperaturas peligrosas bajo carga - >85°C puede causar daño permanente').
solucion(cpu_sobrecalentado, 'URGENTE - SOLUCIÓN INMEDIATA: 1) Verificar cooler montado correctamente, 2) Renovar pasta térmica (aplicar grano tamaño arveja), 3) Ventilador cooler girando, 4) Airflow case correcto, 5) Considerar cooler más potente. PASTA RECOMENDADA: Arctic MX-6, Thermal Grizzly Kryonaut. COSTO: $5-60 USD').
componente_afectado(cpu_sobrecalentado, 'CPU/Cooler').

% CPU throttling - versión flexible
diagnostico(cpu_throttling_detectado) :-
    sintoma(cpu_throttling, si).
explicacion(cpu_throttling_detectado, 'CPU reduciendo frecuencia por protección térmica o power limit').
solucion(cpu_throttling_detectado, 'DIAGNÓSTICO: Usar HWiNFO64 para ver: 1) THERMAL THROTTLING = problema refrigeración, 2) POWER LIMIT THROTTLING = VRM motherboard insuficiente o power limits muy bajos, 3) CURRENT LIMIT = PSU insuficiente. SOLUCIÓN según tipo de throttling detectado').
componente_afectado(cpu_throttling_detectado, 'CPU/Cooler/Motherboard').

% CPU uso 100% constante
diagnostico(cpu_uso_alto_constante) :-
    sintoma(uso_cpu_100, si).
explicacion(cpu_uso_alto_constante, 'CPU al 100% constantemente - Problema de software/malware o cooler insuficiente').
solucion(cpu_uso_alto_constante, 'VERIFICAR: 1) Task Manager → Procesos ordenados por CPU, 2) Identificar proceso culpable, 3) Malware scan (Malwarebytes), 4) Temperatures normales (si altas = throttling), 5) Actualizar Windows/drivers. COMÚN: Windows Update, antivirus, malware, driver bugueado').
componente_afectado(cpu_uso_alto_constante, 'Software/CPU').

% CPU cooler no funciona
diagnostico(cpu_cooler_no_funciona) :-
    sintoma(temp_cpu_idle, si),
    sintoma(ventilador_detenido, si).
explicacion(cpu_cooler_no_funciona, 'Ventilador CPU no gira - Temperatura idle muy alta indica falta de refrigeración').
solucion(cpu_cooler_no_funciona, 'URGENTE: NO usar PC hasta solucionar. VERIFICAR: 1) Cable ventilador conectado a header CPU_FAN, 2) Probar ventilador en otro header, 3) Ventilador bloqueado por cables/polvo, 4) BIOS muestra RPM ventilador. Si ventilador muerto: Reemplazar inmediatamente. COSTO: $15-100 USD nuevo cooler').
componente_afectado(cpu_cooler_no_funciona, 'Cooler CPU').

% ========================================
% REGLAS RAM - 30 DIAGNÓSTICOS ESPECÍFICOS
% ========================================

% 1-10: PROBLEMAS DE DETECCIÓN
diagnostico(ram_modulo_completamente_muerto) :-
    sintoma(ram_detectada, no),
    sintoma(pitidos_post, si),
    sintoma(patron_pitidos, 3),
    sintoma(cantidad_ram_detectada, '0GB').
explicacion(ram_modulo_completamente_muerto, 'Módulo RAM completamente sin respuesta - No detectado en POST').
solucion(ram_modulo_completamente_muerto, 'PROBAR cada módulo individualmente en slot A2. Si ninguno detecta: Verificar voltaje DRAM en BIOS (debe ser 1.2V para JEDEC, 1.35V para XMP). Reemplazar módulo muerto').
componente_afectado(ram_modulo_completamente_muerto, 'RAM').

diagnostico(ram_slot_motherboard_danado) :-
    sintoma(ram_detectada, parcial),
    sintoma(cantidad_ram_detectada, '50%'),
    sintoma(memtest_errores, si),
    sintoma(ubicacion_error_ram, direccion_especifica).
explicacion(ram_slot_motherboard_danado, 'Slot DIMM físico dañado - Pines doblados o trazas rotas').
solucion(ram_slot_motherboard_danado, 'PROBAR mismos módulos en diferentes slots. Si errores persisten en mismo slot físico: Slot dañado. Usar otros slots o reemplazar motherboard').
componente_afectado(ram_slot_motherboard_danado, 'Motherboard').

diagnostico(ram_incompatible_jedec_profile) :-
    sintoma(ram_detectada, si),
    sintoma(ram_a_velocidad_maxima, no),
    sintoma(xmp_activado, no),
    sintoma(velocidad_lenta, si).
explicacion(ram_incompatible_jedec_profile, 'RAM corriendo a velocidad mínima (2133MHz) - Perfiles JEDEC no compatibles').
solucion(ram_incompatible_jedec_profile, 'ACTIVAR XMP/DOCP en BIOS. Si inestable: Configurar manualmente frecuencia, timings y voltaje según especificaciones del módulo').
componente_afectado(ram_incompatible_jedec_profile, 'RAM').

% 11-20: PROBLEMAS DE ESTABILIDAD
diagnostico(ram_xmp_inestable_imc_debil) :-
    sintoma(xmp_activado, si),
    sintoma(memtest_errores, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(aplicaciones_crash, si).
explicacion(ram_xmp_inestable_imc_debil, 'Integrated Memory Controller no soporta frecuencia/timings XMP').
solucion(ram_xmp_inestable_imc_debil, 'REDUCIR frecuencia RAM en incrementos de 100MHz. Aumentar voltaje VCCSA/VDDQ (Intel) o VSOC (AMD) +0.05V. Probar estabilidad con TestMem5').
componente_afectado(ram_xmp_inestable_imc_debil, 'RAM').

diagnostico(ram_timings_muy_apretados) :-
    sintoma(memtest_errores, si),
    sintoma(xmp_activado, si),
    sintoma(congelamientos, si),
    sintoma(ram_a_velocidad_maxima, si).
explicacion(ram_timings_muy_apretados, 'Timings primarios (CL-tRCD-tRP-tRAS) demasiado agresivos para los chips').
solucion(ram_timings_muy_apretados, 'AFLQJAR timings: CL+2, tRCD+2, tRP+2, tRAS+4. Ejemplo: CL16-18-18-38 -> CL18-20-20-42. Verificar estabilidad').
componente_afectado(ram_timings_muy_apretados, 'RAM').

diagnostico(ram_temperature_related_errors) :-
    sintoma(memtest_errores, si),
    sintoma(sobrecalentamiento, si),
    sintoma(congelamientos, si),
    sintoma(ram_a_velocidad_maxima, si).
explicacion(ram_temperature_related_errors, 'RAM supera 50°C - Errores aumentan exponencialmente con temperatura').
solucion(ram_temperature_related_errors, 'INSTALAR heatsinks RAM o ventilador directo. Reducir voltaje DRAM si posible. Monitorear temp con HWiNFO64').
componente_afectado(ram_temperature_related_errors, 'RAM').

% 21-30: PROBLEMAS AVANZADOS
diagnostico(ram_rank_interleave_problema) :-
    sintoma(dual_channel_activo, no),
    sintoma(ram_detectada, si),
    sintoma(slots_ocupados, 4),
    sintoma(velocidad_lenta, si).
explicacion(ram_rank_interleave_problema, 'Problema con interleaving entre ranks - Performance degradada').
solucion(ram_rank_interleave_problema, 'VERIFICAR manual motherboard slots correctos para 4 DIMMs. Usar módulos idénticos. Mejorar flujo de aire sobre RAM').
componente_afectado(ram_rank_interleave_problema, 'RAM').

diagnostico(ram_power_delivery_insuficiente) :-
    sintoma(memtest_errores, si),
    sintoma(reinicios_aleatorios, si),
    sintoma(xmp_activado, si).
explicacion(ram_power_delivery_insuficiente, 'Voltaje DRAM insuficiente bajo carga - Drops de voltaje').
solucion(ram_power_delivery_insuficiente, 'AUMENTAR voltaje DRAM de 1.35V a 1.40V (máximo seguro para daily). Verificar con osciloscopio si hay droop').
componente_afectado(ram_power_delivery_insuficiente, 'RAM').

diagnostico(ram_refresh_rate_problema) :-
    sintoma(memtest_errores, si),
    sintoma(aplicaciones_crash, si),
    sintoma(archivos_corruptos, si).
explicacion(ram_refresh_rate_problema, 'tREFI demasiado alto - Celdas no se refrescan a tiempo').
solucion(ram_refresh_rate_problema, 'REDUCIR tREFI de 65535 a 32767 o menos. Aumentar tRFC proporcionalmente. Trade-off: menor latency vs mayor estabilidad').
componente_afectado(ram_refresh_rate_problema, 'RAM').

diagnostico(ram_contactos_sucios) :-
    sintoma(ram_detectada, intermitente),
    sintoma(reinicios_aleatorios, si),
    sintoma(pitidos_post, si).
explicacion(ram_contactos_sucios, 'Contactos dorados oxidados/sucios - Resistencia eléctrica alta').
solucion(ram_contactos_sucios, 'LIMPIAR contactos con goma de borrar blanca y alcohol isopropílico 99%. Secar completamente antes de reinstalar').
componente_afectado(ram_contactos_sucios, 'RAM').

% ========================================
% RAM - VERSIONES FLEXIBLES
% ========================================

% RAM no detectada - versión flexible
diagnostico(ram_no_detectada) :-
    sintoma(ram_detectada, no).
explicacion(ram_no_detectada, 'RAM no detectada o detectada incorrectamente - Problema de módulos o slots').
solucion(ram_no_detectada, 'PROCEDIMIENTO: 1) APAGAR, desconectar PSU, 2) Remover TODA la RAM, 3) Insertar UN módulo en slot A2 (segundo desde CPU), 4) Encender - Si detecta: Agregar módulos uno por uno, 5) Si NO detecta: Probar módulo en otro slot, 6) Limpiar contactos dorados con goma de borrar. COMÚN: RAM no insertada completamente (requiere fuerza, debe hacer CLICK)').
componente_afectado(ram_no_detectada, 'RAM/Motherboard').

% RAM con errores - versión flexible
diagnostico(ram_con_errores) :-
    sintoma(memtest_errores, si).
explicacion(ram_con_errores, 'RAM presenta errores en MemTest86 - Módulo defectuoso o configuración inestable').
solucion(ram_con_errores, 'DIAGNÓSTICO: 1) Ejecutar MemTest86 con UN módulo a la vez, 2) Identificar módulo defectuoso, 3) Si TODOS fallan: Problema de motherboard/IMC CPU, 4) Si XMP activo: Deshabilitar y probar, 5) Errores en dirección específica = chip específico dañado. REEMPLAZAR módulo defectuoso bajo garantía si aplica').
componente_afectado(ram_con_errores, 'RAM').

% RAM XMP inestable - versión flexible
diagnostico(ram_xmp_inestable) :-
    sintoma(xmp_activado, si),
    sintoma(reinicios_aleatorios, si).
explicacion(ram_xmp_inestable, 'Perfil XMP/DOCP causando inestabilidad - IMC CPU no soporta frecuencia/timings').
solucion(ram_xmp_inestable, 'SOLUCIÓN: 1) Deshabilitar XMP en BIOS → Probar estabilidad, 2) Si estable: Reducir frecuencia RAM manualmente (ej: 3600→3200 MHz), 3) Aumentar voltaje DRAM de 1.35V a 1.40V, 4) Actualizar BIOS (mejora compatibilidad RAM), 5) Configurar timings manualmente más relajados. TRADE-OFF: Estabilidad > Performance mínima perdida').
componente_afectado(ram_xmp_inestable, 'RAM/CPU IMC').

% RAM dual channel no activo
diagnostico(ram_dual_channel_inactivo) :-
    sintoma(dual_channel_activo, no),
    sintoma(ram_detectada, si).
explicacion(ram_dual_channel_inactivo, 'RAM no corriendo en Dual Channel - Performance reducida 30-50%').
solucion(ram_dual_channel_inactivo, 'CONFIGURACIÓN CORRECTA: Para 2 módulos usar slots A2+B2 (segundo y cuarto desde CPU). Para 4 módulos: Todos ocupados. VERIFICAR: 1) Task Manager → Performance → Memory → Channels usado, 2) CPU-Z → Memory → Channel, 3) Reinsertar RAM en slots correctos según manual motherboard').
componente_afectado(ram_dual_channel_inactivo, 'RAM/Configuración').

% RAM velocidad incorrecta
diagnostico(ram_velocidad_incorrecta) :-
    sintoma(ram_a_velocidad_maxima, no),
    sintoma(ram_detectada, si).
explicacion(ram_velocidad_incorrecta, 'RAM corriendo a velocidad menor que especificación - Stuck en JEDEC 2133/2400 MHz').
solucion(ram_velocidad_incorrecta, 'ACTIVAR XMP/DOCP: 1) Entrar BIOS (DEL/F2 al encender), 2) Buscar "XMP" (Intel) o "DOCP/EOCP" (AMD), 3) Activar perfil 1, 4) Guardar y salir (F10), 5) Verificar con CPU-Z → Memory → DRAM Frequency (mostrar la mitad: 1800MHz = 3600MHz efectivo). Si inestable: Ver solución ram_xmp_inestable').
componente_afectado(ram_velocidad_incorrecta, 'RAM/Configuración BIOS').

% ========================================
% REGLAS ALMACENAMIENTO - 30 DIAGNÓSTICOS ESPECÍFICOS
% ========================================

% 1-10: HDD MECÁNICOS
diagnostico(hdd_click_of_death) :-
    sintoma(ruidos_disco, si),
    sintoma(ruido_tipo, click_repetitivo),
    sintoma(disco_detectado, no),
    sintoma(archivos_corruptos, si).
explicacion(hdd_click_of_death, 'Cabezales atascados - No pueden posicionarse en pistas').
solucion(hdd_click_of_death, 'APAGAR inmediatamente. No intentar recuperación DIY. Servicio profesional clean room required. Costo: $300-2000 USD').
componente_afectado(hdd_click_of_death, 'HDD').

diagnostico(hdd_motor_spindle_fallo) :-
    sintoma(ruidos_disco, no),
    sintoma(disco_detectado, no),
    sintoma(ruido_tipo, silencio_total).
explicacion(hdd_motor_spindle_fallo, 'Motor spindle no gira - Platos inmóviles').
solucion(hdd_motor_spindle_fallo, 'PROBAR con fuente de poder externa. Si motor no arranca: Reemplazar HDD. Recovery posible con reemplazo de PCB + transferencia ROM').
componente_afectado(hdd_motor_spindle_fallo, 'HDD').

diagnostico(hdd_head_crash) :-
    sintoma(ruidos_disco, si),
    sintoma(ruido_tipo, chirrido_metalico),
    sintoma(golpe_caida, si),
    sintoma(archivos_corruptos, si).
explicacion(hdd_head_crash, 'Cabezales contactaron superficie platos - Rayones físicos').
solucion(hdd_head_crash, 'DETENER uso inmediatamente. Cada encendido empeora daño. Recovery profesional solamente. No abrir HDD - contaminación por partículas').
componente_afectado(hdd_head_crash, 'HDD').

diagnostico(hdd_smart_critical_parameters) :-
    sintoma(smart_warnings, si),
    sintoma(sectores_realocados, '>100'),
    sintoma(velocidad_lenta, si),
    sintoma(errores_lectura, si).
explicacion(hdd_smart_critical_parameters, 'Parámetros SMART críticos: Reallocated Sectors > 100, Current Pending Sector Count > 0').
solucion(hdd_smart_critical_parameters, 'BACKUP urgente. Reemplazar HDD inmediatamente. Usar CrystalDiskInfo para monitoreo continuo').
componente_afectado(hdd_smart_critical_parameters, 'HDD').

% 11-20: SSD PROBLEMAS ELECTRÓNICOS
diagnostico(ssd_controller_muerto) :-
    sintoma(ssd_no_reconocido, si),
    sintoma(disco_detectado, no),
    sintoma(olor_quemado, no),
    sintoma(m2_slot_funciona, si).
explicacion(ssd_controller_muerto, 'Controlador SSD (Phison/Samsung/SMI) falló - No responde a comandos').
solucion(ssd_controller_muerto, 'PROBAR en otro puerto/PC. Si no detecta: Controller muerto. Recovery a nivel chip posible pero costoso ($400-1500 USD)').
componente_afectado(ssd_controller_muerto, 'SSD').

diagnostico(ssd_nand_wear_out) :-
    sintoma(ssd_ralentizado, si),
    sintoma(smart_warnings, si),
    sintoma(velocidad_lenta, si),
    sintoma(errores_lectura, si).
explicacion(ssd_nand_wear_out, 'Celdas NAND agotadas - Media Wearout Indicator (SMART E9) > 90%').
solucion(ssd_nand_wear_out, 'VERIFICAR SMART atributo 233 "Media Wearout Indicator". Si > 90%: Backup urgente y reemplazar SSD. No confiable para datos importantes').
componente_afectado(ssd_nand_wear_out, 'SSD').

diagnostico(ssd_dram_cache_corrupto) :-
    sintoma(ssd_ralentizado, si),
    sintoma(congelamientos, si),
    sintoma(disco_desaparece, si).
explicacion(ssd_dram_cache_corrupto, 'Cache DRAM del SSD corrupto - Mapping table errors').
solucion(ssd_dram_cache_corrupto, 'ACTUALIZAR firmware SSD. Ejecutar Secure Erase. Si persiste: SSD defectuoso, reemplazar').
componente_afectado(ssd_dram_cache_corrupto, 'SSD').

% 21-30: PROBLEMAS CONECTIVIDAD/INTERFACES
diagnostico(nvme_thermal_throttling_severo) :-
    sintoma(nvme_throttling, si),
    sintoma(sobrecalentamiento, si),
    sintoma(ssd_ralentizado, si),
    sintoma(velocidad_lenta, si).
explicacion(nvme_thermal_throttling_severo, 'NVMe SSD > 80°C - Throttling reduce velocidad a 1/3 de capacidad').
solucion(nvme_thermal_throttling_severo, 'INSTALAR heatsink M.2 con thermal pads de alta conductividad. Mejorar flujo de aire case. Considerar SSD con heatsink integrado').
componente_afectado(nvme_thermal_throttling_severo, 'SSD').

diagnostico(sata_cable_defectuoso) :-
    sintoma(disco_desaparece, si),
    sintoma(errores_lectura, si),
    sintoma(velocidad_lenta, si),
    sintoma(disco_detectado, intermitente).
explicacion(sata_cable_defectuoso, 'Cable SATA con conductores rotos/intermitentes - Error rate alto').
solucion(sata_cable_defectuoso, 'REEMPLAZAR cable SATA. Usar cables con conectores metálicos y trabas. Máximo 50cm de longitud. Verificar conexión firme').
componente_afectado(sata_cable_defectuoso, 'Cables').

diagnostico(m2_slot_pcie_lanes_conflicto) :-
    sintoma(ssd_no_reconocido, si),
    sintoma(m2_slot_funciona, no),
    sintoma(sata_ports_funcionan, no).
explicacion(m2_slot_pcie_lanes_conflicto, 'Slot M.2 comparte lanes PCIe con puertos SATA - Conflicto de recursos').
solucion(m2_slot_pcie_lanes_conflicto, 'CONSULTAR manual motherboard. Algunos slots M.2 deshabilitan puertos SATA específicos. Usar slot M.2 que no comparta recursos').
componente_afectado(m2_slot_pcie_lanes_conflicto, 'Motherboard').

diagnostico(usb_external_disk_power_insufficient) :-
    sintoma(disco_desaparece, si),
    sintoma(usb_velocidad_lenta, si),
    sintoma(dispositivos_no_reconocidos, si).
explicacion(usb_external_disk_power_insufficient, 'Disco externo no recibe suficiente potencia por USB - Drops de voltaje').
solucion(usb_external_disk_power_insufficient, 'USAR cable Y-splitter con dos puertos USB. Conectar a puertos USB posteriores (más potencia). Evitar hubs USB no alimentados').
componente_afectado(usb_external_disk_power_insufficient, 'USB/PSU').

% ========================================
% REGLAS GPU - 30 DIAGNÓSTICOS ESPECÍFICOS
% ========================================

% 1-10: PROBLEMAS DE DETECCIÓN/POWER
diagnostico(gpu_no_detectada_power_insuficiente) :-
    sintoma(gpu_detectada, no),
    sintoma(pantalla_enciende, no),
    sintoma(ventiladores_gpu_giran, no),
    sintoma(enciende, si).
explicacion(gpu_no_detectada_power_insuficiente, 'GPU no recibe suficiente potencia - Cables PCIe incompletos o PSU insuficiente').
solucion(gpu_no_detectada_power_insuficiente, 'VERIFICAR todos cables PCIe: 6-pin + 8-pin requeridos. Usar cables separados, no daisy-chain. PSU mínimo: 550W para mid-range, 750W+ para high-end').
componente_afectado(gpu_no_detectada_power_insuficiente, 'GPU/PSU').

diagnostico(gpu_pcie_slot_compatibility_issue) :-
    sintoma(gpu_detectada, no),
    sintoma(slots_pcie_funcionan, parcial),
    sintoma(mensaje_no_signal, si).
explicacion(gpu_pcie_slot_compatibility_issue, 'GPU en slot PCIe incorrecto - Slot x16 físico pero eléctrico x4, o PCIe generación mismatch').
solucion(gpu_pcie_slot_compatibility_issue, 'USAR slot PCIe x16 superior (generalmente más cercano a CPU). Verificar en BIOS que corre a x16. Forzar PCIe Gen3 si GPU Gen4 en motherboard vieja').
componente_afectado(gpu_pcie_slot_compatibility_issue, 'GPU/Motherboard').

% 11-20: PROBLEMAS TÉRMICOS ESPECÍFICOS
diagnostico(gpu_thermal_paste_dried_out) :-
    sintoma(temp_gpu_idle, si),
    sintoma(temp_gpu_carga, si),
    sintoma(gpu_throttling, si),
    sintoma(pasta_termica_vieja, si).
explicacion(gpu_thermal_paste_dried_out, 'Pasta térmica GPU seca - Delta > 40°C entre idle y carga').
solucion(gpu_thermal_paste_dried_out, 'REPISTAR GPU: Remover cooler, limpiar die GPU y base cooler con alcohol 99%, aplicar pasta térmica de alta conductividad (Thermal Grizzly, Arctic MX-6)').
componente_afectado(gpu_thermal_paste_dried_out, 'GPU').

diagnostico(gpu_vrm_overheating) :-
    sintoma(gpu_throttling, si),
    sintoma(temp_gpu_carga, no),
    sintoma(coil_whine_gpu, si),
    sintoma(pantallazos_negros, si).
explicacion(gpu_vrm_overheating, 'VRM GPU sobrecalentado - Throttling ocurre antes de que GPU alcance temperatura crítica').
solucion(gpu_vrm_overheating, 'MEJORAR refrigeración VRM: Agregar thermal pads a fases VRM, instalar ventilador directo, o waterblock completo. Monitorear temp VRM con HWiNFO64 si soportado').
componente_afectado(gpu_vrm_overheating, 'GPU').

diagnostico(gpu_fan_bearing_failure) :-
    sintoma(ventilador_ruidoso, si),
    sintoma(ventilador_vibra, si),
    sintoma(temp_gpu_idle, si),
    sintoma(ventiladores_gpu_giran, si).
explicacion(gpu_fan_bearing_failure, 'Rodamientos ventilador GPU desgastados - Ruido mecánico y vibración').
solucion(gpu_fan_bearing_failure, 'REEMPLAZAR ventiladores GPU. Buscar modelo específico en AliExpress/Amazon, o instalar cooler aftermarket (Arctic Accelero, Raijintek Morpheus)').
componente_afectado(gpu_fan_bearing_failure, 'GPU').

% 21-30: PROBLEMAS DE RENDIMIENTO/ARTEFACTOS
diagnostico(gpu_vram_failure_specific_chip) :-
    sintoma(artifactos_gpu, si),
    sintoma(artifactos_3d, si),
    sintoma(driver_crashed, si),
    sintoma(pantallazos_negros, si).
explicacion(gpu_vram_failure_specific_chip, 'Chip VRAM específico fallando - Artefactos consistentes en misma ubicación pantalla').
solucion(gpu_vram_failure_specific_chip, 'EJECUTOR MATS/MODS memory test para identificar chip específico. Reparación requiere reballing BGA profesional. Costo: $150-400 USD').
componente_afectado(gpu_vram_failure_specific_chip, 'GPU').

diagnostico(gpu_core_degradation_from_mining) :-
    sintoma(driver_crashed, si),
    sintoma(fps_bajos, si),
    sintoma(gpu_throttling, si),
    sintoma(artifactos_gpu, intermitente).
explicacion(gpu_core_degradation_from_mining, 'Core GPU degradado por uso intensivo 24/7 - Silicio perdió propiedades').
solucion(gpu_core_degradation_from_mining, 'APLICAR undervolting: Reducir voltaje core 50-100mV, reducir frecuencia 100-200MHz. Si persiste: GPU permanentemente dañada').
componente_afectado(gpu_core_degradation_from_mining, 'GPU').

diagnostico(gpu_driver_conflict_cleanup_needed) :-
    sintoma(driver_crashed, si),
    sintoma(pantallazos_negros, si),
    sintoma(recientemente_actualizo_drivers, si).
explicacion(gpu_driver_conflict_cleanup_needed, 'Conflictos entre versiones driver - Archivos residuales causan inestabilidad').
solucion(gpu_driver_conflict_cleanup_needed, 'DDU (Display Driver Uninstaller) en modo seguro. Reinstalar drivers estables (no beta). Verificar que no hay conflictos Intel/NVIDIA o AMD/NVIDIA').
componente_afectado(gpu_driver_conflict_cleanup_needed, 'GPU/Software').

diagnostico(gpu_power_limit_throttling) :-
    sintoma(gpu_throttling, si),
    sintoma(fps_bajos, si),
    sintoma(temp_gpu_carga, no),
    sintoma(pantallazos_negros, no).
explicacion(gpu_power_limit_throttling, 'GPU alcanza power limit - Reduce clocks para mantenerse dentro de TDP').
solucion(gpu_power_limit_throttling, 'AUMENTAR power limit en MSI Afterburner (+10-20%). Mejorar alimentación: Verificar cables PCIe, PSU capacidad. Undervolt para mejor eficiencia').
componente_afectado(gpu_power_limit_throttling, 'GPU').

diagnostico(gpu_pcie_bus_contention) :-
    sintoma(fps_bajos, si),
    sintoma(velocidad_lenta, si),
    sintoma(gpu_detectada, si),
    sintoma(ssd_no_reconocido, si).
explicacion(gpu_pcie_bus_contention, 'GPU compite por ancho de banda PCIe con otros dispositivos').
solucion(gpu_pcie_bus_contention, 'MOVOR GPU a slot x16 dedicado. Mover NVMe a slot que no comparta lanes. Deshabilitar dispositivos PCIe no esenciales').
componente_afectado(gpu_pcie_bus_contention, 'GPU/Motherboard').

% ========================================
% REGLAS MOTHERBOARD - 30 DIAGNÓSTICOS ESPECÍFICOS
% ========================================

% 1-10: PROBLEMAS BIOS/POST
diagnostico(motherboard_bios_corruption) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, no),
    sintoma(pitidos_post, no),
    sintoma(led_power, si).
explicacion(motherboard_bios_corruption, 'BIOS/UEFI corrupto - No pasa POST, no hay beep codes').
solucion(motherboard_bios_corruption, 'USAR BIOS recovery: Botón Flash BIOS (si disponible), o reprogramar chip BIOS con hardware CH341A. Verificar versión compatible').
componente_afectado(motherboard_bios_corruption, 'Motherboard').

diagnostico(motherboard_cmos_battery_dead) :-
    sintoma(fecha_hora_resetea, si),
    sintoma(configuracion_bios_se_pierde, si),
    sintoma(enciende, si),
    sintoma(bios_version_actualizada, no).
explicacion(motherboard_cmos_battery_dead, 'Batería CR2032 agotada - No mantiene configuración CMOS').
solucion(motherboard_cmos_battery_dead, 'REEMPLAZAR batería CR2032. Verificar voltaje > 3.0V. Resetear BIOS después del reemplazo. Configurar fecha/hora y settings').
componente_afectado(motherboard_cmos_battery_dead, 'Motherboard').

diagnostico(motherboard_cpu_compatibility_issue) :-
    sintoma(cpu_reconocido_correctamente, no),
    sintoma(enciende, si),
    sintoma(pitidos_post, si),
    sintoma(recientemente_instalo_hardware, si).
explicacion(motherboard_cpu_compatibility_issue, 'BIOS no soporta CPU instalado - Requiere actualización').
solucion(motherboard_cpu_compatibility_issue, 'ACTUALIZAR BIOS con CPU compatible. Usar Q-Flash Plus/BIOS Flashback si disponible, o CPU loaner program de fabricante').
componente_afectado(motherboard_cpu_compatibility_issue, 'Motherboard').

% 11-20: PROBLEMAS DE ALIMENTACIÓN VRM
diagnostico(motherboard_vrm_overheating) :-
    sintoma(cpu_throttling, si),
    sintoma(sobrecalentamiento, si),
    sintoma(temp_cpu_carga, si),
    sintoma(reinicios_aleatorios, si).
explicacion(motherboard_vrm_overheating, 'VRM motherboard sobrecalentado - MOSFETs > 100°C, throttling CPU por falta de potencia estable').
solucion(motherboard_vrm_overheating, 'MEJORAR refrigeración VRM: Instalar heatsinks en MOSFETs, agregar ventilador directo, reducir voltaje CPU, upgrade motherboard con mejor VRM').
componente_afectado(motherboard_vrm_overheating, 'Motherboard').

diagnostico(motherboard_vrm_capacitor_failure) :-
    sintoma(reinicios_aleatorios, si),
    sintoma(voltaje_inestable, si),
    sintoma(olor_ozono, si),
    sintoma(apagado_subito, si).
explicacion(motherboard_vrm_capacitor_failure, 'Capacitores VRM hinchados/fugando - Filtrado insuficiente, ripple excesivo').
solucion(motherboard_vrm_capacitor_failure, 'INSPECCIONAR capacitores cerca socket CPU. Reemplazar con mismos valores (uF, V, low ESR). Requiere soldadura SMD profesional').
componente_afectado(motherboard_vrm_capacitor_failure, 'Motherboard').

% 21-30: PROBLEMAS DE CONECTIVIDAD/PUERTOS
diagnostico(motherboard_usb_overcurrent_protection) :-
    sintoma(usb_funciona, no),
    sintoma(dispositivos_no_reconocidos, si),
    sintoma(usb_intermitente, si),
    sintoma(enciende, si).
explicacion(motherboard_usb_overcurrent_protection, 'Protección overcurrent activada en puertos USB - Cortocircuito en dispositivo USB').
solucion(motherboard_usb_overcurrent_protection, 'DESCONECTAR todos dispositivos USB. Reiniciar. Conectar uno por uno para identificar culpable. Verificar fusibles poliswitch en motherboard').
componente_afectado(motherboard_usb_overcurrent_protection, 'Motherboard').

diagnostico(motherboard_audio_codec_failure) :-
    sintoma(audio_funciona, no),
    sintoma(audio_distorsionado, si),
    sintoma(crackling_audio, si),
    sintoma(driver_red_actualizado, si).
explicacion(motherboard_audio_codec_failure, 'Chip audio integrado (Realtek ALC) dañado - Generalmente por corto en jack 3.5mm').
solucion(motherboard_audio_codec_failure, 'USAR audio externo: Tarjeta PCIe sound card o DAC USB. Deshabilitar audio integrado en BIOS. Reparación chip requiere microsoldadura').
componente_afectado(motherboard_audio_codec_failure, 'Motherboard').

diagnostico(motherboard_network_controller_failure) :-
    sintoma(ethernet_funciona, no),
    sintoma(wifi_detecta, no),
    sintoma(led_ethernet_parpadea, no),
    sintoma(driver_red_actualizado, si).
explicacion(motherboard_network_controller_failure, 'Controlador red integrado (Intel/I211) muerto - Generalmente por sobretensión').
solucion(motherboard_network_controller_failure, 'USAR adaptador PCIe network card (Intel i350). Verificar que drivers estén actualizados. Reparación generalmente no económica').
componente_afectado(motherboard_network_controller_failure, 'Motherboard').

diagnostico(motherboard_pcie_slot_wear) :-
    sintoma(gpu_detectada, intermitente),
    sintoma(artifactos_gpu, si),
    sintoma(slots_pcie_funcionan, parcial),
    sintoma(gpu_sag_estres_pcb, si).
explicacion(motherboard_pcie_slot_wear, 'Slot PCIe desgastado por GPU pesada - Contactos flojos, conexión intermitente').
solucion(motherboard_pcie_slot_wear, 'USAR soporte anti-sag GPU. Probar otro slot PCIe. Si slot dañado: Reparación requiere reemplazo slot completo (difícil)').
componente_afectado(motherboard_pcie_slot_wear, 'Motherboard').

diagnostico(motherboard_ram_slot_timing_issues) :-
    sintoma(ram_detectada, si),
    sintoma(memtest_errores, si),
    sintoma(xmp_activado, si),
    sintoma(dual_channel_activo, no).
explicacion(motherboard_ram_slot_timing_issues, 'Problemas de timing entre slots RAM - Topología daisy chain vs T-topology').
solucion(motherboard_ram_slot_timing_issues, 'CONSULTAR manual motherboard para slots recomendados. Generalmente A2+B2 para 2 módulos. Ajustar ProcODT, RTT values en BIOS').
componente_afectado(motherboard_ram_slot_timing_issues, 'Motherboard').

diagnostico(motherboard_standoff_short_circuit) :-
    sintoma(enciende, no),
    sintoma(led_power, no),
    sintoma(chispa_electrica, si),
    sintoma(olor_quemado, si).
explicacion(motherboard_standoff_short_circuit, 'Cortocircuito por standoff extra - PCB hace contacto con chasis').
solucion(motherboard_standoff_short_circuit, 'REMOVER motherboard del case. Verificar que solo hay standoffs en agujeros de montaje. Probar motherboard fuera del case').
componente_afectado(motherboard_standoff_short_circuit, 'Motherboard').

% ========================================
% REGLAS REFRIGERACIÓN - 25 DIAGNÓSTICOS ESPECÍFICOS
% ========================================

% 1-10: REFRIGERACIÓN LÍQUIDA
diagnostico(aio_pump_failure) :-
    sintoma(sobrecalentamiento, si),
    sintoma(temp_cpu_idle, si),
    sintoma(temp_cpu_carga, si),
    sintoma(ventilador_ruidoso, no),
    sintoma(apagado_termico, si).
explicacion(aio_pump_failure, 'Bomba AIO falló - No circula líquido, CPU sobrecalienta rápidamente').
solucion(aio_pump_failure, 'VERIFICAR que bomba está conectada a header PUMP_FAN o CPU_FAN. Escuchar si hace ruido al encender. Reemplazar AIO completo si bomba muerta. Garantía generalmente 5-6 años').
componente_afectado(aio_pump_failure, 'Cooler CPU').

diagnostico(aio_fluid_evaporation) :-
    sintoma(sobrecalentamiento, si),
    sintoma(temp_cpu_carga, si),
    sintoma(ventilador_ruidoso, si),
    sintoma(aio_age_years, '>3').
explicacion(aio_fluid_evaporation, 'Líquido AIO se evaporó - Nivel bajo, burbujas de aire en bomba').
solucion(aio_fluid_evaporation, 'REEMPLAZAR AIO completo. No intentar rellenar - sellos comprometidos. Prevención: Reemplazar AIO cada 5-6 años preventivamente').
componente_afectado(aio_fluid_evaporation, 'Cooler CPU').

diagnostico(custom_loop_air_bubble) :-
    sintoma(sobrecalentamiento, si),
    sintoma(temp_cpu_carga, si),
    sintoma(ventilador_ruidoso, si),
    sintoma(gpu_throttling, si).
explicacion(custom_loop_air_bubble, 'Burbuja de aire en loop - Bloquea flujo, reduce transferencia térmica').
solucion(custom_loop_air_bubble, 'BLEED loop: Inclinar case en todas direcciones, encender/bombas intermitentemente. Agregar reservoir fillport si no tiene. Verificar que bomba siempre abajo del radiador').
componente_afectado(custom_loop_air_bubble, 'Sistema Refrigeración').

diagnostico(radiator_fins_clogged_dust) :-
    sintoma(sobrecalentamiento, si),
    sintoma(temp_cpu_carga, si),
    sintoma(polvo_acumulado, si),
    sintoma(flujo_aire_bloqueado, si).
explicacion(radiator_fins_clogged_dust, 'Aletas radiador obstruidas por polvo - Flujo de aire reducido >70%').
solucion(radiator_fins_clogged_dust, 'LIMPIAR radiador con aire comprimido (dirección contraria a flujo normal). Considerar filtros de polvo magneticos. Limpieza cada 3-6 meses según ambiente').
componente_afectado(radiator_fins_clogged_dust, 'Radiador').

% 11-20: REFRIGERACIÓN POR AIRE
diagnostico(tower_cooler_mounting_pressure_issue) :-
    sintoma(sobrecalentamiento, si),
    sintoma(temp_cpu_idle, si),
    sintoma(cpu_throttling, si),
    sintoma(recientemente_instalo_hardware, si).
explicacion(tower_cooler_mounting_pressure_issue, 'Cooler torre con presión desigual - Contacto térmico pobre en áreas del IHS').
solucion(tower_cooler_mounting_pressure_issue, 'REINSTALAR cooler: Apretar tornillos en patrón X cruzado, presión uniforme. Verificar que brackets están correctamente orientados').
componente_afectado(tower_cooler_mounting_pressure_issue, 'Cooler CPU').

diagnostico(heatpipe_phase_change_failure) :-
    sintoma(sobrecalentamiento, si),
    sintoma(temp_cpu_carga, si),
    sintoma(cooler_age_years, '>5'),
    sintoma(pasta_termica_vieja, no).
explicacion(heatpipe_phase_change_failure, 'Heatpipes perdieron vacío/fluido - Transferencia térmica degradada').
solucion(heatpipe_phase_change_failure, 'REEMPLAZAR cooler completo. Heatpipes no son reparables. Síntoma: Heatpipes se sienten frías mientras CPU está caliente').
componente_afectado(heatpipe_phase_change_failure, 'Cooler CPU').

diagnostico(case_airflow_negative_pressure) :-
    sintoma(sobrecalentamiento, si),
    sintoma(polvo_acumulado, si),
    sintoma(temp_gpu_carga, si),
    sintoma(temp_cpu_carga, si).
explicacion(case_airflow_negative_pressure, 'Presión negativa en case - Más exhaust que intake, acumulación polvo rápida').
solucion(case_airflow_negative_pressure, 'BALANCEAR airflow: Mismo número de fans intake/exhaust, o ligeramente positivo. Velocidad intake > exhaust. Verificar dirección de flujo').
componente_afectado(case_airflow_negative_pressure, 'Case/Fans').

% 21-25: PROBLEMAS DE FAN CONTROL
diagnostico(pwm_fan_controller_failure) :-
    sintoma(ventilador_ruidoso, si),
    sintoma(ventilador_detenido, si),
    sintoma(sobrecalentamiento, si),
    sintoma(fan_speed_constant, si).
explicacion(pwm_fan_controller_failure, 'Controlador PWM motherboard defectuoso - Fans at full speed o detenidos').
solucion(pwm_fan_controller_failure, 'PROBAR fans en otro header. Usar controlador fan hub externo. Reparación motherboard requiere reemplazo de IC PWM').
componente_afectado(pwm_fan_controller_failure, 'Motherboard').

% ========================================
% CASOS ESPECIALES - 25 DIAGNÓSTICOS
% ========================================

% 1-10: DAÑO POR LÍQUIDO
diagnostico(liquid_spill_immediate_damage) :-
    sintoma(derramo_liquido, si),
    sintoma(enciende, no),
    sintoma(olor_quemado, si),
    sintoma(chispa_electrica, si).
explicacion(liquid_spill_immediate_damage, 'Cortocircuito inmediato por líquido - Múltiples componentes afectados').
solucion(liquid_spill_immediate_damage, 'ACCION INMEDIATA: Desconectar poder, remover batería CMOS. Limpiar con alcohol isopropílico 99%. Secar 72+ horas. Probar componentes uno por uno. Esperar pérdida total').
componente_afectado(liquid_spill_immediate_damage, 'Múltiples Componentes').

diagnostico(liquid_spill_corrosion_long_term) :-
    sintoma(derramo_liquido, si),
    sintoma(enciende, intermitente),
    sintoma(reinicios_aleatorios, si),
    sintoma(congelamientos, si).
explicacion(liquid_spill_corrosion_long_term, 'Corrosión progresiva por residuos líquidos - Fallos intermitentes que empeoran').
solucion(liquid_spill_corrosion_long_term, 'LIMPIAR profundamente con ultrasonido o cepillo isopropílico. Inspeccionar corrosión en trazas. Reemplazar componentes afectados. Generalmente motherboard no reparable').
componente_afectado(liquid_spill_corrosion_long_term, 'Motherboard/GPU').

% 11-20: DAÑO FÍSICO
diagnostico(physical_impact_bga_failure) :-
    sintoma(golpe_caida, si),
    sintoma(artifactos_gpu, si),
    sintoma(gpu_detectada, intermitente),
    sintoma(driver_crashed, si).
explicacion(physical_impact_bga_failure, 'Balls BGA fracturados por impacto - Conexiones intermitentes en GPU/CPU').
solucion(physical_impact_bga_failure, 'REBALLING profesional requerido. Costo $100-300 USD. Diagnóstico: Presionar suavemente on GPU/CPU mientras funciona - si cambia comportamiento, confirma BGA').
componente_afectado(physical_impact_bga_failure, 'GPU/CPU').

diagnostico(pcb_flex_cracked_traces) :-
    sintoma(golpe_caida, si),
    sintoma(enciende, no),
    sintoma(led_power, si),
    sintoma(ventiladores, si).
explicacion(pcb_flex_cracked_traces, 'Traces PCB rotos por flexión - Circuitos abiertos en motherboard/GPU').
solucion(pcb_flex_cracked_traces, 'INSPECCIONAR visualmente con lupa bajo buena luz. Buscar cracks finos. Reparación requiere microsoldadura y jumper wires. Generalmente no económico').
componente_afectado(pcb_flex_cracked_traces, 'Motherboard/GPU').

% 21-25: PROBLEMAS ELÉCTRICOS
diagnostico(power_surge_multiple_failures) :-
    sintoma(tormenta_electrica, si),
    sintoma(sobretension_electrica, si),
    sintoma(enciende, no),
    sintoma(olor_quemado, si).
explicacion(power_surge_multiple_failures, 'Sobretensión dañó múltiples componentes - Generalmente PSU, motherboard, conectados vía USB/ethernet').
solucion(power_surge_multiple_failures, 'PROBAR PSU sola (paperclip test). Verificar todos componentes. Usar protector contra sobretensiones UPS para futuro. Pérdida generalmente extensa').
componente_afectado(power_surge_multiple_failures, 'Múltiples Componentes').

% ========================================
% DIAGNÓSTICOS CRUZADOS - 20 REGLAS
% ========================================

% 1-10: INTERACCIONES CPU-MOTHERBOARD-RAM
diagnostico(imc_motherboard_ram_incompatibility) :-
    sintoma(memtest_errores, si),
    sintoma(xmp_activado, si),
    sintoma(ram_a_velocidad_maxima, no),
    sintoma(cpu_reconocido_correctamente, si).
explicacion(imc_motherboard_ram_incompatibility, 'IMC CPU no puede manejar topología motherboard + densidad RAM').
solucion(imc_motherboard_ram_incompatibility, 'ACTUALIZAR BIOS. Reducir frecuencia RAM. Aumentar voltajes VDDQ/VDDQ2 (Intel) o VSOC/VDDG (AMD). Consultar QVL motherboard').
componente_afectado(imc_motherboard_ram_incompatibility, 'CPU/Motherboard/RAM').

diagnostico(vrm_insufficient_for_cpu_boost) :-
    sintoma(cpu_throttling, si),
    sintoma(frecuencia_cpu_correcta, no),
    sintoma(temp_cpu_carga, no),
    sintoma(sobrecalentamiento, si).
explicacion(vrm_insufficient_for_cpu_boost, 'VRM motherboard no puede sostener potencia para turbo boost CPU').
solucion(vrm_insufficient_for_cpu_boost, 'REDUCIR power limits en BIOS. Mejorar refrigeración VRM. Upgrade motherboard con mejor VRM (más fases, MOSFETs de mayor calidad)').
componente_afectado(vrm_insufficient_for_cpu_boost, 'Motherboard/CPU').

% 11-20: INTERACCIONES PSU-COMPONENTES
diagnostico(psu_ripple_affecting_stability) :-
    sintoma(reinicios_aleatorios, si),
    sintoma(congelamientos, si),
    sintoma(memtest_errores, si),
    sintoma(artifactos_gpu, intermitente).
explicacion(psu_ripple_affecting_stability, 'Ripple PSU excesivo afecta múltiples componentes - Errores memoria, inestabilidad GPU').
solucion(psu_ripple_affecting_stability, 'MEDIR ripple con osciloscopio (>50mV inaceptable). Reemplazar PSU con mejor regulación y filtrado. PSU tier C o mejor en PSU tier list').
componente_afectado(psu_ripple_affecting_stability, 'PSU/Múltiples Componentes').

diagnostico(transient_response_psu_issue) :-
    sintoma(apagado_subito, si),
    sintoma(gpu_detectada, si),
    sintoma(enciende, si),
    sintoma(voltaje_inestable, no).
explicacion(transient_response_psu_issue, 'Respuesta transiente PSU pobre - No puede manejar cambios rápidos de carga (ej: GPU boosting)').
solucion(transient_response_psu_issue, 'UPGRADE PSU con mejor respuesta transiente (generalmente PSU de mayor calidad, no necesariamente mayor wattage). Verificar reviews técnicas').
componente_afectado(transient_response_psu_issue, 'PSU/GPU').

diagnostico(ground_loop_audio_network_issues) :-
    sintoma(crackling_audio, si),
    sintoma(velocidad_red_baja, si),
    sintoma(usb_intermitente, si),
    sintoma(ethernet_funciona, intermitente).
explicacion(ground_loop_audio_network_issues, 'Ground loops causando interferencia - Múltiples problemas de señal/ruido').
solucion(ground_loop_audio_network_issues, 'CONECTAR todo a misma toma tierra. Usar aisladores audio USB/3.5mm. Verificar cableado eléctrico casa. UPS con buen filtro').
componente_afectado(ground_loop_audio_network_issues, 'Sistema Completo').

diagnostico(thermal_runaway_scenario) :-
    sintoma(sobrecalentamiento, si),
    sintoma(apagado_termico, si),
    sintoma(temp_cpu_carga, si),
    sintoma(temp_gpu_carga, si),
    sintoma(ventilador_detenido, si).
explicacion(thermal_runaway_scenario, 'Fallo múltiple refrigeración - Temperaturas aumentan exponencialmente').
solucion(thermal_runaway_scenario, 'SHUTDOWN inmediato. Revisar todos fans, bombas, pastas térmicas. Reemplazar componentes fallados. Verificar curves fan en BIOS/software').
componente_afectado(thermal_runaway_scenario, 'Sistema Refrigeración').

diagnostico(compatibility_chain_reaction) :-
    sintoma(recientemente_instalo_hardware, si),
    sintoma(memtest_errores, si),
    sintoma(gpu_detectada, no),
    sintoma(disco_detectado, intermitente).
explicacion(compatibility_chain_reaction, 'Nuevo hardware causa conflictos en cadena - Incompatibilidades múltiples').
solucion(compatibility_chain_reaction, 'REVERTIR a configuración anterior estable. Actualizar BIOS. Instalar un componente a la vez, verificando estabilidad. Consultar compatibilidades').
componente_afectado(compatibility_chain_reaction, 'Múltiples Componentes').

% ========================================
% DIAGNÓSTICOS GENÉRICOS (ATRAPATODO)
% ========================================

% 1. Problema de encendido general
diagnostico(problema_encendido_general) :-
    sintoma(enciende, no).
explicacion(problema_encendido_general, 'El equipo no enciende - Problema de alimentación o hardware crítico').
solucion(problema_encendido_general, 'VERIFICAR: 1) Cable de poder conectado, 2) Interruptor PSU en ON, 3) PSU funcionando (test paperclip), 4) Botón de encendido, 5) Conexión 24-pin motherboard bien insertada. COSTO ESTIMADO: $0-150 USD').
componente_afectado(problema_encendido_general, 'PSU/Motherboard').

% 2. Problema de video general
diagnostico(problema_video_general) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, no).
explicacion(problema_video_general, 'El equipo enciende pero no hay imagen en pantalla - Problema de GPU o conexión de video').
solucion(problema_video_general, 'VERIFICAR: 1) Cable de video bien conectado, 2) Monitor encendido y en entrada correcta, 3) Probar otro cable/puerto, 4) GPU bien insertada, 5) RAM bien insertada (causa común), 6) Probar video integrado si existe. COSTO: $0-400 USD si requiere GPU nueva').
componente_afectado(problema_video_general, 'GPU/Monitor/Cables').

% 3. Problema de almacenamiento general
diagnostico(problema_almacenamiento_general) :-
    sintoma(disco_detectado, no).
explicacion(problema_almacenamiento_general, 'Disco duro/SSD no detectado en BIOS - Problema de conexión o disco fallido').
solucion(problema_almacenamiento_general, 'VERIFICAR: 1) Cable SATA/NVMe bien conectado en ambos extremos, 2) Probar otro cable SATA, 3) Probar disco en otro equipo, 4) Verificar que BIOS detecta disco, 5) Orden de boot correcto. COSTO: $30-200 USD nuevo disco').
componente_afectado(problema_almacenamiento_general, 'Disco/SSD/Cables').

% 4. Problema de RAM general
diagnostico(problema_ram_general) :-
    sintoma(ram_detectada, no).
explicacion(problema_ram_general, 'Memoria RAM no detectada o detectada parcialmente - Problema de módulos o slots').
solucion(problema_ram_general, 'VERIFICAR: 1) RAM insertada completamente (click audible), 2) Probar un módulo a la vez, 3) Probar en diferentes slots, 4) Limpiar contactos dorados con goma de borrar, 5) Verificar compatibilidad RAM con motherboard. COSTO: $30-100 USD nueva RAM').
componente_afectado(problema_ram_general, 'RAM/Motherboard').

% 5. Problema de temperatura general
diagnostico(problema_temperatura_general) :-
    sintoma(sobrecalentamiento, si).
explicacion(problema_temperatura_general, 'Sistema presenta sobrecalentamiento - Problema de refrigeración').
solucion(problema_temperatura_general, 'VERIFICAR: 1) Ventiladores girando (CPU, GPU, case), 2) Pasta térmica seca (reemplazar cada 2-3 años), 3) Cooler bien montado, 4) Polvo acumulado (limpieza con aire comprimido), 5) Flujo de aire case (intake/exhaust balanceado). COSTO: $10-80 USD').
componente_afectado(problema_temperatura_general, 'Sistema de refrigeración').

% 6. Problema de arranque con pitidos
diagnostico(problema_pitidos_post_general) :-
    sintoma(pitidos_post, si).
explicacion(problema_pitidos_post_general, 'Sistema emite pitidos POST - Código de error de hardware').
solucion(problema_pitidos_post_general, 'IDENTIFICAR patrón de pitidos y consultar manual de motherboard. Común: 1 pitido largo + 2 cortos = GPU, 3 pitidos = RAM, pitidos continuos = PSU. VERIFICAR componente indicado por código de pitidos').
componente_afectado(problema_pitidos_post_general, 'Variable según patrón').

% 7. Problema de ruidos anormales
diagnostico(problema_ruidos_general) :-
    sintoma(ruidos_disco, si).
explicacion(problema_ruidos_general, 'Disco hace ruidos anormales - Posible fallo mecánico inminente').
solucion(problema_ruidos_general, 'URGENTE: Hacer BACKUP inmediato. Clicks repetitivos = cabezales dañados, chirrido = motor/rodamientos. NO usar disco extensivamente. Considerar reemplazo inmediato. COSTO: $50-200 USD nuevo disco + posible recuperación datos $300-2000 USD').
componente_afectado(problema_ruidos_general, 'Disco HDD').

% 8. Problema de GPU no detectada
diagnostico(problema_gpu_no_detectada_general) :-
    sintoma(gpu_detectada, no),
    sintoma(enciende, si).
explicacion(problema_gpu_no_detectada_general, 'Tarjeta gráfica no detectada por el sistema - Problema de conexión o GPU fallida').
solucion(problema_gpu_no_detectada_general, 'VERIFICAR: 1) Cables PCIe power conectados (6-pin/8-pin), 2) GPU bien insertada en slot, 3) Drivers instalados, 4) Probar GPU en otro equipo, 5) Probar otro slot PCIe, 6) PSU con suficiente potencia. COSTO: $150-800 USD nueva GPU').
componente_afectado(problema_gpu_no_detectada_general, 'GPU/PSU').

% 9. Problema de reinicios aleatorios
diagnostico(problema_reinicios_general) :-
    sintoma(reinicios_aleatorios, si).
explicacion(problema_reinicios_general, 'Sistema se reinicia sin razón aparente - Múltiples causas posibles').
solucion(problema_reinicios_general, 'VERIFICAR: 1) Temperaturas (CPU/GPU), 2) PSU con potencia suficiente y estable, 3) RAM con MemTest86, 4) Actualizar drivers, 5) Windows Event Viewer para errores, 6) Malware scan. CAUSAS COMUNES: PSU insuficiente, RAM defectuosa, sobrecalentamiento').
componente_afectado(problema_reinicios_general, 'PSU/RAM/Cooling').

% 10. Problema de congelamientos
diagnostico(problema_congelamientos_general) :-
    sintoma(congelamientos, si).
explicacion(problema_congelamientos_general, 'Sistema se congela (freeze) frecuentemente - Problema de hardware o drivers').
solucion(problema_congelamientos_general, 'VERIFICAR: 1) RAM con MemTest86, 2) Temperaturas estables, 3) Disco con errores (CrystalDiskInfo), 4) Drivers actualizados, 5) Actualizaciones Windows, 6) Malware. COMÚN: RAM defectuosa, SSD con sectores malos, drivers incompatibles').
componente_afectado(problema_congelamientos_general, 'RAM/Disco/Drivers').

% Reglas finales de cobertura
diagnostico(no_faults_detected) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, si),
    sintoma(velocidad_lenta, no),
    sintoma(sobrecalentamiento, no),
    sintoma(reinicios_aleatorios, no).
explicacion(no_faults_detected, 'Sistema funcionando correctamente - No se detectaron fallas').
solucion(no_faults_detected, 'Realizar mantenimiento preventivo: Limpieza de polvo, verificar temperaturas, actualizar drivers, backup de datos').
componente_afectado(no_faults_detected, 'Ninguno').

diagnostico(insufficient_symptoms) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, si).
explicacion(insufficient_symptoms, 'Síntomas insuficientes para diagnóstico específico - Se necesitan más respuestas').
solucion(insufficient_symptoms, 'Continuar con el cuestionario para obtener diagnóstico más preciso. Problemas comunes no detectados aún: rendimiento, temperatura, estabilidad').
componente_afectado(insufficient_symptoms, 'Desconocido').

diagnostico(sistema_ok_mantenimiento_preventivo) :-
    sintoma(enciende, si),
    sintoma(pantalla_enciende, si),
    sintoma(velocidad_lenta, no),
    sintoma(sobrecalentamiento, no),
    sintoma(ruidos_disco, no),
    \+ sintoma(_, no). % No hay síntomas negativos graves

diagnostico(problema_intermitente_dificil_diagnostico) :-
    sintoma(reinicios_aleatorios, si),
    sintoma(congelamientos, si),
    % No coincide con otros diagnósticos específicos
    \+ sintoma(memtest_errores, si),
    \+ sintoma(temp_cpu_carga, si).

confianza(psu_rail_12v_totalmente_muerto, 0.95) :-
    sintoma(enciende, no),
    sintoma(led_power, no),
    sintoma(ventiladores, no),
    sintoma(olor_quemado, no).

confianza(psu_posiblemente_muerta, 0.70) :-
    sintoma(enciende, no),
    sintoma(led_power, no).

% Ordenar diagnósticos por confianza
diagnostico_con_confianza(Diagnostico, Confianza) :-
    diagnostico(Diagnostico),
    confianza(Diagnostico, Confianza).

diagnostico(problema_complejo_psu_y_gpu) :-
    sintoma(reinicios_espontaneos, si),
    sintoma(apagado_subito, si),
    sintoma(gpu_detectada, si),
    sintoma(artifactos_gpu, si),
    sintoma(ventiladores_gpu_giran, si).
explicacion(problema_complejo_psu_y_gpu, 
    'PSU insuficiente causa inestabilidad GPU bajo carga').
solucion(problema_complejo_psu_y_gpu,
    'CALCULAR: Consumo GPU pico + CPU + 20% margen. UPGRADE PSU a 750W+ si necesario').

diagnostico(thermal_throttling_cascade) :-
    sintoma(temp_cpu_carga, si),
    sintoma(temp_gpu_carga, si),
    sintoma(polvo_acumulado, si),
    sintoma(flujo_aire_bloqueado, si),
    sintoma(velocidad_lenta, si).
explicacion(thermal_throttling_cascade,
    'Throttling térmico en cascada CPU+GPU por refrigeración deficiente').

diagnostico(diagnostico_incompleto_pocos_sintomas) :-
    findall(S, sintoma(S, _), Sintomas),
    length(Sintomas, N),
    N > 0,
    N < 5.
explicacion(diagnostico_incompleto_pocos_sintomas,
    'Diagnóstico preliminar - Se detectaron síntomas pero se necesitan más datos').
solucion(diagnostico_incompleto_pocos_sintomas,
    'CONTINUAR cuestionario: Responder al menos 10 preguntas para diagnóstico preciso. Sistema cuenta con 70+ preguntas específicas').
componente_afectado(diagnostico_incompleto_pocos_sintomas, 'Evaluación en Proceso').


% ========================================
% 8. VALIDACIÓN DE ÁRBOL
% ========================================

% Regla para verificar que no hay bucles
verificar_sin_bucles(Inicio) :-
    verificar_sin_bucles_helper(Inicio, []).

verificar_sin_bucles_helper(ejecutar_diagnostico, _) :- !.
verificar_sin_bucles_helper(fin_diagnostico, _) :- !.
verificar_sin_bucles_helper(Actual, Visitados) :-
    \+ member(Actual, Visitados),
    siguiente_pregunta(Actual, _, Siguiente),
    verificar_sin_bucles_helper(Siguiente, [Actual|Visitados]).

% Regla para listar preguntas sin salida
preguntas_sin_salida(Lista) :-
    findall(P, (pregunta(P, _), \+ siguiente_pregunta(P, _, _)), Lista).

% Regla para listar átomos usados pero no definidos
atomos_no_definidos(Lista) :-
    findall(A, (siguiente_pregunta(_, _, A), \+ pregunta(A, _), 
                A \= ejecutar_diagnostico, A \= fin_diagnostico), ListaDup),
    sort(ListaDup, Lista).


% ========================================
% COMPLETAR PATHS FALTANTES DEL ÁRBOL
% ========================================

% Completar rama zumbido_bobinas
siguiente_pregunta(zumbido_bobinas, si, olor_ozono).
siguiente_pregunta(zumbido_bobinas, no, reinicios_espontaneos).

% Completar rama olor_ozono - CORREGIDO
siguiente_pregunta(olor_ozono, si, chispa_electrica).
siguiente_pregunta(olor_ozono, no, disco_detectado).

% Completar rama sobretension_electrica - CORREGIDO
siguiente_pregunta(sobretension_electrica, si, olor_quemado).
siguiente_pregunta(sobretension_electrica, no, voltaje_inestable).

% Completar rama reinicios_espontaneos
siguiente_pregunta(reinicios_espontaneos, si, apagado_subito).
siguiente_pregunta(reinicios_espontaneos, no, disco_detectado).

% Completar rama apagado_subito
siguiente_pregunta(apagado_subito, si, voltaje_inestable).
siguiente_pregunta(apagado_subito, no, disco_detectado).

% Completar rama tormenta_electrica - CORREGIDO
siguiente_pregunta(tormenta_electrica, si, ejecutar_diagnostico).
siguiente_pregunta(tormenta_electrica, no, ejecutar_diagnostico).

% Completar rama golpe_caida - CORREGIDO
siguiente_pregunta(golpe_caida, si, artefactos_visuales).
siguiente_pregunta(artefactos_visuales, si, gpu_detectada).
siguiente_pregunta(artefactos_visuales, no, ruidos_disco).
siguiente_pregunta(golpe_caida, no, disco_detectado).

% Completar rama archivos_corruptos
siguiente_pregunta(archivos_corruptos, si, smart_warnings).
siguiente_pregunta(archivos_corruptos, no, velocidad_lenta).

% Asegurar que smart_warnings tenga salida
siguiente_pregunta(smart_warnings, no, temperatura_disco).
siguiente_pregunta(temperatura_disco, si, velocidad_lenta).
siguiente_pregunta(temperatura_disco, no, velocidad_lenta).

% Completar rama smart_warnings
siguiente_pregunta(smart_warnings, si, sectores_realocados).
siguiente_pregunta(smart_warnings, no, velocidad_lenta).

% Completar rama sectores_realocados - CORREGIDO
siguiente_pregunta(sectores_realocados, si, velocidad_lenta).
siguiente_pregunta(sectores_realocados, no, ssd_ralentizado).
siguiente_pregunta(ssd_ralentizado, si, ram_detectada).
siguiente_pregunta(ssd_ralentizado, no, ram_detectada).

% Completar rama m2_slot_funciona
siguiente_pregunta(m2_slot_funciona, si, velocidad_lenta).
siguiente_pregunta(m2_slot_funciona, no, bios_version_actualizada).

% Completar ramas de RAM
siguiente_pregunta(ubicacion_error_ram, _, xmp_activado).
siguiente_pregunta(slots_ocupados, _, dual_channel_activo).
siguiente_pregunta(dual_channel_activo, si, ram_a_velocidad_maxima).
siguiente_pregunta(dual_channel_activo, no, xmp_activado).
siguiente_pregunta(ram_a_velocidad_maxima, si, sobrecalentamiento).
siguiente_pregunta(ram_a_velocidad_maxima, no, sobrecalentamiento).
siguiente_pregunta(ram_a_velocidad_maxima, si, sobrecalentamiento).
siguiente_pregunta(ram_a_velocidad_maxima, no, sobrecalentamiento).

% Completar ramas de temperatura
siguiente_pregunta(flujo_aire_bloqueado, si, polvo_acumulado).
siguiente_pregunta(flujo_aire_bloqueado, no, red_funciona).
siguiente_pregunta(polvo_acumulado, si, red_funciona).
siguiente_pregunta(polvo_acumulado, no, red_funciona).
siguiente_pregunta(ventilador_vibra, si, polvo_acumulado).
siguiente_pregunta(ventilador_vibra, no, polvo_acumulado).
siguiente_pregunta(ventilador_detenido, si, pasta_termica_vieja).
siguiente_pregunta(ventilador_detenido, no, ventilador_vibra).
siguiente_pregunta(temp_gpu_idle, si, temp_gpu_carga).
siguiente_pregunta(temp_gpu_idle, no, red_funciona).
siguiente_pregunta(temp_gpu_carga, si, ventilador_ruidoso).
siguiente_pregunta(temp_gpu_carga, no, red_funciona).
siguiente_pregunta(ventilador_ruidoso, si, ventilador_detenido).
siguiente_pregunta(ventilador_ruidoso, no, ventilador_vibra).

% Completar ramas de red
siguiente_pregunta(led_ethernet_parpadea, si, driver_red_actualizado).
siguiente_pregunta(led_ethernet_parpadea, no, driver_red_actualizado).
siguiente_pregunta(driver_red_actualizado, si, audio_funciona).
siguiente_pregunta(driver_red_actualizado, no, audio_funciona).
siguiente_pregunta(ping_alto, si, paquetes_perdidos).
siguiente_pregunta(ping_alto, no, conexion_intermitente).
siguiente_pregunta(paquetes_perdidos, si, conexion_intermitente).
siguiente_pregunta(paquetes_perdidos, no, conexion_intermitente).
siguiente_pregunta(conexion_intermitente, si, led_ethernet_parpadea).
siguiente_pregunta(conexion_intermitente, no, driver_red_actualizado).

% Completar ramas de USB/Audio
siguiente_pregunta(audio_solo_un_lado, si, audio_distorsionado).
siguiente_pregunta(audio_solo_un_lado, no, microfono_funciona).
siguiente_pregunta(audio_distorsionado, si, microfono_funciona).
siguiente_pregunta(audio_distorsionado, no, microfono_funciona).
siguiente_pregunta(microfono_funciona, si, usb_funciona).
siguiente_pregunta(microfono_funciona, no, usb_funciona).
siguiente_pregunta(usb_3_no_funciona, si, usb_velocidad_lenta).
siguiente_pregunta(usb_3_no_funciona, no, usb_frontal_no_funciona).
siguiente_pregunta(usb_velocidad_lenta, si, dispositivos_no_reconocidos).
siguiente_pregunta(usb_velocidad_lenta, no, usb_frontal_no_funciona).
siguiente_pregunta(dispositivos_no_reconocidos, si, usb_frontal_no_funciona).
siguiente_pregunta(dispositivos_no_reconocidos, no, usb_velocidad_lenta).
siguiente_pregunta(usb_velocidad_lenta, si, ejecutar_diagnostico).
siguiente_pregunta(usb_velocidad_lenta, no, ejecutar_diagnostico).
siguiente_pregunta(usb_frontal_no_funciona, si, usb_posterior_funciona).
siguiente_pregunta(usb_frontal_no_funciona, no, usb_posterior_funciona).
siguiente_pregunta(usb_posterior_funciona, si, puertos_traseros_funcionan).
siguiente_pregunta(usb_posterior_funciona, no, slots_pcie_funcionan).
siguiente_pregunta(patron_pitidos, _, cpu_reconocido_correctamente).

% Completar ramas de GPU
siguiente_pregunta(driver_gpu_instalado, si, artifactos_gpu).
siguiente_pregunta(driver_gpu_instalado, no, artifactos_gpu).
siguiente_pregunta(driver_crashed, si, fps_bajos).
siguiente_pregunta(driver_crashed, no, temp_gpu_carga).
siguiente_pregunta(coil_whine_gpu, si, ventiladores_gpu_giran).
siguiente_pregunta(coil_whine_gpu, no, ventiladores_gpu_giran).
siguiente_pregunta(ventiladores_gpu_giran, si, cpu_reconocido_correctamente).
siguiente_pregunta(ventiladores_gpu_giran, no, cpu_reconocido_correctamente).

% Completar ramas de Motherboard/CPU
siguiente_pregunta(bios_version_actualizada, si, puertos_traseros_funcionan).
siguiente_pregunta(bios_version_actualizada, no, puertos_traseros_funcionan).
siguiente_pregunta(configuracion_bios_se_pierde, si, bios_version_actualizada).
siguiente_pregunta(configuracion_bios_se_pierde, no, bios_version_actualizada).
siguiente_pregunta(sata_ports_funcionan, si, m2_slot_funciona).
siguiente_pregunta(sata_ports_funcionan, no, m2_slot_funciona).
siguiente_pregunta(slots_pcie_funcionan, si, sata_ports_funcionan).
siguiente_pregunta(slots_pcie_funcionan, no, fecha_hora_resetea).
siguiente_pregunta(frecuencia_cpu_correcta, si, cpu_throttling).
siguiente_pregunta(frecuencia_cpu_correcta, no, cpu_throttling).
siguiente_pregunta(cpu_throttling, si, uso_cpu_100).
siguiente_pregunta(cpu_throttling, no, uso_cpu_100).
siguiente_pregunta(uso_cpu_100, si, proceso_consume_cpu).
siguiente_pregunta(uso_cpu_100, no, recientemente_instalo_hardware).
siguiente_pregunta(proceso_consume_cpu, _, recientemente_instalo_hardware).

% Completar rama casos especiales
siguiente_pregunta(recientemente_actualizo_bios, si, derramo_liquido).
siguiente_pregunta(recientemente_actualizo_bios, no, derramo_liquido).
siguiente_pregunta(sintoma_actual_mas_especifico, _, ejecutar_diagnostico).

% Para patron_pitidos (valores 1,2,3,mas pero puede recibir otros)
siguiente_pregunta(patron_pitidos, Valor, cpu_reconocido_correctamente) :-
    \+ member(Valor, [1, 2, 3, mas]).

% Para cantidad_ram_detectada
siguiente_pregunta(cantidad_ram_detectada, Valor, memtest_errores) :-
    \+ member(Valor, [parcial, incorrecta]).

% Para ruido_tipo
siguiente_pregunta(ruido_tipo, Valor, smart_warnings) :-
    \+ member(Valor, [click_repetitivo, chirrido_continuo, golpeteo]).

% Asegurar que todos los caminos lleguen a ejecutar_diagnostico
siguiente_pregunta(ejecutar_diagnostico, _, fin_diagnostico).