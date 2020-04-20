#|
Trabajo Práctico 1: Receta para el diseño

Integrantes:
- Antunez, Joaquin, comisión 1.
- Aseguinolaza, Luis, comisión 1.
|#

; Ejercicio 1

;Representamos a las dimensiones en metros como numeros y al tipo de pintura como un número

;pintura-necesaria-uno: Number Number Number -> Number
;Recibe las 3 dimensiones de la pileta, devuelve la cantidad de litros de pintura de tipo 1 necesaria para pintar la pileta de dichas dimensiones

;pintura-necesaria-dos: Number Number Number -> Number
;Recibe las 3 dimensiones de la pileta, devuelve la cantidad de litros de pintura de tipo 2 necesaria para pintar la pileta de dichas dimensiones

;pintura-necesaria: Number Number Number Number -> Number
;Recibe las 3 dimensiones de la pileta y el tipo de pintura, devuelve la cantidad de litros de pintura necesaria para pintar la pileta de dichas dimensiones

(define 1LT1 16) ; 1Litro Tipo1
(define 1LT2 12) ; 1Litro Tipo2

(define (pintura-necesaria-uno a b c) (/ (+ (* a b) (* (* a c) 2) (* (* b c) 2) ) 1LT1) )

(define (pintura-necesaria-dos a b c) (/ (+ (* a b) (* (* a c) 2) (* (* b c) 2) ) 1LT2) )

(define (pintura-necesaria a b c t) (cond [(= t 1) (pintura-necesaria-uno a b c)] [(= t 2) (pintura-necesaria-dos a b c)]) )

(check-expect (pintura-necesaria 2 3 4 1) 2.875)
(check-expect (pintura-necesaria 3 6 9 2) 15)
(check-expect (pintura-necesaria 2 5 8 1) 7.625)
(check-expect (pintura-necesaria 3 4 6 2) 8)

; Ejercicio 2

;Representamos a las dimensiones en metros como numeros , al tipo de pintura como un número , y a la cantidad de baldes de pintura como un número.

;chequeo-pintura: Number Number Number Number Number -> Number
;Recibe las 3 dimensiones de la pileta, el tipo de pintura y la cantidad de litros de dicha pintura. Devuelve si sobra, alcanza o falta pintura, y de sobrar o faltar, sus respectivas cantidades expresadas en cantidades de baldes.

;comparacion-baldes-litros: Number Number -> String
;Recibe la cantidad de baldes que se disponen y la cantidad de litros de pintura necesarios. Devuelve si sobra, alcanza o falta pintura, y de sobrar o faltar, sus respectivas cantidades expresadas en cantidades de baldes.

(define LxB 2) ; Litros x Balde

(define (chequeo-pintura a b c t cb) (cond [(= t 1) ( comparacion-baldes-litros cb (pintura-necesaria-uno a b c) ) ] [(= t 2) ( comparacion-baldes-litros cb (pintura-necesaria-dos a b c) )]) )

(define (comparacion-baldes-litros b l) ( cond [ ( >= ( - b ( / l LxB) ) 1 )  (string-append "Sobra/n " (number->string(floor ( - b ( / l LxB) ))) " balde/s." )] [ ( < ( - b ( / l LxB) ) 0 )  (string-append "Falta/n " (number->string (ceiling (-( - b ( / l LxB) ) ))) " balde/s.")] [else "Cantidad justa"] ))

(check-expect (chequeo-pintura 2 5 8 2 6) "Cantidad justa")
(check-expect (chequeo-pintura 2 5 8 2 5) "Falta/n 1 balde/s.")
(check-expect (chequeo-pintura 8 8 8 1 12) "Sobra/n 2 balde/s.")
(check-expect (chequeo-pintura 4 5 6 2 0) "Falta/n 6 balde/s.")

; Ejercicio 3

;Como podemos observar, las funciones definidas en el apartado 1 nos fueron útiles para realizar el apartado 2, ya que fueron reutilizadas.
;Si sólo se hubiese pedido diseñar la función del apartado 2, probablemente si hubiese sido útil definir la/s funcion/es, en este caso, del apartado 1.
;Esto es así porque de alguna manera necesitamos obtener los litros de pintura que se vayan a necesitar para pintar dicha pileta, pues es un dato necesario
;para definir la/s funcion/es del apartado 2.
