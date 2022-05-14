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

