;;;
;;;  				CARLOS LARA CASANOVA
;;; 				UGR-INGENIERÍA DEL CONOCIMIENTO
;;; 				2021-2022
;;; 				SISTEMA EXPERTO SENCILLO
;;;

;;; Voy a utilizar las siguiente propiedades:

;; EL sistema usará las opininiones del alumno sobre distintos campos de la informática
;; para guardar dicha opinión utilizaré la tupla (EstudianteGusta tema si | no | nose)
;; dónde opinión es sí o no dependiendo de si está interesado o no. La opinión
;; se pregunta directamente.

;; EL sistema usas las disintas ramas de la asignatura que guardo como
;; (Rama nombre_rama)
;; Es conocimiento por defecto

;; El sistema usará si una rama es recomendable o no
;; Cuando una rama sea recomendable tendré (Recomendable rama)
;; Al inicio todas las ramas son recomendables.
;;
;; Dejarán de serlo si el alumno muestra rechazo a sus temas principiales
;; o si encuentro que muestra mayor interés en otras ramas.

;; Cuando deje de ser recomendable una rama estará descartada
;; que lo guardo como (Descartada rama)

;; Los temas principales que trata una rama se guardan como
;; (Imprescindible tema rama)
;; Son conocimiento por defecto.

;; Cuando un alumno muestre interés en lo que se da en una rama.
;; Si muestra sólo interés por algunos de los temas entonces mostrará
;; menor interés por dicha rama. Esto se representa mediante.
;;
;; (Interes rama) si muestra interés por todos sus temas
;;
;; (InteresParcial rama) si muestra interés por alguno de sus temas
;;
;; Para ver el interés que muestra hago uso de las respuestas a las preguntas
;; que están guardadas en (Opninion tema si | no | nose)
;;

;; Tambien guardo algunas características de las distintas ramas como
;;
;; (nombre_caracteristicas valor | nose rama)
;;
;; Dónde valor puede ser mucho | poco ó mucho | poco dependiendo de la
;; característica
;;
;; Esto es conocimiento por defecto
;;
;; Esto se usará para comparar qué rama se adecúa más al alumno
;; cuando ha mostrado el mismo interés en distitas ramas.
;; Para saber sus gustos le pregunto y lo guardo en:
;;
;; (nombre_caracteristicas valor | nose usuario)
;;
;;
;; Tambien guardo el orden de las ramas según mi preferencia para ello guardo para cada rama
;; (Orden 1|2|3|4|5 rama)
;; dónde cuando menor el número más prioridad
;; Esto sólo se usa si el alumnos muestra el mismo interés sobre varias ramas al final del todo.
;; Entonces le recomiendo la que a mi me parece más interesante.

;; El resto del conocimiento se usa para gestionar las preguntas, escribir cadenas
;; de texto y son auxiliares.


;;; El sistema empieza con el conocimiento de las distintas ramas de informatica
(deffacts Ramas
	(Rama Computacion_y_Sistemas_Inteligentes)
	(Rama Ingenieria_del_Software)
	(Rama Ingenieria_de_Computadores)
	(Rama Sistemas_de_Informacion)
	(Rama Tecnologias_de_la_Informacion)
)


;;; Los siguientes hechos son campos imprescindibles para cada rama
;;: Sino te gusta un campo asocidado a una rama entonces no se
;;; va a recomnedar. De esta forma descarto recomendaciones tan
;;; absurdas como recomendar la rama de CSI a un alumno al que no
;;; le interesa la ia.
(deffacts Imprescindibles
	(Imprescindible cienciascomputacion Computacion_y_Sistemas_Inteligentes)
	(Imprescindible ia Computacion_y_Sistemas_Inteligentes)
	(Imprescindible programacion Ingenieria_del_Software)
	(Imprescindible proyectos Ingenieria_del_Software)
	(Imprescindible hardware Ingenieria_de_Computadores)
	(Imprescindible basesdatos Sistemas_de_Informacion)
	(Imprescindible cienciadatos Sistemas_de_Informacion)
	(Imprescindible seguridad Tecnologias_de_la_Informacion)
	(Imprescindible web Tecnologias_de_la_Informacion)
)

;;;
;;; Aqui guardo otro conocimiento relativo a las ramas que
;;; tiene que ver con cómo se imparten en general y no con
;;; lo que se da en ellas
;;;
(deffacts Caracteristicas
	(cantidadexamenes mucho Computacion_y_Sistemas_Inteligentes)
	(cantidadexamenes mucho Sistemas_de_Informacion)
	(cantidadexamenes mucho Tecnologias_de_la_Informacion)
	(cantidadexamenes mucho Ingenieria_de_Computadores)
	(cantidadexamenes poco Ingenieria_del_Software)
	(cargapractica mucho Computacion_y_Sistemas_Inteligentes)
	(cargapractica poco Sistemas_de_Informacion)
	(cargapractica poco Tecnologias_de_la_Informacion)
	(cargapractica mucho Ingenieria_de_Computadores)
	(cargapractica mucho Ingenieria_del_Software)
	(cargateorica mucho Computacion_y_Sistemas_Inteligentes)
	(cargateorica mucho Sistemas_de_Informacion)
	(cargateorica poco Tecnologias_de_la_Informacion)
	(cargateorica poco Ingenieria_de_Computadores)
	(cargateorica poco Ingenieria_del_Software)
)

;;; muchos conceptos clave en texto
(deffacts Texto
	(Texto cargapractica "carga práctica")
	(Texto cargateorica "carga teorica")
	(Texto cantidadexamenes "cantidad de exámenes")
	(Texto Computacion_y_Sistemas_Inteligentes "Computación y Sistemas Inteligentes")
	(Texto Sistemas_de_Informacion "Sistemas de Información")
	(Texto Tecnologias_de_la_Informacion "Tecnologias de la Información")
	(Texto Ingenieria_de_Computadores "Ingeniería de Computadores")
	(Texto Ingenieria_del_Software "Ingeniería del Software")
	(Texto cienciascomputacion "Ciencia de la computación")
	(Texto ia "Inteliencia Artificial")
	(Texto web "Programación web")
	(Texto seguridad "seguridad informática")
	(Texto cienciadatos "Ciencia de datos")
	(Texto basesdatos "Bases de datos")
	(Texto hardware "Hardware")
	(Texto proyectos "Gestión de proyectos")
	(Texto programacion "Programación")
)

;;; Aqui guardo el conocimiento sobre mi preferencia personal a la hora
;;; de elegir ramas. En caso de que dos o más ramas sean recomendables al final
;;; entonces recomendaré la que a mi me parece más interesante.
(deffacts preferencias_mias
	(Orden 1 Computacion_y_Sistemas_Inteligentes)
	(Orden 2 Ingenieria_de_Computadores)
	(Orden 3 Tecnologias_de_la_Informacion)
	(Orden 4 Sistemas_de_Informacion)
	(Orden 5 Ingenieria_del_Software)
)

;;; Empiezo preguntando
(deffacts inicio
	(preguntar)
)

;;; Al inicio todas las ramas son recomendables porque no se nada de la persona
(defrule iniciar_recomendables
(declare (salience 9999))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Rama ?x)
=>
	(assert (Recomendable ?x))
)


;;; Si una pregunta no tiene una respuesta válida debo de volver a preguntarla
(defrule respuesta_invalida

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	?dir <- (pregunta ?x ?y)
	(and 	(test (neq ?y si))
				(test (neq ?y no))
				(test (neq ?y nose))
	)
=>
	(assert (preguntar))
	(retract ?dir)
)


;;; Guardo la respuesta de la pregunta como conocimiento que pueda usar para razonar
(defrule procesa_pregunta

(declare (salience 9998))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	?dir <- (pregunta ?x ?y)
=>
	(assert (EstudianteGusta (materia ?x) (cantidad ?y)))
	(assert (preguntar))
	(retract ?dir)
)

;;;
;;;  A Continuación hago las preguntas muy enfocadas a ver los intereses del alumno
;;;  para poder empezar a razonar por ahí y hacerle otras preguntas si fuera necesario
;;;
;;; La primera pregunta de cada rama será sobre el tema más importante de dicha rama, si no
;;: le gusta dicho tema descarto dicha rama y no le preguntaré si le interesan los otros
;;; temas que se dan en la rama.

(defrule pregunta2

(declare (salience 4999))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Recomendable Computacion_y_Sistemas_Inteligentes)
	(not (EstudianteGusta (materia cienciascomputacion) (cantidad ?)))
	?dir <- (preguntar)
=>
	(printout t "¿Te interesa la teoría de la computación? (si | no | nose)" crlf)
	(assert (pregunta cienciascomputacion (read)))
	(retract ?dir)
)

(defrule pregunta1

(declare (salience 5000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Recomendable Computacion_y_Sistemas_Inteligentes)
	(not (EstudianteGusta (materia ia) (cantidad ?)))
	?dir <- (preguntar)
=>
	(printout t "¿Te interesan las distintas técnicas de Inteligencia Artificial? (si | no | nose)" crlf)
	(assert (pregunta ia (read)))
	(retract ?dir)
)

(defrule pregunta4

(declare (salience 4997))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Recomendable Ingenieria_del_Software)
	(not (EstudianteGusta (materia programacion) (cantidad ?)))
	?dir <- (preguntar)
=>
	(printout t "¿Quieres mejorar tu habilidades de programación? (si | no | nose)" crlf)
	(assert (pregunta programacion (read)))
	(retract ?dir)
)

(defrule pregunta3

(declare (salience 4998))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Recomendable Ingenieria_del_Software)
	(not (EstudianteGusta (materia proyectos) (cantidad ?)))
	?dir <- (preguntar)
=>
	(printout t "¿Y te interesaría trabajar gestionando proyectos en empresas? (si | no | nose)" crlf)
	(assert (pregunta proyectos (read)))
	(retract ?dir)
)

(defrule pregunta5

(declare (salience 4996))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Recomendable Ingenieria_de_Computadores)
	(not (EstudianteGusta (materia hardware) (cantidad ?)))
	?dir <- (preguntar)
=>
	(printout t "¿Te han gustado las asignaturas que has dado relacionadas con el hardware? (si | no | nose)" crlf)
	(assert (pregunta hardware (read)))
	(retract ?dir)
)

(defrule pregunta7

(declare (salience 4994))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Recomendable Sistemas_de_Informacion)
	(not (EstudianteGusta (materia basesdatos) (cantidad ?)))
	?dir <- (preguntar)
=>
	(printout t "¿Te insteresa como se almacena de la información y las bases de datos? (si | no | nose)" crlf)
	(assert (pregunta basesdatos (read)))
	(retract ?dir)
)

(defrule pregunta6

(declare (salience 4995))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Recomendable Sistemas_de_Informacion)
	(not (EstudianteGusta (materia cienciadatos) (cantidad ?)))
	?dir <- (preguntar)
=>
	(printout t "¿Y que me dices del tema de la ciencia de datos, te gusta? (si | no | nose)" crlf)
	(assert (pregunta cienciadatos (read)))
	(retract ?dir)
)

(defrule pregunta9

(declare (salience 4992))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Recomendable Tecnologias_de_la_Informacion)
	(not (EstudianteGusta (materia seguridad) (cantidad ?)))
	?dir <- (preguntar)
=>
	(printout t "¿Te interesa el tema de la seguridad informática? (si | no | nose)" crlf)
	(assert (pregunta seguridad (read)))
	(retract ?dir)
)

(defrule pregunta8

(declare (salience 4993))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Recomendable Tecnologias_de_la_Informacion)
	(not (EstudianteGusta (materia web) (cantidad ?)))
	?dir <- (preguntar)
=>
	(printout t "¿Quieres aprender programación web? (si | no | nose)" crlf)
	(assert (pregunta web (read)))
	(retract ?dir)
)

;;;
;;; Ya le hice las preguntas principales
;;;
(defrule para_preguntar

(declare (salience 1000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	?dir <- (preguntar)
=>
	(assert (descartar))
	(retract ?dir)
)

;;;
;;; Razono con el conocimiento que tengo, descarto una rama si no le gusta
;;; uno de los campos imprescindibles que trata
;;;
(defrule descartar_rama

(declare (salience 9000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Imprescindible ?x ?rama)
	(EstudianteGusta (materia ?x) (cantidad no))
	(not (Interes ?rama))
	(not (InteresParcial ?rama))
	?dir <- (Recomendable ?rama)
=>
	(retract ?dir)
	(assert (Descartada ?rama))
)


;;;
;;; Veo las ramas en las que muestra interés en sus campos principales
;;;
(defrule interesa_rama

(declare (salience 8999))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Recomendable ?rama)
	(not (Interes ?rama))
	(not (InteresParcial ?rama))
	(not (Descartada ?rama)) ;; Esto es innecesario pues recomendable y descartada son excluyentes
	(Imprescindible ?x ?rama)
	(EstudianteGusta (materia ?x) (cantidad si))
=>
	(assert (Interes ?rama))
)

;;;
;;; SI la persona encuentra parte de los campos de la rama (los principales) interesantes pero
;;; alguno secundario no entonces le interesa parcialmente la rama
(defrule interesa_rama_parcial

(declare (salience 8998))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Recomendable ?rama)
	(not (InteresParcial ?rama))
	(not (Descartada ?rama)) ;; Esto es innecesario pues recomendable y descartada son excluyentes
	(Imprescindible ?x ?rama)
	(EstudianteGusta (materia ?x) (cantidad si))
	(Imprescindible ?y ?rama)
	(or
		(EstudianteGusta (materia ?y) (cantidad nose))
		(EstudianteGusta (materia ?y) (cantidad no))
	)
=>
	(assert (InteresParcial ?rama))
)

;;; Si una rama ha sido descartada obviamente no tiene interés en dicha rama
(defrule rama_descartada1

(declare (salience 9999))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Descartada ?rama)
	?dir <- (Interes ?rama)
=>
	(retract ?dir)
)

;;; Igualmente con interés parcial
(defrule rama_descartada2

(declare (salience 9999))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Descartada ?rama)
	?dir <- (InteresParcial ?rama)
=>
	(retract ?dir)
)


;;; Si el alumno tiene interés parcial en una rama obviamente no tiene interés completo
(defrule rama_interes_parcial

(declare (salience 9998))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(InteresParcial ?rama)
	?dir <- (Interes ?rama)
=>
	(retract ?dir)
)


;;; Si el alumno muestra mayor interés en un rama que en otra descarto la otra
;;; Obviamente debo esperar a que acabar de preguntar para saberlo por completo
(defrule prefiere_rama

(declare (salience 9000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(descartar)
	(Interes ?rama)
	?dir <- (Recomendable ?rama2)
	(not (Interes ?rama2))
=>
	(assert (Descartada ?rama2))
	(retract ?dir)
)

(defrule prefiere_rama2

(declare (salience 9000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(descartar)
	(InteresParcial ?rama)
	?dir <- (Recomendable ?rama2)
	(not (Interes ?rama2))
	(not (InteresParcial ?rama2))
=>
	(assert (Descartada ?rama2))
	(retract ?dir)
)

;;;
;;; Ahora toca razonar. Buscaré cosas que puedan hacer que se decida por una rama u otra.
;;; pensaré en cosas que hacen que pueda preferir una rama a otra sabiendo que ya mostró
;;; el mismo interés en lo que se imparte en ambas
;;;

(defrule empieza_razonar

(declare (salience 1))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	?dir <-(descartar)
=>
	(retract ?dir)
	(assert (razonar))
)

;;; Si todas fueron descartadas entonces el alumno no muestra interés
;;; por ninguna rama y le recomiendo la que considero más sencilla
;;; para acabar la carrera
(defrule recomendar_rama_no_interes

(declare (salience 9999))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	?dir <- (razonar)
	(not (Recomendable ?rama))
=>
	(retract ?dir)
	(assert (aconsejar))
	(assert (Consejo Ingenieria_del_Software "
Honestamente no muestras nigún interés en lo que se imparte en ninguna rama así que lo que yo te recomiendo es meterte en esta rama porque es la más sencilla ya que se pueden aprobar la mayoría de las asignaturas de esta rama sin realizar exámenes." ))
)

;;; Si tengo ramas empatadas intento preguntar algo que me haga decidirme por una de
;;; las dos (o más). Busco carácterísticas que distingan las ramas que quedan.

;; El orden en que pienso que es más relevante es la carga teoríca > carga práctica > cantidad de exámenes.

;; Si la carga teoríca puede hacer que se decida le pregunto

(defrule desempate_carga_teorica

(declare (salience 5000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(razonar)
	(Recomendable ?rama)
	(Recomendable ?rama2)
	(test (neq ?rama ?rama2))
	(cargateorica ?c1 ?rama)
	(cargateorica ?c2 ?rama2)
	(test (neq ?c1 ?c2))
	(not (preguntacargateorica))
=>
	(assert (preguntacargateorica))
)

(defrule pregunta_carga_teorica

(declare (salience 6000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(preguntacargateorica)
=>
	(printout t "¿Prefieres las asignaturas con mucha o poca teoría?(mucho | poco | nose)" crlf)
	(assert (cargateorica (read) usuario))
)

(defrule repetir_pregunta_carga_teorica

(declare (salience 9999))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	?dir <- (cargateorica ?x usuario)
	?dir2 <- (preguntacargateorica)
	(and
		(test (neq ?x mucho))
		(test (neq ?x poco))
		(test (neq ?x nose))
	)
=>
	(retract ?dir)
	(retract ?dir2)
	(assert (preguntacargateorica))
)


;; Igual con la carga práctica

(defrule desempate_carga_practica

(declare (salience 4999))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(razonar)
	(Recomendable ?rama)
	(Recomendable ?rama2)
	(test (neq ?rama ?rama2))
	(cargapractica ?c1 ?rama)
	(cargapractica ?c2 ?rama2)
	(test (neq ?c1 ?c2))
	(not (preguntacargapractica))
=>
	(assert (preguntacargapractica))
)


(defrule pregunta_carga_practica

(declare (salience 6000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(preguntacargapractica)
=>
	(printout t "¿Cuántas prácticas prefieres?(mucho | poco | nose)" crlf)
	(assert (cargapractica (read) usuario))
)

(defrule repetir_pregunta_carga_practica

(declare (salience 9999))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	?dir <- (cargapractica ?x usuario)
	?dir2 <- (preguntacargapractica)
	(and
		(test (neq ?x mucho))
		(test (neq ?x poco))
		(test (neq ?x nose))
	)
=>
	(retract ?dir)
	(retract ?dir2)
	(assert (preguntacargapractica))
)


;; Igual con la cantidad de examenes
(defrule desempate_cantidad_examenes

(declare (salience 4998))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(razonar)
	(Recomendable ?rama)
	(Recomendable ?rama2)
	(test (neq ?rama ?rama2))
	(cantidadexamenes ?c1 ?rama)
	(cantidadexamenes ?c2 ?rama2)
	(test (neq ?c1 ?c2))
	(not (preguntacantidadexamenes))
=>
	(assert (preguntacantidadexamenes))
)


(defrule pregunta_cantidad_examenes

(declare (salience 6000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(preguntacantidadexamenes)
=>
	(printout t "¿Te gusta que las asignaturas tengan muchos exámenes?(mucho | poco | nose)" crlf)
	(assert (cantidadexamenes (read) usuario))
)


(defrule repetir_pregunta_cantidad_examenes

(declare (salience 9999))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	?dir <- (cantidadexamenes ?x usuario)
	?dir2 <- (preguntacantidadexamenes)
	(and
		(test (neq ?x mucho))
		(test (neq ?x poco))
		(test (neq ?x nose))
	)
=>
	(retract ?dir)
	(retract ?dir2)
	(assert (preguntacantidadexamenes))
)


;;; Aquí si tenía dos asignaturas empatadas las desempato según el criterio
;;; de desmpate que proceda
(defrule descartar_desempate_cantidad_examenes

(declare (salience 9000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Recomendable ?rama1)
	?dir <- (Recomendable ?rama2)
	(cantidadexamenes ?u usuario)
	(cantidadexamenes ?r1 ?rama1)
	(cantidadexamenes ?r2 ?rama2)
	(test (neq ?r1 ?r2))
	(test (eq ?r1 ?u))
=>
	(assert (explicar desempate))
	(assert (Descartada ?rama2))
	(retract ?dir)
)


(defrule descartar_desempate_carga_practica

(declare (salience 9000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Recomendable ?rama1)
	?dir <- (Recomendable ?rama2)
	(cargapractica ?u usuario)
	(cargapractica ?r1 ?rama1)
	(cargapractica ?r2 ?rama2)
	(test (neq ?r1 ?r2))
	(test (eq ?r1 ?u))
=>
	(assert (explicar desempate))
	(assert (Descartada ?rama2))
	(retract ?dir)
)


(defrule descartar_desempate_carga_teorica

(declare (salience 9000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(Recomendable ?rama1)
	?dir <- (Recomendable ?rama2)
	(cargateorica ?u usuario)
	(cargateorica ?r1 ?rama1)
	(cargateorica ?r2 ?rama2)
	(test (neq ?r1 ?r2))
	(test (eq ?r1 ?u))
=>
	(assert (explicar desempate))
	(assert (Descartada ?rama2))
	(retract ?dir)
)

;;; Antes de finalizar el razonamiento debo elegir cuál rama recomendar
;;; para ello entra mi preferencia personal que es como a mi más me
;;; gusta. Esto sólo es relevante sino está claro cuál prefiere.
(defrule desmepate_preferencia_personal

(declare (salience 1000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(razonar)
	(Recomendable ?rama1)
	?dir <- (Recomendable ?rama2)
	(Orden ?o1 ?rama1)
	(Orden ?o2 ?rama2)
	(test (< ?o1 ?o2))
=>
	(assert (explicar personal)) ;; Para saber que luego debo explicar esto.
	(assert (es_peor ?rama2))
	(retract ?dir)
	(assert (Descartada ?rama2))
)

;;; Ahora finalmente paso a aconsejar la rama que elegí
(defrule aconsejar
    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))

	?dir <- (razonar)
=>
	(retract ?dir)
	(assert (aconsejar))
)

;;; Elijo la rama finalmente y ahora construyo la explicación con el conocimiento que tengo.
;;; Uso conocimiento sobre si es necesario explicarlo (es decir lo he usado)
;;; tambié hago uso de conocimiento sobre si ya lo expliqué
(defrule rama_a_aconsejar

(declare (salience 9000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(aconsejar)
	(not (Consejo ?))
	(Recomendable ?rama)
=>
	(assert (Consejo ?rama))
)

;;; Reconstruyo el por qué se eligió esta rama
(defrule reconstruir_interesado1

(declare (salience 8010))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(aconsejar)
	(not (explicado Interes))
	?dir <- (Consejo ?rama)
	(Interes ?rama)
=>
	(assert (explicado Interes))
	(retract ?dir)
	(assert (Consejo ?rama "
Has mostrado interés en todos los campos principales que se imparten en la rama, siendo estos: "))
)

(defrule reconstruir_interesado2

(declare (salience 8010))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(aconsejar)
	?dir <- (Consejo ?rama ?textant)
	(Interes ?rama)
	(Imprescindible ?x ?rama)
	(not (explicado ?x))
	(Texto ?x ?text)
=>
	(assert (explicado ?x))
	(retract ?dir)
	(assert (Consejo ?rama (str-cat ?textant "
	" ?text) ))
)

(defrule recontruir_interesado_parcial1

(declare (salience 8009))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(aconsejar)
	(not (explicado InteresParcial))
	?dir <- (Consejo ?rama)
	(InteresParcial ?rama)
=>
	(assert (explicado InteresParcial))
	(retract ?dir)
	(assert (Consejo ?rama "
Has mostrado interés en algunos de los campos principales que se imparten en la rama, siendo estos: "))
)


(defrule reconstruir_interesado_parcial2

(declare (salience 8009))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(aconsejar)
	?dir <- (Consejo ?rama ?textant)
	(InteresParcial ?rama)
	(Imprescindible ?x ?rama)
	(EstudianteGusta (materia ?x) (cantidad si))
	(not (explicado ?x))
	(Texto ?x ?text)
=>
	(assert (explicado ?x))
	(retract ?dir)
	(assert (Consejo ?rama (str-cat ?textant "
	" ?text) ))
)


;;; Ahora si las hay, pongo las razones secundarias si las hay
(defrule empezar_razon_secundaria_si_vacio

(declare (salience 8008))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(aconsejar)
	?dir <- (Consejo ?rama)
	(not (explicado RazonSecundariaVacio))
	?dir2 <- (explicar desempate)
=>
	(assert (explicado RazonSecundariaVacio))
	(assert (Consejo ?rama "
Aunque no hayas mostrado especial interés en ningún campo de los que te he preguntado te puede gustar la rama ya que:
"))
	(retract ?dir)
	(retract ?dir2)
)


(defrule recontruir_razon_secundaria_no_vacio

(declare (salience 8008))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(aconsejar)
	(not (explicado RazonSecundaria))
	(not (explicado RazonSecundariaVacio))
	?dir <- (Consejo ?rama ?textant)
	?dir2 <- (explicar desempate)
=>
	(assert (explicado RazonSecundaria))
	(retract ?dir)
	(retract ?dir2)
	(assert (Consejo ?rama (str-cat ?textant "
Además la rama se ajusta a tus gustos ya que:
")))
)


(defrule reconstruir_razon_secundaria_carga_teorica

(declare (salience 8007))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(aconsejar)
	(not (explicado cargateorica))
	?dir <- (Consejo ?rama ?textant)
	(cargateorica ?ct usuario)
	(cargateorica ?ctrama ?rama)
	(test (eq ?ctrama ?ct))
=>
	(assert (explicado cargateorica))
	(retract ?dir)
	(assert (Consejo ?rama (str-cat ?textant "	Esta rama tiene " ?ct " carga teórica que es como tu prefieres.
")))
)

(defrule reconstruir_razon_secundaria_carga_practica

(declare (salience 8007))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(aconsejar)
	(not (explicado cargapractica))
	?dir <- (Consejo ?rama ?textant)
	(cargapractica ?ct usuario)
	(cargapractica ?ctrama ?rama)
	(test (eq ?ctrama ?ct))
=>
	(assert (explicado cargapractica))
	(retract ?dir)
	(assert (Consejo ?rama (str-cat ?textant "	Esta rama tiene " ?ct " carga práctica que es como tu prefieres.
")))
)


(defrule reconstruir_razon_secundaria_cantidad_examenes

(declare (salience 8007))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(aconsejar)
	(not (explicado cantidadexamenes))
	?dir <- (Consejo ?rama ?textant)
	(cantidadexamenes ?ct usuario)
	(cantidadexamenes ?ctrama ?rama)
	(test (eq ?ctrama ?ct))
=>
	(assert (explicado cantidadexamenes))
	(retract ?dir)
	(assert (Consejo ?rama (str-cat ?textant "	Las asignaturas de esta rama tienen " ?ct " número de exámenes que es como tu prefieres.
")))
)


(defrule reconstruir_preferencia_personal_vacio

(declare (salience 8006))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(aconsejar)
	(not (explicado personal))
	?dir2 <- (explicar personal)
	?dir <- (Consejo ?rama)
	=>
	(assert (explicado personal))
	(assert (explicado personalVacio))
	(retract ?dir)
	(retract ?dir2)
	(assert (Consejo ?rama "
La verdad es que no me has dado ninguna información con la que trabajar así que simplemente te recomiendo la que más
interesante me parece a mi que sería la rama de CSI."))
)


(defrule reconstruir_preferencia_personal

(declare (salience 8006))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(aconsejar)
	(not (explicado personal))
	?dir2 <- (explicar personal)
	?dir <- (Consejo ?rama ?textant)
	=>
	(assert (explicado personal))
	(retract ?dir)
	(retract ?dir2)
	(assert (Consejo ?rama (str-cat ?textant "
Finalmente me he decidido por la que más interesante me parece a mí. Estas otras ramas también te podrían interesar:
")))
)

(defrule reconstruir_otras_ramas

(declare (salience 8000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))
	(aconsejar)
	(not (explicado personalVacio))
	?dir2 <- (es_peor ?r2)
	?dir <- (Consejo ?rama ?textant)
	(Texto ?r2 ?tr2)
=>
	(retract ?dir2)
	(retract ?dir)
	(assert (Consejo ?rama (str-cat ?textant "
	" ?tr2)))
)



;;; La imprimo
(defrule dar_consejo

(declare (salience -9000))

    ; Comprobamos que estamos en el modulo de carlos
    (ModuloConversacion (modulo carlos))

	(aconsejar)
	(Consejo ?rama ?text)
	(Texto ?rama ?ramatexto)
=>
	(printout t "#########################################
#########################################
#########################################" crlf crlf)
	(printout t "Te aconsejo la rama " ?ramatexto crlf)
	(printout t "Las razones son las siguientes:
" ?text crlf)

    ; Antes de pasar al siguiente modulo, tengo que limpiar los consejos que he usado, para que el
    ; que viene despues no los vuelva a mostrar, o que esto de problemas de la logica del modulo
    (assert (QuieroLimpiarYSiguiente si))
)

; Antes de pasar al siguiente modulo, limpiamos los hechos que pueden interferir en el correcto
; funcionamiento del siguiente modulo
; Estos son: los consejos que se quedan sin borrar del sistema (el siguiente modulo puede razonar
; erroneamente en base a ellos, los puede mostrar al dar el resultado al usuario...)
(defrule limpiar_antes_de_siguiente
    ; Estamos en modo de limpieza
    (QuieroLimpiarYSiguiente si)

    ; Queda un consejo sin limpiar
    ?consejo <- (Consejo ?rama ?texto)

    =>

    ; Borramos dicho consejo que quedo sin limpiar
    (retract ?consejo)
)

; Cuando hayamos terminado de limpiar, ya podemos pasar al siguiente modulo
(defrule ya_limpiado_siguiente

    ; Nos encontramos en modo de limpieza
    (QuieroLimpiarYSiguiente si)

    ; No quedan consejos que limpiar
    (not (Consejo ?rama ?texto))

    =>

    ; Ya es seguro pasar al siguiente modulo
	(assert (QuieroSiguienteModulo si))
)

(defrule print1
(declare (salience -9000))
(ModuloConversacion (modulo carlos))
(EstudianteGusta (materia ?x) (cantidad ?y))
=>
(printout t "EstudianteGusta materia " ?x " cantidad " ?y crlf)
)
