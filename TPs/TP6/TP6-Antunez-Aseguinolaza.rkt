;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname TP6-Antunez-Aseguinolaza) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
#| Trabajo Práctico 6

Integrantes:
- Antunez,  Joaquin ; comisión 1.
- Aseguinolaza, Luis ; comisión 1.
|#

;;;;;;;; Ejercicio 1

; implica : Boolean Boolean -> Boolean
; dados dos valores booleanos se comporta como la tabla de verdad del operador "->"

(check-expect (implica #t #t) #t)
(check-expect (implica #t #f) #f)
(check-expect (implica #f #t) #t)
(check-expect (implica #f #f) #t)

(define (implica b1 b2)
  (if (false? b1) #t (if (false? b2) #f #t)))

; equivalente : Boolean Boolean -> Boolean
; dados dos valores booleanos se comporta como la tabla de verdad del operador "<->"

(check-expect (equivalente #t #t) #t)
(check-expect (equivalente #t #f) #f)
(check-expect (equivalente #f #t) #f)
(check-expect (equivalente #f #f) #t)

(define (equivalente b1 b2)
  (if (equal? b1 b2) #t #f))

;;;;;;;; Ejercicio 2

; Un Natural es:
; – 0
; – (add1 Natural)
; interpretación: Natural representa los números naturales

; añadir : X List of List(Y) -> List of List(Z)
; dado un elemento cualquiera X y una lista L de listas de elementos Y cualquiera, devuelve una lista que representa
; el resultado de añadir X a todos los elementos de L

(check-expect (añadir #t (list (list 1 1) (list 2 2) (list 3 3))) (list (list #t 1 1) (list #t 2 2) (list #t 3 3) ))
(check-expect (añadir 1 empty) empty)
(check-expect (añadir "A" (list 1 2 3)) (list (list "A" 1) (list "A" 2) (list "A" 3) ))

(define (añadir x l) (cond [(empty? l) empty]
                           [(list? (first l)) (cons (cons x (first l)) (añadir x (rest l)))]
                           [else (cons (list x (first l)) (añadir x (rest l)))]))

; valuaciones : Natural -> List of List(Boolean)
; dado un número natural n, genere todas las
; posibles valuaciones que existen con n variables proposicionales.

(check-expect (valuaciones 3) (list
(list #false #false #false)
(list #false #false #true)
(list #false #true #false)
(list #false #true #true)
(list #true #false #false)
(list #true #false #true)
(list #true #true #false)
(list #true #true #true)))

(check-expect (valuaciones 2) (list
(list #false #false)
(list #false #true)
(list #true #false)
(list #true #true)))

(define (valuacionesaux n) (cond [(zero? n) empty]
                              [(= n 1) (list #f #t)]
                              [else (append (añadir #f (valuacionesaux (- n 1))) (añadir #t (valuacionesaux (- n 1))) )]) )

(define (valuaciones n) (cond [(zero? n) empty]
                              [(= n 1) (list (list #f)(list #t) ) ]
                              [else (valuacionesaux n)]))

;;;;;;;; Ejercicio 3

; A : List(Boolean) -> Boolean

; (p1 => p3 ^ p2 => p3) <=> (p1 | p2) => p3

(check-expect (A (list  #t #t #t ) ) #t )
(define
  (A l)
  (let ([p1 (first l)]
        [p2 (second l)]
        [p3 (third l)])
  (equivalente (and (implica p1 p3)
                    (implica p2 p3))
               (implica (or p1 p2)
                        p3))))

; B : List(Boolean) -> Boolean

; (p1 => p3) ^ (p2 => p3) <=> ( (p1 ^ p2) => p3 )

(check-expect (B (list  #t #t #f ) ) #t )
(check-expect (B (list  #t #f #f ) ) #f )
(define
  (B l)
  (let ([p1 (first l)]
        [p2 (second l)]
        [p3 (third l)])
  (equivalente (and (implica p1 p3)
                    (implica p2 p3))
               (implica (and p1 p2)
                        p3))))

; C : List(Boolean) -> Boolean

; ((p1)' | (p2)') <=> p1 ^ p2

(check-expect (C (list  #t #t ) ) #f )
(define
  (C l)
  (let ([p1 (first l)]
        [p2 (second l)])
  (equivalente (or (not p1) (not p2) )
               (and p1 p2))))

;;;;;;;; Ejercicio 4

; componer : (List(Boolean) -> Boolean) List of List(Boolean) -> List(Boolean)
; dada una fórmula proposicional P y lista de listas de booleanos correspondientes a unas valuaciones,
; devuelve una lista que representa el resultado de aplicar P a cada valuación.

(check-expect (componer C (list (list #f #f) (list #f #t) (list #t #f) (list #t #t) )) (list #f #f #f #f))

(define (componer P l) (cond [(empty? l) empty]
                             [else (cons (P (first l)) (componer P (rest l)))]) )

; evaluar : (List(Boolean) -> Boolean) Natural -> List(Boolean)
; dada una fórmula proposicional P y la cantidad de variables n que utiliza P,
; devuelva una lista con (2 ^ n) booleanos, que son el resultado de evaluar P en cada una de las
; posibles valuaciones. Es decir, que devuelva una lista con la última columna de la tabla de verdad de P.

(check-expect (evaluar A 3) (list #t #t #t #t #t #t #t #t))
(check-expect (evaluar C 2) (list #f #f #f #f))

(define (evaluar P n) (componer P (valuaciones n)))

;;;;;;;; Ejercicio 5

(define (oLogico a b) (or a b))

(define (yLogico a b) (and a b))

; tautología? : (List(Boolean)) -> Boolean
; Dada una proposición, y la cantidad de variables que involucra, devuelve si la proposición es una tautología.

(check-expect (tautología? A 3) #true)
(check-expect (tautología? B 3) #false)
(check-expect (tautología? C 2) #false)

(define (tautología? P n)
  (foldl yLogico true (evaluar P n)))

; contradicción? : (List(Boolean)) -> Boolean
; Dada una proposición, y la cantidad de variables que involucra, devuelve si la proposición es una contradicción.

(check-expect (contradicción? A 3) #false)
(check-expect (contradicción? B 3) #false)
(check-expect (contradicción? C 2) #true)

(define (contradicción? P n)
  (not (foldl oLogico false (evaluar P n))))

; satisfactible? : (List(Boolean)) -> Boolean
; dada una proposición, y la cantidad de variables que involucra, devuelve si la proposición es satisfactible,
; i.e., si es verdadera para al menos una valuación.

(check-expect (satisfactible? A 3) #true)
(check-expect (satisfactible? B 3) #true)
(check-expect (satisfactible? C 2) #false)

(define (satisfactible? P n)
  (foldl oLogico false (evaluar P n)))

;;;;;;;; Ejercicio 6

;;;; Ejemplos de fórmulas proposicionales

; D : List(Boolean) -> Boolean
; D representa la fórmula proposicional p
(define
  (D l)
  (first l))

; E : List(Boolean) -> Boolean
; E representa la fórmula proposicional p \/ ~p 
(define
  (E l)
  (let ([p (first l)])
  (or p (not p))))

; F : List(Boolean) -> Boolean
; F representa la fórmula proposicional p /\ ~p 
(define
  (F l)
  (let ([p (first l)])
  (and p (not p))))

; MP : List(Boolean) -> Boolean
; MP representa la fórmula proposicional ((p -> q) /\ p) -> q
; conocida como modus ponens.
(define
  (MP l)
  (let ([p (first l)]
        [q (second l)])
  (implica (and (implica p q) p) q)))

; MT : List(Boolean) -> Boolean
; MT representa la fórmula proposicional ((p -> q) /\ ~q) -> ~p
; conocida como modus tollens.
(define
  (MT l)
  (let ([p (first l)]
        [q (second l)])
  (implica (and (implica p q) (not q)) (not p))))

; DM1 : List(Boolean) -> Boolean
; DM1 representa la fórmula proposicional ~(p \/ q) <-> (~p /\ ~q)
; que constituye una de las leyes de morgan.
(define
  (DM1 l)
  (let ([p (first l)]
        [q (second l)])
  (equivalente (not (or p q))
               (and (not p) (not q)))))

; G : List(Boolean) -> Boolean
; G representa la fórmula proposicional p1 /\ ~ p2 /\ (p1 -> ~p4) /\ (p2 \/ p3) /\ (p3 -> p4)
(define
  (G l)
  (let ([p1 (first l)]
        [p2 (second l)]
        [p3 (third l)]
        [p4 (fourth l)])
  (and p1
       (not p2)
       (implica p1 (not p4))
       (or p2 p3)
       (implica p3 p4))))

; H : List(Boolean) -> Boolean
; H representa la fórmula proposicional ((p1 \/ p2) -> p3) /\ (~p3 \/ ~p4)
(define
  (H l)
  (let ([p1 (first l)]
        [p2 (second l)]
        [p3 (third l)]
        [p4 (fourth l)])
  (and (implica (or p1 p2) p3)
       (or (not p3) (not p4)))))

; I : List(Boolean) -> Boolean
; I representa la fórmula proposicional
; ((p1 \/ ~p2) -> (p5 \/ (p1 /\ p3 /\ ~p4))) <-> (~(~p1 \/ ~p3 \/ p4 \/ p5) -> (~p1 \/ ~p2))
(define
  (I l)
  (let ([p1 (first l)]
        [p2 (second l)]
        [p3 (third l)]
        [p4 (fourth l)]
        [p5 (fifth l)])
  (equivalente
    (implica (or p1 (not p2))
             (or p5 (and p1 p3 (not p4))))
    (implica (not (or (not p1) (not p3) p4 p5))
             (or (not p1) (not p2))))))

;;;; Tests para ejercicio 4

; ocurrencias : List(X) X -> Natural
; Dados una lista l de elementos de tipo X y un elemento v de tipo
; X, devuelve la cantidad de veces que v aparece en l.
(define
  (ocurrencias l v)
  (length (filter (lambda (x) (equal? x v)) l)))

(check-expect (ocurrencias (evaluar A 3) #t) 8)
(check-expect (ocurrencias (evaluar A 3) #f) 0)
(check-expect (ocurrencias (evaluar B 3) #t) 6)
(check-expect (ocurrencias (evaluar B 3) #f) 2)
(check-expect (ocurrencias (evaluar C 2) #t) 0)
(check-expect (ocurrencias (evaluar C 2) #f) 4)
(check-expect (ocurrencias (evaluar D 1) #t) 1)
(check-expect (ocurrencias (evaluar D 1) #f) 1)
(check-expect (ocurrencias (evaluar E 1) #t) 2)
(check-expect (ocurrencias (evaluar E 1) #f) 0)
(check-expect (ocurrencias (evaluar F 1) #t) 0)
(check-expect (ocurrencias (evaluar F 1) #f) 2)
(check-expect (ocurrencias (evaluar MP 2) #t) 4)
(check-expect (ocurrencias (evaluar MP 2) #f) 0)
(check-expect (ocurrencias (evaluar MT 2) #t) 4)
(check-expect (ocurrencias (evaluar MT 2) #f) 0)
(check-expect (ocurrencias (evaluar DM1 2) #t) 4)
(check-expect (ocurrencias (evaluar DM1 2) #f) 0)
(check-expect (ocurrencias (evaluar G 4) #t) 0)
(check-expect (ocurrencias (evaluar G 4) #f) 16)
(check-expect (ocurrencias (evaluar H 4) #t) 6)
(check-expect (ocurrencias (evaluar H 4) #f) 10)
(check-expect (ocurrencias (evaluar I 5) #t) 21)
(check-expect (ocurrencias (evaluar I 5) #f) 11)

;;;; Tests para ejercicio 5

(check-expect (tautología? A 3) #t)
(check-expect (tautología? B 3) #f)
(check-expect (tautología? C 2) #f)
(check-expect (tautología? D 1) #f)
(check-expect (tautología? E 1) #t)
(check-expect (tautología? F 1) #f)
(check-expect (tautología? MP 2) #t)
(check-expect (tautología? MT 2) #t)
(check-expect (tautología? DM1 2) #t)
(check-expect (tautología? G 4) #f)
(check-expect (tautología? H 4) #f)
(check-expect (tautología? I 5) #f)

(check-expect (contradicción? A 3) #f)
(check-expect (contradicción? B 3) #f)
(check-expect (contradicción? C 2) #t)
(check-expect (contradicción? D 1) #f)
(check-expect (contradicción? E 1) #f)
(check-expect (contradicción? F 1) #t)
(check-expect (contradicción? MP 2) #f)
(check-expect (contradicción? MT 2) #f)
(check-expect (contradicción? DM1 2) #f)
(check-expect (contradicción? G 4) #t)
(check-expect (contradicción? H 4) #f)
(check-expect (contradicción? I 5) #f)

(check-expect (satisfactible? A 3) #t)
(check-expect (satisfactible? B 3) #t)
(check-expect (satisfactible? C 2) #f)
(check-expect (satisfactible? D 2) #t)
(check-expect (satisfactible? E 1) #t)
(check-expect (satisfactible? F 1) #f)
(check-expect (satisfactible? MP 2) #t)
(check-expect (satisfactible? MT 2) #t)
(check-expect (satisfactible? DM1 2) #t)
(check-expect (satisfactible? G 4) #f)
(check-expect (satisfactible? H 4) #t)
(check-expect (satisfactible? I 5) #t)