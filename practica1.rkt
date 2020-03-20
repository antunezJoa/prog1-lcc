;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname practica1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/image)

; Ejercicio 1.3.1

;1

(define (gof imagen) (if (>= (image-height imagen) (image-width imagen)) "Flaca" "Gorda" ))

;2

(define (gofoc imagen) (if (= (image-height imagen) (image-width imagen)) "Cuadrada" (if (> (image-height imagen) (image-width imagen)) "Flaca" "Gorda") ))

;3

(define (tresDesiguales? a b c) (and (not(= a b)) (not(= a c)) (not(= c b)) ) )

(define (triangulo? a b c) (if (= a b c) "Equilatero" (if (tresDesiguales? a b c) "Escaleno" "Isosceles")))

;4

(define (triangulo?v2 a b c) (if (= (+ a b c) 180) (if (= a b c) "Equilatero" (if (tresDesiguales? a b c) "Escaleno" "Isosceles")) "Error" ))

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

(define (pitagorica?2 a b c) (if (= (+ (expt a 2) (expt b 2) ) (expt c 2)) #true #false ) )

;8

(define (pitagorica?2v2 a b c) (if (= (+ (expt a 2) (expt b 2) ) (expt c 2)) (string-append "Los numeros " (number->string a) ", " (number->string b) " y " (number->string c) " forman una terna pitagórica.") (string-append "Los numeros " (number->string a) ", " (number->string b) " y " (number->string c) " no forman una terna pitagórica.") ) )

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