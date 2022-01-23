;;; exp: the expression
;;; this function is used to check if the expression is a QUOTATION.
(define (quoted? exp)
  (tagged-list? exp 'quote))

;;; exp: the expression
;;; this function is used to get the value of the quotation
(define (text-of-quotation exp)
  (cadr exp))

(define (process-quotation quoted env)
  (if (pair? quoted)
      (lazy-cons (process-quotation (car quoted) env)
		 (process-quotation (cdr quoted) env)
		 env)
      quoted))

(define (lazy-cons x y env)
  (make-procedure '(m) (list (list 'm x y)) env))
