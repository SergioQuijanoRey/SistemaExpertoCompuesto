; Estructura para representar cuando se ha tomado una decision final sobre las asignaturas
; Una vez que se toma esta decision, se termina el proceso de entrevista. Se informa al usuario de
; la rama y se muestra una serie de motivos
(deftemplate Decision
    (slot rama)
)

; Cuando ya se ha tomado una decision, debemos marcar que se ha terminado la sesion de preguntas,
; para mostrar la decision final y dejar de preguntar
(defrule decisionTomadaEntoncesTerminado


    ; Las comprobaciones de seguridad tienen este valor de prioridad
    (declare (salience 7000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; Esta regla retira hechos para mantener la validez del programa, y por tanto, entra en la
    ; categoria de prioridades 1. (consultar la documentacion en main.clp en la que indico esta

    (Decision (rama ?rama))
    ?hecho <- (Terminado (estado no))

    =>

    ; Quitamos Terminado no y añadimos Terminado si, para dejar de mostrar mensajes
    (retract ?hecho)
    (assert (Terminado (estado si)))

)

; COMPROBACIONES DE SEGURIDAD
;===================================================================================================

; No podemos tener al mismo tiempo un hecho (Decision ?rama) y (Terminado (estado no))
(defrule checkDecisionTomadaEntoncesTerminado

    ; jerarquia de prioridades)
    ; Le doy menos prioridad que otras comprobaciones de seguridad porque aunque tome una decision,
    ; al tener mas modulos el programa no termina
    (declare (salience 6000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))


    ; Tenemos una decision ya tomada
    (Decision (rama ?rama))

    ; Pero no hemos indicado que se haya terminado
    (Terminado (estado no))

    =>

    (printout t "ERROR! Se ha tomado una decision pero no se indica que se haya terminado" crlf)
    ; (printout t "   Decision " ?rama crlf)
    (printout t "   (Terminado (estado no))" crlf)


)
