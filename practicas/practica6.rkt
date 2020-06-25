;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname practica6) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/image)

; Un Natural es:
; – 0
; – (add1 Natural)
; interpretación: Natural representa los números naturales

; copiar: Natural String -> Lista(String)
; El propósito de la función copiar es crear una lista de
; n copias de una cadena s
(check-expect (copiar 2 "hola") (list "hola" "hola"))
(check-expect (copiar 0 "hola") '())
(check-expect (copiar 4 "abc") (list "abc" "abc" "abc" "abc"))
(define (copiar n s) (cond [(zero? n) '()]
                           [(positive? n) (cons s (copiar (sub1 n) s))]))


; Ejercicio 1

; sumanat : Natural Natural -> Natural
; toma dos números naturales y sin usar + devuelve un
; natural que es la suma de ambos
(check-expect (sumanat 2 3) 5)
(check-expect (sumanat 4 5) 9)
(define (sumanat n1 n2) (cond [(zero? n1) n2]
                              [(zero? n2) n1]
                              [else (add1 (sumanat (sub1 n1) n2))]))

; Ejercicio 2

; prodnat : Natural Natural -> Natural
; toma como entrada dos números
; naturales y debe multiplicarlos sin usar * ni +
(check-expect (prodnat 3 4) 12)
(check-expect (prodnat 2 8) 16)
(define (prodnat n1 n2) (cond [(zero? n1) 0]
                              [(zero? n2) 0]
                              [else (sumanat (prodnat (sub1 n1) n2) n2)]))

; Ejercicio 3

; powernat : Natural Natural -> Natural
; toma dos números naturales y devuelve el resultado de elevar el primero a la potencia
; del segundo, usando la función prodnat definida en el ejercicio anterior
(check-expect (powernat 2 3) 8)
(check-expect (powernat 2 5) 32)
(define (powernat n1 n2) (cond [(zero? n1) 0]
                               [(zero? n2) 1]
                               [else (prodnat n1 (powernat n1 (sub1 n2)))]))

; Ejercicio 4

; sigma : Natural (Natural -> Number) -> Number
; dados un número natural n y una función f,
; devuelve la sumatoria de f para los valores de 0 hasta n
(check-expect (sigma 4 sqr) 30)
(check-expect (sigma 10 identity) 55)
(define (sigma n f) (cond [(zero? n) (f n)]
                          [else (+ (f n) (sigma (sub1 n) f))]))

; Ejercicio 5

; reciprocoCubo : Natural -> Number
; dado un número natural calcula el recíproco de su cubo
(check-expect (reciprocoCubo 3) (/ 1 27))
(check-expect (reciprocoCubo 5) (/ 1 125))
(define (reciprocoCubo n) (cond [(zero? n) 0]
                                [else (/ 1 (* n n n))]))

; funciong : Natural (Natural -> Number) -> Number
(define (funciong n) (sigma n reciprocoCubo))

;;;;;;;;;;;;;;;;;;;;

; recDosElevado-n : Natural -> Number
; dado un numero natural n devuelve el resultado de elevar dos a la n
(check-expect (recDosElevado-n 5) (/ 1 32))
(check-expect (recDosElevado-n 0) 1)
(define (recDosElevado-n n) (cond [(zero? n) 1]
                                  [else (/ 1 (powernat 2 n))]))

; funcionr : Natural (Natural -> Number) -> Number
(define (funcionr n) (sigma n recDosElevado-n))

;;;;;;;;;;;;;;;;;;;;

; isobrei+1 : Natural -> Number
; dado un numero natural n devuelve el resultado de ( n / (n+1) )
(check-expect (isobrei+1 4) (/ 4 5))
(check-expect (isobrei+1 0) 0)
(define (isobrei+1 n) (cond [(zero? n) 0]
                            [else (/ n (add1 n))]))

; funcions : Natural (Natural -> Number) -> Number
(define (funcions n) (sigma n isobrei+1))

;;;;;;;;;;;;;;;;;;;;

; 1sobrei+1 : Natural -> Number
; dado un numero natural n devuelve el resultado de ( n / (n+1) )
(check-expect (1sobrei+1 4) (/ 1 5))
(check-expect (1sobrei+1 0) 1)
(define (1sobrei+1 n) (cond [(zero? n) 1]
                            [else (/ 1 (add1 n))]))

; funciont : Natural (Natural -> Number) -> Number
(define (funciont n) (sigma n 1sobrei+1))

; Ejercicio 6

; Una ListaN es:
; – '()
; – (cons Natural ListaN)

; intervalo : Natural -> ListaN
; dado un número natural n, devuelve la lista (list 1 2 ... n).
; Para 0 devuelve '().
(check-expect (intervalo 3) (list 1 2 3))
(check-expect (intervalo 0) empty)
(define (intervalo n) (cond [(zero? n) empty]
                            [else (reverse (cons n (reverse (intervalo (sub1 n)))))]))

; Ejercicio 7

; factnat : Natural -> Natural
; toma un número natural y devuelve su factorial. El
; factorial de un número natural n se calcula haciendo 1 x 2 x ... x n
(check-expect (factnat 6) 720)
(check-expect (factnat 0) 1)
(define (factnat n) (cond [(zero? n) 1]
                          [else (prodnat n (factnat (- n 1)))]))

; Ejercicio 8

; fibnat : Natural -> Natural
; toma un número natural y devuelve el valor
; correspondiente a la secuencia de Fibonacci para ese valor:
; fibnat (0) = 1
; fibnat (1) = 1
; fibnat (n+2) = fibnat (n) + fibnat (n+1)
(check-expect (fibnat 6) 13)
(check-expect (fibnat 1) 1)
(define (fibnat n) (cond [(zero? n) 1]
                         [(= n 1) 1]
                         [else (+ (fibnat (sub1 n)) (fibnat (- n 2) ))]))

; Ejercicio 9

; list-fibonacci : Natural -> ListaN
; dado un número n devuelve una lista con los
; primeros n+1 valores de la serie de fibonacci,
; ordenados de mayor a menor. Es decir, (listfibonacci n) = (list (fib n) (fib (- n 1)) ... (fib 0))3
(check-expect (list-fibonacci 4)
(list 5 3 2 1 1))
(check-expect (list-fibonacci 0)
(list 1))
(define (list-fibonacci n) (cond [(zero? n) (list 1)]
                                 [else (cons (fibnat n) (list-fibonacci (sub1 n) ))]))

; Ejercicio 10

; g : Natural -> ListN
; g (0) = 1
; g (1) = 2
; g (2) = 3
; g (n) = g (n-1) * g (n-2) * g (n-3) para todo n mayor o igual a 3
(check-expect (g 3) 6)
(check-expect (g 4) 36)
(define (g n) (cond [(zero? n) 1]
                    [(= n 1) 2]
                    [(= n 2) 3]
                    [else (* (g (sub1 n)) (g (- n 2)) (g (- n 3)) )]))

; list-g : Natural -> ListN
; dado un número n devuelve la lista con los valores que resulta de
; evaluar a g en n, n-1, n-2,...,0. Es decir (list-g n) = (list (g n) (g (- 1 n)) ... (g 1) (g 0)).
(check-expect (list-g 4)
(list 36 6 3 2 1))
(check-expect (list-g 0)
(list 1))
(define (list-g n) (cond [(zero? n) (list (g n))]
                         [else (cons (g n) (list-g (sub1 n)))]))

; Ejercicio 11

; componer : (Number -> Number) Number Number -> Natural
; dados:
; una función f: Number -> Number,
; un natural n, y
; un número x,
; devuelva el resultado de aplicar n veces la función f a x.
(check-expect (componer sqr 2 5)
625)
(check-expect (componer add1 5 13)
18)
(check-expect (componer identity 5 1)
1)
(check-expect (componer sub1 5 1)
-4)
(define (componer f n x) (cond [(zero? n) x]
                               [else (componer f (sub1 n) (f x))]))

; Ejercicio 12

; multiplos : Natural Natural -> ListaN
; toma dos naturales n y m, y devuelva una lista con
; los primeros n múltiplos positivos de m, en orden inverso: m * n, m * (n-1), ... , m * 2, m.
(check-expect (multiplos 4 7)
(list 28 21 14 7))
(check-expect (multiplos 0 11)
'())
(define (multiplos n m) (cond [(zero? n) empty]
                              [else (cons (* m n) (multiplos (sub1 n) m))]))

; Ejercicio 13

; g2 : Natural -> (Natural -> Boolean) -> Boolean
; dado un número natural n y una
; función f: Natural -> Boolean, devuelve #true si y sólo si alguno de los valores (f 0) ,(f 1)
; ,... (f n) es #true.
(check-expect (g2 3 negative?)
#false)
(check-expect (g2 7 even?)
#true)
(define (g2 n f) (cond [(zero? n) (f n)]
                       [else (or (f n) (g2 (sub1 n) f))]))

; Ejercicio 14

; Una ImageList es:
; – '()
; – (cons Image ImageList)

; circulosLista : Natural -> ImageList
; tome un número natural m y devuelve una lista de circulos azules de radios: m^2, (m-1)^2 , ... , 2^2 , 1 respectivamente.
(define (circulosLista m) (cond [(zero? m) empty]
                                [else (cons (circle (sqr m) "outline" "blue") (circulosLista (sub1 m)) )]))

; Una posnList es:
; – '()
; – (cons (make-posn) posnList)

; replicador-posn : posn Natural -> posnList
; dados dos numeros x e y, y un numero natural m, devuelve una lista de estructuras (make-posn x y) de longitud m
(check-expect (replicador-posn 5 5 6) (list (make-posn 5 5) (make-posn 5 5) (make-posn 5 5) (make-posn 5 5) (make-posn 5 5) (make-posn 5 5)))
(check-expect (replicador-posn 5 5 0) empty)
(define (replicador-posn x y m) (cond [(zero? m) empty]
                                      [else (cons (make-posn x y) (replicador-posn x y (sub1 m) ))]))

; circulos : Natural -> Image
; tome un número natural m y devuelva una imagen
; cuadrada de lado 2*m^2 con m círculos azules centrados y radios: m^2, (m-1)^2 , ... , 2^2 , 1 respectivamente.
(define (circulos m)
  (place-images (circulosLista m) (replicador-posn (/ (* 2 (sqr m)) 2) (/ (* 2 (sqr m)) 2) m) (square (* 2 (sqr m)) "solid" "white")))

; Ejercicio 15

(define LADOC 200)

; cuadradosLista : Natural Number -> ImageList
; toma un numero natural m y un numero ang y devuelve una lista de cuadrados azules de lados de tamaño m^2, (m-1)^2 , ... , 2^2 ,1 respectivamente. El ángulo ang indica la rotación del
; cuadrado de mayor dimensión. El ángulo que corresponde al cuadrado de lado (m-1)^2 debe ser de 20 grados mayor que el que le corresponde al cuadrado de lado m^2,
; para cualquier valor de m mayor o igual a 1.
(define (cuadradosLista m ang) (cond [(zero? m) empty]
                                     [else (cons (rotate ang (square (sqr m) "outline" "blue")) (cuadradosLista (sub1 m) (+ ang 20) ) )]))

; cuadrados : Natural Number -> Image
; Diseñe una función cuadrados que tome un número natural m, un ángulo ang y
; devuelva una imagen cuadrada de lado 200 con m cuadrados azules centrados. Los cuadrados azules
; tendrán lados de tamaño: m^2, (m-1)^2 , ... , 2^2 ,1 respectivamente. El ángulo ang indica la rotación del
; cuadrado de mayor dimensión. El ángulo que corresponde al cuadrado de lado (m-1)^2 debe ser de 20 grados mayor que el que le corresponde al cuadrado de lado m^2,
; para cualquier valor de m mayor o igual a 1.
(define (cuadrados m ang)
  (place-images (cuadradosLista m ang) (replicador-posn (/ LADOC 2) (/ LADOC 2) m) (square LADOC "solid" "white")))

; Ejercicio 16

; Una NumbersList es:
; – '()
; – (cons Number NumbersList)

; cuotas : Number Natural Natural -> ListNumbers
; Una persona solicita un préstamo a una entidad bancaria y se compromete a devolver el
; importe total del préstamo más intereses en n cuotas mensuales crecientes, con una tasa de interés
; del i% anual. La cuota j-ésima, con j que va de 1 hasta n, se calcula sumando dos valores:
; la parte correspondiente a la devolución del préstamo, que se calcula así: total/n;
; la parte correspondiente a los intereses de la cuota, que se calcula así: (total/n) * (i/
; (100*12)) * j.
; la funcion cuotas dado un importe total de un préstamo, un valor n correspondiente
; al número de cuotas, una tasa i de interés, devuelve una lista con las cuotas a pagar ordenadas de
; forma creciente.
(check-expect (cuotas 10000 0 18 1)
'())
(check-expect (cuotas 10000 1 12 1)
(list 10100))
(check-expect (cuotas 30000 3 12 1)
(list 10100 10200 10300))
(check-expect (cuotas 100000 4 18 1)
(list 25375 25750 26125 26500))
(define (cuotas monto n i j) (cond [(< n j) empty]
                                   [else (cons (+ (/ monto n) (* (/ monto n) (/ i (* 100 12)) j)) (cuotas monto n i (add1 j)))]))