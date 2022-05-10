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

; Definimos los hechos inciales relacionados con los modulos
; Principalmente, el orden de los modulos y el modulo inicial
(deffacts EstadoInicialModulos
    ; Modulo inicial con el que iniciamos la conversacion
    (ModuloConversacion (modulo sergio))

    ; Orden de los modulos
    (SiguienteModulo (modulo sergio) (siguientemodulo carlos))
    (SiguienteModulo (modulo carlos) (siguientemodulo luis))
)
