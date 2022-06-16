;;;
(deffacts Ramas
	(Rama Computacion_y_Sistemas_Inteligentes)
	(Rama Ingenieria_del_Software)
	(Rama Ingenieria_de_Computadores)
	(Rama Sistemas_de_Informacion)
	(Rama Tecnologias_de_la_Informacion)
)

(deffacts Atributos
   (atributo web Ingenieria_del_Software)
   (atributo web Tecnologias_de_la_Informacion)
   (atributo programacion Computacion_y_Sistemas_Inteligentes)
   (atributo programacion Ingenieria_del_Software)
   (atributo administracionsistemas Ingenieria_de_Computadores)
   (atributo administracionsistemas Sistemas_de_Informacion)
   (atributo red Tecnologias_de_la_Informacion)
   (atributo matematicas Computacion_y_Sistemas_Inteligentes)
   (atributo docencia Computacion_y_Sistemas_Inteligentes)
   (atributo docencia Sistemas_de_Informacion)
   (atributo robotica Computacion_y_Sistemas_Inteligentes)
   (atributo robotica Ingenieria_de_Computadores)
   (atributo basesdatos Sistemas_de_Informacion)
   (atributo hardware Ingenieria_de_Computadores)
   (atributo videojuegos Ingenieria_del_Software)
)

(deffacts Razones
   (razon web "te gustaria estudiar programacion web o diseño web")
   (razon programacion "eres un fiera programando")
   (razon administracionsistemas "vas a ser un gran administrador de sistemas")
   (razon red "vas a ser mejor en redes que spiderman")
   (razon matematicas "te llaman el matemago")
   (razon docencia "se te ve cara de profesor")
   (razon robotica "vas a dominar el mundo con tus robots")
   (razon basesdatos "te llaman la atencion las bases de datos")
   (razon hardware "por alguna razon te gusta el hardware")
   (razon videojuegos "quiero jugar tus videojuegos")
   (razon porDefecto ", bueno, realmente no tengo razones para recomendartela jeje")
)

(deffacts Consejos
   (consejo Computacion_y_Sistemas_Inteligentes "")
   (consejo Ingenieria_del_Software "")
   (consejo Ingenieria_de_Computadores "")
   (consejo Sistemas_de_Informacion "")
   (consejo Tecnologias_de_la_Informacion "")
)

(deffacts ModuloIni
   (modulointerno inicio)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule RazonPorDefecto


    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   (modulointerno inicio)
   (Rama ?r)
   (not (explicacion ?r porDefecto))
   =>
   (assert (explicacion ?r porDefecto))
)

(defrule Comenzar_preguntas


   (declare (salience 1))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))

   ?f <- (modulointerno inicio)
   =>
   (retract ?f)
   (assert (modulointerno preguntas))
)

;;;;;;; Preguntas

(defrule PreguntaWeb


    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   (modulointerno preguntas)
   =>
   (printout t "¿Te gustaria estudiar programacion web o otros temas de web? (si/no)" crlf)
   (assert (gusta web (read)))
)

(defrule PreguntaProgramar


   (declare (salience 1))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   (modulointerno preguntas)
   =>
   (printout t "¿Se te da bien picar codigo todo el dia? (si/no)" crlf)
   (assert (EstudianteGusta (materia programacion) (cantidad read)) )
)

(defrule PreguntaAdSi


   (declare (salience 1))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   (modulointerno preguntas)
   =>
   (printout t "¿Te llama la atencion la administracion de sistemas? (si/no)" crlf)
   (assert (EstudianteGusta (materia administracionsistemas) (cantidad read)) )
)

(defrule PreguntaRed


   (declare (salience 1))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   (modulointerno preguntas)
   =>
   (printout t "¿Te interesa conocer los entresijos de las redes e internet? (si/no)" crlf)
   (assert (EstudianteGusta (materia red) (cantidad read)) )
)

(defrule PreguntaMates


   (declare (salience 1))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   (modulointerno preguntas)
   =>
   (printout t "¿Eres amigo de las formulas matematicas o al menos las entiendes? (si/no)" crlf)
   (assert (EstudianteGusta (materia matematicas) (cantidad read)) )
)

(defrule PreguntaDocencia


   (declare (salience 1))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   (modulointerno preguntas)
   =>
   (printout t "¿Te ves dando clase en un futuro? (si/no)" crlf)
   (assert (EstudianteGusta (materia docencia) (cantidad read)))
)

(defrule PreguntaRobotica


   (declare (salience 1))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   (modulointerno preguntas)
   =>
   (printout t "¿Te interesan los robots (y no solo para dominar el mundo)? (si/no)" crlf)
   (assert (EstudianteGusta (materia robotica) (cantidad read)))
)

(defrule PreguntaBD


   (declare (salience 1))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   (modulointerno preguntas)
   =>
   (printout t "¿Que tal te fue con las sentencias de SQL, te gusto Base de Datos? (si/no)" crlf)
   (assert (EstudianteGusta (materia basesdatos) (cantidad read)) )
)

(defrule PreguntaHardware


   (declare (salience 1))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   (modulointerno preguntas)
   =>
   (printout t "¿Ey, no seras de los que le gusta mas el hardware? (si/no)" crlf)
   (assert (EstudianteGusta (materia hardware) (cantidad read)) )
)

(defrule PreguntaVideojuegos


   (declare (salience 1))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   ?m <- (modulointerno preguntas)
   =>
   (retract ?m)
   (assert (modulointerno razonamiento))
   (printout t "Hmm, ¿y trabajar en un futuro en algo relacionado con videojuegos? (si/no)" crlf)
   (assert (EstudianteGusta (materia videojuegos) (cantidad read)) )
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule RazonarGusto


   (declare (salience 1))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   (modulointerno razonamiento)
   (EstudianteGusta ?r ?n)
   (atributo ?r ?R)
   =>
   (assert (gustaRama ?r ?R ?n))
)

(defrule FinRazonamiento

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))

   ?m <- (modulointerno razonamiento)
   =>
   (retract ?m)
   (assert (modulointerno explicacion))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule RazonarConsejo


   (declare (salience 1))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   (modulointerno explicacion)
   (gustaRama ?r ?R no)
   ?c <- (explicacion ?R porDefecto)
   =>
   (retract ?c)
   (assert (explicacion ?R no))
)

(defrule RazonarConsejoSi


   (declare (salience 1))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   (modulointerno explicacion)
   (gustaRama ?r ?R si)
   ?c <- (explicacion ?R ?n)
   (test (neq ?n si))
   =>
   (retract ?c)
   (assert (explicacion ?R si))
)

(defrule FinConsejos

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))

   ?m <- (modulointerno explicacion)
   =>
   (retract ?m)
   (assert (modulointerno motivos))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule MotivosConsejoPorDefecto


   (declare (salience 2))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   (modulointerno motivos)
   (explicacion ?R porDefecto)
   ?f <- (consejo ?R ?expl)
   (razon porDefecto ?motivo)
   (not (defecto ?R))
   =>
   (bind ?texto (str-cat ?expl ?motivo))
   (assert (consejo ?R ?texto) (defecto ?R))
   (retract ?f)
)

(defrule MotivosConsejo


   (declare (salience 1))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))
   ?g <- (gustaRama ?r ?R si)
   (explicacion ?R si)
   ?e <- (consejo ?R ?expl)
   (razon ?r ?motivo)
   =>
   (bind ?texto (str-cat ?expl ?motivo ", "))
   (assert (consejo ?R ?texto))
   (retract ?g ?e)
)

(defrule Fin_motivos

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))

   ?f <- (modulointerno motivos)
   =>
   (assert (modulointerno explicacion))
   (retract ?f)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ExplRazonada


   (declare (salience 1))

    ; Comprobamos que estamos en el modulo de luis
    (ModuloConversacion (modulo luis))

  (modulointerno explicacion)
  (explicacion ?R ?n)
  (test (or (eq ?n si) (eq ?n porDefecto)))
  (consejo ?R ?expl)
  =>
  printout t "Te aconsejo " ?R " porque " ?expl crlf)
)
