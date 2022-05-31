; Modulo en el que vamos a desarrollar la conversacion para desempatar entre las dos ramas de
; informacion. Podriamos hacer esto en el modulo de la conversacion normal, pero hay que tener en
; cuenta que ahora estamos haciendo preguntas mas concretas al usuario para distinguir entre dos
; ramas muy parecidas. Ademas, se puede llegar a la situacion de empate de varias formas, asi que
; los hechos de partida (ie. si le gusta programar, si le gustan las matematicas) son distintos, y
; esto modifica tanto el flujo de la conversacion como la logica de alto nivel que aplicamos. En
; este modulo solo desarrollamos la conversacion, para la logica de alto nivel consultar
; logica_alto_nivel_desempatar.clp
; Ademas, en la conversacion, volvemos a usar prioridades en el rango -1, -2, ... porque el resto de
; reglas de la conversacion normal tienen en cuenta el empate para no seguir por esas preguntas

; Podemos llegar en las siguientes situaciones a este modo:
; 1. Hardware descartado | normal, nota media normal, Mates sí
; 2. Hardware descartado | normal, nota media normal | alta | muy alta, Mates no | nose, programar no | nose

; Empezamos mostrando que estamos en una situacion de empate
(defrule mostrarQueEstamosEnUnEmpate

    (declare (salience -2))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; No se ha terminado y estamos en un empate
    (Terminado (estado no))
    (EmpateInformacion (flag si))

    =>

    (printout t "Vaya! Creo que te voy a recomentar la rama de Tecnologias de la Informacion o la rama de Sistemas de Informacion" crlf)
    (printout t "El problema es que son dos ramas muy parecidas, asi que voy a tener que ver como nos decidimos por una de las dos" crlf)

    ; El sistema va a poder tomar decisiones sin que tengamos que preguntar mas cosas al usuario
    ; Por tanto, uso esta regla para forzar el mensaje anterior, sin que se tomen decisiones antes
    ; de mostrar dicho mensaje
    (assert (MensajeInicial dado))
)

; PREGUNTA SOBRE SI GUSTA TRABAJAR CON BASES DE DATOS
;===================================================================================================

; Esta conversacion solo se da cuando no le gustan ni las matematicas ni programar
(defrule conversacionDesempateNoGustaNiProgramarNiMatematicasPreguntaBaseDatos


    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; No se ha terminado y estamos en un empate
    (Terminado (estado no))
    (EmpateInformacion (flag si))

    ; Al estudiante no le gusta ni programar ni las matematicas
    (EstudianteGusta (materia programacion) (cantidad no | nose))
    (EstudianteGusta (materia matematicas) (cantidad no | nose))

    =>

    (printout t "Veo que no te gustan ni las matematicas ni programar. Ambas ramas tienen un poco de todo asi que te voy a tener que preguntar por otros temas" crlf)
    (printout t "Te gusta trabajar directamente con bases de datos?" crlf)
    (printout t "Las opciones son: si / no / nose" crlf)
    (printout t "Recuerda que no puedes responder 'no se', escribelo todo junto como 'nose'" crlf)
    (printout t "Entrada: ")
    (assert (EstudianteGusta (materia basesdatos) (cantidad (read))))
)

(defrule ValidarEstudianteGustaBasesDatos

    ; Las comprobaciones de seguridad tienen prioridad 7000
    (declare (salience 7000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))


    ; El estudiante ya ha introducido una respuesta a la pregunta sobre el hardware
    (EstudianteGusta (materia basesdatos) (cantidad ?nivel))

    ; La respuesta dada no es valida
    (test (and
        (neq ?nivel si)
        (neq ?nivel no)
        (neq ?nivel nose)
    ))

    =>

    ; Marcamos la respuesta como no valida
    (assert (ValidoEstudianteGustaBasesDatos false))


)

(defrule RepiteConversacionGustaBasesDatos

    ; Asigno la misma prioridad que la prioridad de la pregunta que estamos corrigiendo
    (declare (salience -2))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))


    ; Comprobamos que no hayamos terminado con la conversacion y que estemos en un empate
    (Terminado (estado no))
    (EmpateInformacion (flag si))

    ; Tomo la respuesta dada por el estudiante; que tendremos que retirar
    ?respuesta <- (EstudianteGusta (materia basesdatos) (cantidad ?nivel))

    ; La respuesta dada no es correcta
    ?validacion <- (ValidoEstudianteGustaBasesDatos false)

    =>

    ; Retiramos la marca de validacion de la respuesta
    ; Asi, la nueva respuesta que va a dar el usuario se va a validar de nuevo
    (retract ?validacion)

    ; Retiramos la respuesta incorrecta, para que solo quede la respuesta correcta
    (retract ?respuesta)

    ; Repetimos la pregunta
    (printout t "" crlf)
    (printout t "La respuesta que me has dado no es correcta!" crlf)
    (printout t "Has respondido " ?nivel ", que no es ni si / no / nose" crlf)
    (printout t "Recuerda escribir la respuesta en minusculas" crlf)
    (printout t "Recuerda tambien que si quieres decir 'no se', debes escribir 'nose' porque 'no se' no es valido" crlf)
    (printout t "Repite tu respuesta (si / no / nose)" crlf)
    (printout t "Entrada: ")
    (assert (EstudianteGusta  (materia basesdatos) (cantidad (read))))
)

; PREGUNTA SOBRE SI LE GUSTA USAR LINUX
;===================================================================================================

; Esta conversacion solo se da cuando no le gustan ni las matematicas ni programar
(defrule conversacionDesempateGustaLinux


    (declare (salience -3))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; No se ha terminado y estamos en un empate
    (Terminado (estado no))
    (EmpateInformacion (flag si))

    ; Al estudiante no le gusta ni programar ni las matematicas
    (EstudianteGusta (materia programacion) (cantidad no | nose))
    (EstudianteGusta (materia matematicas) (cantidad no | nose))

    =>

    (printout t "Vale, ahora dime si te gusta / estas comodo usando linux" crlf)
    (printout t "Las opciones son: si / no / nose" crlf)
    (printout t "Recuerda que no puedes responder 'no se', escribelo todo junto como 'nose'" crlf)
    (printout t "Entrada: ")
    (assert (EstudianteGusta (materia linux) (cantidad (read))))
)

(defrule ValidarEstudianteGustaLinux

    ; Las comprobaciones de seguridad tienen prioridad 7000
    (declare (salience 7000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))


    ; El estudiante ya ha introducido una respuesta a la pregunta sobre linux
    (EstudianteGusta (materia linux) (cantidad ?nivel))

    ; La respuesta dada no es valida
    (test (and
        (neq ?nivel si)
        (neq ?nivel no)
        (neq ?nivel nose)
    ))

    =>

    ; Marcamos la respuesta como no valida
    (assert (ValidoEstudianteGustaLinux false))

)

(defrule RepiteConversacionGustaLinux

    ; Asigno la misma prioridad que la prioridad de la pregunta que estamos corrigiendo
    (declare (salience -4))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))


    ; Comprobamos que no hayamos terminado con la conversacion y que estemos en un empate
    (Terminado (estado no))
    (EmpateInformacion (flag si))

    ; Tomo la respuesta dada por el estudiante; que tendremos que retirar
    ?respuesta <- (EstudianteGusta (materia linux) (cantidad ?nivel))

    ; La respuesta dada no es correcta
    ?validacion <- (ValidoEstudianteGustaLinux false)

    =>

    ; Retiramos la marca de validacion de la respuesta
    ; Asi, la nueva respuesta que va a dar el usuario se va a validar de nuevo
    (retract ?validacion)

    ; Retiramos la respuesta incorrecta, para que solo quede la respuesta correcta
    (retract ?respuesta)

    ; Repetimos la pregunta
    (printout t "" crlf)
    (printout t "La respuesta que me has dado no es correcta!" crlf)
    (printout t "Has respondido " ?nivel ", que no es ni si / no / nose" crlf)
    (printout t "Recuerda escribir la respuesta en minusculas" crlf)
    (printout t "Recuerda tambien que si quieres decir 'no se', debes escribir 'nose' porque 'no se' no es valido" crlf)
    (printout t "Repite tu respuesta (si / no / nose)" crlf)
    (printout t "Entrada: ")
    (assert (EstudianteGusta (materia linux) (cantidad (read))))
)
