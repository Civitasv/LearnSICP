;;; exp: the expression
;;; this function is used to check if the expression is IF.
(define (if? exp)
  (tagged-list? exp 'if))

;;; exp: the expression
;;; this function is used to get the predicate part of the expression.
(define (if-predicate exp)
  (cadr exp))

;;; exp: the expression
;;; this function is used to get the consequent part of the expression.
(define (if-consequent exp)
  (caddr exp))

;;; exp: the expression
;;; this function is used to get the alternative part of the expression.
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

;;; predicate: the predicate part
;;; consequent: the consequent part
;;; alternative: the alternative part
;;; this function is used to construct a IF expression.
(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

;;; exp: if expression, such as: (if (> 1 2) 1 2)
;;; env: the environment
;;; this function evaluates the predicate part of the if expression, if the result is
;;; true, then evaluates the consequent, otherwise it evaluates the alternative.
(define (eval-if exp env)
  (if (true? (meta-eval (if-predicate exp) env))
      (meta-eval (if-consequent exp) env)
      (meta-eval (if-alternative exp) env)))

(define (analyze-if exp)
  (let ((pproc (meta-analyze (if-predicate exp)))
	(cproc (meta-analyze (if-consequent exp)))
	(aproc (meta-analyze (if-alternative exp))))
    (lambda (env) (if (true? (pproc env))
		      (cproc env)
		      (aproc env)))))
