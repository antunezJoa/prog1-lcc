;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname TP2-Antunez-Aseguinolaza) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
Trabajo Práctico 2: Programas Interactivos

Integrantes:
- Antunez, Joaquin, comisión 1.
- Aseguinolaza, Luis, comisión 1.
|#

(require 2htdp/image)
(require 2htdp/universe)

; El estado del programa es un número perteneciente al intervalo cerrado [0,100] que determina:
; - el texto a imprimir en pantalla
; - la posición horizontal
; - el color de dicho texto

;CONSTANTES:

(define ANCHO 600) ; ancho de la escena
(define ALTO 120) ; alto de la escena
(define COLOR_ESC "white") ; color de la escena
(define ESCENA (empty-scene ANCHO ALTO COLOR_ESC)) ; escena

(define INICIAL 50) ; estado inicial

(define FONT_SIZE 20) ; tamaño de la fuente del texto a imprimir en pantalla
(define COLOR_PAR "blue") ; color que le corresponde al numero en caso de ser par
(define COLOR_IMPAR "red") ; color que le corresponde al numero en caso de ser impar

(define TIEMPO 2) ; cada 2 segundos se debe actualizar el estado

(define MAXN 100) ; límite por derecha del intervalo de numeros pedidos
(define MINN 0) ; límite por izquierda del intervalo de numeros pedidos

(define OFFSET FONT_SIZE) ; espacio a dejar en ambos lados de la escena para que los numeros entren en pantalla
(define ESPACIO (/ (- ANCHO (* OFFSET 2)) 100)); tamaño del salto disponible (graficamente) entre numeros

;FUNCIONES:

; paridad : Estado -> String
; dado un estado actual s devuelve un string según:
; - si el estado es un numero par, devuelve "blue"
; - si el estado es un numero impar, devuelve "red"
(check-expect (paridad 0) "blue")
(check-expect (paridad 5) "red")
(check-expect (paridad 99) COLOR_IMPAR)
(define (paridad x)
  (if (even? x) COLOR_PAR COLOR_IMPAR))

; pantalla : Estado -> Image
; dado un estado s lo imprime en pantalla 
(define (pantalla s)
  (place-image (text (number->string s) FONT_SIZE (paridad s) )
               (+ (* s ESPACIO) OFFSET)
               (/ ALTO 2)
               ESCENA)
  )

; mult8? : Estado -> Boolean
; dado un estado actual s dice si el programa debe terminar de acuerdo a
; si el estado es múltiplo de 8
(check-expect (mult8? 8) #true)
(check-expect (mult8? 59) #false)
(check-expect (mult8? 16) #true)
(check-expect (mult8? 63) #false)
(define (mult8? s)
  (if (zero? (modulo s 8)) #true #false))

; randomRango : Number Number -> Number
; Dados dos numeros a y b, devuelve un numero aleatorio perteneciente al intervalo cerrado [a,b]
(check-expect (randomRango 5 5) 5)
(check-expect #true (<= 0 (randomRango MINN MAXN) 100))
(check-expect #true (<= 0 (randomRango MINN (- (/ MAXN 2) 1)) 49)) 
(check-expect #true (<= 51 (randomRango (+(/ MAXN 2)1) MAXN) 100) )
(define (randomRango a b)
   (+ a (random (+ 1 (- b a))) ) )

; nuevoNumero : Estado -> Estado
; Devuelve un estado aleatorio entre [0,100]
(check-expect #true (<= 0 (nuevoNumero INICIAL) 100))
(define (nuevoNumero s)
  (randomRango MINN MAXN))

; manejarTeclado : Estado String -> Estado
; dado el estado actual s y una tecla k, calcula el siguiente estado según
; - "right" : se reemplaza el número actual (estado) por otro que sea elegido aleatoriamente entre 51 y 100
; - "left" : se reemplaza el número actual (estado) por otro que sea elegido aleatoriamente entre 0 y 49
; cualquier otra tecla no modifica el estado
(check-expect #true (<= 0 (manejarTeclado INICIAL "left")))
(check-expect #true (> (/ MAXN 2) (manejarTeclado INICIAL "left")))
(check-expect #true (< (/ MAXN 2) (manejarTeclado INICIAL "right")))
(check-expect #true (>= MAXN (manejarTeclado INICIAL "right")))
(check-expect (manejarTeclado INICIAL "q") INICIAL)
(define (manejarTeclado s k) (cond[(key=? k "left") (randomRango MINN (- (/ MAXN 2) 1))]
                                  [(key=? k "right") (randomRango (+ (/ MAXN 2) 1) MAXN)]
                                  [else s]))

(big-bang INICIAL                      ; estado inicial del programa
          [to-draw pantalla]           ; dibuja en la pantalla el estado actual
          [on-tick nuevoNumero TIEMPO] ; cada TIEMPO (2) segundos, se invoca a la función nuevoNumero para manejar el evento
          [on-key manejarTeclado]      ; cuando se presiona una tecla, la función manejarTeclado se invoca para manejar el teclado
          [stop-when mult8? pantalla]  ; cada vez que hay un nuevo estado, la función mult8? es invocada,
                                       ; si devuelve true se termina el programa, en caso contrario (false) el programa continua
  )