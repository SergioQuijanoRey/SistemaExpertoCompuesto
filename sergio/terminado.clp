; Controla si se ha terminado la parte de realizar las preguntas
; Si se ha tomado una decision, entonces se tiene que indicar que se ha terminado
; No uso el hecho (Decision ?rama) porque es mas facil comprobar que (Terminado no) que comprobar
; que no existe todavia una regla (Decision ?rama)
(deftemplate Terminado
    (slot estado
        (type SYMBOL)
        (allowed-symbols si no)
    )
)

; Muchas reglas hacen una asercion para Terminado si. Dichas reglas deberian retirar tambien la
; regla Terminado no, pero añado una regla para esto para asegurar la validez del programa
(defrule terminadoSiNoIncompatibles

    ; jerarquia de prioridades)
    (declare (salience 9000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; Esta regla retira hechos para mantener la validez del programa, y por tanto, entra en la
    ; categoria de prioridades 1. (consultar la documentacion en main.clp en la que indico esta

    (Terminado (estado si))
    ?hecho <- (Terminado (estado no))

    =>

    (retract ?hecho)
)


; COMPROBACIONES DE SEGURIDAD
;===================================================================================================

; No podemos tener al mismo tiempo un hecho Terminado si y un hecho Terminado no
(defrule checkTerminadoEstadoValido

    ; Las comprobaciones de seguridad tienen este valor de prioridad
    (declare (salience 7000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))


    ; Tomamos dos hechos que se contradicen
    (Terminado (estado si))
    (Terminado (estado no))

    =>

    (printout t "ERROR! Tenemos al mismo tiempo los hechos (Terminado (estado si)) y (Terminado (estado no))" crlf)
    (printout t "   Esto claramente no es posible, y deja al programa en un estado invalido" crlf)
)
