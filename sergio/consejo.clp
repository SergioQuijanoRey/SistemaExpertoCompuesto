; Modulo en el que definimos reglas para trabajar con las reglas de los consejos
; Un consejo viene dado en la forma:
; (Consejo <nombre de la rama> "<texto del motivo>")

; COMPROBACIONES DE SEGURIDAD
;===================================================================================================

; Usamos esta regla para comprobar que un consejo sobre una rama se refiere a una rama que tengamos
; almacenada en el sistema
(defrule checkConsejoTieneRamaValida

    ; Las reglas que comprueban la validez del estado del sistema siempre tienen esta prioridad
    (declare (salience 7000))

    ; Estamos en el modulo de Sergio
    (ModuloConversacion (modulo sergio))

    (Consejo ?rama ?texto)
    (not (Rama ?rama))

    =>

    (printout t "ERROR! La rama que especifica un consejo no es valida!" crlf)
    (printout t "  Consejo " ?rama " '" ?texto "'" crlf)
)
