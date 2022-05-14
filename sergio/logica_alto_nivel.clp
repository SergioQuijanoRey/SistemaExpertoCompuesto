; Modulo en el que programamos la logica de mas alto nivel
; Tomamos las respuestas del estudiante y realizamos razonamientos en base a ello
; Consultar el fichero estructura_respuestas.clp donde tengo todos los deftemplates de las variables
; que representan las respuestas dadas por el usuario

; LOGICA REFERENTE A LA RESPUESTA QUE DA EL USUARIO SOBRE SI LE GUSTA EL HARDWARE
;===================================================================================================


; Si al estudiante le gusta mucho el hardware, entonces la mejor opcion que puede tomar es estudiar
; Arquitectura de computadores, por los motivos que explico en las reglas
(defrule EstudianteGustaMuchoHardware

    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    (EstudianteGustaHardware (cantidad mucho))

    =>

    ; Marcamos los consejos que queremos darle al estudiante
    (assert (Consejo Ingenieria_de_Computadores "Te gusta mucho el hardware, y en esta rama se estudia muchisimo de hardware"))
    (assert (Consejo Ingenieria_de_Computadores "Ademas, la rama es bastante facil (casi nadie la coge y los profesores son muy atentos con los alumnos"))
    (assert (Consejo Ingenieria_de_Computadores "Tambien, es de las especializaciones que mejor estan pagadas en el mercado laboral"))

    ; Terminamos, porque ya hemos elegido una rama
    (assert (Terminado (estado si)))
    (assert (Decision (rama Ingenieria_de_Computadores)))
)


; Si al estudiante no le gusta nada el hardware, descartamos esta rama
(defrule EstudianteGustaPocoHardware


    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    (EstudianteGustaHardware (cantidad poco))

    =>

    ; Marcamos los motivos por los que descartamos esta rama
    (assert (Descartar Ingenieria_de_Computadores 1 "Si no te gusta el hardware, no escojas esta rama porque casi todas las asignaturas son de hardware"))
    (assert (Descartar Ingenieria_de_Computadores 2 "Ademas, seguramente no quieras dedicarte al hardware en tu futuro profesional, y esta rama es muy específica en hardware"))
)

; Para entrar a Ingenieria de Computadores te tiene que gustar realmente el hardware, porque si no
; es una rama muy fea / dificil. Por tanto, si el alumno esta dudoso sobre esta rama, tambien la
; descartamos
(defrule EstudianteNoSabeSiGustaHardware


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    (EstudianteGustaHardware (cantidad nose))

    =>

    ; Marcamos los motivos por los que descartamos esta rama
    (assert (Descartar Ingenieria_de_Computadores 1 "Si no estas muy seguro de si te gusta el hardware, es mejor que no escojas esta rama"))
    (assert (Descartar Ingenieria_de_Computadores 2 "Casi todas las asignaturas tienen una gran componente de hardware, y si no te gusta va a ser muy duro"))
    (assert (Descartar Ingenieria_de_Computadores 3 "Ademas, tienes que estar muy seguro de que te guste el hardware. Si no eres afin a este campo, las asignaturas se te van a hacer realmente complicadas"))
)

; Si al estudiante le gusta normal el hardware, no hacemos nada
; Guardamos esta informacion para mas tarde, pero necesitamos realizar mas preguntas


; LOGICA REFERENTE A LA NOTA MEDIA DEL ESTUDIANTE
;===================================================================================================

; Lo primero que podemos hacer es discretizar la nota media del usuario en cuatro categorias, con
; las que el sistema pueda razonar mas comodamente

(defrule categorizaNotaMediaBaja


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; La nota media es baja
    (NotaMediaEstudiante (numero ?nota))
    (test (>= ?nota 0))
    (test (<= ?nota 4.5))

    =>

    (assert (NotaMediaCategorica (valor baja)))
)

(defrule categorizaNotaMediaNormal


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; La nota media es normal
    (NotaMediaEstudiante (numero ?nota))
    (test (> ?nota 4.5))
    (test (<= ?nota 6.5))

    =>

    (assert (NotaMediaCategorica (valor normal)))
)


(defrule categorizaNotaMediaAlta


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; La nota media es media alta
    (NotaMediaEstudiante (numero ?nota))
    (test (> ?nota 6.5))
    (test (<= ?nota 8.5))

    =>

    (assert (NotaMediaCategorica (valor alta)))
)


(defrule categorizaNotaMediaMuyAlta


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; La nota media es muy alta
    (NotaMediaEstudiante (numero ?nota))
    (test (> ?nota 8.5))
    (test (<= ?nota 10.0))

    =>

    (assert (NotaMediaCategorica (valor muyalta)))
)

; Ahora que tenemos la nota media categorizada, podemos empezar a tomar algunas decisiones en
; base a esta informacion

; En primer lugar, si la nota media es baja, descartamos CSI porque es una rama realmente
; complicada y que requiere de unas muy buenas bases durante la carrera
(defrule notaBajaDescartaCSI


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    (NotaMediaCategorica (valor baja))

    =>

    (assert (Descartar Computacion_y_Sistemas_Inteligentes 1 "Si tienes una nota baja, no te aconsejo para nada que curses CSI"))
    (assert (Descartar Computacion_y_Sistemas_Inteligentes 2 "Es una rama bastante dificil, asi que si has tenido dificultades con otras asignaturas o no has trabajado demasiado, es mejor olvidar esta rama"))
    (assert (Descartar Computacion_y_Sistemas_Inteligentes 3 "Ademas, require de unas buenas bases durante toda la carrera, que puede ser que no hayas adquirido"))
)

; Con una nota media baja, creo que la mejor opcion es Ingenieria del software. El resto de ramas
; son bastante especificas y requieren de cierta base. En Ingenieria del Software muchas de las
; asignaturas son sencillas, y ademas te van a ayudar a retomar las bases
(defrule notaBajaAconsejaIngSoftware


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    (NotaMediaCategorica (valor baja))

    =>

    ; Marcamos los consejos que queremos darle al estudiante
    (assert (Consejo Ingenieria_del_Software "En primer lugar, el resto de ramas son bastante especificas y necesitan de ciertas bases que puede que no tengas"))
    (assert (Consejo Ingenieria_del_Software "En esta rama muchas de las asignaturas son sencillas, asi que puede que esto te haga conseguir una mejor nota media"))
    (assert (Consejo Ingenieria_del_Software "Ademas, muchas asignaturas (ie. Desarrollo del Software) repiten machaconamente las bases, por lo que te puede servir para construir unas bases mas solidas que te sirvan en el futuro"))

    ; Terminamos, porque ya hemos elegido una rama
    (assert (Terminado (estado si)))
    (assert (Decision (rama Ingenieria_del_Software)))
)

; Con una nota media alta o muy alta, es aconsejable hacer cualquier rama porque en principio no
; deberia ser muy complicada para el estudiante
(defrule notaAltaOMuyAltaAyudaSiempre


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; La nota media es alta o muy alta
    (NotamediaCategorica (valor alta | muyalta))

    ; Para cualquier rama sirve el siguiente consejo
    (Rama ?rama)

    =>

    ; Añadimos este consejo, que sirve para cualquiera de las ramas que al final decidamos
    (assert (Consejo ?rama "Con esa nota media tan buena, seguramente te sea muy facil superar esta rama"))
)


; LOGICA REFERENTE A SI LE GUSTAN LAS MATEMATICAS AL ESTUDIANTE
;===================================================================================================

; Si le gustan las matematicas, y tiene buena nota (normal | alta | muyalta), entonces recomiendo CSI
(defrule GustanMatematicasYBuenaNota


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; La nota media es buena, suficiente para cursar esta rama
    (NotaMediaCategorica (valor alta | muyalta))

    ; Le gustan las matematicas al estudiante
    (EstudianteGustaMatematicas (cantidad si))

    =>

    ; Marcamos los consejos que queremos darle al estudiante
    (assert (Consejo Computacion_y_Sistemas_Inteligentes "Si te gustan las matematicas y tienes una nota media buena, creo que vas a disfrutar mucho de esta rama"))
    (assert (Consejo Computacion_y_Sistemas_Inteligentes "Vas a ver bastantes matematicas, muy bien integradas en la parte de informatica. Con asignaturas tanto con buena carga de programacion (ie. AA VC IC) como muy teóricas (ie. MAC)"))
    (assert (Consejo Computacion_y_Sistemas_Inteligentes "Ademas, creo que es una de las ramas mas bonitas de la informatica. Si no tienes problemas con superar las asignaturas (que con tu nota media no deberias), vas a disfrutar mucho"))
    (assert (Consejo Computacion_y_Sistemas_Inteligentes "Y sobre todo, te abre un gran abanico de profesiones, todas ellas apasionantes y muy bien pagadas"))

    ; Terminamos, porque ya hemos elegido una rama
    (assert (Terminado (estado si)))
    (assert (Decision (rama Computacion_y_Sistemas_Inteligentes)))
)


; Si le gustan las matematicas, pero su nota es normal, recomendamos una asignatura de informacion
; Podriamos recomendar CSI, pero le va a ser muy complicado superar estas asignaturas con una nota
; tan ajustada
(defrule GustanMatematicasPeroNotaNormal


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; La nota media es baja o normal
    ; Notar que si la nota media es baja, anteriormente ya hemos recomendado Ing. Software. Dejamos
    ; este valor redundante por si se quiere modifcar la base de conocimiento, porque sigue siendo
    ; valido el razonamiento que hacemos a continuacion
    (NotaMediaCategorica (valor baja | normal))

    ; Le gustan las matematicas al estudiante
    (EstudianteGustaMatematicas (cantidad si))

    =>

    ; Marcamos los consejos que queremos darle al estudiante
    ; Marcamos los mismos consejos para las dos asignaturas de informacion
    (assert (Consejo Sistemas_de_Informacion "Te gustan las matematicas, pero con la nota media que tienes creo que vas a tener algunas dificultades (como ya te he comentado)"))
    (assert (Consejo Sistemas_de_Informacion "En esta rama vas a tener que realizar diseños de bases de datos a alto nivel, asi que hay te van a ser utiles conceptos / formas de pensar matematicos"))
    (assert (Consejo Sistemas_de_Informacion "Ademas, las consultas a las bases de datos estan muy basadas en algebra de conjuntos y otras operaciones matematicas, que te van a gustar"))

    (assert (Consejo Tecnologias_de_la_Informacion "Te gustan las matematicas, pero con la nota media que tienes creo que vas a tener algunas dificultades (como ya te he comentado)"))
    (assert (Consejo Tecnologias_de_la_Informacion "En esta rama vas a tener que realizar diseños de bases de datos a alto nivel, asi que hay te van a ser utiles conceptos / formas de pensar matematicos"))
    (assert (Consejo Tecnologias_de_la_Informacion "Ademas, las consultas a las bases de datos estan muy basadas en algebra de conjuntos y otras operaciones matematicas, que te van a gustar"))

    ; Marcamos que queremos aconsejar una rama de informacion, para pasar a un modo desempate!
    (assert (EmpateInformacion (flag si)))
)

; Si al estudiante no le gustan las matematicas, descartamos CSI porque tiene gran carga de matematicas
(defrule NoGustanMatematicasDescartaCSI


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    (EstudianteGustaMatematicas (cantidad no))

    =>

    (assert (Descartar Computacion_y_Sistemas_Inteligentes 1 "Si no te gustan las matematicas, no te recomiendo que curses esta rama"))
    (assert (Descartar Computacion_y_Sistemas_Inteligentes 2 "Muchas de las asignaturas tienen una componente muy matematica (ie. AA, VC, IC, MAC...)"))
    (assert (Descartar Computacion_y_Sistemas_Inteligentes 3 "Por lo tanto, si cursas esta rama creo que vas a sufrir mucho por las mates"))

)

; Lo mismo de antes se aplica si no sabe si le gustan. Si no esta seguro, es mejor que no curse esta rama
; No lo hacemos en la misma regla que la anterior porque los mensajes de descarte van a ser ligeramente
; diferentes
(defrule NoSabeSiGustanMatematicasDescartaCSI


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    (EstudianteGustaMatematicas (cantidad nose))

    =>

    (assert (Descartar Computacion_y_Sistemas_Inteligentes 1 "Si no sabes si te gustan las matematicas, no te recomiendo que curses esta rama"))
    (assert (Descartar Computacion_y_Sistemas_Inteligentes 2 "Muchas de las asignaturas tienen una componente muy matematica (ie. AA, VC, IC, MAC...)"))
    (assert (Descartar Computacion_y_Sistemas_Inteligentes 3 "Por lo tanto, si cursas esta rama y no conectas bien con las matematicas, vas a sufrir mucho"))
    (assert (Descartar Computacion_y_Sistemas_Inteligentes 4 "Es decir, creo que es mejor que no te arriesgues con esta rama"))

)

; LOGICA REFERENTE A SI LE GUSTA PROGRAMAR AL ESTUDIANTE
;===================================================================================================

; En este punto ya sabemos que al estudiante no le gustan las matematicas. Si le gustasen ya habriamos
; realizado una asignacion de rama. Pero por facilitar el añadir / quitar conocimiento, realizamos
; comprobaciones sobre esto

; Si al estudiante le gusta programar, no le gustan las matematicas y tiene nota normal, asignamos
; Ing. Software porque es la rama con mas programacion sin otros elementos
(defrule GustaProgramarEntoncesSoftware


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; Le gusta programar, y no le gustan las matematicas
    (EstudianteGustaProgramar (cantidad si))
    (EstudianteGustaMatematicas (cantidad no))

    =>

    ; Marcamos los consejos que queremos darle al estudiante
    (assert (Consejo Ingenieria_del_Software "Te gusta programar, y no te gustan las matematicas"))
    (assert (Consejo Ingenieria_del_Software "Por tanto, te recomiendo esta rama. Es quizas la rama que mas programacion conlleve de la carrera"))
    (assert (Consejo Ingenieria_del_Software "Ademas, es la rama en la que te vas a dedicar a programar sin preocuparte demasiado de otras especialidades"))
    (assert (Consejo Ingenieria_del_Software "Por ejemplo, no tienes que programar sabiendo cosas de IA (CSI), programar sabiendo como funciona el hardware a gran detalle (Ing. Computadores), ..."))

    ; Terminamos, porque ya hemos elegido una rama
    (assert (Terminado (estado si)))
    (assert (Decision (rama Ingenieria_del_Software)))

)

; Si al estudiante no le gusta programar, no le gustan las matematicas y tiene nota normal, le
; recomiendo que haga alguna asignatura de informacion. En estas asignaturas hay menos carga de programacion
; como tal (aunque se usa muchas consultas SQL o no relacionales) y son asequibles
(defrule NoGustaProgramarEntoncesInformacion


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; Le gusta programar, tiene nota media y no le gustan las matematicas
    (EstudianteGustaProgramar (cantidad no))
    (EstudianteGustaMatematicas (cantidad no))

    =>

    ; Marcamos los consejos que queremos darle al estudiante
    ; Marcamos los mismos consejos para las dos asignaturas de informacion
    (assert (Consejo Sistemas_de_Informacion "No te gustan ni las matematicas, ni el hardware, ni programar, asi que creo que la mejor opcion es esta rama"))
    (assert (Consejo Sistemas_de_Informacion "Algo vas a tener que programar, pero puede ser de las ramas que menos programacion involucre"))
    (assert (Consejo Sistemas_de_Informacion "Ademas, la programacion va muy de la mano con consultas SQL | No relacionales"))
    (assert (Consejo Sistemas_de_Informacion "Tambien, es una rama bastante asequible que no deberia hacerse muy complicada"))

    (assert (Consejo Tecnologias_de_la_Informacion "No te gustan ni las matematicas, ni el hardware, ni programar, asi que creo que la mejor opcion es esta rama"))
    (assert (Consejo Tecnologias_de_la_Informacion "Algo vas a tener que programar, pero puede ser de las ramas que menos programacion involucre"))
    (assert (Consejo Tecnologias_de_la_Informacion "Ademas, la programacion va muy de la mano con consultas SQL | No relacionales"))
    (assert (Consejo Tecnologias_de_la_Informacion "Tambien, es una rama bastante asequible que no deberia hacerse muy complicada"))

    ; Marcamos que queremos aconsejar una rama de informacion, para pasar a un modo desempate!
    (assert (EmpateInformacion (flag si)))
)

; Si no sabe si le gusta programar, no le gusta el hardware o no lo sabe, le recomiendo informacion.
; No tiene mucha programacion, pero algo tiene. Asi que así puede saber si le gusta o no le gusta
; programar para su futuro profesional. Desarrollo seria demasiado arriesgado porque no sabe si le
; gusta programar
(defrule NoSabeSiGustaProgramarEntoncesInformacion


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; Le gusta programar, tiene nota media y no le gustan las matematicas
    (EstudianteGustaProgramar (cantidad nose))
    (EstudianteGustaMatematicas (cantidad no))

    =>

    ; Descartamos desarrollo del software
    (assert (Descartar Ingenieria_del_Software 1 "Si no sabes si te gusta programar, Desarrollo del software tiene demasiada programacion"))
    (assert (Descartar Ingenieria_del_Software 2 "Creo que es arriesgado que sin saber si te gusta programar, te metas en una rama con tantisima carga de programacion"))

    ; Marcamos los consejos que queremos darle al estudiante
    ; Marcamos los mismos consejos para las dos asignaturas de informacion
    (assert (Consejo Sistemas_de_Informacion "No te gustan ni las matematicas, ni el hardware, y no sabes si te gusta  programar, asi que creo que la mejor opcion es esta rama"))
    (assert (Consejo Sistemas_de_Informacion "Algo vas a tener que programar, asi que esto puede servirte para decidir si te gusta o no te gusta programar"))
    (assert (Consejo Sistemas_de_Informacion "Y esta puede ser una informacion muy valiosa para tu futuro profesional"))
    (assert (Consejo Sistemas_de_Informacion "Ademas, en caso de que no te guste programar, no hay mucha carga de esto. Asi que es una apuesta sin mucho riesgo"))


    (assert (Consejo Tecnologias_de_la_Informacion "No te gustan ni las matematicas, ni el hardware, y no sabes si te gusta  programar, asi que creo que la mejor opcion es esta rama"))
    (assert (Consejo Tecnologias_de_la_Informacion "Algo vas a tener que programar, asi que esto puede servirte para decidir si te gusta o no te gusta programar"))
    (assert (Consejo Tecnologias_de_la_Informacion "Y esta puede ser una informacion muy valiosa para tu futuro profesional"))
    (assert (Consejo Tecnologias_de_la_Informacion "Ademas, en caso de que no te guste programar, no hay mucha carga de esto. Asi que es una apuesta sin mucho riesgo"))

    ; Marcamos que queremos aconsejar una rama de informacion, para pasar a un modo desempate!
    (assert (EmpateInformacion (flag si)))
)


; REGLA POR DEFECTO
;===================================================================================================

; Esta regla no deberia lanzarse en mi sistema. Pero la dejo porque asi es mas sencillo que la base
; de conocimiento sea modificada. Si al modificar la base de conocimiento no se contempla una
; combinacion, en vez de dejar al estudiante sin respuesta al menos damos una respuesta por defecto
(defrule respuestaPorDefecto

    ; La regla por defecto deberia ser lo ultimo en ejecutarse de todo el sistema
    (declare (salience -9999))


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    (Terminado (estado no))

    =>

    ; Marcamos los consejos que queremos darle al estudiante
    (assert (Consejo Ingenieria_del_Software "Con la informacion que tengo ahora mismo no puedo darte una respuesta demasiado buena"))
    (assert (Consejo Ingenieria_del_Software "Te recomiendo esta rama porque es la mas generica de todas las ramas"))
    (assert (Consejo Ingenieria_del_Software "Desde esta rama puedes pivotar a otras ramas con facilidad"))

    ; Terminamos, porque ya hemos elegido una rama
    (assert (Terminado (estado si)))
    (assert (Decision (rama Ingenieria_del_Software)))
)
