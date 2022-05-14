; Modulo en el que definimos la logica que controla en que parte de la conversaciones nos encontramos
; Iniciaremos la conversacion con el sistema de Sergio, despues el de Carlos y para finalizar el de Luis

; Estructura para definir el modulo en el que nos encontramos actualmente
(deftemplate ModuloConversacion
    (slot modulo
        (type SYMBOL)
        (allowed-symbols sergio carlos luis)
    )
)

; Con esta estructura controlamos el modulo siguiente a un modulo dado
(deftemplate SiguienteModulo
    (slot modulo
        (type SYMBOL)
        (allowed-symbols sergio carlos luis)
    )

    (slot siguientemodulo
        (type SYMBOL)
        (allowed-symbols sergio carlos luis)
    )

)

; Usamos esta regla para, si uno de los tres modulos marca que ha terminado, se pase al siguiente modulo
(defrule marcadoSiguienteModuloCambiaModulo
    ; Algun modulo ha marcado que ha terminado y que tiene que pasar al siguiente
    ?quieroprevio <- (QuieroSiguienteModulo si)

    ; Modulo previo para desmarcarlo
    ?moduloprevio <- (ModuloConversacion (modulo ?modprevio))

    ; Usamos la regla para saber cual es el siguiente modulo
    (SiguienteModulo (modulo ?modprevio) (siguientemodulo ?modsiguiente))

    =>

    ; Hacemos el cambio de modulo
    (retract ?moduloprevio)
    (assert (ModuloConversacion (modulo ?modsiguiente)))

    ; Retiramos el hecho para saltar a otro modulo, porque en otro caso
    (retract ?quieroprevio)

)

