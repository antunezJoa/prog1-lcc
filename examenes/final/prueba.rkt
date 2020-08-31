;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname prueba) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct circulo [x y color])
; circulo es (Number, Number, String)
; Intepretación: El primer elemento es la posicion horizontal del circulo,
; el segundo elemento es la posicion vertical del circulo,
; el tercer elemento determina el color del circulo.

;CONSTANTES:

;ancho y alto
(define ANCHO 200)
(define ALTO (/ ANCHO 2))

;color
(define COLOR "black")

;forma
(define FORMA "solid")

;radio del círculo
(define RADIO 25)

;objeto
(define OBJETO (circle RADIO FORMA COLOR))

;escena
(define ESCENA (empty-scene ANCHO ALTO))

; delta: unidades que se mueve el objeto por cada tecla pulsada seguan sea left o right
(define DELTA 5)

;estado inicial
(define INICIAL (make-circulo RADIO (/ ALTO 2) COLOR))

;FUNCIONES:

;dibujar : Estado -> Image
;dado un estado s, dibuja un círculo centrado horizontalmente, cuya posición sobre el eje vertical está determinada por el estado actual y
(define (dibujar s)
 (place-image OBJETO (circulo-x s) (circulo-y s) ESCENA))

; manejarTecladov3: Estado String -> Estado
; dado el estado actual s y una tecla k, calcula el siguiente estado según:
; - "left"  : decrementa el estado DELTA unidades horizontalmente
; - "right": incrementa el estado DELTA unidades horizontalmente
(check-expect (manejarTecladov3 INICIAL "left") (make-circulo (- (circulo-x INICIAL) DELTA) (circulo-y INICIAL) COLOR))
(check-expect (manejarTecladov3 INICIAL "right") (make-circulo  (+ (circulo-x INICIAL) DELTA) (circulo-y INICIAL) COLOR))
(define (manejarTecladov3 s k) (cond [(key=? k "right") (make-circulo (+ (circulo-x s) DELTA) (circulo-y s) (circulo-color s))]
                                     [(key=? k "left") (make-circulo (- (circulo-x s) DELTA) (circulo-y s) (circulo-color s))]
                                     [else s]))

; limites : Estado -> Estado
; dado el estado actual asegura que el siguiente estado no se sobrepasa de los límites de la escena
; si la posicion horizontal (x) siguiente es menor a RADIO, devuelve RADIO
; si la posicion horizontal (x) siguiente es mayor a ANCHO - RADIO, devuelve ANCHO - RADIO
(check-expect (limites (make-circulo RADIO RADIO COLOR)) (make-circulo RADIO RADIO COLOR))
(check-expect (limites INICIAL) INICIAL)
(define (limites s) (cond [(< (circulo-x s) RADIO) (make-circulo RADIO (circulo-y s) (circulo-color s))]
                          [(> (circulo-x s) (- ANCHO RADIO)) (make-circulo (- ANCHO RADIO) (circulo-y s) (circulo-color s))]
                          [else s]))

; manejarTecladov3.1 : Estado String -> Estado
; dado el estado actual s y una tecla k, calcula el siguiente estado según:
; - "left"  : decrementa el estado DELTA unidades horizontalmente
; - "right" : incrementa el estado DELTA unidades horizontalmente
; sin dejar que el círculo desaparezca de la escena
(check-expect (manejarTecladov3.1 (make-circulo (- ANCHO RADIO) (circulo-y INICIAL) COLOR) "right") (make-circulo (- ANCHO RADIO) (circulo-y INICIAL) COLOR))
(check-expect (manejarTecladov3.1 INICIAL "left") INICIAL)
(define (manejarTecladov3.1 s k)
  (limites (manejarTecladov3 s k)))

(big-bang INICIAL                     ; estado inicial del programa
          [to-draw dibujar]           ; dibuja en la pantalla el círculo en el estado actual
          [on-key manejarTecladov3.1] ; cuando se presiona una tecla, la funcion manejarTecladov3 se invoca para manejar el teclado
)