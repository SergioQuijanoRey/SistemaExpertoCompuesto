;;;
;;;  				CARLOS LARA CASANOVA
;;; 				UGR-INGENIERÍA DEL CONOCIMIENTO
;;; 				2021-2022
;;; 				SISTEMA EXPERTO SENCILLO 
;;;

;;; Voy a utilizar las siguiente propiedades:

;; EL sistema usará las opininiones del alumno sobre distintos campos de la informática
;; para guardar dicha opinión utilizaré la tupla (Opinion tema si | no | nose)
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
;; Dónde valor puede ser Mucho | Poco ó Mucha | Poca dependiendo de la 
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
;;; le interesa la IA. 
(deffacts Imprescindibles
	(Imprescindible Ciencias_Computación Computacion_y_Sistemas_Inteligentes)
	(Imprescindible IA Computacion_y_Sistemas_Inteligentes)
	(Imprescindible Programacion Ingenieria_del_Software)
	(Imprescindible Proyectos Ingenieria_del_Software)
	(Imprescindible Hardware Ingenieria_de_Computadores)
	(Imprescindible Bases_de_Datos Sistemas_de_Informacion)
	(Imprescindible Ciencia_de_Datos Sistemas_de_Informacion)
	(Imprescindible Seguridad Tecnologias_de_la_Informacion)
	(Imprescindible Web Tecnologias_de_la_Informacion)
)

;;;
;;; Aqui guardo otro conocimiento relativo a las ramas que 
;;; tiene que ver con cómo se imparten en general y no con 
;;; lo que se da en ellas
;;;
(deffacts Caracteristicas
	(CantidadExamenes Mucho Computacion_y_Sistemas_Inteligentes)
	(CantidadExamenes Mucho Sistemas_de_Informacion)
	(CantidadExamenes Mucho Tecnologias_de_la_Informacion)
	(CantidadExamenes Mucho Ingenieria_de_Computadores)
	(CantidadExamenes Poco Ingenieria_del_Software)
	(CargaPractica Mucha Computacion_y_Sistemas_Inteligentes)
	(CargaPractica Poca Sistemas_de_Informacion)
	(CargaPractica Poca Tecnologias_de_la_Informacion)
	(CargaPractica Mucha Ingenieria_de_Computadores)
	(CargaPractica Mucha Ingenieria_del_Software)
	(CargaTeorica Mucha Computacion_y_Sistemas_Inteligentes)
	(CargaTeorica Mucha Sistemas_de_Informacion)
	(CargaTeorica Poca Tecnologias_de_la_Informacion)
	(CargaTeorica Poca Ingenieria_de_Computadores)
	(CargaTeorica Poca Ingenieria_del_Software)
)

;;; Muchos conceptos clave en texto
(deffacts Texto
	(Texto CargaPractica "carga práctica")
	(Texto CargaTeorica "carga teorica")
	(Texto CantidadExamenes "cantidad de exámenes")
	(Texto Computacion_y_Sistemas_Inteligentes "Computación y Sistemas Inteligentes")
	(Texto Sistemas_de_Informacion "Sistemas de Información")
	(Texto Tecnologias_de_la_Informacion "Tecnologias de la Información")
	(Texto Ingenieria_de_Computadores "Ingeniería de Computadores")
	(Texto Ingenieria_del_Software "Ingeniería del Software")
	(Texto Ciencias_Computación "Ciencia de la computación")
	(Texto IA "Inteliencia Artificial")
	(Texto Web "Programación Web")
	(Texto Seguridad "Seguridad informática")
	(Texto Ciencia_de_Datos "Ciencia de datos")
	(Texto Bases_de_Datos "Bases de datos")
	(Texto Hardware "Hardware")
	(Texto Proyectos "Gestión de proyectos")
	(Texto Programacion "Programación")
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
	(Rama ?x)
=>
	(assert (Recomendable ?x))
)


;;; Si una pregunta no tiene una respuesta válida debo de volver a preguntarla
(defrule respuesta_invalida
(declare (salience 9999))
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
	?dir <- (pregunta ?x ?y)
=>
	(assert (Opinion ?x ?y))
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
	(Recomendable Computacion_y_Sistemas_Inteligentes)
	(not (Opinion Ciencias_Computación ?))
	?dir <- (preguntar)
=>
	(printout t "¿Te interesa la teoría de la computación? (si | no | nose)" crlf)
	(assert (pregunta Ciencias_Computación (read)))
	(retract ?dir)
)

(defrule pregunta1
(declare (salience 5000))
	(Recomendable Computacion_y_Sistemas_Inteligentes)
	(not (Opinion IA ?))
	?dir <- (preguntar)
=>
	(printout t "¿Te interesan las distintas técnicas de Inteligencia Artificial? (si | no | nose)" crlf)
	(assert (pregunta IA (read)))
	(retract ?dir)
)

(defrule pregunta4
(declare (salience 4997))
	(Recomendable Ingenieria_del_Software)
	(not (Opinion Programacion ?))
	?dir <- (preguntar)
=>
	(printout t "¿Quieres mejorar tu habilidades de programación? (si | no | nose)" crlf)
	(assert (pregunta Programacion (read)))
	(retract ?dir)
)

(defrule pregunta3
(declare (salience 4998))
	(Recomendable Ingenieria_del_Software)
	(not (Opinion Proyectos ?))
	?dir <- (preguntar)
=>
	(printout t "¿Y te interesaría trabajar gestionando proyectos en empresas? (si | no | nose)" crlf)
	(assert (pregunta Proyectos (read)))
	(retract ?dir)
)

(defrule pregunta5
(declare (salience 4996))
	(Recomendable Ingenieria_de_Computadores)
	(not (Opinion Hardware ?))
	?dir <- (preguntar)
=>
	(printout t "¿Te han gustado las asignaturas que has dado relacionadas con el hardware? (si | no | nose)" crlf)
	(assert (pregunta Hardware (read)))
	(retract ?dir)
)

(defrule pregunta7
(declare (salience 4994))
	(Recomendable Sistemas_de_Informacion)
	(not (Opinion Bases_de_Datos ?))
	?dir <- (preguntar)
=>
	(printout t "¿Te insteresa como se almacena de la información y las bases de datos? (si | no | nose)" crlf)
	(assert (pregunta Bases_de_Datos (read)))
	(retract ?dir)
)

(defrule pregunta6
(declare (salience 4995))
	(Recomendable Sistemas_de_Informacion)
	(not (Opinion Ciencia_de_Datos ?))
	?dir <- (preguntar)
=>
	(printout t "¿Y que me dices del tema de la ciencia de datos, te gusta? (si | no | nose)" crlf)
	(assert (pregunta Ciencia_de_Datos (read)))
	(retract ?dir)
)

(defrule pregunta9
(declare (salience 4992))
	(Recomendable Tecnologias_de_la_Informacion)
	(not (Opinion Seguridad ?))
	?dir <- (preguntar)
=>
	(printout t "¿Te interesa el tema de la seguridad informática? (si | no | nose)" crlf)
	(assert (pregunta Seguridad (read)))
	(retract ?dir)
)

(defrule pregunta8
(declare (salience 4993))
	(Recomendable Tecnologias_de_la_Informacion)
	(not (Opinion Web ?))
	?dir <- (preguntar)
=>
	(printout t "¿Quieres aprender programación web? (si | no | nose)" crlf)
	(assert (pregunta Web (read)))
	(retract ?dir)
)

;;;
;;; Ya le hice las preguntas principales
;;;
(defrule para_preguntar
(declare (salience 1000))
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
	(Imprescindible ?x ?rama)
	(Opinion ?x no)
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
	(Recomendable ?rama)
	(not (Interes ?rama))
	(not (InteresParcial ?rama))
	(not (Descartada ?rama)) ;; Esto es innecesario pues recomendable y descartada son excluyentes
	(Imprescindible ?x ?rama)
	(Opinion ?x si)
=>
	(assert (Interes ?rama))
)

;;;
;;; SI la persona encuentra parte de los campos de la rama (los principales) interesantes pero
;;; alguno secundario no entonces le interesa parcialmente la rama
(defrule interesa_rama_parcial
(declare (salience 8998))
	(Recomendable ?rama)
	(not (InteresParcial ?rama))
	(not (Descartada ?rama)) ;; Esto es innecesario pues recomendable y descartada son excluyentes
	(Imprescindible ?x ?rama)
	(Opinion ?x si)
	(Imprescindible ?y ?rama)
	(or
		(Opinion ?y nose)
		(Opinion ?y no)
	)
=>
	(assert (InteresParcial ?rama))
)

;;; Si una rama ha sido descartada obviamente no tiene interés en dicha rama 
(defrule rama_descartada1
(declare (salience 9999))
	(Descartada ?rama)
	?dir <- (Interes ?rama)
=>
	(retract ?dir)
)

;;; Igualmente con interés parcial
(defrule rama_descartada2
(declare (salience 9999))
	(Descartada ?rama)
	?dir <- (InteresParcial ?rama)
=>
	(retract ?dir)
)


;;; Si el alumno tiene interés parcial en una rama obviamente no tiene interés completo
(defrule rama_interes_parcial
(declare (salience 9998))
	(InteresParcial ?rama)
	?dir <- (Interes ?rama)
=>
	(retract ?dir)
)


;;; Si el alumno muestra mayor interés en un rama que en otra descarto la otra
;;; Obviamente debo esperar a que acabar de preguntar para saberlo por completo
(defrule prefiere_rama
(declare (salience 9000))
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
	(razonar)
	(Recomendable ?rama)
	(Recomendable ?rama2)
	(test (neq ?rama ?rama2))
	(CargaTeorica ?c1 ?rama)
	(CargaTeorica ?c2 ?rama2)
	(test (neq ?c1 ?c2))
	(not (preguntaCargaTeorica))
=>
	(assert (preguntaCargaTeorica))
)

(defrule pregunta_carga_teorica
(declare (salience 6000))
	(preguntaCargaTeorica)
=>
	(printout t "¿Prefieres las asignaturas con mucha o poca teoría?(Mucha | Poca | nose)" crlf)
	(assert (CargaTeorica (read) usuario))
)

(defrule repetir_pregunta_carga_teorica
(declare (salience 9999))
	?dir <- (CargaTeorica ?x usuario)
	?dir2 <- (preguntaCargaTeorica)
	(and
		(test (neq ?x Mucha))
		(test (neq ?x Poca))
		(test (neq ?x nose))
	)
=>
	(retract ?dir)
	(retract ?dir2)
	(assert (preguntaCargaTeorica))
)


;; Igual con la carga práctica

(defrule desempate_carga_practica
(declare (salience 4999))
	(razonar)
	(Recomendable ?rama)
	(Recomendable ?rama2)
	(test (neq ?rama ?rama2))
	(CargaPractica ?c1 ?rama)
	(CargaPractica ?c2 ?rama2)
	(test (neq ?c1 ?c2))
	(not (preguntaCargaPractica))
=>
	(assert (preguntaCargaPractica))
)


(defrule pregunta_carga_practica
(declare (salience 6000))
	(preguntaCargaPractica)
=>
	(printout t "¿Cuántas prácticas prefieres?(Mucha | Poca | nose)" crlf)
	(assert (CargaPractica (read) usuario))
)

(defrule repetir_pregunta_carga_practica
(declare (salience 9999))
	?dir <- (CargaPractica ?x usuario)
	?dir2 <- (preguntaCargaPractica)
	(and
		(test (neq ?x Mucha))
		(test (neq ?x Poca))
		(test (neq ?x nose))
	)
=>
	(retract ?dir)
	(retract ?dir2)
	(assert (preguntaCargaPractica))
)


;; Igual con la cantidad de examenes
(defrule desempate_cantidad_examenes
(declare (salience 4998))
	(razonar)
	(Recomendable ?rama)
	(Recomendable ?rama2)
	(test (neq ?rama ?rama2))
	(CantidadExamenes ?c1 ?rama)
	(CantidadExamenes ?c2 ?rama2)
	(test (neq ?c1 ?c2))
	(not (preguntaCantidadExamenes))
=>
	(assert (preguntaCantidadExamenes))
)


(defrule pregunta_cantidad_examenes
(declare (salience 6000))
	(preguntaCantidadExamenes)
=>
	(printout t "¿Te gusta que las asignaturas tengan muchos exámenes?(Mucho | Poco | nose)" crlf)
	(assert (CantidadExamenes (read) usuario))
)


(defrule repetir_pregunta_cantidad_examenes
(declare (salience 9999))
	?dir <- (CantidadExamenes ?x usuario)
	?dir2 <- (preguntaCantidadExamenes)
	(and
		(test (neq ?x Mucho))
		(test (neq ?x Poco))
		(test (neq ?x nose))
	)
=>
	(retract ?dir)
	(retract ?dir2)
	(assert (preguntaCantidadExamenes))
)


;;; Aquí si tenía dos asignaturas empatadas las desempato según el criterio
;;; de desmpate que proceda
(defrule descartar_desempate_cantidad_examenes
(declare (salience 9000))
	(Recomendable ?rama1)
	?dir <- (Recomendable ?rama2)
	(CantidadExamenes ?u usuario)
	(CantidadExamenes ?r1 ?rama1)
	(CantidadExamenes ?r2 ?rama2)
	(test (neq ?r1 ?r2))
	(test (eq ?r1 ?u))
=>
	(assert (explicar desempate))
	(assert (Descartada ?rama2))
	(retract ?dir)
)


(defrule descartar_desempate_carga_practica
(declare (salience 9000))
	(Recomendable ?rama1)
	?dir <- (Recomendable ?rama2)
	(CargaPractica ?u usuario)
	(CargaPractica ?r1 ?rama1)
	(CargaPractica ?r2 ?rama2)
	(test (neq ?r1 ?r2))
	(test (eq ?r1 ?u))
=>
	(assert (explicar desempate))
	(assert (Descartada ?rama2))
	(retract ?dir)
)


(defrule descartar_desempate_carga_teorica
(declare (salience 9000))
	(Recomendable ?rama1)
	?dir <- (Recomendable ?rama2)
	(CargaTeorica ?u usuario)
	(CargaTeorica ?r1 ?rama1)
	(CargaTeorica ?r2 ?rama2)
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
	(aconsejar)
	(not (Consejo ?))
	(Recomendable ?rama)
=>
	(assert (Consejo ?rama))
)

;;; Reconstruyo el por qué se eligió esta rama
(defrule reconstruir_interesado1
(declare (salience 8010))
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
	(aconsejar)
	?dir <- (Consejo ?rama ?textant)
	(InteresParcial ?rama)
	(Imprescindible ?x ?rama)
	(Opinion ?x si)
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
	(aconsejar)
	(not (explicado CargaTeorica))
	?dir <- (Consejo ?rama ?textant)
	(CargaTeorica ?ct usuario)
	(CargaTeorica ?ctrama ?rama)
	(test (eq ?ctrama ?ct))
=>
	(assert (explicado CargaTeorica))
	(retract ?dir)
	(assert (Consejo ?rama (str-cat ?textant "	Esta rama tiene " ?ct " carga teórica que es como tu prefieres.
")))
)

(defrule reconstruir_razon_secundaria_carga_practica
(declare (salience 8007))
	(aconsejar)
	(not (explicado CargaPractica))
	?dir <- (Consejo ?rama ?textant)
	(CargaPractica ?ct usuario)
	(CargaPractica ?ctrama ?rama)
	(test (eq ?ctrama ?ct))
=>
	(assert (explicado CargaPractica))
	(retract ?dir)
	(assert (Consejo ?rama (str-cat ?textant "	Esta rama tiene " ?ct " carga práctica que es como tu prefieres.
")))
)


(defrule reconstruir_razon_secundaria_cantidad_examenes
(declare (salience 8007))
	(aconsejar)
	(not (explicado CantidadExamenes))
	?dir <- (Consejo ?rama ?textant)
	(CantidadExamenes ?ct usuario)
	(CantidadExamenes ?ctrama ?rama)
	(test (eq ?ctrama ?ct))
=>
	(assert (explicado CantidadExamenes))
	(retract ?dir)
	(assert (Consejo ?rama (str-cat ?textant "	Las asignaturas de esta rama tienen " ?ct " número de exámenes que es como tu prefieres.
")))
)


(defrule reconstruir_preferencia_personal_vacio
(declare (salience 8006))
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
)
