(require 2htdp/image)

;Primera parte:

; Ejercicio 1.3.1

;1

(define (gof imagen) (if (>= (image-height imagen) (image-width imagen)) "Flaca" "Gorda" ))

;2

(define (gofoc imagen) (if (= (image-height imagen) (image-width imagen)) "Cuadrada" (if (> (image-height imagen) (image-width imagen)) "Flaca" "Gorda") ))

;3

(define (tresDesiguales? a b c) (and (not(= a b)) (not(= a c)) (not(= c b)) ) )

(define (triangulo? a b c) (if (= a b c) "Equilatero" (if (tresDesiguales? a b c) "Escaleno" "Isosceles")))

;4

(define (triangulo?v2 a b c) (if (= (+ a b c) 180) (triangulo? a b c) "Error" ))

;5

(define PC 60)
(define PL 8)

(define PCD (- PC (/ (* PC 10) 100)))
(define PLD (- PL (/ (* PL 15) 100)))

(define (precio c l) (+ (if (>= c 4) (* PCD c) (* PC c) ) (if (>= l 5) (* PLD l) (* PL l) ) ) )

;6

(define (precioSinDesc c l) (+ (* PC c) (* PL l) ) )

(define (preciov2 c l) (if (>= (+ c l) 10) (min (- (precioSinDesc c l) (/ (* (precioSinDesc c l) 18) 100) ) (precio c l) ) (precio c l) ) )

;7

(define (pitagorica?v2 a b c) (if (= (+ (expt a 2) (expt b 2) ) (expt c 2)) #true (if (= (+ (expt b 2) (expt c 2) ) (expt a 2)) #true (if (= (+ (expt c 2) (expt a 2) ) (expt b 2)) #true #false ))))

;8

(define (pitagorica?2v2 a b c) (if (= (+ (expt a 2) (expt b 2) ) (expt c 2)) (string-append "Los numeros " (number->string a) ", " (number->string b) " y " (number->string c) " forman una terna pitagórica.") (if (= (+ (expt b 2) (expt c 2) ) (expt a 2)) (string-append "Los numeros " (number->string a) ", " (number->string b) " y " (number->string c) " forman una terna pitagórica.") (if (= (+ (expt c 2) (expt a 2) ) (expt b 2)) (string-append "Los numeros " (number->string a) ", " (number->string b) " y " (number->string c) " forman una terna pitagórica.") (string-append "Los numeros " (number->string a) ", " (number->string b) " y " (number->string c) " no forman una terna pitagórica.") ) ) ))

;9

(define (collatz n) (if (even? n) (/ n 2) (+ (* 3 n) 1) ))

;Ejercicio 2.1

;a - Perú

(define peru (place-image (rectangle 30 60 "solid" "red") 15 30 (place-image (rectangle 30 60 "solid" "white") 45 30 (place-image (rectangle 30 60 "solid" "red") 75 30 (empty-scene 90 60)))))

;b - Italia

(define italia (place-image (rectangle 30 60 "solid" "green") 15 30 (place-image (rectangle 30 60 "solid" "white") 45 30 (place-image (rectangle 30 60 "solid" "red") 75 30 (empty-scene 90 60)))))

;c

(define (bandera3RectVert color1rect color2rect color3rect) (place-image (rectangle 30 60 "solid" color1rect) 15 30 (place-image (rectangle 30 60 "solid" color2rect) 45 30 (place-image (rectangle 30 60 "solid" color3rect) 75 30 (empty-scene 90 60)))))

;d - Alemania

(define alemania (place-image (rectangle 90 20 "solid" "black") 45 10 (place-image (rectangle 90 20 "solid" "red") 45 30 (place-image (rectangle 90 20 "solid" "yellow") 45 50 (empty-scene 90 60)))))

;e - Holanda

(define holanda (place-image (rectangle 90 20 "solid" "red") 45 10 (place-image (rectangle 90 20 "solid" "white") 45 30 (place-image (rectangle 90 20 "solid" "blue") 45 50 (empty-scene 90 60)))))

;f

(define (bandera3RectHor color1rect color2rect color3rect) (place-image (rectangle 90 20 "solid" color1rect) 45 10 (place-image (rectangle 90 20 "solid" color2rect) 45 30 (place-image (rectangle 90 20 "solid" color3rect) 45 50 (empty-scene 90 60)))))

;g

(define (bandera3Rect sentido color1rect color2rect color3rect) (if (string=? "vertical" sentido) (bandera3RectVert color1rect color2rect color3rect) (bandera3RectHor color1rect color2rect color3rect)))

;h - Bandera de Francia utilizando la funcion definida en el apartado g

(bandera3Rect "vertical" "blue" "white" "red")

;i - Sudan, Argentina, Camerun

(define sudan (place-image (rotate -90 (triangle 60 "solid" "green")) 22.5 30 (bandera3Rect "horizontal" "red" "white" "black")))

(define argentina (place-image (circle 8 "solid" "yellow") 45 30 (bandera3Rect "horizontal" "LightSkyBlue" "white" "LightSkyBlue")))

(define camerun (place-image (star 10 "solid" "yellow") 45 30 (bandera3Rect "vertical" "green" "red" "yellow")))

;j - Brasil

(define brasil (place-image (circle 12.5 "solid" "blue") 45 30 (place-image (rotate -90 (triangle 45 "solid" "yellow")) 62 30 (place-image (rotate 90 (triangle 45 "solid" "yellow")) 28 30 (place-image (rectangle 90 60 "solid" "green") 45 30 (empty-scene 90 60) )))))

;h

(define ANCHO 180)
(define ALTO 120)

;hay que usar las constantes globales 'ancho' y 'alto'
;a la hora de ubicar una imagen en el empty-scene hay que utilizar operaciones con las constantes a la hora de poner los tamaños y las coordenadas de esta imagen a introducir
;cambio solo el de perú porque los demas ni ganas es re largo:

;suponiendo que el doble de grande es hacer el doble del tamaño del ancho y alto del empty-screen inicial de ancho 90 y alto 60, pasamos a ancho 180 y alto 120

(define perux2 (place-image (rectangle (/ ANCHO 3) ALTO "solid" "red") (/ ANCHO 6) (/ ALTO 2) (place-image (rectangle (/ ANCHO 3) ALTO "solid" "white") (/ ANCHO 2) (/ ALTO 2) (place-image (rectangle (/ ANCHO 3) ALTO "solid" "red") (- ANCHO (/ ANCHO 6)) (/ ALTO 2) (empty-scene ANCHO ALTO)))))

;Segunda parte:

; Ejercicio 1.1.1

;1

; (sgn2 (- 2 3)) == (sgn2 -1) == (cond [(< -1 0) -1] [(= -1 0) 0] [(> -1 0) 1]) ==  (cond [#true -1] [(= -1 0) 0] [(> -1 0) 1]) == -1

; (sgn2 6) == (cond [(< 6 0) -1] [(= 6 0) 0] [(> 6 0) 1]) == (cond [#false -1] [(= 6 0) 0] [(> 6 0) 1]) == (cond [(= 6 0) 0] [(> 6 0) 1]) ==  (cond [#false 0] [(> 6 0) 1]) == (cond [(> 6 0) 1]) == (cond [#true 1]) == 1

;2.2

(define (gofocv2 imagen) (cond [(= (image-height imagen) (image-width imagen)) "Cuadrada"][(> (image-height imagen) (image-width imagen)) "Flaca"][(< (image-height imagen) (image-width imagen)) "Gorda"]))

;2.4

(define (soloDosIguales? a b c) (cond [(= a b c) #f] [(tresDesiguales? a b c) #f] [(or (= a b) (= a c) (= c b) ) #t]))

(define (triangulo?v3 a b c) (cond [(not(= (+ a b c) 180)) "Error"] [(tresDesiguales? a b c) "Escaleno"] [(= a b c) "Equilatero"] [(soloDosIguales? a b c) "Isosceles"]) )

;2.6

(define (precio_cond c l) (+ (cond [(>= c 4) (* PCD c)] [(< c 4) (* PC c)] ) (cond [(>= l 5) (* PLD l)] [(< l 5) (* PL l)]) ) )

(define (preciov2_cond c l) (cond [(>= (+ c l) 10) (min (- (precioSinDesc c l) (/ (* (precioSinDesc c l) 18) 100) ) (preciov2 c l) )] [(< (+ c l) 10) (preciov2 c l)]) )

;2.7

(define (pitagorica?v2_cond a b c) (cond [(= (+ (expt a 2) (expt b 2) ) (expt c 2)) #t] [(= (+ (expt b 2) (expt c 2) ) (expt a 2)) #t] [(= (+ (expt c 2) (expt a 2) ) (expt b 2)) #t] [else #f]) )

;3

;(pitagorica?v2_cond 3 5 6) == #false

;(pitagorica?v2_cond 3 5 4) == #true

;4

;ancho alto

(define (gofoc_cond imagen) (cond [(<= (* 2 (image-height imagen)) (image-width imagen)) "Muy gorda"]
                                  [(<= (* 2 (image-width imagen)) (image-height imagen)) "Muy flaca"]
                                  [(= (image-height imagen) (image-width imagen)) "Cuadrada"]
                                  [(> (image-height imagen) (image-width imagen)) "Flaca"]
                                  [(< (image-height imagen) (image-width imagen)) "Gorda"]))

;5

(define (clasificar t) (cond [(< t 0) "Perder 3 finales seguidas"]
                             [(and (> t 0) (< t 15)) "Frío (F)"]
                             [(and (> t 15) (< t 25)) "Agradable (A)"]
                             [(> t 25) "El mas grande del interior"]))

#|

(clasificar -3)

==

(cond [(< -3 0) "Perder 3 finales seguidas"]
      [(and (> -3 0) (< -3 15)) "Frío (F)"]
      [(and (> -3 15) (< -3 25)) "Agradable (A)"]
      [(> -3 25) "El mas grande del interior"])

==

(cond [#true "Perder 3 finales seguidas"]
      [(and (> -3 0) (< -3 15)) "Frío (F)"]
      [(and (> -3 15) (< -3 25)) "Agradable (A)"]
      [(> -3 25) "El mas grande del interior"])

==

"Perder tres finales seguidas"

-------------------------------------------------

(clasificar 12)

==

(cond [(< 12 0) "Perder 3 finales seguidas"]
      [(and (> 12 0) (< 12 15)) "Frío (F)"]
      [(and (> 12 15) (< 12 25)) "Agradable (A)"]
      [(> 12 25) "El mas grande del interior"])

==

(cond [#false "Perder 3 finales seguidas"]
      [(and (> 12 0) (< 12 15)) "Frío (F)"]
      [(and (> 12 15) (< 12 25)) "Agradable (A)"]
      [(> 12 25) "El mas grande del interior"])

==

(cond [(and (> 12 0) (< 12 15)) "Frío (F)"]
      [(and (> 12 15) (< 12 25)) "Agradable (A)"]
      [(> 12 25) "El mas grande del interior"])

==

(cond [#true "Frío (F)"]
      [(and (> 12 15) (< 12 25)) "Agradable (A)"]
      [(> 12 25) "El mas grande del interior"])

==

"Frío (F)"

-------------------------------------------------

(clasificar 28)

==

(cond [(< 28 0) "Perder 3 finales seguidas"]
      [(and (> 28 0) (< 28 15)) "Frío (F)"]
      [(and (> 28 15) (< 28 25)) "Agradable (A)"]
      [(> 28 25) "El mas grande del interior"])

==

(cond [#false "Perder 3 finales seguidas"]
      [(and (> 28 0) (< 28 15)) "Frío (F)"]
      [(and (> 28 15) (< 28 25)) "Agradable (A)"]
      [(> 28 25) "El mas grande del interior"])

==

(cond [(and (> 28 0) (< 28 15)) "Frío (F)"]
      [(and (> 28 15) (< 28 25)) "Agradable (A)"]
      [(> 28 25) "El mas grande del interior"])

==

(cond [#false "Frío (F)"]
      [(and (> 28 15) (< 28 25)) "Agradable (A)"]
      [(> 28 25) "El mas grande del interior"])

==

(cond [(and (> 28 15) (< 28 25)) "Agradable (A)"]
      [(> 28 25) "El mas grande del interior"])

==

(cond [#false "Agradable (A)"]
      [(> 28 25) "El mas grande del interior"])

==

(cond [(> 28 25) "El mas grande del interior"])

==

(cond [#true "El mas grande del interior"])

==

"El mas grande del interior"

-----------------------------------------------

Lo que sucede con la expresion (clasificar 15) es que el valor 15 no es tenido en cuenta en las condiciones del programa, al poner (< t 15) y (> t 15) no esta comprendido el 15.
Lo mismo sucede con el 0 y el 25.

|#

(define (clasificarv2 t) (cond [(< t 0) "Perder 3 finales seguidas"]
                             [(and (>= t 0) (< t 15)) "Frío (F)"]
                             [(and (>= t 15) (< t 25)) "Agradable (A)"]
                             [(>= t 25) "El mas grande del interior"]))

;6, 7, 8, 9

(define (sgn2 x) (cond [(< x 0) -1]
                       [(= x 0) 0]
                       [(> x 0) 1]))

(define (booltonumber b) (cond [ (and #t b) 1] [else 0]) )

(define (imageTypeToNumber imagen) (cond [(equal? (gofoc imagen) "Flaca") -1] [(equal? (gofoc imagen) "Cuadrada") 0] [(equal? (gofoc imagen) "Gorda") 1]) )

(define (stringConvertible? s) (cond [(number? (string->number s)) #t] [(boolean? (string->number s)) #f]) )

(define (sgn3 x) (cond [(number? x) (sgn2 x)]
                       [(string? x) (if (stringConvertible? x) (sgn2 (string->number x)) "La cadena no se puede convertir a string")]
                       [(boolean? x) (sgn2 (booltonumber x ))]
                       [(image? x) (sgn2 (imageTypeToNumber x ))]
                       [else "Clase no soportada por la funcion"]))