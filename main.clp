; Fichero principal en el que controlamos el uso de todos los modulos
; Autores:
; Sergio Quijano Rey
;   sergioquijano@correo.ugr.es
; TODO -- Luis y Carlos poned aqui vuestros datos si os parece

; EJECUCION RAPIDA DEL SCRIPT
;===================================================================================================

; Con estas instrucciones podemos ejecutar el script desde la linea de comandos
; Haciendo `clips -f main.clp`

; Cargamos todos los ficheros en los que hemos dividido el codigo
; El orden en el que importamos los ficheros es relevante

; Ficheros de Sergio Quijano Rey:
(load sergio/estructura_respuestas.clp)
(load sergio/terminado.clp)
(load sergio/decision.clp)
(load sergio/ramas.clp)
(load sergio/consejo.clp)
(load sergio/conversacion.clp)
(load sergio/conversacion_desempatar.clp)
(load sergio/logica_alto_nivel.clp)
(load sergio/logica_alto_nivel_desempatar.clp)
(load sergio/mostrar_resultado.clp)
(load sergio/estado_inicial.clp)


; Ejecutamos el codigo
(reset)
(run)
