; Modulo en el que vamos a definir estructuras comunes
; Por ejemplo, ciertas respuestas a ciertas preguntas se pueden repetir, y queremos reusar ese
; conocimiento en los distintos modulos, aunque usen ese conocimiento de forma distinta
; Por ejemplo, los tres modulos puede ser que usen si al estudiante le gustan o no las matematicas

(deftemplate EstudianteGusta
    (slot materia
        (type SYMBOL)
        (allowed-symbols hardware matematicas programacion basesdatos proyectos cienciascomputacion ia cienciadatos seguridad web cantidadexamenes cargapractica cargateorica linux administracionsistemas red docencia robotica)
    )

    (slot cantidad
        (type SYMBOL)
        (allowed-symbols si no mucho normal poco nose)
    )
)

; Definimos estas dos reglas para unificar los criterios de los tres compañeros
; Sergio tiene reglas que usan mucho poco normal. Luis y Carlos solo tienen reglas de si | no | nose
; Usamos estas dos reglas para hacer la transformacion
(defrule UnificarEstudianteGustaMuchoONormal
    (declare (salience 9999))
    (EstudianteGusta (materia ?x) (cantidad ?y))
    (test (or
        (eq ?y normal)
        (eq ?y mucho)
    ))

    =>

    (assert (EstudianteGusta (materia ?x) (cantidad si)))
)
(defrule UnificarEstudianteGustaPoco
    (declare (salience 9999))

    (EstudianteGusta (materia ?x) (cantidad ?y))
    (test (eq ?y poco))

    =>

    (assert (EstudianteGusta (materia ?x) (cantidad no)))
)
