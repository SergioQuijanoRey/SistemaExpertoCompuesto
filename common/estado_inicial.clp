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

; Hechos iniciales para indicar el arte ascii de los nombres de los modulos
(deffacts ArteAscii
    (AsciiArt inicial
"(_)     (_)    (_)     | |
 _ _ __  _  ___ _  __ _| |
| | '_ \\| |/ __| |/ _` | |
| | | | | | (__| | (_| | |
|_|_| |_|_|\\___|_|\\__,_|_|
"
    )


    (AsciiArt sergio
"
/  ___|              (_)
\\ `--.  ___ _ __ __ _ _  ___
 `--. \\/ _ \\ '__/ _` | |/ _ \\
/\\__/ /  __/ | | (_| | | (_) |
\\____/ \\___|_|  \\__, |_|\\___/
                 __/ |
                |___/
"
    )


    (AsciiArt carlos
"
/  __ \\          | |
| /  \\/ __ _ _ __| | ___  ___
| |    / _` | '__| |/ _ \\/ __|
| \\__/\\ (_| | |  | | (_) \\__ \\
 \\____/\\__,_|_|  |_|\\___/|___/
"
    )


    (AsciiArt luis
"
 _           _
| |         (_)
| |    _   _ _ ___
| |   | | | | / __|
| |___| |_| | \\__ \\
\\_____/\\__,_|_|___/
"
    )

)
