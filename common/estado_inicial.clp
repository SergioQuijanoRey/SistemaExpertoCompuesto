; Modulo en el que establecemos el estado inicial comun
; Notar que los tres modulos pueden establecer su estado inicial de forma individual

; Definimos los hechos inciales relacionados con los modulos
; Principalmente, el orden de los modulos y el modulo inicial
(deffacts EstadoInicialModulos
    ; Modulo inicial con el que iniciamos la conversacion
    (ModuloConversacion (modulo inicial))

    ; Orden de los modulos
    (SiguienteModulo (modulo inicial) (siguientemodulo sergio))
    (SiguienteModulo (modulo sergio) (siguientemodulo carlos))
    (SiguienteModulo (modulo carlos) (siguientemodulo luis))
)
