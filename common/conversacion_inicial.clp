; Modulo en el que definimos la conversacion que vamos a tener al comienzo de la sesion

(defrule mensajeBienvenida

    ; Nos encontramos en el modulo inicial
    (ModuloConversacion (modulo inicial))

    =>

    ; Mostramos los mensajes
    (printout t "" crlf)
    (printout t "Bienvenido a nuestro sistema experto conjunto sobre las ramas de la carrera de Informatica" crlf)
    (printout t "Somos Sergio, Carlos y Luis. Entre los tres esperamos ayudarte" crlf)
    (printout t "Hablaras con nosotros en orden. Te haremos ciertas preguntas y te daremos tres consejos, siguiendo nuestros tres criterios propios" crlf)
    (printout t "Esperamos asi darte una vision mas global para que puedas tomar tu propia decision de manera mas informada" crlf)
    (printout t "" crlf)

    ; Ahora marcamos que queremos pasar al siguiente modulo
    (assert (QuieroSiguienteModulo si))
)
