;;; exp: the expression
;;; this function is used to check if the expression is a LAMBDA.
(define (lambda? exp)
  (tagged-list? exp 'lambda))

;;; exp: the expression
;;; this function is used to get the parameters of the lambda expression.
(define (lambda-parameters exp)
  (cadr exp))

;;; exp: the expression
;;; this function is used to get the body of the lambda expression.
(define (lambda-body exp)
  (cddr exp))

;;; parameters: the lambda parameters
;;; body: the lambda body
;;; this function is used to make a lambda expression.
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

(define (analyze-lambda exp)
  (let ((vars (lambda-parameters exp))
	(bproc (analyze-sequence (lambda-body exp))))
    (lambda (env) (make-procedure vars bproc env))))
