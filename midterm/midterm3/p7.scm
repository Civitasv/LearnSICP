(define foo
  (cons-stream '()
               (interleave (stream-map (lambda (p) (cons 'over p)) foo)
                           (stream-map (lambda (p) (cons 'under p)) foo))))

(define patterns
  (stream-filter (lambda (p) (and (member 'over p) (member 'under p)))
                 foo))
