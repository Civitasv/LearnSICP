(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))

(define (append x y)
  (set-cdr! (lat-pair x) y)
  x)