;;; exp: the expression
;;; this function is used to check if the expression is a DEFINITION.
(define (definition? exp)
  (tagged-list? exp 'define))

;;; exp: the expression
;;; this function is used to get the variable of the expression. There are two
;;; forms of the definition, 1. (define x 2) 2. (define (f x) (+ x 1))
(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))

;;; exp: the expression
;;; this function is used to get the value of the expression. For type 1, we return
;;; the value, for type 2, we make a LAMBDA EXPRESSION.
(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)   ; formal paramters
                   (cddr exp)))) ; body

;;; exp: the definition expression, such as (define x 2)
;;; env: the environment
;;; this function is used to define a variable and assign the value to it.
(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
                    (meta-eval (definition-value exp) env)
                    env)
  'ok)