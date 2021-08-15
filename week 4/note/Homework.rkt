#lang simply-scheme

(define (make-interval x y)
  (cons x y))

(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (and (<= (lower-bound y) 0) (>= (upper-bound y) 0))
      (error "Can't divide by an interval that spans error!")
      (mul-interval
       x
       (make-interval (/ 1.0 (upper-bound y))
                      (/ 1.0 (lower-bound y))))))

(define (sub-interval x y)
  (add-interval x (make-interval (- (upper-bound y)) (- (lower-bound y)))))

(add-interval (make-interval 1 2) (make-interval 2 3))
(sub-interval (make-interval 1 2) (make-interval 2 3))

(define (make-center-percent center tolorence)
  (let ((dist (* center tolorence 0.01)))
    (make-interval (- center dist) (+ center dist))))

(define (center interval)
  (/ (+ (upper-bound interval) (lower-bound interval)) 2))

(define (percent interval)
  (* 100 (/ (- (upper-bound interval) (center interval)) (center interval))))

(center (make-interval 1 3))
(percent (make-interval 1 3))

(define (last-pair elements)
  (if (null? (cdr elements))
      elements
      (last-pair (cdr elements))))

(last-pair '(12 13 14))

(define (same-parity x . w)
  (if (= (remainder x 2) 0)
      (append (list x) (filter (lambda (x) (= (remainder x 2) 0)) w))
      (append (list x) (filter (lambda (x) (= (remainder x 2) 1)) w))))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)

(define (for-each f data)
  (if (null? data)
      #t
      (let ((ignore (f (car data))))
        (for-each f (cdr data)))))

(for-each (lambda (x) (newline) (display x)) (list 1 23 3))

(define (substitute lst old new)
  (cond ((null? lst) '())
        ((equal? lst old) new)
        ((pair? lst) (cons (substitute (car lst) old new)
                           (substitute (cdr lst) old new)))
        (else lst)))

(substitute '((lead guitar) (bass guitar) (rhythm guitar) drums) 'guitar 'axe)

(define (find-match ele old-lst new-lst)
  (cond ((null? old-lst) ele)
        ((equal? ele (car old-lst)) (car new-lst))
        (else (find-match ele (cdr old-lst) (cdr new-lst)))))

(define (substitute2 lst old-lst new-lst)
  (cond ((null? lst) '())
        ((pair? lst)
         (cons (substitute2 (car lst) old-lst new-lst)
               (substitute2 (cdr lst) old-lst new-lst)))
        (else (find-match lst old-lst new-lst))))

(define (cxr-function word)
  (define (helper word)
    (if (empty? word)
        (lambda (x) x)
        (compose (if (equal? (first word) 'a) car cdr)
                 (cxr-function (bf word)))))
  (helper (bf (bl word))))

(cxr-function 'cdddadaadar)

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

((one (lambda (x) x)) 1)