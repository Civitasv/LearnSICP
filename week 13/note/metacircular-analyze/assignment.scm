;;; exp: the expression
;;; this function is used to check if the expression is an ASSIGNMENT.
(define (assignment? exp)
  (tagged-list? exp 'set!))

;;; exp: the expression
;;; this function is used to get the variable of the expression.
(define (assignment-variable exp)
  (cadr exp))

;;; exp: the expression
;;; this function is used to get the value of the expression.
(define (assignment-value exp)
  (caddr exp))

;;; exp: the assignment expression, such as (set! x 2)
;;; env: the environment
;;; this function is used to find the value to be assigned and transmits the variable and
;;; the resulting value to SET-VARIABLE-VALUE! to be installed in the designated environment.
(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
                       (meta-eval (assignment-value exp) env)
                       env)
  'ok)

(define (analyze-assignment exp)
  (let ((var (assignment-variable exp))
	(vproc (meta-analyze (assignment-value exp))))
    (lambda (env)
      (set-variable-value! var (vproc env) env)
      'ok)))

