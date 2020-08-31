;Ejercicio 2.1.a

(-(* 12 5)(* 7 6))

(+(-(* 3 5)(* 7 (/ 4 14)))(/ 3 1))

(+(cos 0.8)(/ 1 5)(* (sin 0.8) 3.5))

;Ejercicio 2.1.b

;(-(* 12 5)(* 7 6)) = (- 60 42) = 18

;(+(-(* 3 5)(* 7 (/ 4 14)))(/ 3 1)) = (+(- 15 2) 3) = (+ 13 3) = 16

;(+(cos 0.8)(/ 1 5)(* (sin 0.8) 3.5)) = (+ 0.6967 0.2 (* 0.71735 3.5)) = (+ 0.6967 0.2 2.5107) = 3.407453027495495

;Ejercicio 2.1.c

(* (+ 2 3) 4)

;Ejercicio 2.2

(/ 1 (sin ( sqrt 3))) ; = (/ 1 (sin  #i1.7320508075688772)) = (/ 1 #i0.9870266449903538) = #i1.0131438751684085

(* (sqrt 2) (sin pi)) ; = (* #i1.4142135623730951 (sin pi)) = ( #i1.4142135623730951 (sin  #i3.141592653589793)) = (* #i1.4142135623730951 #i1.2246467991473532e-16) = #i1.7319121124709868e-16

(+ 3 ( sqrt (- 4))) ; = (+ 3 (sqrt -4)) = (+ 3 0+2i) = 3+2i

(* (sqrt 5) (sqrt (/ 3 (cos pi)))); = (* #i2.23606797749979 (sqrt  (/ 3 (cos pi)))) = (* #i2.23606797749979 (sqrt  (/   3   (cos    #i3.141592653589793)))) = (* #i2.23606797749979 (sqrt (/ 3 #i-1.0))) = (* #i2.23606797749979 (sqrt #i-3.0)) = (* #i2.23606797749979 #i0+1.7320508075688772i) = #i0+3.872983346207417i

;(/ (sqrt 5) (sin (* 3 0))) = Error, divide por 0

;(/ (+ 3) (* 2 4)) = Error, la funcion + espera minimo 2 argumentos y recibe solo 1

(* 1 2 3 4 5 6 7 8) ; = 40320

(/ 120 2 3 2 2 5) ; = 1

;Ejercicio 2.3

(log e)
(log 10)
(tan 0.5)
(expt 2 2)
(random 100) ;devuelve un numero natural al azar menor que 100
(max 1 2 3 47 6)
(min 5 6 45 9 1)
(floor 26.6)
(floor 26.1)
(ceiling 26.1)
(ceiling 26.8)
(abs -6)
(abs 6)

;Ejercicio 3.1

(string-append "hola" "mundo") ; = "holamundo"

(string-append "Pro" "gra" "ma.") ; = "Programa."

(number->string 1357) ; = "1357"

;(string-append "La respuesta es " (+ 21 21)) ; Error de tipo en el segundo argumento

(string-append "La respuesta es " (number->string (+ 21 21))) ; = (string-append "La respuesta es " (number->string 42)) = (string-append "La respuesta es " "42") = "La respuesta es 42"

(* (string-length "Hola") (string-length "Chau")) ; = (* 4 4) = 16

(string-ith "Cholex" 1)

(string-append "Alejo " (substring "Cholex" 0 4))

;Ejercicio 4.2.1

(not #t) ; = #f

(or #t #f) ; = #t

(and #t #f) ; = #f

(and #t (or #f (not #f)) (not #t)) ; = (and #t (or #f #t) (not #t)) = (and #t #t (not #t)) =  (and #t #t #f) = #f

(not (= 2 (* 1 3))) ; = (not (= 2 3)) = (not #f) = #t

(or (= 2 (* 1 3)) (< 4 (+ 3 2))) ; = (or (= 2 3) (< 4 (+ 3 2))) = (or #f (< 4 (+ 3 2))) = (or #f (< 4 5)) = (or #f #t) = #t

; Ejercicio 4.2.2

#| a- El coseno de 0 es positivo |# (> (cos 0) 0) ; = (> 1 0) = #t

#| b- La longitud de la cadena "Hola, mundo" es 14 |# (= (string-length "Hola, mundo") 14) ; = (= 11 14) = #f 

#| c- pi es un numero entre 3 y 4 |# (and (< pi 4) (> pi 3)); = (and #t (> pi 3)) = (and #t #t) = #t

#| d- El area de un cuadrado de lado 5 es igual a la raíz cuadrada de 265 |# (= (* 5 5) (sqrt 625)) ; = (= 25 (sqrt 625)) =  (= 25 25) = #t

;Ejercicio 5.1

(circle 10 "solid" "red")

(rectangle 10 20 "solid" "blue")

(rectangle 20 12 "outline" "magenta")

(overlay (rectangle 20 20 "outline" "blue") (circle 50 "solid" "green"))

(empty-scene 100 100)

(place-image (circle 10 "solid" "blue") 40 80 (empty-scene 100 100))

(image-width (circle 10 "solid" "red"))

(+ (image-width (circle 10 "solid" "red")) (image-width (rectangle 10 20 "solid" "blue")))

;Ejercicio 6.2

(define (f x) (+ x 1))

(define (doble x) (* x 2))

(define (cuad-azul x) (square x "solid" "blue"))

(define (h x y) (< x (doble y)))

#| 1 |# (cuad-azul (doble 10)) ; = (cuad-azul (* 10 2)) =  (cuad-azul 20) = square 20 "solid" "blue" = un cuadradito

(and (h 2 3) (h 3 4)) ; = (and (< 2 (doble 3) (h 3 4)) = (and (< 2 (* 3 2) (h 3 4)) = (and (< 2 6) (h 3 4)) = (and #t (h 3 4)) = (and #t (< 3 (doble 4))) = (and #t (< 3 (* 4 2))) = (and #t (< 3 8)) =  (and #t #t) = #t

(= (f 1) (doble 1)) ; = (= (+ 1 1) (doble 1)) = (= 2 (doble 1)) = (= 2 (* 1 2)) = (= 2 2) = #t

#| 2 |#

(define (pitagoras x y) (sqrt (+ (expt x 2) (expt y 2))))

(define (distancia-origen x y) (pitagoras x y))

#| 3 |#

(define (distancia-puntos x1 y1 x2 y2) (pitagoras (- x2 x1) (- y2 y1)))

#| 4 |#

(define (volumen-cubo x) (expt x 3))

#| 5 |#

(define (area-cubo x) (* 6 (expt x 2)))

#| 6 |#

(define (metro-pie x) (/ x 3.28))

#| 7 |#

(define (cel-far x) (+ 32 (* x 1.8)))

#| 8 |#

(define (posible? a b c) (and (> (+ a b) c) (> (+ a c) b) (> (+ c b) a) ) )

#| 9 |#

(define (pitagorica? a b c) (= (+ (expt a 2) (expt b 2) ) (expt c 2)) ) ; siendo c el valor que tomaria la hipotenusa

#| 10 |#

(define (suma-long x y) (+ (string-length x) (string-length y) ) )

#| 11 |#

(define (comienzaA? x) (string=? "A" (string-ith x 0) ))

#| 12 |#

(define (poner- s i) (string-append (substring s 0 i) "-" (substring s i (string-length s) ) ) )

