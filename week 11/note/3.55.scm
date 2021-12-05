(define (partial-sums s)
  (define helper (cons-stream (stream-car s)
                              (add-streams helper (stream-cdr s))))
  helper)