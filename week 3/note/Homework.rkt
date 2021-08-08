#lang simply-scheme

(define (iterative-improve good-enough? improve)
  (define (iterate guess)
    (if (good-enough? guess)
        guess
        (iterate (improve guess))))
  iterate)


(define (fixed-point f first-guess)
  ((iterative-improve (lambda (guess) (< (abs (- guess (f guess))) 0.001)) f) first-guess))

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1)

(define (cont-frac n d k)
    (cont-frac-iter n d 0 k))

(define (cont-frac-iter n d a b)
    (if (= b 0)
        a
        (cont-frac-iter n d (/ (n b) (+ (d b) a)) (- b 1))))

(define (phi k)
  (/ 1 (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) k)))

(define (cont-frac-recursion n d k)
    (define (helper i)
        (if (> i k)
            0
            (/ (n i) (+ (d i) (helper (+ i 1))))))
    (helper 1))

(cont-frac-recursion (lambda (i) 1.0) (lambda (i) 1.0) 20)

(define approxi-e
    (cont-frac (lambda (x) 1.0) 
               (lambda (x) 
                    (cond ((= x 1) 1)
                          ((= x 2) 2)
                          ((= (remainder (- x 2) 3) 0) (* 2 (/ (- x 2) 3)))
                          (else 1))) 20))
approxi-e

(define (next-perf n)
    (define (sum-of-factors num)
        (cond ((= num 0) 0)
              ((= (remainder n num) 0) (+ num (sum-of-factors (- num 1))))
              (else (sum-of-factors (- num 1)))))
    (if (= (sum-of-factors (- n 1)) n) 
        n
        (next-perf (+ n 1))))
(next-perf 29)

(define (number-of-partitions n)
    (define (helper n type)
        (cond ((= n 0) 1)
              ((or (< n 0) (= type 0)) 0)
              (else (+ (helper n (- type 1))
                 (helper (- n type) type)))))
  (helper n n))
(number-of-partitions 5)
