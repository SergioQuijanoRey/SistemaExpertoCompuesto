; Modulo en el que vamos a definir estructuras comunes
; Por ejemplo, ciertas respuestas a ciertas preguntas se pueden repetir, y queremos reusar ese
; conocimiento en los distintos modulos, aunque usen ese conocimiento de forma distinta
; Por ejemplo, los tres modulos puede ser que usen si al estudiante le gustan o no las matematicas

(deftemplate EstudianteGusta
    (slot materia
        (type SYMBOL)
        (allowed-symbols hardware matematicas programacion basesdatos proyectos cienciascomputacion ia cieciadatos seguridad web cantidadexamenes cargapractica cargateorica)
    )

    (slot cantidad
        (type SYMBOL)
        (allowed-symbols si no mucho normal poco nose)
    )
)

(deftemplate UnificarEstudianteGusta1
(declare (salience 9999))
(EstudianteGusta (materia ?x) (cantidad ?y))
(test (eq ?y mucho | normal))
=>
(assert (EstudianteGusta (materia ?x) (cantidad si)))
)


(deftemplate UnificarEstudianteGusta2
(declare (salience 9999))
(EstudianteGusta (materia ?x) (cantidad ?y))
(test (eq ?y poco))
=>
(assert (EstudianteGusta (materia ?x) (cantidad no)))
)
