; Modulo en el que indicamos los hechos iniciales
; Es decir, definimos el estado del que parte el sistema

(deffacts estado_inicial

    ; Este hecho controla si hemos terminado el razonamiento
    ; Lo usamos para poder finalizar cuando queramos, sin tener que seguir con la conversacion
    ; si ya tenemos toda la informacion necesaria
    (Terminado (estado no))

    ; Empezamos sin un empate entre las dos ramas de informacion
    (EmpateInformacion (flag no))
)
