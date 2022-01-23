;;; exps: the expressions
;;; env: the environment
;;; this function evaluates each expression and returns a list of the corresponding values.
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (meta-eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))

(define (list-of-arg-values exps env)
  (if (no-operands? exps)
      '()
      (cons (meta-eval (first-operand exps) env)
	    (list-of-arg-values (rest-operands exps)
				env))))
