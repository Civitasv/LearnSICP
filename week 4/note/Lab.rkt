#lang simply-scheme

(define x (cons 4 5))
(car x)
(cdr x)
(define y (cons 'hello 'goodbye))
(define z (cons x y))
(car (cdr z))
(cdr (cdr z))
(cdr (car z))
(car (cons 8 3))
(car z)

(define (make-rational num den)
  (cons num den))

(define (numerator rat)
  (car rat))

(define (denominator rat)
  (cdr rat))

(define (*rat a b)
  (make-rational (* (numerator a) (numerator b))
                 (* (denominator a) (denominator b))))

(define (+rat a b)
  (make-rational (+ (* (numerator a) (denominator b)) (* (numerator b) (denominator a))) (* (denominator a) (denominator b))))

(define (print-rat rat)
  (word (numerator rat) '/ (denominator rat)))

(print-rat (make-rational 2 3))
(print-rat (*rat (make-rational 2 3) (make-rational 1 4)))
(print-rat (+rat (make-rational 2 3) (make-rational 1 4)))

(define test '(a (b c) d))
(car test)
(cdr test)
(car (cdr test))

(define (make-segment p1 p2)
  (cons p1 p2))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (midpoint-segment segment)
  (make-point (/ (+ (x-point (start-segment segment)) (x-point (end-segment segment))) 2)
              (/ (+ (y-point (start-segment segment)) (y-point (end-segment segment))) 2)))

(midpoint-segment (make-segment (make-point 1 3) (make-point 2 4)))

(define (make-rectangle side1 side2)
  (cons side1 side2))

(define (first-leg rectangle)
  (car rectangle))

(define (second-leg rectangle)
  (cdr rectangle))

(define (square x) (* x x))

(define (segment-length segment)
  (sqrt (+ (square (- (x-point (end-segment segment)) (x-point (start-segment segment))))
           (square (- (y-point (end-segment segment)) (y-point (start-segment segment)))))))

(define (perimeter rectangle)
  (* 2 (+ (segment-length (first-leg rectangle))
          (segment-length (second-leg rectangle)))))

(define (area rectangle)
  (* (segment-length (first-leg rectangle))
     (segment-length (second-leg rectangle))))
     
(define (make-rectangle2 base height)
  (cons base height))

(define (~cons x y)
  (lambda (m) (m x y)))

(define (~car z)
  (z (lambda (p q) p)))

(define (~cdr z)
  (z (lambda (p q) q)))

(~car (~cons 2 3))
(~cdr (~cons 2 3))

(define (reverse3 lst)
  (define (helper lst res)
    (if (null? lst)
        res
        (helper (cdr lst) (cons (car lst) res))))
  (helper lst null))

(define (reverse2 lst)
  (if (null? lst)
      '()
      (append (reverse2 (cdr lst)) (list (car lst)))))

(reverse2 (list 1 2 3 4 5 6))
(reverse3 (list 1 2 3 4 5 6))