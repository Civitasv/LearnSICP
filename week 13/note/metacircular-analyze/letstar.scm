(define (let*? exp)
  (tagged-list? exp 'let*))

(define (let*-assignments exp)
  (cadr exp))

(define (let*-body exp)
  (cddr exp))

(define (let*->nested-lets exp)
  (define (helper assignments)
    (if (null? assignments)
        (let*-body exp)
        (make-let (list (car assignments)) (helper (cdr assignments)))))
  (helper (let*-assignments exp)))