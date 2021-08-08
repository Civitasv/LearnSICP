#lang simply-scheme

(define (product fn a next b)
        (if (> a b)
            1
            (* (fn a) (product fn (next a) next b))))


(define (factorial n)
  (product (lambda (x) x) 1 (lambda (x) (+ 1 x)) n))


(factorial 3)

(define (pi terms)
  (* 4 (product (lambda (x) (/ (* (- x 1) (+ x 1))
                               (* x x)))
                3
                (lambda (x) (+ x 2))
                terms)))

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate combiner null-value term (next a) next b))))

(define (sum fn a next b)
  (accumulate + 0 fn a next b))

;(define (product fn a next b)
 ; (accumulate * 1 fn a next b))

(define (filtered-accumulate PRED combiner null-value term a next b)
  (if (> a b)
      null-value
      (if (PRED a)
          (combiner (term a) (filtered-accumulate PRED combiner null-value term (next a) next b))
          (filtered-accumulate PRED combiner null-value term (next a) next b))
      ))

;(define (sum-square-prime a b)
 ; (filtered-accumulate prime? + 0 (lambda (x) (* x x)) a (lambda (x) (+ x 1)) b))

;(define (product-positive n)
 ; (filtered-accumulate (lambda (x) (= 1 (gcd x n))) * 1 (lambda (x) x) 1 (lambda (x) (+ 1 x)) n))

(define tolerance 0.00001)
;(define (fixed-point f first-guess)
 ; (define (close-enough ? v1 v2)
  ;  (< (abs (- v1 v2)) tolerance))

  ;(define (try guess)
   ; (let ((next (f guess)))
    ;  (if (close-enough? guess next)
     ;     next
      ;    (try next))))

  ;(try first-guess))

(define (cubic a b c)
  (lambda (x) (+ (* x x x) (* a x x) (* b x) c)))

(define (double f)
  (lambda (x) (f (f x))))

((double (lambda(x) (+ 1 x))) 3)

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (lambda (x)
    (if (= n 0)
        (lambda (x) x)
        (compose f (repeated f (- n 1))))))

(define (iterative-improve good-enough? improve)
  (define (iterate guess)
    (if (good-enough? guess)
        guess
        (iterate (improve guess))))
  iterate)
(define square (lambda (x) (* x x)))

(define average (lambda (x y) (/ (+ x y) 2)))

(define (sqrt x)
  ((iterative-improve (lambda (guess) (< (abs (- (square guess) x)) 0.001)) (lambda (guess) (average guess (/ x guess))) ) x))

(define (fixed-point f first-guess)
  ((iterative-improve (lambda (guess) (< (abs (- guess (f guess))) 0.001)) f) first-guess))

(define (every f sent)
  (if (empty? sent)
      '()
      (se (f (first sent)) (every f (bf sent)))))

(every first '(nowhere ma))

(  (  (lambda (f) (lambda (n) (f f n)))
      (lambda (fun x)
	(if (= x 0)
	    1
	    (* x (fun fun (- x 1)))))  )
   5)

((lambda (f n) (if (= n 0) 1 (* n (f f (- n 1)))))
 (lambda (f n) (if (= n 0) 1 (* n (f f (- n 1)))))
 5)
