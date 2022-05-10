; Modulo en el que definimos la conversacion que se va a seguir
; En este fichero no nos encargamos de la toma de decisiones, de razonar sobre las respuestas...
; Para mas informacion sobre esta logica, consultar el fichero logica_alto_nivel.clp

; En el fichero estructura_respuestas.clp tenemos los deftemplates que fijan las estructuras que
; usamos para representar las respuestas dadas por el usuario

; Regla para iniciar la conversacion con el usuario
; Mostramos un mensaje introductorio
(defrule ConversacionPresentacion

    (declare (salience -1))

    =>

    (printout t "Bienvenido a mi recomendador de ramas, de la ETSIIT UGR" crlf)
    (printout t "En este sistema experto reflejo mi conocimiento sobre las ramas de la carrera, para recomendarte una rama en concreto" crlf)
    (printout t "Espero que sea de ayuda, y empezamos con las preguntas :D" crlf)
    (printout t "" crlf)
)

;===================================================================================================

; Reglas para preguntar al usuario cuanto le gusta el hardware
; Realizamos la pregunta directa al usuario y, ademas, validamos la respuesta dada

(defrule ConversacionGustaHardware

    (declare (salience -2))

    ; Comprobamos que no hayamos terminado con la conversacion
    (Terminado (estado no))

    =>


    (printout t "Para empezar, cuanto dirias que te gusta la parte relacionada a hardware?" crlf)
    (printout t "Las opciones son:" crlf)
    (printout t "mucho / normal / poco / nose" crlf)
    (printout t "Entrada: ")
    (assert (EstudianteGustaHardware (cantidad (read))))
)

(defrule ValidarEstudianteGustaHardware

    ; Las comprobaciones de seguridad tienen prioridad 7000
    (declare (salience 7000))

    ; El estudiante ya ha introducido una respuesta a la pregunta sobre el hardware
    (EstudianteGustaHardware (cantidad ?nivel))

    ; La respuesta dada no es valida
    (test (and
        (neq ?nivel mucho)
        (neq ?nivel normal)
        (neq ?nivel poco)
        (neq ?nivel nose)
    ))

    =>

    ; Marcamos la respuesta como no valida
    (assert (ValidoEstudianteGustaHardware false))


)

(defrule RepiteConversacionGustaHardware

    ; Asigno la misma prioridad que la prioridad de la pregunta que estamos corrigiendo
    (declare (salience -2))

    ; Comprobamos que no hayamos terminado con la conversacion
    (Terminado (estado no))

    ; Tomo la respuesta dada por el estudiante; que tendremos que retirar
    ?respuesta <- (EstudianteGustaHardware (cantidad ?nivel))

    ; La respuesta dada no es correcta
    ?validacion <- (ValidoEstudianteGustaHardware false)

    =>

    ; Retiramos la marca de validacion de la respuesta
    ; Asi, la nueva respuesta que va a dar el usuario se va a validar de nuevo
    (retract ?validacion)

    ; Retiramos la respuesta incorrecta, para que solo quede la respuesta correcta
    (retract ?respuesta)

    ; Repetimos la pregunta
    (printout t "" crlf)
    (printout t "La respuesta que me has dado no es correcta!" crlf)
    (printout t "Has respondido " ?nivel ", que no es ni mucho / normal / poco / nose" crlf)
    (printout t "Recuerda escribir la respuesta en minusculas" crlf)
    (printout t "Recuerda tambien que si quieres decir 'no se', debes escribir 'nose' porque 'no se' no es valido" crlf)
    (printout t "Repite tu respuesta (mucho / normal / poco / nose)" crlf)
    (printout t "Entrada: ")
    (assert (EstudianteGustaHardware (cantidad (read))))
)

;===================================================================================================

; Reglas para preguntar al usuario su nota media
; Realizamos la pregunta directa al usuario y, ademas, validamos la respuesta dada
;
; A partir de un valor numerico, categorizaremos en cuatro categorias discretas que seran suficientes
; para que nuestro sistema razone


(defrule conversacionNotaMedia
    (declare (salience -3))

    ; Comprobamos que no hayamos terminado con la conversacion
    (Terminado (estado no))

    =>


    (printout t "Vale, ahora lo que necesito saber es cual es tu nota media (me vale un valor aproximado)" crlf)
    (printout t "Por ejemplo, 7.5, o 9, ... Pero debes responder un valor numerico" crlf)
    (printout t "Entrada: ")
    (assert (NotaMediaEstudiante (numero (read))))
)


(defrule ValidarNotaMediaRangos

    ; Las comprobaciones de seguridad tienen prioridad 7000
    (declare (salience 7000))

    ; El estudiante ya ha introducido una respuesta a la pregunta sobre el hardware
    (NotaMediaEstudiante (numero ?nivel))

    ; La respuesta dada no es valida
    (test (or
        (< ?nivel 0)
        (> ?nivel 10)
    ))

    =>

    ; Marcamos la respuesta como no valida por no estar en un buen rango
    (assert (ValidoNotaMedia rango false))

)


(defrule RepiteConversacionNotaMedia

    ; Asigno la misma prioridad que la prioridad de la pregunta que estamos corrigiendo
    (declare (salience -3))

    ; Comprobamos que no hayamos terminado con la conversacion
    (Terminado (estado no))

    ; Tomo la respuesta dada por el estudiante, que  tendremos que retirar por no ser valida
    ?respuesta <- (NotaMediaEstudiante (numero ?nivel))

    ; La respuesta dada no es correcta, porque el rango no es valido
    ?validacion <- (ValidoNotaMedia rango false)

    =>

    ; Retiramos la marca de validacion de la respuesta
    ; Asi, la nueva respuesta que va a dar el usuario se va a validar de nuevo
    (retract ?validacion)

    ; Retiramos la respuesta incorrecta, para que solo quede la respuesta correcta
    (retract ?respuesta)

    ; Repetimos la pregunta
    (printout t "" crlf)
    (printout t "La respuesta que me has dado no es correcta!" crlf)
    (printout t "Has respondido " ?nivel ", que no esta en el rango [0, 10] que esperaba" crlf)
    (printout t "Repite tu respuesta en un rango de 0 a 10, por favor" crlf)
    (printout t "Entrada: ")
    (assert (NotaMediaEstudiante (numero (read))))
)

;===================================================================================================


; Reglas para preguntar al usuario si le gusta o no las matematicas
; Realizamos la pregunta directa al usuario y, ademas, validamos la respuesta dada

(defrule ConversacionGustaMatematicas

    (declare (salience -4))

    ; Comprobamos que no hayamos terminado con la conversacion
    (Terminado (estado no))

    =>


    (printout t "Vale, ahora dime si te gustan o no las matematicas." crlf)
    (printout t "Las opciones son: si / no / nose" crlf)
    (printout t "Recuerda que no puedes responder 'no se', escribelo todo junto como 'nose'" crlf)
    (printout t "Entrada: ")
    (assert (EstudianteGustaMatematicas (cantidad (read))))
)

(defrule ValidarEstudianteGustaMatematicas

    ; Las comprobaciones de seguridad tienen prioridad 7000
    (declare (salience 7000))

    ; El estudiante ya ha introducido una respuesta a la pregunta sobre el hardware
    (EstudianteGustaMatematicas (cantidad ?nivel))

    ; La respuesta dada no es valida
    (test (and
        (neq ?nivel si)
        (neq ?nivel no)
        (neq ?nivel nose)
    ))

    =>

    ; Marcamos la respuesta como no valida
    (assert (ValidoEstudianteGustaMatematicas false))


)

(defrule RepiteConversacionGustaMatematicas

    ; Asigno la misma prioridad que la prioridad de la pregunta que estamos corrigiendo
    (declare (salience -4))

    ; Comprobamos que no hayamos terminado con la conversacion
    (Terminado (estado no))

    ; Tomo la respuesta dada por el estudiante; que tendremos que retirar
    ?respuesta <- (EstudianteGustaMatematicas (cantidad ?nivel))

    ; La respuesta dada no es correcta
    ?validacion <- (ValidoEstudianteGustaMatematicas false)

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
    (assert (EstudianteGustaMatematicas (cantidad (read))))
)

;===================================================================================================


; Reglas para preguntar al usuario si le gusta o no programar
; Realizamos la pregunta directa al usuario y, ademas, validamos la respuesta dada

(defrule ConversacionGustaProgramar

    (declare (salience -5))

    ; Comprobamos que no hayamos terminado con la conversacion
    (Terminado (estado no))

    ; Comprobamos que no haya un empate en informacion, pues en este caso la decision ya esta
    ; tomada, solo hay que elegir una de las dos ramas empatadas. En teste punto de la conversacion
    ; ya puede darse esa condicion
    (EmpateInformacion (flag no))

    =>


    (printout t "Con la informacion que me has dado hasta ahora, necesito saber si te gusta programar o no." crlf)
    (printout t "La forma de proceder con esta pregunta es igual que con la anterior, pero la repito para que quede mas claro" crlf)
    (printout t "Las opciones son: si / no / nose" crlf)
    (printout t "Recuerda que no puedes responder 'no se', escribelo todo junto como 'nose'" crlf)
    (printout t "Entrada: ")
    (assert (EstudianteGustaProgramar (cantidad (read))))
)

(defrule ValidarEstudianteGustaProgramar

    ; Las comprobaciones de seguridad tienen prioridad 7000
    (declare (salience 7000))

    ; El estudiante ya ha introducido una respuesta a la pregunta sobre el hardware
    (EstudianteGustaProgramar (cantidad ?nivel))

    ; La respuesta dada no es valida
    (test (and
        (neq ?nivel si)
        (neq ?nivel no)
        (neq ?nivel nose)
    ))

    =>

    ; Marcamos la respuesta como no valida
    (assert (ValidoEstudianteGustaProgramar false))


)

(defrule RepiteConversacionGustaProgramar

    ; Asigno la misma prioridad que la prioridad de la pregunta que estamos corrigiendo
    (declare (salience -5))

    ; Comprobamos que no hayamos terminado con la conversacion
    (Terminado (estado no))

    ; Comprobamos que no haya un empate en informacion, pues en este caso la decision ya esta
    ; tomada, solo hay que elegir una de las dos ramas empatadas. En teste punto de la conversacion
    ; ya puede darse esa condicion
    (EmpateInformacion (flag no))

    ; Tomo la respuesta dada por el estudiante; que tendremos que retirar
    ?respuesta <- (EstudianteGustaProgramar (cantidad ?nivel))

    ; La respuesta dada no es correcta
    ?validacion <- (ValidoEstudianteGustaProgramar false)

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
    (assert (EstudianteGustaProgramar (cantidad (read))))
)
