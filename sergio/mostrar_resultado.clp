; Modulo en el que mostramos el resultado final que el sistema ha marcado como respuesta

; En esta regla, mostramos la decision final que toma el sistema
; Marcamos una regla para mostrar todos los motivos por los que recomendamos cierta rama
(defrule mostrarResultadoFinal

    ; Si ocurre el caso de que descartamos una rama, y tomamos la decision por otra rama, queremos
    ; mostrar ambos hechos, porque aportan al usuario mas informacion sobre la decision tomada, somos
    ; mas informativos. Creo que el orden logico es mostrar primero por que se descarta cierta rama
    ; y mas tarde mostrar los motivos por los que tomamos la decision final, una vez que ya se han
    ; ido descartando ciertas decisiones. Por tanto, ponemos menos prioridad que las reglas que
    ; como añadir un flag FIFO y en base a ello modificar el comportamiento del programa)
    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))


    (Terminado (estado si))
    (Decision (rama ?rama))
    (NombreRama ?rama ?ramaformato)

    =>

    ; Mostramos la decision final
    (printout t "Ya hemos llegado a una conclusion :D" crlf)
    (printout t "Te recomiendo que escojas la rama " ?ramaformato crlf)
    (printout t "Los motivos por los que te recomiendo esta rama son:" crlf)

    ; Marcamos que tenemos que mostrar los motivos para escoger esta rama
    (assert (MostrarMotivos ?rama))


    ; Establecemos estrategia FIFO, para que los consejos que vamos a mostrar se muestren por orden
    ; de añadido, y asi evitar tener que modificar la estructura de las reglas (Consejo ?rama ?texto)
    (set-strategy breadth)
)


; Regla que muestra los motivos por los cuales se ha escogido cierta rama
; Nos apoyamos en que se toman los consejos en orden de añadido. Es decir, se tiene que establecer
; la estrategia de resolucion de conflictos FIFO
; De otra forma, tendriamos que modificar las reglas del tipo
;   (Consejo rama texto)
; por reglas del tipo
;   (Consejo rama orden texto)
(defrule mostrarMotivos


    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    (MostrarMotivos ?rama)

    ?consejo <- (Consejo ?rama ?texto)

    =>

    (printout t "   - " ?texto crlf)
    (retract ?consejo)
)


; Mostramos el motivo por el que descartamos ciertas asignaturas
; Esto lo hacemos durante la conversacion, porque creo que asi la interaccion con el usuario es mas
; natural
;
; Aqui da igual la estrategia que usemos, porque en el guion de practicas no se especifican restricciones
; sobre esta regla, y por tanto puedo indicar el orden. Sin embargo, fijando la estrategia a FIFO,
; obtenemos la misma funcionalidad de forma directa

; Si hay algun descarte que mostrar, establecemos la estrategia FIFO para mostrar correctamente
; los mensajes
(defrule algunDescartePonerFIFO



    (declare (salience -1))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; La regla añade un hecho basico del programa (en realidad realiza una modificacion, pero seria

    ; Existe alguna regla de descarte, asi que es necesario que activemos ya el modo FIFO
    (Descartar ?rama ?orden ?texto)

    =>

    ; Establecemos estrategia FIFO, para que los consejos que vamos a mostrar se muestren por orden
    ; de añadido, y asi evitar tener que modificar la estructura de las reglas (Consejo ?rama ?texto)
    (set-strategy breadth)
)

; Mostramos un mensaje algo distinto la primera vez que en el restro de veces
; En el primer mensaje mostramos la rama que descartamos
(defrule MostrarPrimerDescarte



    (declare (salience -2))

    ; muestran los descartes
    (declare (salience -4))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; Tomamos el primer descarte
    ?hecho <- (Descartar ?rama ?orden ?texto)
    (test (eq ?orden 1))

    ; Tomamos el formato de texto de la rama
    (NombreRama ?rama ?ramaformato)

    =>

    (retract ?hecho)

    ; En esta regla en concreto, tenemos que mostrar que descartamos cierta rama
    (printout t "Descartamos la rama " ?ramaformato " por los siguientes motivos: " crlf)
    (printout t "   -  " ?texto crlf)

)

; Mostramos los motivos por los que se descarta una rama
; El primer mensaje ya se ha mostrado, asi que ahora solo hacemos print en modo lista
(defrule mostrarListaDeDescarte



    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))
    ?hecho <- (Descartar ?rama ?orden ?texto)


    =>

    (retract ?hecho)

    ; En esta regla en concreto, tenemos que mostrar que descartamos cierta rama
    (printout t "   -  " ?texto crlf)
)
