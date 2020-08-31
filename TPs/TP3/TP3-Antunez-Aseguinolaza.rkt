;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname TP3-Antunez-Aseguinolaza) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#|
Trabajo Práctico 3: Estructuras

Integrantes:
- Antunez, Joaquin, comisión 1.
- Aseguinolaza, Luis, comisión 1.
|#

;Ejercicio 1

(define-struct circunferencia [x y radio])
; circunferencia es (Number, Number, Number)
; Interpretación: El primer elemento es un número que representa la coordenada horizontal del punto,
; el segundo elemento es un número que representa la coordenada vertical del punto,
; el tercer elemento representa la longitud de su radio.

;Ejercicio 2

; distanciaCentros : circunferencia circunferencia -> Number
; dadas dos estructuras de tipo circunferencia, calcula y retorna la distancia entre sus centros.
(check-expect (distanciaCentros (make-circunferencia 5 6 5) (make-circunferencia 8 10 8)) 5)
(check-expect (distanciaCentros (make-circunferencia 8 10 5) (make-circunferencia 5 6 8)) 5)
(define (distanciaCentros c1 c2)
  (sqrt (+ (expt (- (max (circunferencia-x c1) (circunferencia-x c2) ) (min (circunferencia-x c1) (circunferencia-x c2) ) ) 2) (expt (- (max (circunferencia-y c1) (circunferencia-y c2) ) (min (circunferencia-y c1) (circunferencia-y c2) ) ) 2) )))

; tangentes-exteriores? : circunferencia circunferencia -> Boolean
; dadas dos estructuras de tipo circunferencia, devuelve #true si las mismas son tangentes exteriores,
; #false en caso contrario.
; dos circunferencias van a ser tangentes exteriores cuando la distancia entre sus centros sea igual a la suma de sus radios.
(check-expect (tangentes-exteriores? (make-circunferencia 5 6 2.5) (make-circunferencia 8 10 2.5)) #true)
(check-expect (tangentes-exteriores? (make-circunferencia 5 6 5) (make-circunferencia 8 10 8)) #false)
(define (tangentes-exteriores? c1 c2)
  (= (distanciaCentros c1 c2) (+ (circunferencia-radio c1) (circunferencia-radio c2))))

;Ejercicio 3

; crear-tangente-exterior : circunferencia Number -> circunferencia
; dadas una estructura de tipo circunferencia y un número entero mayor a 0, devuleve otra circunferencia que verifica:
; - C y C’ son tangentes exteriores,
; - el radio de C’ es n veces el radio de C,
; - las coordenadas y de los centros de C y C’ son iguales,
; - la coordenada x del centro de C’ es mayor a la coordenada x del centro de C.
(check-expect (crear-tangente-exterior (make-circunferencia 1 1 1) 1) (make-circunferencia 3 1 1))
(check-expect (crear-tangente-exterior (make-circunferencia 25 30 5) 3) (make-circunferencia 45 30 15))
(define (crear-tangente-exterior c n)
  (make-circunferencia  (+ (+ (circunferencia-x c) (circunferencia-radio c)) (* (circunferencia-radio c) n)) (circunferencia-y c) (* (circunferencia-radio c) n)))

; EXTRA: definimos una constante y un par de funciones para poder visualizar graficamente las circunferencias

(define cir (make-circunferencia 25 30 5)) ; definimos una circunferencia cualquiera

; dibujar : circunferencia Image -> Image
; dadas una circunferencia y una imagen (fondo), dibuja la circunferencia en dicho fondo
(define (dibujar c esc)
  (place-image (circle (circunferencia-radio c) "outline" "red") (circunferencia-x c) (circunferencia-y c) esc))

; mostrar : circunferencia circunferencia -> Image
; dadas dos circunferencias, devuelve una imagen que contiene a ambas dibujadas
(define (mostrar c1 c2)
  (dibujar c2 (dibujar c1 (empty-scene (+ (+ (circunferencia-x c2) (circunferencia-radio c2))(- (circunferencia-x c1) (circunferencia-radio c1))) (+ (+ (circunferencia-y c2) (circunferencia-radio c2))(- (circunferencia-y c2) (circunferencia-radio c2)))))))

(mostrar cir (crear-tangente-exterior cir 15)) ; mostramos las circunferencias
(tangentes-exteriores? cir (crear-tangente-exterior cir 3)) ; verificamos que las circunferencias sean efectivamente tangentes exteriores