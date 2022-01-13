(define (application? exp)
  (pair? exp))

(define (operator exp)
  (car exp))

(define (operands exp)
  (cdr exp))

(define (no-operands? ops)
  (null? ops))

(define (first-operand ops)
  (car ops))

(define (rest-operands ops)
  (cdr ops))

(define (make-procedure parameters body env)
  (list 'procedure parameters body env))

(define (compound-procedure? p)
  (tagged-list? p 'procedure))

(define (procedure-parameters p)
  (cadr p))

(define (procedure-body p)
  (caddr p))

(define (procedure-environment p)
  (cadddr p))
