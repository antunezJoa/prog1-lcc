#|
Trabajo Práctico 5: Naturales

Integrantes:
- Antunez, Joaquin ; comisión 1.
- Aseguinolaza, Luis ; comisión 1.
|#

;;;;;;;; Ejercicio 1

; subir : Natural -> Natural
; dado un número natural n, determine de cuántas
; formas distintas se puede subir una escalera de n escalones si se suben los escalones,
; únicamente, de a uno, de a tres o de a cinco.

; Por ejemplo, hay tres formas distintas de subir una escalera de cuatro escalones:
; - subir un escalón, subir un escalón, subir un escalón, subir un escalón;
; - subir tres escalones, subir un escalón;
; - subir un escalón, subir tres escalones.

; Observar que no es posible subir escalones de a cinco en este caso, ya que la escalera tiene
; menos de cinco escalones.

(check-expect (subir 4) 3)
(check-expect (subir 7) 12)

(define (subir n) (cond [(= n 1) 1]
                        [(= n 1) 1]
                        [(= n 3) 2]
                        [(= n 5) 5]
                        [(< n 3) (subir (- n 1))]
                        [(< n 5) (+ (subir (- n 1) ) (subir (- n 3) ))]
                        [else (+ (subir (- n 1) ) (subir (- n 3) ) (subir (- n 5) ) )]))

;;;;;;;; Ejercicio 2

;;;; Ejercicio 2-1

; Costo de los recorridos válidos:
; 5 + 4 - 10 + 15 + 2 + 4 = 20
; 5 + 4 - 10 + 8 + 2 + 4 = 13
; 5 + 4 - 10 + 8 + 1 + 4 = 12
; 5 + 4 - 2 + 8 + 2 + 4 = 21
; 5 + 4 - 2 + 8 + 1 + 4 = 20
; 5 + 4 - 2 + 9 + 1 + 4 = 21
; 5 + 1 - 2 + 8 + 2 + 4 = 18
; 5 + 1 - 2 + 8 + 1 + 4 = 17
; 5 + 1 - 2 + 9 + 1 + 4 = 18
; 5 + 1 - 22 + 9 + 1 + 4 = -2

;;;; Ejercicio 2-2
#|
                      /    tab[0][0]     si i = 0, j = 0
                     |   tab[i][j] + maximocosto(i,j-1)  si i = 0, j != 0
maximoCosto(i, j) = <
                     |   tab[i][j] + maximocosto(i-1 , j)    si i != 0, j = 0
                      \   tab[i][j] + max (  maximocosto(i-1 , j) , maximocosto(i,j-1) )    si i != 0, j != 0
|#

;;;; Ejercicio 2-3

(define TABLERO (list (list -5 10) (list 0 -2) (list 9 3)))
(define TABLERO2 (list (list 5 4 -10 15) (list 1 -2 8 2) (list -22 9 1 4))) ; TABLERO2 representa el tablero utilizado en el ejercicio 2-1

; Una NumbersList es:
; – '()
; – (cons Number NumbersList)

; Un Tablero es:
; - '()
; - (cons NumbersList Tablero)
; interpretación: lista de listas de enteros tab

; buscarij : Tablero Natural  -> X
; dado un numero natural n y un Tablero,
; - si es un tablero de 1 sola NumberList devuelve el n-esimo elemento de la NumberList del tablero
; - si es un tablero de 2 o más NumberLists devuelve la n-esima NumberList  del tablero

(check-expect (buscarij TABLERO2 0) (list 5 4 -10 15))
(check-expect (buscarij (first TABLERO2) 0) 5)

(define (buscarij tab ij) (cond [(= ij 0) (first tab)]
                                [else (buscarij (rest tab) (- ij 1))]))

; iterar : Tablero Natural Natural -> Number
; dado un tablero y dos Naturales que representan coordenadas (filas y columnas),
; devuelve la posicion (i, j) del tablero

(check-expect (iterar TABLERO2 0 1) 4)
(check-expect (iterar TABLERO 2 1) 3)

(define (iterar tab i j)  (buscarij  (buscarij tab i ) j))

; maximo-costo : Tablero Natural Natural -> Number
; dados un tablero, que
; representa un tablero de m filas y n columnas, y dos naturales i y j devuelva el máximo
; costo de un recorrido válido de (0,0) a (i,j) en el tablero. Puede asumir que 0 ≤ i < n,
; 0 ≤ j < m.

(check-expect (maximo-costo TABLERO2 2 3) 21)
(check-expect (maximo-costo TABLERO 2 1) 7)

(define (maximo-costo tab i j) (cond [(and (= i 0) (= j 0)) (iterar tab i j)]
                                     [(= i 0) (+ (iterar tab i j) (maximo-costo tab i (- j 1)))]
                                     [(= j 0) (+ (iterar tab i j) (maximo-costo tab (- i 1) j ))]
                                     [else (+ (iterar tab i j) (max (maximo-costo tab (- i 1) j) (maximo-costo tab i (- j 1))))]))

;;;; Ejercicio 2-4

; maximo-costo-tablero : Tablero -> Number
; dado un tablero, que
; representa un tablero de m filas y n columnas, devuelva el máximo costo que puede tener
; un recorrido válido en el tablero.

(check-expect (maximo-costo-tablero TABLERO) 7)
(check-expect (maximo-costo-tablero TABLERO2) 21)

(define (maximo-costo-tablero tab) (maximo-costo tab (- (length tab) 1) (- (length (first tab)) 1)))