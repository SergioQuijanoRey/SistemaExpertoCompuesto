; Fichero principal en el que controlamos el uso de todos los modulos
; Autores:
; Sergio Quijano Rey
;   sergioquijano@correo.ugr.es
; TODO -- Luis y Carlos poned aqui vuestros datos si os parece

; EJECUCION RAPIDA DEL SCRIPT
;===================================================================================================

; Con estas instrucciones podemos ejecutar el script desde la linea de comandos
; Haciendo `clips -f main.clp`

; Cargo primero los modulos comunes, porque en muchos de los ficheros originales ahora tenemos
; comprobaciones que se encuentran en estos ficheros common/.clp
(load common/modulos.clp)
(load common/conversacion_inicial.clp)

; Ahora cargo el estado inicial comun, que depende de los modulos comunes cargados previamente
(load common/estado_inicial.clp)

; Cargamos todos los ficheros en los que hemos dividido el codigo
; El orden en el que importamos los ficheros es relevante

; Ficheros de Sergio Quijano Rey:

; Empiezo cargando terminado y sergio/estructura_respuestas, porque definen los templates para
; un par de hechos que aserto en el estado inicial
(load sergio/terminado.clp)
(load sergio/estructura_respuestas.clp)

; Cargo el estado inicial, que se usa en otras modulos
(load sergio/estado_inicial.clp)

(load sergio/decision.clp)
(load sergio/ramas.clp)
(load sergio/consejo.clp)
(load sergio/conversacion.clp)
(load sergio/conversacion_desempatar.clp)
(load sergio/logica_alto_nivel.clp)
(load sergio/logica_alto_nivel_desempatar.clp)
(load sergio/mostrar_resultado.clp)

; Ficheros de Carlos Lara Casanova
(load carlos.clp)

; Ficheros de Luis Rodriguez Domingo
(load luis.clp)


; Ejecutamos el codigo
(reset)
(run)
