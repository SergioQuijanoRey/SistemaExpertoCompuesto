; Modulo en el que vamos a definir estructuras comunes
; Por ejemplo, ciertas respuestas a ciertas preguntas se pueden repetir, y queremos reusar ese
; conocimiento en los distintos modulos, aunque usen ese conocimiento de forma distinta
; Por ejemplo, los tres modulos puede ser que usen si al estudiante le gustan o no las matematicas

(deftemplate EstudianteGusta
    (slot materia
        (type SYMBOL)
        (allowed-symbols hardware matematicas programacion basesdatos proyectos cienciascomputacion ia cienciadatos seguridad web cantidadexamenes cargapractica cargateorica linux)
    )

    (slot cantidad
        (type SYMBOL)
        (allowed-symbols si no mucho normal poco nose)
    )
)

; Usamos estas reglas para unificar la regla que tiene Carlos sobre hardware (si no nose) con la que
; tiene sergio (mucho normal poco nose) en el caso de hardware
(defrule UnificarHardwareLuisToSergio_casosi
    (declare (salience 9999))

    ; Estamos en el modulo de sergio, que necesita de este cambio
    (ModuloConversacion (modulo sergio))

    ; Tenemos una regla sobre hardware que hay que unificar
    ?hecho <- (EstudianteGusta (materia hardware) (cantidad si))

    =>

    ; Retiramos el hecho en el formato antiguo
    (retract ?hecho)

    ; Introducimos un hecho en el formato nuevo
    (assert (EstudianteGusta (materia hardware) (cantidad mucho)))
)
(defrule UnificarHardwareLuisToSergio_casono
    (declare (salience 9999))

    ; Estamos en el modulo de sergio, que necesita de este cambio
    (ModuloConversacion (modulo sergio))

    ; Tenemos una regla sobre hardware que hay que unificar
    ?hecho <- (EstudianteGusta (materia hardware) (cantidad no))

    =>

    ; Retiramos el hecho en el formato antiguo
    (retract ?hecho)

    ; Introducimos un hecho en el formato nuevo
    (assert (EstudianteGusta (materia hardware) (cantidad poco)))
)
