(define (ordinal n)
  (lambda (lst)
    (list-ref lst (- n 1))))

(define third (ordinal 3))
(third '(John Paul George Ringo))
