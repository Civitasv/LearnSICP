#lang simply-scheme

(define (calc)
  (display ">> ")
  (flush-output)
  (print (calc-eval (read)))
  (display "\n")
  (calc))

(define (accumulate op init seqs)
  (if (null? seqs)
      init
      (op (car seqs) (accumulate op init (cdr seqs)))))

(define (calc-apply op args)
  (cond ((eq? op '+) (accumulate + 0 args))
        ((eq? op '-) (cond ((null? args) (error "Calc: no args to -"))
                           ((= (length args) 1) (- (car args)))
                           (else (- (car args) (accumulate + 0 (cdr args))))))
        ((eq? op '*) (accumulate * 1 args))
        ((eq? op '/) (cond ((null? args) (error "Calc: no args to /"))
                           ((= (length args) 1) (/ (car args)))
                           (else (/ (car args) (accumulate * 1 (cdr args))))))
        ((eq? op 'first) (first (car args)))
        ((eq? op 'butfirst) (bf (car args)))
        ((eq? op 'last) (last (car args)))
        ((eq? op 'butlast) (butlast (car args)))
        ((eq? op 'word) (apply word args))
        (else (error "Calc: bad operator:" op))))

(define (calc-eval exp)
  (cond ((number? exp) exp)
        ((word? exp) exp)
        ((list? exp) (calc-apply (car exp) (map calc-eval (cdr exp))))
        (else (error "Calc: bad expression: " exp))))

(calc)
