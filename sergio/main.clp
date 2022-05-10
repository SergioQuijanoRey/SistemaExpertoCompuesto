; Práctica 3
; Sergio Quijano Rey, sergioquijano@correo.ugr.es

; ENUNCIADO
; ==================================================================================================
; El problema consiste en diseñar un sistema experto que asesore a un estudiante de ingeniería
; informática sobre qué rama elegir de forma que el sistema actúe tal y como lo haríais vosotros.

; Así, la práctica consiste en crear un programa en CLIPS que:
; 1. Le pregunte al usuario que pide asesoramiento lo que le preguntaríais a alguien que os pida consejo
;    en ese sentido, y de la forma y orden en que lo preguntaríais vosotros.
; 2. Razone y tome decisiones cómo lo haríais vosotros para esta tarea.
; 3. Le aconseje la rama o las ramas que le aconsejaríais vosotros, junto con los motivos por los
;    que se le aconseja.

; DESCRIPCION DE PROPIEDADES
; ==================================================================================================

; A continuacion describimos las propiedades de alto nivel que usamos, los valores que pueden tomar,
; como se representan en el sistema y si se preguntan o se deducen a partir de otros hechos. Por
; propia comodidad, todas estas variables relevantes las he organizado en el fichero
; estructura_respuestas.clp, salvo las variables para mostrar los descartes que hacemos y la decision
; tomada, que se pueden consultar en mas detalle en mostrar_resultado.clp
;
; 1. Propiedad si al estudiante le gusta el hardware
;   - Valores que toma: mucho normal poco nose
;   - Representacion en el sistema: con hechos EstudianteGustaHardare especificados en el fichero estructura_respuestas.clp
;   - Se pregunta o se deduce: se pregunta directamente al usuario
;
; 2. Propiedad Nota Media del estudiante, en valor numerico
;   - Valores que toma: numero en el rango [0, 10]
;   - Representacion en el sistema: con hechos NotaMediaEstudiante especificados en el fichero estructura_respuestas.clp
;   - Se pregunta o se deduce: se pregunta directamente al usuario
;
; 3. Propiedad Nota Media del estudiante, categorizada
;   - Valores que toma: baja normal alta muyalta
;   - Representacion en el sistema: con hechos NotaMediaCategorica especificados en el fichero estructura_respuestas.clp
;   - Se pregunta o se deduce: se deduce, con reglas en logica_alto_nivel.clp, a partir de NotaMediaEstudiante
;
; 4. Propiedad si al estudiante le gustan las matematicas
;   - Valores que toma: si no nose
;   - Representacion en el sistema: con hechos EstudianteGustaMatematicas especificados en el fichero estructura_respuestas.clp
;   - Se pregunta o se deduce: se pregunta directamente al usuario
;
; 5. Propiedad si decidimos aconsejar una de las dos ramas de informacion, que estan en empate
;   - Valores que toma: si no
;   - Representacion en el sistema: con hechos EmpateInformacion especificados en el fichero estructura_respuestas.clp
;   - Se pregunta o se deduce: se deduce de las otras respuestas del usuario, cuando queremos aconsejar
;                              a una de las dos ramas de informacion. Entramos en modo empate, aplicando
;                              reglas especificas y preguntas especificas para diferenciar ramas
;  - Consultar conversacion_desempatar.clp y logica_alto_nivel_desempatar.clp para mas informacion
;
; 6. Propiedad si al estudiante le gusta programar
;   - Valores que toma: si no nose
;   - Representacion en el sistema: con hechos EstudianteGustaProgramar especificados en el fichero estructura_respuestas.clp
;   - Se pregunta o se deduce: se pregunta directamente al usuario
;
; 7. Propiedad si al estudiante le gusta trabajar con bases de datos
;   - Valores que toma: si no nose
;   - Representacion en el sistema: con hechos EstudianteGustaBasesDatos especificados en el fichero estructura_respuestas.clp
;   - Se pregunta o se deduce: se pregunta directamente al usuario
;
; 8. Propiedad si al estudiante le gusta linux
;   - Valores que toma: si no nose
;   - Representacion en el sistema: con hechos EstudianteGustaLinux especificados en el fichero estructura_respuestas.clp
;   - Se pregunta o se deduce: se pregunta directamente al usuario
;
; 9. Propiedad si al estudiante le gusta linux
;   - Valores que toma: si no nose
;   - Representacion en el sistema: con hechos EstudianteGustaLinux especificados en el fichero estructura_respuestas.clp
;   - Se pregunta o se deduce: se pregunta directamente al usuario
;
; 10. Propiedad consejos para una rama
;   - Valores que toma: La rama que aconsejamos y un texto con el motivo
;   - Representacion en el sistema: con hechos (Consejo ?rama ?texto)
;   - Se pregunta o se deduce: se deduce con la logica de alto nivel de nuestro sistema
;
; 11. Propiedad descartar una asignatura
;   - Valores que toma: la rama que descartamos, el orden del motivo y el texto con el motivo
;   - Representacion en el sistema: con hechos (Descartar ?rama ?orden ?texto)
;   - Se pregunta o se deduce: se deduce de la logica de alto nivel de nuestro sistema
;
; 12. Propiedad de control para saber si hemos terminado con las preguntas
;   - Valores que toma: si no
;   - Representacion en el sistema: con hechos Terminado especificados en el fichero terminado.clp
;   - Se pregunta o se deduce: se deduce de la logica de alto nivel. Cuando ya hemos tomado una
;                              decision definitiva, usamos esta regla para parar de preguntar y
;                              mostrar el resultado final
;
; 13. Propiedad para saber cual es la decision final del sistema
;   - Valores que toma: la rama por la cual nos decidimos
;   - Representacion en el sistema: con hechos Decision en el fichero decision.clp
;   - Se pregunta o se deduce: se deduce de la logica de alto nivel. Cuando ya hemos tomado una
;                              decision definitiva, usamos esta regla para marcar cual es la rama
;                              por la que nos decantamos
;

; EVALUACION DE LA PRACTICA
; ==================================================================================================

; Dejo anotados aqui los criterios que se muestran en el guion de practicas para evaluar dicha practica

; - Gestión de la entrada y salida de datos (1 punto): el programa solicita los datos de forma
; sencilla y cómoda para el usuario, y  proporciona la salida de forma clara y precisa.

; - Naturalidad de la interacción con el usuario (2 puntos).: que el usuario no tenga que responder
; de forma mecánica y tediosa todas las preguntas posibles, sino que al igual que haría una persona
; solo se realicen las preguntas oportunas en cada caso.

; - Legibilidad y editabilidad de la base de conocimiento (1,5 puntos): el conocimiento debe estar
; organizado en módulos, con funcionalidades separadas, y ser fácil de entender por una persona
; interesada en el problema, de forma que sea  fácil de probar, depurar y sobre todo modificar y
; mejorar. Se debe poder modificar o añadir reglas para mejorar el comportamiento del sistema sin
; tener que modificar nada.

; - Posibilidad de responder a partir de información parcial (1,5 puntos): el sistema debe
; proporcionar respuesta  aunque el usuario haya respondido “no sé” a alguna pregunta.

; - Grado de elaboración de la explicación de la respuesta (2 puntos).: la justificación de la
; recomendación proporcionada es detallada pero comprensible y se ajusta a la inferencia realizada.

; - Profundidad del sistema (2 puntos): Que el sistema utilice y deduzca hechos y conceptos de alto
; nivel y no que todo sea preguntar cosas al usuario y responder con reglas basadas directamente en
; los hechos obtenidos de las respuestas del usuario

; NOTAS PERSONALES
;===================================================================================================

; Estructuramos todo el programa siguiendo las siguientes preferencias, para mantener el correcto
; estado del programa:
; 1. Reglas que eliminan hechos para mantener la validez del programa => 9000
; 2. Reglas que añaden hechos básicos sobre el estado del programa => 8000
; 3. Comprobaciones de seguridad => 7000
; 4. Preguntas al usuario siguiendo cierto orden => -1, -2, ...


; EJECUCION RAPIDA DEL SCRIPT
;===================================================================================================

; Con estas instrucciones podemos ejecutar el script desde la linea de comandos
; Haciendo `clips -f main.clp`

; Cargamos todos los ficheros en los que hemos dividido el codigo
; El orden en el que importamos los ficheros es relevante. Por ejemplo, si importamos primero
; decisiones y luego generaria_tres_fichas_conectadas, obtenemos un error
(load estructura_respuestas.clp)
(load terminado.clp)
(load decision.clp)
(load ramas.clp)
(load consejo.clp)
(load conversacion.clp)
(load conversacion_desempatar.clp)
(load logica_alto_nivel.clp)
(load logica_alto_nivel_desempatar.clp)
(load mostrar_resultado.clp)
(load estado_inicial.clp)

; Ejecutamos el codigo
(reset)
(run)
