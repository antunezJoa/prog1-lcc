;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname practica5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require racket/base)
(require 2htdp/image)

; Ejercicio 1

; Contactos es:
; - una lista vacia '() o
; - una expresión del tipo (cons un-nombre-persona Contactos)
; Contactos puede ser una lista vacía o una lista de contactos encabezada por el String un-nombre-persona.

(cons "Ivan"
      (cons "Lautaro"
            (cons "Joaquin"
                  (cons "Alvaro"
                        (cons "Jeremias" '())))))

(list "Ivan" "Lautaro" "Joaquin" "Alvaro" "Jeremias")

; Ejercicio 2

; (cons "1" (cons "2" '())) es un ejemplo de lista Contactos porque "1" y "2" son Strings
; y por lo tanto califican como posible elemento de una lista Contactos
; ya que Contactos puede ser una lista vacía o una lista de contactos encabezada por el String un-nombre-persona
; mas allá de que ninguna persona se llame "1" o "2".

; (cons 2 '()) no es un ejemplo de lista de Contactos porque 2 es de tipo Number y no String, por lo tanto no califica como
; elemento de una lista Contactos ya que Contactos puede ser una lista vacía o una lista de contactos encabezada por el String un-nombre-persona.

; Ejercicio 3

; Una Lista-de-booleanos es:
; – '()
; – (cons Boolean Lista-de-booleanos)

; Ejercicio 3.5

; Contactos es:
; - una lista vacia '() o
; - una expresión del tipo (cons un-nombre-persona Contactos)
; Contactos puede ser una lista vacía o una lista de contactos encabezada por el String un-nombre-persona.

; contiene-Marcos? : Contactos -> Booleano
; dada una lista de Contactos, determina si "Marcos" es un elemento de la misma
(check-expect (contiene-Marcos? '()) #false)
(check-expect (contiene-Marcos? (cons "Sara" (cons "Pedro"  (cons "Esteban" '())))) #false)
(check-expect (contiene-Marcos? (cons "A" (cons "Marcos" (cons "C" '())))) #true)
(check-expect (contiene-Marcos? (cons "Juan" '())) #false)
(check-expect (contiene-Marcos? (cons "Marcos" '())) #true)
(define (contiene-Marcos? l) (cond [(empty? l) #false]
                                   [(cons? l) (if (string=? (first l) "Marcos")
                                                  #true
                                                  (contiene-Marcos? (rest l)))]))

; Ejercicio 4

(contiene-Marcos?
 (cons "Eugenia"
  (cons "Lucía"
    (cons "Dante"
      (cons "Federico"
        (cons "Marcos"
          (cons "Gabina"
            (cons "Laura"
              (cons "Pamela" '()))))))))) ; -> #true

; Ejercicio 5

; Cadenas es:
; - una lista vacia '() o
; - una expresión del tipo (cons un-string-cualquiera Contactos)
; Cadenas puede ser una lista vacía o una lista de strings cualesquiera encabezada por un String cualquiera.

; contiene? : String Cadenas -> Booleano
; determina si un string aparece en una lista de string.
(check-expect (contiene? "Messi" '()) #false)
(check-expect (contiene? "Sara" (cons "Sara" (cons "Pedro"  (cons "Esteban" '())))) #true)
(check-expect (contiene? "C" (cons "A" (cons "Marcos" (cons "C" '())))) #true)
(check-expect (contiene? "Pedro" (cons "Juan" '())) #false)
(check-expect (contiene? "Marcos" (cons "Marcos" '())) #true)
(define (contiene? s l) (cond [(empty? l) #false]
                              [(cons? l) (if (string=? (first l) s)
                                              #true
                                             (contiene? s (rest l)))]))

; Ejercicio 6

;(contiene-Marcos? (cons "Marcos" (cons "C" '())))
; == (contiene-Marcos? (cons "Marcos" (list "C")))
; == (contiene-Marcos? (list "Marcos" "C"))
; == (cond [(empty? (list "Marcos" "C")) #false] [(cons? (list "Marcos" "C")) (if (string=? (first (list "Marcos" "C")) "Marcos") #true (contiene-Marcos? (rest (list "Marcos" "C"))))]))
; == (cond [#false #false] [(cons? (list "Marcos" "C")) (if (string=? (first (list "Marcos" "C")) "Marcos") #true (contiene-Marcos? (rest (list "Marcos" "C"))))]))
; == (cond [#true (if (string=? (first (list "Marcos" "C")) "Marcos") #true (contiene-Marcos? (rest (list "Marcos" "C"))))]))
; == (if (string=? (first (list "Marcos" "C")) "Marcos") #true (contiene-Marcos? (rest (list "Marcos" "C"))))
; == (if (string=? "Marcos" "Marcos") #true (contiene-Marcos? (rest (list "Marcos" "C"))))
; == (if #true #true (contiene-Marcos? (rest (list "Marcos" "C"))))
; == #true

;(contiene-Marcos? (cons "A" (cons "Marcos" (cons "C" '()))))
; == (contiene-Marcos? (cons "A" (cons "Marcos" (list "C"))))
; == (contiene-Marcos? (cons "A" (list "Marcos "C")))
; == (contiene-Marcos? (list "A" "Marcos" "C"))
; == (cond [(empty? (list "A" "Marcos" "C")) #false] [(cons? (list "A" "Marcos" "C")) (if (string=? (first (list "A" "Marcos" "C")) "Marcos") #true (contiene-Marcos? (rest (list "A" "Marcos" "C"))))]))
; == (cond [#false #false] [(cons? (list "A" "Marcos" "C")) (if (string=? (first (list "A" "Marcos" "C")) "Marcos") #true (contiene-Marcos? (rest (list "A" "Marcos" "C"))))]))
; == (cond [#true (if (string=? (first (list "A" "Marcos" "C")) "Marcos") #true (contiene-Marcos? (rest (list "A" "Marcos" "C"))))]))
; == (if (string=? "A" "Marcos") #true (contiene-Marcos? (rest (list "A" "Marcos" "C"))))
; == (if #false #true (contiene-Marcos? (rest (list "A" "Marcos" "C"))))
; == (contiene-Marcos? (list "Marcos" "C"))
; == (cond [(empty? (list "Marcos" "C")) #false] [(cons? (list "Marcos" "C")) (if (string=? (first (list "Marcos" "C")) "Marcos") #true (contiene-Marcos? (rest (list "Marcos" "C"))))]))
; == (cond [#false #false] [(cons? (list "Marcos" "C")) (if (string=? (first (list "Marcos" "C")) "Marcos") #true (contiene-Marcos? (rest (list "Marcos" "C"))))]))
; == (cond [#true (if (string=? (first (list "Marcos" "C")) "Marcos") #true (contiene-Marcos? (rest (list "Marcos" "C"))))]))
; == (if (string=? "Marcos" "Marcos") #true (contiene-Marcos? (rest (list "Marcos" "C"))))
; == (if #true #true (contiene-Marcos? (rest (list "Marcos" "C"))))
; == #true

; ¿Qué pasa si reemplazamos a "Marcos" con "B"?
; En ese caso la función terminará retornando #false, pues "Marcos" no se encontraría en la lista.

; Ejercicio 7

; Una Lista-de-montos es:
; – '()
; – (cons NumeroPositivo Lista-de-montos)
; Lista-de-montos representa una lista con montos de dinero

; contiene-monto? : Lista-de-montos m -> Boolean
; dado una lista de montos y un monto, determina si ese monto se encuentra en la lista de montos
(check-expect (contiene-monto? (list 20 10) 20) #true)
(check-expect (contiene-monto? (list 20 10) 25) #false)
(check-expect (contiene-monto? (cons 50 (cons 30 '())) 10) #false)
(check-expect (contiene-monto? '() 10) #false)
(define (contiene-monto? l m) (cond [(empty? l) #false]
                                    [else (if (= (first l) m) #true (contiene-monto? (rest l) m))]))

; suma : Lista-de-montos -> Number
; toma como entrada una lista con montos de dinero y devuelva como resultado la suma de los montos presentes en dicha lista.
(check-expect (suma (list 10 12)) 22)
(check-expect (suma '()) 0)
(check-expect (suma (cons 25 '())) 25)
(define (suma l) (cond [(empty? l) 0]
                       [else (+ (first l) (suma (rest l)))]))

; (suma (list 10 12))
; == (cond [(empty? (list 10 12)) 0] [else (+ (first (list 10 12)) (suma (rest (list 10 12))))]))
; == (cond [#false 0] [else (+ (first (list 10 12)) (suma (rest (list 10 12))))]))
; == (+ 10 (suma (rest (list 10 12))))
; == (+ 10 (cond [(empty? (rest (list 10 12))) 0] [else (+ (first (rest (list 10 12))) (suma (rest (rest (list 10 12)))))]))
; == (+ 10 (cond [(empty? (list 12)) 0] [else (+ (first (rest (list 10 12))) (suma (rest (rest (list 10 12)))))]))
; == (+ 10 (cond [#false 0] [else (+ (first (rest (list 10 12))) (suma (rest (rest (list 10 12)))))]))
; == (+ 10 (+ (first (list 12)) (suma (rest (rest (list 10 12))))))
; == (+ 10 (+ 12 (suma '())))
; == (+ 10 (+ 12 (cond [(empty? '()) 0] [else (+ (first '()) (suma (rest '())))])))
; == (+ 10 (+ 12 (cond [#true 0] [else (+ (first '()) (suma (rest '())))])))
; == (+ 10 (+ 12 0))
; == (+ 10 12)
; 22

; Ejercicio 8

; Una Lista-de-numeros es:
; – '()
; – (cons Numero Lista-de-numeros)

; pos? : Lista-de-numeros -> Boolean
; toma una Lista-de-numeros y determina si todos los elementos de la lista son positivos
; si (pos? l) devuelve #true, entonces l es un elemento del tipo de dato Lista-de-montos
(check-expect (pos? (list 20 25 30)) #true)
(check-expect (pos? (list 20 0 30)) #false)
(check-expect (pos? '()) #true)
(check-expect (pos? (list 25 -25)) #false)
(define (pos? l) (cond [(empty? l) #true]
                       [else (if (positive? (first l)) (pos? (rest l)) #false)]))

; (pos? (cons 5 '()))
; == (pos? (list 5))
; == (cond [(empty? (list 5)) #true] [else (if (positive? (first (list 5))) (pos? (rest (list 5))) #false)])
; == (cond [#false #true] [else (if (positive? (first (list 5))) (pos? (rest (list 5))) #false)])
; == (if (positive? 5) (pos? (rest (list 5))) #false)
; == (if #true (pos? (rest (list 5))) #false)
; == (pos? (rest (list 5)))
; == (pos? '())
; == (cond [(empty? '()) #true] [else (if (positive? (first '())) (pos? (rest '())) #false)])
; == (cond [#true #true] [else (if (positive? (first '())) (pos? (rest '())) #false)])
; == #true

; (pos? (cons -1 '()))
; == (pos? (list -1))
; == (cond [(empty? (list -1)) #true] [else (if (positive? (first (list -1))) (pos? (rest (list -1))) #false)])
; == (cond [#false #true] [else (if (positive? (first (list -1))) (pos? (rest (list -1))) #false)])
; == (if (positive? -1) (pos? (rest (list -1))) #false)
; == (if #false (pos? (rest (list -1))) #false)
; == #false

; checked-suma : Lista-de-numeros -> Number
; Esta función recibe como entrada una Lista-de-numeros
; y devuelve la suma de sus elementos si la lista pertenece a Lista-demontos sino deberá devolver un string indicando un error.
(check-expect (checked-suma (list 20 25 30)) 75)
(check-expect (checked-suma (list 20 -25 30)) "Error")
(check-expect (checked-suma '()) 0)
(define (checked-suma l) (if (pos? l) (suma l) "Error"))

; Ejercicio 9

; todos-verdaderos : Lista-de-booleanos -> Boolean
; una función que recibe como entrada una lista de valores booleanos y devuelve #true unicamente si todos los elementos de la lista son #true.
(check-expect (todos-verdaderos (list #t #t #t)) #true)
(check-expect (todos-verdaderos (list #t #t #f)) #false)
(check-expect (todos-verdaderos '()) #true)
(check-expect (todos-verdaderos (list #f)) #false)
(define (todos-verdaderos l) (cond [(empty? l) #t]
                                   [else (if (false? (first l)) #f (todos-verdaderos (rest l)) )]))

; uno-verdadero : Lista-de-booleanos -> Boolean
; una función que recibe como entrada una lista de valores booleanos y devuelve #true si al menos uno de los elementos de la lista es #true.
(check-expect (uno-verdadero (list #t #t #t)) #true)
(check-expect (uno-verdadero (list #t #t #f)) #true)
(check-expect (uno-verdadero '()) #false)
(check-expect (uno-verdadero (list #f)) #false)
(check-expect (uno-verdadero (list #t)) #t)
(define (uno-verdadero l) (cond [(empty? l) #f]
                                [else (if (false? (not (first l))) #t (uno-verdadero (rest l)) )]))

; Ejercicio 10

; cant-elementos : lista -> Number
; dada una lista, devuelve la cantidad de elementos que contiene.
(check-expect (cant-elementos '()) 0)
(check-expect (cant-elementos (list 10 20 30)) 3)
(define (cant-elementos l) (cond [(empty? l) 0]
                                 [else (+ 1 (cant-elementos (rest l)))]))

; Ejercicio 11

; promedio : Lista-de-montos -> Number
; que devuelve el promedio de una Lista-de-numeros
(check-expect (promedio (list 7 7 7)) 7)
(check-expect (promedio (list 7 8 9)) 8)
(check-expect (promedio (list 10 5 6)) 7)
(define (promedio l) (/ (suma l) (cant-elementos l)))

; Ejercicio 12

; pares : Lista-de-numeros -> Number
; dada una lista de números l, devuelve una lista con los números pares de l.
(check-expect (pares (list 4 6 3 7 5 0)) (list 4 6 0))
(define (pares l) (cond [(empty? l) '()]
                        [else (if (even? (first l)) (append (list (first l)) (pares (rest l))) (pares (rest l)))]))

; Ejercicio 13

; lmenor5 : String -> Boolean
; dado un string devuelve determina si su longitud es menor a 5.
(check-expect (lmenor5 "Francia") #false)
(check-expect (lmenor5 "Leo") #true)
(define (lmenor5 s) (< (string-length s) 5))

; cortas : Cadenas -> Cadenas
; toma una lista de Cadenas y devuelve una lista con aquellas Cadenas de longitud menor a 5.
(check-expect (cortas (list "Lista" "de" "palabras" "sin" "sentido")) (list "de" "sin"))
(check-expect (cortas '()) '())
(define (cortas l) (cond [(empty? l) '()]
                         [else (if (lmenor5 (first l)) (append (list (first l)) (cortas (rest l))) (cortas (rest l)))]))

; Ejercicio 14

; mayores : Lista-de-numeros Number -> Lista-de-numeros
; dada una lista de números l y un número n, devuelve una lista con aquellos elementos de l que son mayores a n.
(check-expect (mayores (list 1 2 3 4 5 6 7 8 9) 5) (list 6 7 8 9))
(check-expect (mayores (list 1 2 3 4 5 6 7 8 9) 8) (list 9))
(check-expect (mayores (list 1 2 3 4 5 6 7 8 9) 10) '())
(define (mayores l n) (cond [(empty? l) '()]
                          [else (if (> (first l) n) (append (list (first l)) (mayores (rest l) n)) (mayores (rest l) n) )]))

; Ejercicio 15

; (define-struct posn [x y])
; posn es (Number , Number)
; interpretación: un elemento en posn representa una
; posición en coordenadas cartesianas

; Una Lista-de-puntos es:
; – '()
; – (cons (make-posn x y) Lista-de-puntos)

(define MAX 5)

; dist-origen : posn -> Number
; dada una estrucutra (make-posn x y), devuelve la distancia del punto (x,y) al origen
(check-expect (dist-origen (make-posn 3 4)) 5)
(check-expect (dist-origen (make-posn 5 12)) 13)
(check-expect (dist-origen (make-posn 7 24)) 25)
(define (dist-origen p)
  (sqrt (+ (expt (posn-x p) 2) (expt (posn-y p) 2))))

; cercav2 : Lista-de-puntos -> Lista-de-puntos
; toma una lista de puntos del plano (representados mediante estructuras posn), y devuelve la lista de aquellos puntos que están a distancia menor a MAX de origen
(check-expect (cercav2 (list (make-posn 3 5) (make-posn 1 2) (make-posn 0 1) (make-posn 5 6))) (list (make-posn 1 2) (make-posn 0 1)))
(check-expect (cercav2 '()) '())
(define (cercav2 l) (cond [(empty? l) '()]
                          [else (if (< (dist-origen (first l)) MAX) (append (list (first l)) (cercav2 (rest l))) (cercav2 (rest l)) )]))

; Ejercicio 16

; positivos : Lista-de-numeros -> Lista-de-numeros
; toma una lista de números y se quede sólo con aquellos que son mayores a 0.
(check-expect (positivos (list -5 37 -23 0 12)) (list 37 12))
(check-expect (positivos (list 0)) '())
(check-expect (positivos '()) '())
(define (positivos l) (cond [(empty? l) '()]
                            [else (if (> (first l) 0) (append (list (first l)) (positivos (rest l))) (positivos (rest l)) )]))

; Ejercicio 17

; eliminar : Lista-de-numeros Number -> Lista-de-numeros
; dada una lista de números l y un numero n, devuelve la lista que resulta de eliminar en l todas las ocurrencias de n.
(check-expect (eliminar (list 1 2 3 2 7 6) 2) (list 1 3 7 6))
(check-expect (eliminar (list 1 2 3 2 7 6) 0) (list 1 2 3 2 7 6))
(check-expect (eliminar (list -2 -2 -2 -2) -2) empty)
(define (eliminar l n) (cond [(empty? l) empty]
                             [else (if (equal? n (first l)) (eliminar (rest l) n) (append (list (first l)) (eliminar (rest l) n) ) )]))

; Ejercicio 18

; raices : Lista-de-montos -> Lista-de-montos
; dada una lista de números, devuelve una lista con las raíces cuadradas de sus elementos.
(check-expect (raices (list 9 16 4)) (list 3 4 2))
(check-expect (raices empty) empty)
(check-expect (raices (list 0)) (list 0))
(define (raices l) (cond [(empty? l) empty]
                         [else (append (list (sqrt (first l))) (raices (rest l)))]))

; Ejercicio 19

; distancias : Lista-de-puntos -> Lista-de-montos
; dada una lista de puntos del plano, devuelva una lista con la distancia al origen de cada uno.
(check-expect (distancias (list (make-posn 3 4) (make-posn 0 4) (make-posn 12 5))) (list 5 4 13) )
(check-expect (distancias empty) empty)
(check-expect (distancias (list (make-posn 0 0))) (list 0))
(define (distancias l) (cond [(empty? l) empty]
                             [else (append (list (dist-origen (first l))) (distancias (rest l)) )]))

; Ejercicio 20

; Una Lista-de-imagenes es:
; – '()
; – (cons Image Lista-de-imagenes)

; anchos : Lista-de-imagenes -> Lista-de-montos
; dada una lista de imágenes, devuelva una lista con el ancho de cada una
(check-expect (anchos (list (circle 30 "solid" "red") (rectangle 10 30 "outline" "blue"))) (list 60 10) )
(check-expect (anchos empty) empty)
(define (anchos l) (cond [(empty? l) empty]
                         [else (append (list (image-width (first l))) (anchos (rest l)))]))

; Ejercicio 21

(define (sgn2 x) (cond [(< x 0) -1]
                       [(= x 0) 0]
                       [(> x 0) 1]))

; signos : Lista-de-numeros -> Lista-de-numeros
; dada una lista de números, devuelve una lista con el resultado de aplicarle a cada elemento la función sgn2
(check-expect (signos (list 45 32 -23 0 12))  (list 1 1 -1 0 1) )
(check-expect (signos empty) empty)
(define (signos l)(cond
                    [(empty? l) empty]
                    [else (append (list (sgn2 (first l))) (signos (rest l)) )]))

; Ejercicio 22

; cuadrados : Lista-de-numeros -> Lista-de-numeros
; dada una lista de números, devuelva la lista que resulta de elevar al cuadrado cada uno de los elementos de la lista original
(check-expect (cuadrados (list 1 2 3)) (list 1 4 9) )
(check-expect (cuadrados empty) empty)
(check-expect (cuadrados (list 0)) (list 0))
(define (cuadrados l) (cond [(empty? l) empty]
                            [else (append (list (expt (first l) 2)) (cuadrados (rest l)) )]))

; Ejercicio 23

; longitudes : Cadenas -> Lista-de-montos
; dada una lista de cadenas, devuelve la lista de sus longitudes (es decir, la cantidad de caracteres que contienen)
(check-expect (longitudes (list "hola" "cómo" "estás?")) (list 4 4 6))
(check-expect (longitudes empty) empty)
(check-expect (longitudes (list "")) (list 0))
(define (longitudes l) (cond [(empty? l) empty]
                             [else (append (list (string-length (first l))) (longitudes (rest l)) )]))

; Ejercicio 24

; Una Lista-de-temperaturas es:
; – '()
; – (cons Number Lista-de-temperaturas)

; FaC : Number -> Number
; dado un numero en grados Fahrenheit, devuelve su equivalente en grados Celsius.
(check-expect (FaC 32) 0)
(check-expect (FaC 50) 10)
(check-expect (FaC 77) 25)
(define (FaC x) (/ (* 5 (- x 32)) 9))

; convertirFC : Lista-de-temperaturas -> Lista-de-temperaturas
; dada una lista de temperaturas en grados Fahrenheit, devuelve esta lista de temperaturas convertidas en grados Celsius.
(check-expect (convertirFC (list 32 50 77)) (list 0 10 25))
(check-expect (convertirFC empty) empty)
(define (convertirFC l) (cond [(empty? l) empty]
                              [else (append (list (FaC (first l))) (convertirFC (rest l)) )]))

; Ejercicio 25

; prod : Lista-de-numeros -> Number
; multiplica los elementos de una lista de números entre sí. Para la lista vacía, devuelve 1.
(check-expect (prod (list 1 2 3 4 5)) 120)
(check-expect (prod empty) 1)
(check-expect (prod (list 1 2 3 4 5 0)) 0)
(define (prod l) (cond [(empty? l) 1]
                       [else (* (first l) (prod (rest l)))]))

; Ejercicio 26

; pegar : Cadenas -> String
; dada una lista de strings, devuelve el string que se obtiene de concatenar todos los elementos de la lista
(check-expect (pegar (list "Las " "lis" "tas " "son " "complicadas" ".")) "Las listas son complicadas.")
(check-expect (pegar empty) "")
(define (pegar l) (cond [(empty? l) ""]
                        [else (string-append (first l) (pegar (rest l)))]))

; Ejercicio 27

; maximo : Lista-de-montos -> Number
; devuelve el máximo de una lista de números naturales. Para la lista vacía, devuelve 0.
(check-expect (maximo (list 23 543 325 0 75)) 543)
(check-expect (maximo empty) 0)
(define (maximo l) (cond [(empty? l) 0]
                         [else (foldr max (first l) (rest l))]))

; Ejercicio 28

; sumdist : Lista-de-puntos -> Number
; dada una lista de puntos del plano, devuelva la suma de sus distancias al origen.
(check-expect (sumdist (list (make-posn 3 4) (make-posn 0 4) (make-posn 12 5))) 22)
(check-expect (sumdist empty) 0)
(define (sumdist l) (cond [(empty? l) 0]
                          [else (suma (distancias l))]))

; Ejercicio 29

; sumcuad : Lista-de-numeros -> Number
; dada una lista de números, devuelve la suma de sus cuadrados. Para la lista vacía, devuelve 0.
(check-expect (sumcuad (list 1 2 3)) 14)
(check-expect (sumcuad (list 0 1 2 3 4 5 6)) 91)
(check-expect (sumcuad empty) 0)
(define (sumcuad l) (cond [(empty? l) 0]
                          [else (suma (cuadrados l))]))