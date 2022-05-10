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
   (atributo prog Computacion_y_Sistemas_Inteligentes)
   (atributo prog Ingenieria_del_Software)
   (atributo adsi Ingenieria_de_Computadores)
   (atributo adsi Sistemas_de_Informacion)
   (atributo red Tecnologias_de_la_Informacion)
   (atributo mates Computacion_y_Sistemas_Inteligentes)
   (atributo doc Computacion_y_Sistemas_Inteligentes)
   (atributo doc Sistemas_de_Informacion)
   (atributo robot Computacion_y_Sistemas_Inteligentes)
   (atributo robot Ingenieria_de_Computadores)
   (atributo bd Sistemas_de_Informacion)
   (atributo hw Ingenieria_de_Computadores)
   (atributo viju Ingenieria_del_Software)
)

(deffacts Razones
   (razon web "te gustaria estudiar programacion web o diseño web")
   (razon prog "eres un fiera programando")
   (razon adsi "vas a ser un gran administrador de sistemas")
   (razon red "vas a ser mejor en redes que spiderman")
   (razon mates "te llaman el matemago")
   (razon doc "se te ve cara de profesor")
   (razon robot "vas a dominar el mundo con tus robots")
   (razon bd "te llaman la atencion las bases de datos")
   (razon hw "por alguna razon te gusta el hardware")
   (razon viju "quiero jugar tus videojuegos")
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
   (modulo inicio)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule RazonPorDefecto
   (declare (salience 1))
   (modulo inicio)
   (Rama ?r)
   (not (explicacion ?r porDefecto))
   =>
   (assert (explicacion ?r porDefecto))
)

(defrule Comenzar_preguntas
   ?f <- (modulo inicio)
   =>
   (retract ?f)
   (assert (modulo preguntas))
)

;;;;;;; Preguntas 

(defrule PreguntaWeb
   (declare (salience 1))
   (modulo preguntas)
   =>
   (printout t "¿Te gustaria estudiar programacion web o otros temas de web? (si/no)" crlf)
   (assert (gusta web (read)))
)

(defrule PreguntaProgramar
   (declare (salience 1))
   (modulo preguntas)
   =>
   (printout t "¿Se te da bien picar codigo todo el dia? (si/no)" crlf)
   (assert (gusta prog (read)) )
)

(defrule PreguntaAdSi
   (declare (salience 1))
   (modulo preguntas)
   =>
   (printout t "¿Te llama la atencion la administracion de sistemas? (si/no)" crlf)
   (assert (gusta adsi (read)) )
)

(defrule PreguntaRed
   (declare (salience 1))
   (modulo preguntas)
   =>
   (printout t "¿Te interesa conocer los entresijos de las redes e internet? (si/no)" crlf)
   (assert (gusta red (read)) )
)

(defrule PreguntaMates
   (declare (salience 1))
   (modulo preguntas)
   =>
   (printout t "¿Eres amigo de las formulas matematicas o al menos las entiendes? (si/no)" crlf)
   (assert (gusta mates (read)) )
)

(defrule PreguntaDocencia
   (declare (salience 1))
   (modulo preguntas)
   =>
   (printout t "¿Te ves dando clase en un futuro? (si/no)" crlf)
   (assert (gusta doc (read)))
)

(defrule PreguntaRobotica
   (declare (salience 1))
   (modulo preguntas)
   =>
   (printout t "¿Te interesan los robots (y no solo para dominar el mundo)? (si/no)" crlf)
   (assert (gusta robot (read)))
)

(defrule PreguntaBD
   (declare (salience 1))
   (modulo preguntas)
   =>
   (printout t "¿Que tal te fue con las sentencias de SQL, te gusto Base de Datos? (si/no)" crlf)
   (assert (gusta bd (read)) )
)

(defrule PreguntaHardware
   (declare (salience 1))
   (modulo preguntas)
   =>
   (printout t "¿Ey, no seras de los que le gusta mas el hardware? (si/no)" crlf)
   (assert (gusta hw (read)) )
)

(defrule PreguntaVideojuegos
   (declare (salience 1))
   ?m <- (modulo preguntas)
   =>
   (retract ?m)
   (assert (modulo razonamiento))
   (printout t "Hmm, ¿y trabajar en un futuro en algo relacionado con videojuegos? (si/no)" crlf)
   (assert (gusta viju (read)))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule RazonarGusto
   (declare (salience 1))
   (modulo razonamiento)
   (gusta ?r ?n)
   (atributo ?r ?R)
   =>
   (assert (gustaRama ?r ?R ?n))
)

(defrule FinRazonamiento
   ?m <- (modulo razonamiento)
   =>
   (retract ?m)
   (assert (modulo explicacion))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule RazonarConsejo
   (declare (salience 1))
   (modulo explicacion)
   (gustaRama ?r ?R no)
   ?c <- (explicacion ?R porDefecto)
   =>
   (retract ?c)
   (assert (explicacion ?R no))
)

(defrule RazonarConsejoSi
   (declare (salience 1))
   (modulo explicacion)
   (gustaRama ?r ?R si)
   ?c <- (explicacion ?R ?n)
   (test (neq ?n si))
   =>
   (retract ?c)
   (assert (explicacion ?R si))
)

(defrule FinConsejos
   ?m <- (modulo explicacion)
   =>
   (retract ?m)
   (assert (modulo motivos))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule MotivosConsejoPorDefecto
   (declare (salience 2))
   (modulo motivos)
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
   ?f <- (modulo motivos)
   =>
   (assert (modulo explicacion))
   (retract ?f)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ExplRazonada
  (modulo explicacion)
  (explicacion ?R ?n)
  (test (or (eq ?n si) (eq ?n porDefecto)))
  (consejo ?R ?expl)
  =>
  printout t "Te aconsejo " ?R " porque " ?expl crlf)
)