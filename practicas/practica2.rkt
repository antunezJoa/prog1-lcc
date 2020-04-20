;Ejercicio 1

;Representamos las distancias (coordenadas) como números

;distancia-origen: Number Number -> Number
;Recibe dos numeros que representan las coordenadas x e y de un punto y devuelve la distancia entre dicho punto y el origen

;entrada 3 4, salida 5
;entrada 5 12, salida 13
;entrada 7 24, salida 25

(define (distancia-origen x y) (sqrt (+ (expt x 2) (expt y 2) ) ) )

(check-expect (distancia-origen 3 4) 5)
(check-expect (distancia-origen 5 12) 13)
(check-expect (distancia-origen 7 24) 25)

;Ejercicio 2

;Representamos las distancias (coordenadas) como números

;distancia-puntos Number Number Number Number -> Number
;Recibe cuatro numeros que representan las coordenadas x e y de dos puntos y devuelve la distancia entre dichos puntos

;entrada 0 0 3 4, salida 5
;entrada 2 2 7 14, salida 13
;entrada 5 6 12 30, salida 25

(define (distancia-puntos x1 y1 x2 y2) (sqrt (+ (expt (- x2 x1 ) 2) (expt (- y2 y1 ) 2) ) ) )

(check-expect (distancia-puntos 0 0 3 4) 5)
(check-expect (distancia-puntos 2 2 7 14) 13)
(check-expect (distancia-puntos 5 6 12 30) 25)

;Ejercicio 3

;Representamos la arista del cubo como un número

;vol-cubo: Number -> Number
;Recibe un numero que representa la arista de un cubo y devuelve el volúmen de dicho cubo

;entrada 2, salida 8
;entrada 6, salida 216
;entrada 10, salida 1000

(define (vol-cubo a) (expt a 3))

(check-expect (vol-cubo 2) 8)
(check-expect (vol-cubo 6) 216)
(check-expect (vol-cubo 10) 1000)

;Ejercicio 4

;Representamos la arista del cubo como un número

;area-cubo: Number -> Number
;Recibe un numero que representa la arista de un cubo y devuelve el área de dicho cubo

;entrada 2, salida 24
;entrada 6, salida 216
;entrada 10, salida 600

(define (area-cubo a) (* (expt a 2) 6))

(check-expect (area-cubo 2) 24)
(check-expect (area-cubo 6) 216)
(check-expect (area-cubo 10) 600)

;Ejercicio 5

;Representamos a la frase o palabra como un string y a la posicion como un número

;string-insert: String Number -> String
;Recibe un string y un numero y devuelve un string con un - insertado en la posicion del string inicial representada por el número

;entrada "hola" 2, salida "ho-la"
;entrada "ivansuli" 4, salida "ivan-suli"
;entrada "djgorilla" 2, salida "dj-gorilla"

(define (string-insert s i) (string-append (substring s 0 i) "-" (substring s i (string-length s) ) ) )

(check-expect (string-insert "hola" 2) "ho-la")
(check-expect (string-insert "ivansuli" 4) "ivan-suli")
(check-expect (string-insert "djgorilla" 2) "dj-gorilla")

;Ejercicio 6

;Representamos a la frase o palabra como un string, y a al caracter obtenido como un string

;string-last: String -> String
;Recibe una cadena no vacia y devuelve su último caracter

;entrada "ivansuli", salida "i"
;entrada "la flame", salida "e"
;entrada "skr skr", salida "r"

(define (string-last s) (substring s (- (string-length s) 1) (string-length s) ))
(define (string-lastv2 s) (if ( = (string-length s) 0) "La cadena es vacia" (substring s (- (string-length s) 1) (string-length s) )))

(check-expect (string-lastv2 "ivansuli") "i")
(check-expect (string-lastv2 "la flame") "e")
(check-expect (string-lastv2 "skr skr") "r")
(check-expect (string-lastv2 "") "La cadena es vacia")

;Ejercicio 7
;Representamos a las frases o palabras como strings

;string-remove-last: String -> String
;Recibe una cadena de caracteres, devuelve la misma cadena de caracteres sin su último caracter

;entrada "ivansolex", salida "ivansole"
;entrada "totex", salida "tote"
;entrada "cueivoo", salida "cueivo"

(define (string-remove-last s) (substring s 0 (- (string-length s) 1) ) )

(check-expect (string-remove-last "ivansolex") "ivansole")
(check-expect (string-remove-last "totex") "tote")
(check-expect (string-remove-last "cueivoo") "cueivo")

;Ejercicio 9
;Representamos a las cantidades y porcentajes como numeros

;porcentaje: Number -> Number
;Recibe un numero que representa el porcentaje a calcular y luego restar por sobre la cuota definida en una constante

;desc-persona: Number -> Number
;Recibe un numero que representa cantidad de personas y devuelve el numero que representa porcentaje de descuento que les corresponde

;desc-meses: Number -> Number
;Recibe un numero que representa cantidad de meses a pagar juntos y devuelve el numero que representa porcentaje de descuento que les corresponde

;monto-persona: Number Number -> Number
;Recibe un numero que representa personas y otro numero que representa meses, luego devuelve cuanto dinero cada uno tienen que pagar esas personas (dichas cantidades de dinero son iguales)

;entrada 2 2, salida 975
;entrada 3 3, salida 1267.5
;entrada 1 5, salida 2437.5

(define CUOTA 650)
(define DOSP 10)
(define TRESOMASP 20)
(define DOSM 15)
(define TRESOMASM 25)
(define MAX 35)

(define (porcentaje p) (- CUOTA (/ (* CUOTA p) 100) ) )

(define (desc-persona cp) (cond [(= cp 1) 0] [(= cp 2) DOSP] [(>= cp 3) TRESOMASP]) )

(define (desc-meses cm) (cond [(= cm 1) 0] [(= cm 2) DOSM] [(>= cm 3) TRESOMASM]) )

(define (monto-persona cp cm) ( if (> (+ (desc-persona cp) (desc-meses cm) ) MAX) (* (porcentaje MAX) cm) (* (porcentaje (+ (desc-persona cp) (desc-meses cm) ) ) cm) ) )

(check-expect (monto-persona 2 2) 975)
(check-expect (monto-persona 3 3) 1267.5)
(check-expect (monto-persona 1 5) 2437.5)

;Ejercicio 10
;Representamos la edad en meses y el nivel de hemoglobina en sangre como números

;niveles: Number -> Number
;Recibe un numero que representa la edad de una persona en meses y devuelve el valor minimo de hemoglobina en sangre normal

;anemia: Number Number -> Boolean
;Recibe dos numeros que representan la edad de una persona en meses y su nivel de hemoglobina en sangre, y devuelve un booleano que representa si dicha persona tiene o no anemia

;entrada 4 8, salida #true
;entrada 20 12, salida #false
;entrada 70 10, salida #true
;entrada 200 15, salida #false

(define (niveles edad) (cond [(<= edad 1) 13] [(and (> edad 1) (<= edad 6) ) 10] [(and (> edad 6) (<= edad 12) ) 11] [(and (> edad 12) (<= edad 60) ) 11.5] [(and (> edad 60) (<= edad 120) ) 12.6] [(> edad 120) 13]) )

(define (anemia edad hemo) (if (< hemo (niveles edad)) #true #false ) )

(check-expect (anemia 4 8) #true)
(check-expect (anemia 20 12) #false)
(check-expect (anemia 70 10) #true)
(check-expect (anemia 200 15) #false)

;Ejercicio 11
;Representamos a los números como números

;autopromediable?: Number Number Number -> Boolean
;Recibe los tres numeros que forman la terna y devuelve un booleano que indica si la terna es autopromediable o no

;autopromediable: Number Number Number -> Number
;Recibe los tres numeros que forman la terna y de acuerdo a si es una terna autopromediable o no realiza el producto o la suma de dichos numeros

;entrada 7 5 9, salida 315
;entrada 6 6 6, salida 216
;entrada 8 5 6, salida 19

(define (autopromediable? a b c) (cond [(= (/ (+ a b) 2) c) #true] [(= (/ (+ a c) 2) b) #true] [(= (/ (+ c b) 2) a) #true] [else #false]) )

(define (autopromediable a b c) (if (autopromediable? a b c) (* a b c) (+ a b c) ) )

(check-expect (autopromediable 7 5 9) 315)
(check-expect (autopromediable 6 6 6) 216)
(check-expect (autopromediable 8 5 6) 19)

;Ejercicio 12
;Representamos a la cantidad en litros como números y la clase del combustible tambien como un  número (2 o 3)

;autonomia-ciudad-clase-dos: Number -> String
;Recibe un numero que corresponde a la cantidad de litros restantes en el tanque y devuelve un numero que indica la autonomía del auto en ciudad para un combustible de grado 2

;autonomia-ruta-clase-dos: Number -> String
;Recibe un numero que corresponde a la cantidad de litros restantes en el tanque y devuelve un numero que indica la autonomía del auto en ruta para un combustible de grado 3

;autonomia-ciudad-clase-tres: Number -> String
;Recibe un numero que corresponde a la cantidad de litros restantes en el tanque y devuelve un numero que indica la autonomía del auto en ciudad para un combustible de grado 2

;autonomia-ruta-clase-tres: Number -> String
;Recibe un numero que corresponde a la cantidad de litros restantes en el tanque y devuelve un numero que indica la autonomía del auto en ruta para un combustible de grado 3

;autonomia: Number Number -> String
;Recibe dos numeros que corresponden a la cantidad de litros restantes en el tanque y la clase (grado) del combustible, devuelve un string que indica la autonomía del auto en ciudad y en ruta

;entrada 20 2, salida "Autonomía en ciudad: 160km. Autonomía en ruta: 220km."
;entrada 20 3, salida "Autonomía en ciudad: 176km. Autonomía en ruta: 242km."
;entrada 15 3, salida "Autonomía en ciudad: 132km. Autonomía en ruta: 181.5km."
;entrada 30 2, salida "Autonomía en ciudad: 240km. Autonomía en ruta: 330km."

(define 1LCG2 8)
(define 1LRG2 11)
(define 1LCG3 (+ 1LCG2 (/ (* 1LCG2 10) 100) ))
(define 1LRG3 (+ 1LRG2 (/ (* 1LRG2 10) 100) ))

(define (autonomia-ciudad-clase-dos litros) (number->string (* litros 1LCG2)) )

(define (autonomia-ruta-clase-dos litros) (number->string (* litros 1LRG2)) )

(define (autonomia-ciudad-clase-tres litros) (number->string (* litros 1LCG3)) )

(define (autonomia-ruta-clase-tres litros) (number->string (* litros 1LRG3)) )

(define (autonomia litros grado) (cond [(= grado 2) (string-append "Autonomía en ciudad: " (autonomia-ciudad-clase-dos litros) "km. Autonomía en ruta: " (autonomia-ruta-clase-dos litros) "km.")] [(= grado 3) (string-append "Autonomía en ciudad: " (autonomia-ciudad-clase-tres litros) "km. Autonomía en ruta: " (autonomia-ruta-clase-tres litros) "km.")]) )

(check-expect (autonomia 20 2) "Autonomía en ciudad: 160km. Autonomía en ruta: 220km.")
(check-expect (autonomia 20 3) "Autonomía en ciudad: 176km. Autonomía en ruta: 242km.")
(check-expect (autonomia 30 3) "Autonomía en ciudad: 264km. Autonomía en ruta: 363km.")
(check-expect (autonomia 30 2) "Autonomía en ciudad: 240km. Autonomía en ruta: 330km.")
