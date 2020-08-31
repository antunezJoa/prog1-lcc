;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname TP4-Antunez-Aseguinolaza) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
#|
Trabajo Práctico 4: Listas

Integrantes:
- Antunez, Joaquin, comisión 1.
- Aseguinolaza, Luis , comisión 1.
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Datos ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;; Diseño de datos

; Representaremos fechas mediante strings, según el formato aaaa-mm-dd.
; Representaremos los nombres de las localidades y departamentos mediante strings.
; Representaremos la cantidad de casos (sospechosos, descartados y confirmados)
; mediante números.

(define-struct notificacion [fecha loc conf desc sosp notif])
; notificacion es (String, String, Number, Number, Number, Number)
; Interpretación: un elemento en notificacion representa el conjunto de notificaciones
; registradas en una localidad (loc) hasta un día (fecha), en donde:
; - hay conf casos confirmados de COVID-19
; - hay desc casos descartados de COVID-19
; - sosp casos estaban en estudio.
; El último elemento, notif, indica la cantidad total de notificaciones.

;;;;;;;;;;;; Preparación de los Datos

;;;;;; Datos sobre localidades santafesinas

; Datos de entrada sobre localidades
(define INPUT-LOC (read-csv-file "dataset/santa_fe_departamento_localidad.csv"))
(define DATOS-LOC (rest INPUT-LOC))

; tomar-dos : List(X) -> List(X)
; Dada una lista l de dos o más elementos, tomar-dos calcula
; la lista formada por los dos primeros elementos de l, en
; ese orden.
(check-expect (tomar-dos (list "a" "b")) (list "a" "b")) 
(check-expect (tomar-dos (list 0 1 2 3)) (list 0 1))
(define
  (tomar-dos l)
  (list (first l) (second l)))

; Lista de localidades santafecinas
(define LISTA-LOC (map second DATOS-LOC))
; Lista de localidades santafecinas, con su departamento
(define LISTA-DPTO-LOC (map tomar-dos DATOS-LOC))

;;;;;; Datos sobre notificaciones de COVID-19

; Datos de entrada sobre notificaciones
(define INPUT-NOTIF (read-csv-file "dataset/notificaciones_localidad.csv"))
(define DATOS-NOTIF (rest INPUT-NOTIF))

; Lista de notificaciones
; [Completar, ejercicio 1]

; listToNoti : List(X) -> notificacion
; dada una lista l de 6 elementos en un orden específico, convierte esa lista en una
; estructura de tipo notificacion.
(check-expect (listToNoti (list "2020-06-02" "ZAVALLA" "0" "4" "0" "4")) (make-notificacion "2020-06-02" "ZAVALLA" 0 4 0 4))
(check-expect (listToNoti (list "2020-06-02" "VILLA LA RIVERA - OLIVEROS" "0" "1" "0" "1")) (make-notificacion "2020-06-02" "VILLA LA RIVERA - OLIVEROS" 0 1 0 1))
(define (listToNoti l)
  (make-notificacion (first l) (second l) (string->number (third l)) (string->number (fourth l)) (string->number (fifth l)) (string->number (sixth l))))

(define LISTA-NOTIF (map listToNoti DATOS-NOTIF))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Consultas ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define ANTES "2020-04-02")
(define HOY "2020-06-02")
(define LIMITE-CASOS 25)

;;;;;;;;;;;; Consulta 1

; [Completar, ejercicio 2-1]

; filtro-casos : notificacion -> Boolean
; dada una notificacion determina si esta presenta LIMITE-CASOS o mas hasta el día HOY
(check-expect (filtro-casos (make-notificacion "2020-06-02" "ZAVALLA" 30 0 0 4) ) #true )
(check-expect (filtro-casos (make-notificacion "2020-06-02" "SAN GERONIMO" 25 0 0 4) ) #true )
(check-expect (filtro-casos (make-notificacion "2020-06-02" "PERGAMINO" 15 0 0 4) ) #false )
(define (filtro-casos c)
  (and (equal? (notificacion-fecha c)  HOY) (>= (notificacion-conf c) LIMITE-CASOS)))

; localidad : notificacion -> String
; dada una estrucutura de tipo notificacion devuelve el apartado localidad
(check-expect (localidad (make-notificacion "2020-06-02" "ZAVALLA" 30 0 0 4)) "ZAVALLA")
(check-expect (localidad (make-notificacion "2020-06-02" "VILLA LA RIVERA - OLIVEROS" 0 15 0 1)) "VILLA LA RIVERA - OLIVEROS")
(define (localidad c)
  (notificacion-loc c))

; ListaNoti es:
; - empty
; - cons notificación ListaNoti
; interpretación: es una lista de estructuras de tipo notificacion

; ListaStrings es:
; - empty
; - cons String ListaStrings
; interpretación: es una lista de Strings

; localidades-limite-casos : ListaNoti -> ListaStrings
; dada una lista de notificaciones,
; devuelva la lista de localidades que presentan LIMITE-CASOS o
; más casos confirmados de COVID-19 hasta el día HOY
(check-expect (localidades-limite-casos (list (make-notificacion "2020-06-02" "ZAVALLA" 30 0 0 4)
                                              (make-notificacion "2020-06-02" "VILLA LA RIVERA - OLIVEROS" 0 15 0 1) )) (list "ZAVALLA"))
(check-expect (localidades-limite-casos empty) empty)
(check-expect (localidades-limite-casos (list (make-notificacion "2020-06-02" "ZAVALLA" 30 0 0 4)
                                              (make-notificacion "2020-06-02" "SAN GERONIMO" 25 0 0 4)
                                              (make-notificacion "2020-06-02" "PERGAMINO" 15 0 0 4)
                                              (make-notificacion "2020-06-02" "VILLA LA RIVERA - OLIVEROS" 0 15 0 1))) (list "ZAVALLA" "SAN GERONIMO"))
(define (localidades-limite-casos l)
  (map localidad (filter filtro-casos l)))

; [Completar, ejercicio 2-2]
(define LOCALIDADES-LIMITE-CASOS (localidades-limite-casos LISTA-NOTIF))

;;;;;;;;;;;; Consulta 2

; [Completar, ejercicio 3-1]

; unique : ListaStrings -> ListaStrings
; dada una lista de strings devuelve otra lista de strings sin duplicados
(check-expect (unique (list "ZAVALLA" "ZAVALLA")) (list "ZAVALLA"))
(check-expect (unique (list "ROSARIO" "ROSARIO" "SANTA FE" "SANTA FE")) (list "ROSARIO" "SANTA FE"))
(check-expect (unique empty) empty)
(define (unique l) (cond [(empty? l) empty]
                         [(= (length l) 1) l]
                         [(equal? (first l) (first (rest l))) (unique (rest l))]
                         [else (cons (first l) (unique (rest l)))]))

(define LISTA-DPTO (unique (map first DATOS-LOC)))

; [Completar, ejercicio 3-2]

; ListaLS es:
; - empty
; - cons ListaStrings ListaLS
; interpretación: ListaLS es una lista de listas donde cada elemento de ListaLS es una ListaString

; perteneceDpto: ListaLS String String -> Boolean
; dado un departamento, una ciudad y una lista de departamentos y ciudades vinculados
; determina si esa ciudad corresponde a dicho departamento.
(check-expect (perteneceDpto DATOS-LOC "Rosario" "ROSARIO") #true)
(check-expect (perteneceDpto DATOS-LOC "Vera" "TOBA") #true)
(check-expect (perteneceDpto DATOS-LOC "Vera" "Rosario") #false)
(define (perteneceDpto lista dpto ciudad) (cond [(empty? lista) false]
                                                [else (or (and (equal? dpto (first (first lista))) (equal? ciudad (second (first lista)))) (perteneceDpto (rest lista) dpto ciudad))]))

; confirmados-dpto-fecha : ListaNoti String String -> Number
; dada una lista de notificaciones, un departamento y una fecha, calcule la cantidad de casos
; confirmados registrados en dicho departamento hasta la fecha en cuestión
(check-expect (confirmados-dpto-fecha LISTA-NOTIF "Rosario" HOY) 124)
(check-expect (confirmados-dpto-fecha LISTA-NOTIF "Vera" HOY) 1)
(define (confirmados-dpto-fecha lista dpto fecha) (cond [(empty? lista) 0]
                                                        [else (if (and (perteneceDpto DATOS-LOC dpto (notificacion-loc (first lista)) ) (equal? (notificacion-fecha (first lista) ) fecha ) )
                                                                  (+ (notificacion-conf (first lista)) (confirmados-dpto-fecha (rest lista) dpto fecha))
                                                                  (confirmados-dpto-fecha (rest lista) dpto fecha))]))

; [Completar, ejercicio 3-3]

; Lista-tuplas es:
; - empty
; - cons (list String Number) Lista-tuplas
; interpretación: es una lista de listas donde un elemento de lista-tuplas
; es una tupla formada por dos elementos, un String correspondiente al nombre
; de un departamento y un numero correspondiente al número de casos confirmados que se
; han registrado allí hasta una fecha en cuestión

; conf-por-depto-aux : ListaStrings ListaNoti String -> Lista-tuplas
; dada una lista de
; notificaciones, una lista de strings que representan departamentos y una fecha, devuelva una lista de listas de longitud dos: una
; por cada departamento santafesino, donde el primer elemento sea el nombre
; del departamento y el segundo sea el número de casos confirmados que se
; han registrado allí hasta la fecha en cuestión
(check-expect (conf-por-depto-aux (list "Rosario" "San Jerónimo") (list (make-notificacion "2020-06-02" "ZAVALLA" 30 0 0 4)
                                                                        (make-notificacion "2020-06-02" "CORONDA" 25 0 0 4)
                                                                        (make-notificacion "2020-06-02" "SAN GENARO" 10 0 0 4) ) HOY) (list (list "Rosario" 30)
                                                                                                                                            (list "San Jerónimo" 35)))
(check-expect (conf-por-depto-aux (list "Rosario" "Vera") (list (make-notificacion "2020-06-02" "ZAVALLA" 30 0 0 4)
                                                                (make-notificacion "2020-06-02" "VILLA GOBERNADOR GALVEZ" 7 0 0 4) ) HOY) (list (list "Rosario" 37)
                                                                                                                                                (list "Vera" 0)))
(define (conf-por-depto-aux listadptos listanoti fecha) (cond [(empty? listadptos) empty]
                                                              [else (cons (list (first listadptos) (confirmados-dpto-fecha listanoti (first listadptos) fecha)) (conf-por-depto-aux (rest listadptos) listanoti fecha))]))

; confirmados-por-dpto : ListaNoti String -> Lista-tuplas
; dada una lista de
; notificaciones y una fecha, devuelva una lista de listas de longitud dos: una
; por cada departamento santafesino, donde el primer elemento sea el nombre
; del departamento y el segundo sea el número de casos confirmados que se
; han registrado allí hasta la fecha en cuestión
(define (confirmados-por-dpto lista fecha)
  (conf-por-depto-aux LISTA-DPTO lista fecha))

; [Completar, ejercicio 3-4]

(define CONFIRMADOS-DPTO-ANTES (confirmados-por-dpto LISTA-NOTIF ANTES))
(define CONFIRMADOS-DPTO-HOY (confirmados-por-dpto LISTA-NOTIF HOY))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Salidas ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;; Consulta 1

; [Completar, ejercicio 4 - loc-lim-casos.csv]

; normalizar : ListaStrings -> String
; Dada una lista de strings que representan localidades, devuelve un string donde entre localidades se encuentra un caracter "\n",
; al igual que al final del string para así obtener el formato requerido por la función write-file.
(check-expect (normalizar (list "ROSARIO" "SANTA FE")) "ROSARIO\nSANTA FE\n")
(check-expect (normalizar empty) "")
(define (normalizar lista) (cond [(empty? lista) ""]
                                 [else (string-append (first lista) "\n" (normalizar (rest lista)))]))

(write-file "loc-lim-casos.csv" (string-append "Localidad\n" (normalizar LOCALIDADES-LIMITE-CASOS)))

;;;;;;; Consulta 2

; [Completar, ejercicio 4 - casos-por-dpto-hoy.csv y casos-por-dpto-antes.csv]

; normalizarv2 : Lista-tuplas -> String
; Dada una lista-tuplas, devuelve un string donde cada departamento y su respectiva cantidad de casos se encuentran separado por una coma
; y cada registro ( departamento , caso ) por un "\n" para así obtener el formato requerido por la función write-file
(check-expect (normalizarv2 empty) "")
(check-expect (normalizarv2 (list (list "9 de Julio" 0) (list "Belgrano" 5))) "9 de Julio,0\nBelgrano,5\n")
(define (normalizarv2 l) (cond [(empty? l) ""]
                               [else (string-append (first (first l)) "," (number->string (second (first l))) "\n" (normalizarv2 (rest l)))]))

(write-file "casos-por-dpto-hoy.csv" (string-append "Departamento, Casos\n" (normalizarv2 CONFIRMADOS-DPTO-HOY)))

(write-file "casos-por-dpto-antes.csv" (string-append "Departamento, Casos\n" (normalizarv2 CONFIRMADOS-DPTO-ANTES)))