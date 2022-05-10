; Modulo en el que vamos a fijar las estructuras que representan las repsuestas dadas por el
; estudiante al que estamos aconsejando. Asi tenemos todas los hechos bien estructurados con
; deftemplate y en un unico fichero al que consultar fácilmente

; Representa cuanto le gusta al estudiante el hardware
(deftemplate EstudianteGustaHardware
    (slot cantidad
        (type SYMBOL)
        (allowed-symbols mucho normal poco nose)
    )
)

; Nota media del estudiante numerica
; Mas tarde la categorizamos para que sea mas facil trabajar con esta informacion
(deftemplate NotaMediaEstudiante
    ; Valor numerico de la nota
    (slot numero)
)

; Representa la nota media , de forma discretizada a partir de la nota media numerica del estudiante
; De forma discreta es mas facil escribir reglas para que el sistema razone
(deftemplate NotaMediaCategorica
    (slot valor
        (type SYMBOL)
        (allowed-symbols baja normal alta muyalta)
    )
)

; Representa si al estudiante le gustan o no las matematicas
(deftemplate EstudianteGustaMatematicas
    (slot cantidad
        (type SYMBOL)
        (allowed-symbols si no nose)
    )
)

; Cuando se tiene (EmpateInformacion (flag si)), indicamos que hemos decidido aconsejar una de las
; ramas de informacion. Ambas ramas se parecen tanto que preferimos pasar a un modo "desempate", en
; vez de seguir con una entrevista normal. En este nuevo modo, podemos realizar preguntas mas.
; concretas para tomar una decision entre las dos asignaturas. Asi es como funciono yo, porque me
; cuesta distinguir bastante entre estas dos ramas
(deftemplate EmpateInformacion
    (slot flag
        (type SYMBOL)
        (allowed-symbols si no)
    )

)

; Por seguridad, si el flag de empate esta a si, hacemos que si hay un flag de empate a no se borre
; Esto deberia ser responsabilidad de las reglas que modifican el flag, pero asi nos aseguramos de
; mantener la validez del sistema
(defrule flagASiBorraFlagANo
    ; Esta regla elimina un hecho para mantener la validez del sistema, asi que su prioridad
    ; debe ser 9000 (consultar main.clp para ver la jerarquia de prioridades que uso)
    (declare (salience 9000))

    ; Dos hechos contradictorios. Me quedo con el flag si
    (EmpateInformacion (flag si))
    ?hecho <- (EmpateInformacion (flag no))

    =>

    ; Retiro el no para mantener la validez del sistema
    (retract ?hecho)

)

; Regla para comprobar la validez de esta flag
; No puede ser que tengamos el flag a si y no a la vez
(defrule checkEmpateInformacionEstadoValido

    ; Las reglas que comprueban la validez del estado del sistema siempre tienen esta prioridad
    (declare (salience 7000))

    ; Tenemos el flag en dos valores contradictorios:wq
    (EmpateInformacion (flag si))
    (EmpateInformacion (flag no))

    =>

    (printout t "ERROR! El hecho EmpateInformacion (flag ?flag) no esta en un estado valido" crlf)
    (printout t "  Tenemos dicho flag en si y no a la vez!" crlf)
)

; Representa si al estudiante le gustan o no programar
(deftemplate EstudianteGustaProgramar
    (slot cantidad
        (type SYMBOL)
        (allowed-symbols si no nose)
    )
)

; Representa si al estudiante le gusta o no trabajar directamente con bases de datos
(deftemplate EstudianteGustaBasesDatos
    (slot cantidad
        (type SYMBOL)
        (allowed-symbols si no nose)
    )
)


; Representa si el estudiante esta comodo trabajando con linux, o si le gusta
(deftemplate EstudianteGustaLinux
    (slot cantidad
        (type SYMBOL)
        (allowed-symbols si no nose)
    )
)
