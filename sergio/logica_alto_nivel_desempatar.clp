; Modulo en el que vamos a desarrollar la logica de alto nivel que aplicamos cuando estamos
; intentando desempatar entre las dos ramas de informacion. La logica sera mucho mas concreta que
; la logica de alto nivel general, y por tanto usamos este modulo separado. Se explica mas
; motivacion para esta separacion de modos en conversacion_desempatar.clp

; No conozco demasiado la diferencia entre las dos ramas. Leyendo las guias docentes llego a las
; siguientes hipotesis sobre las que voy a basar la logica de alto nivel (hipotesis que pueden
; ser erronas):
;
; - Sistemas de informacion contiene muchas mas matematicas (por ejemplo, Inteligencia de Negocio,
; recuperacion de informacion, )
; - Sistemas de informacion tiene mas administracion de bases de datos que Tecnologias de la informacion
; - Tecnologias de la informacion tiene mucha mas carga de programacion y de servidores (DAI, IV,
; SWAP)


; Ambas ramas son muy parecidas. Pero Sistemas de Informacion contiene algo mas de matematicas (
; principalmente Inteligencia de Negocio). Asi que por esa asignatura, aconsejo esa rama
(defrule EmpateGustaMatesEntoncesSistemas

    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; Nos encontramos en una situacion de empate
    (EmpateInformacion (flag si))

    ; Ya se ha mostrado el mensaje inicial, asi que podemos razonar
    (MensajeInicial dado)

    ; Al estudiante le gustan las matematicas
    (EstudianteGusta (materia matematicas) (cantidad si))

    =>

    ; Marcamos los consejos que queremos darle al estudiante
    (assert (Consejo Sistemas_de_Informacion "Te gustan las matematicas, asi que te aconsejo esta rama y no Tecnologias de la Informacion porque es algo mas matematica"))
    (assert (Consejo Sistemas_de_Informacion "Concretamente, en Sistemas tienes la asignatura Inteligencia de Negocio, que tiene bastante carga de matemáticas, que te puede gustar"))
    (assert (Consejo Sistemas_de_Informacion "Ademas, he cursado personalmente esta asignatura y te puedo asegurar que merece muchisimo la pena, te da una vision global de la ciencia de datos muy adecuada"))

    ; Terminamos, porque ya hemos elegido una rama
    (assert (Terminado (estado si)))
    (assert (Decision (rama Sistemas_de_Informacion)))
)

; Si la nota media es muy alta, entonces recomendamos Sistemas, que es en mi opinion algo mas compleja
(defrule EmpateNotaMuyAltaEntoncesSistemas


    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; Nos encontramos en una situacion de empate
    (EmpateInformacion (flag si))

    ; Ya se ha mostrado el mensaje inicial, asi que podemos razonar
    (MensajeInicial dado)

    ; La nota media del estudiante es muyalta
    ; Ademas, no le gusta programar o no lo sabe (caso 2. descrito en conversacion_desempatar.clp)
    (EstudianteGusta (materia programacion) (cantidad no | nose))
    (NotaMediaCategorica (valor muyalta))

    =>

    ; Marcamos los consejos que queremos darle al estudiante
    (assert (Consejo Sistemas_de_Informacion "Tu nota media es muy alta, asi que te aconsejo esta rama porque es algo mas dificil Tecnologias de la Informacion"))
    (assert (Consejo Sistemas_de_Informacion "Sin embargo, las asignaturas creo que son mas interesantes y con mejores salidas laborales"))
    (assert (Consejo Sistemas_de_Informacion "Tienes una asignatura de mates (IN) que no te gusta, pero con tan buenas notas seguro que no te cuesta nada"))


    ; Terminamos, porque ya hemos elegido una rama
    (assert (Terminado (estado si)))
    (assert (Decision (rama Sistemas_de_Informacion)))
)

; Si al estudiante le gusta la administracion de bases de datos, recomendamos Sistemas porque tiene
; un par de asignaturas de administracion de bases de datos
(defrule gustaBasesDeDatosEntoncesSistemas


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; Nos encontramos en una situacion de empate
    (EmpateInformacion (flag si))

    ; Ya se ha mostrado el mensaje inicial, asi que podemos razonar
    (MensajeInicial dado)

    ; Al estudiante le gustan las bases de datos
    (EstudianteGusta (materia basesdatos) (cantidad si))

    =>

    ; Marcamos los consejos que queremos darle al estudiante
    (assert (Consejo Sistemas_de_Informacion "Si te gusta trabajar directamente con bases de datos, te recomiendo esta rama"))
    (assert (Consejo Sistemas_de_Informacion "Tienes muchisimas asignaturas dedicadas a la administracion de bases de datos"))
    (assert (Consejo Sistemas_de_Informacion "BD Distribuidas, Administracion de BD, Sistemas Multidimensionales, ..."))


    ; Terminamos, porque ya hemos elegido una rama
    (assert (Terminado (estado si)))
    (assert (Decision (rama Sistemas_de_Informacion)))
)

; Si al estudiante le gusta usar linux, le recomiendo Tecnologias, porque tiene algunas asignaturas
; que se basan bastante en el manejo de linux
(defrule gustaLinuxEntoncesTecnologias


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; Nos encontramos en una situacion de empate
    (EmpateInformacion (flag si))

    ; Ya se ha mostrado el mensaje inicial, asi que podemos razonar
    (MensajeInicial dado)

    ; Al estudiante le gustan linux
    (EstudianteGusta (materia linux) (cantidad si))

    =>

    ; Marcamos los consejos que queremos darle al estudiante
    (assert (Consejo Tecnologias_de_la_Informacion "Si te gusta y te sientes comodo trabajando con linux, te recomiendo esta rama"))
    (assert (Consejo Tecnologias_de_la_Informacion "En bastantes asignaturas vas a tener que estar trabajando muy de cerca con entornos linux, asi que te va a gustar"))
    (assert (Consejo Tecnologias_de_la_Informacion "Infraestructura Virtual, Servidores Web de altas prestaciones, ..."))


    ; Terminamos, porque ya hemos elegido una rama
    (assert (Terminado (estado si)))
    (assert (Decision (rama Tecnologias_de_la_Informacion)))
)


; Si al usuario no le gusta linux, entonces recomiendo Sistemas, porque en Tecnologias tiene que trabajar
; bastante con linux
(defrule NoGustaLinuxEntoncesSistemas


    (declare (salience 8000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    ; Nos encontramos en una situacion de empate
    (EmpateInformacion (flag si))

    ; Ya se ha mostrado el mensaje inicial, asi que podemos razonar
    (MensajeInicial dado)

    ; Al estudiante le gustan linux
    (EstudianteGusta (materia linux) (cantidad no | nose))

    =>

    ; Marcamos los consejos que queremos darle al estudiante
    (assert (Consejo Sistemas_de_Informacion "Si no te gusta linux, te aconsejo esta rama, porque en tecnologías tendrias que trabajar muchas asignaturas con linux"))
    (assert (Consejo Sistemas_de_Informacion "Asignaturas en Tecnologias como Infraestructura Virtual, Servidores Web de altas prestaciones, que quieres evitar"))


    ; Terminamos, porque ya hemos elegido una rama
    (assert (Terminado (estado si)))
    (assert (Decision (rama Sistemas_de_Informacion)))
)
