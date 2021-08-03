#lang simply-scheme

(define (substitute sent old new)
  (cond ((empty? sent) '())
        ((equal? (first sent) old) (se new (substitute (bf sent) old new)))
        (else (se (first sent) (substitute (bf sent) old new)))))

(substitute '(she loves you yeah yeah yeah) 'yeah 'maybe)

(define (g)
  (lambda (x) (+ 2 x)))

(define (make-tester w)
  (lambda (x) (equal? x w)))