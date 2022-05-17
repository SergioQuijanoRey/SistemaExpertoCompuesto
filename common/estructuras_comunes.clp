; Modulo en el que vamos a definir estructuras comunes
; Por ejemplo, ciertas respuestas a ciertas preguntas se pueden repetir, y queremos reusar ese
; conocimiento en los distintos modulos, aunque usen ese conocimiento de forma distinta
; Por ejemplo, los tres modulos puede ser que usen si al estudiante le gustan o no las matematicas

(deftemplate EstudianteGusta
    (slot materia
        (type SYMBOL)
        (allowed-symbols hardware matematicas programacion basesdatos)
    )

    (slot cantidad
        (type SYMBOL)
        (allowed-symbols mucho normal poco nose)
    )
)

