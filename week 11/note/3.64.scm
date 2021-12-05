(define (abs x)
  (if (< x 0)
      (- x)
      x))

(define (stream-limit s tolerance)
  (cond ((or (stream-null? s) (stream-null? (stream-cdr s))) -1)
        ((< (abs (- (stream-car s) (stream-car (stream-cdr s)))) tolerance) (stream-car (stream-cdr s)))
        (else (stream-limit (stream-cdr s) tolerance))))