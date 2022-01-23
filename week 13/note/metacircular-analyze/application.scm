(define (analyze-application exp)
  (let ((fproc (meta-analyze (operator exp)))
	(aprocs (map meta-analyze (operands exp))))
    (lambda (env) (execute-application (fproc env)
				       (map (lambda (aproc)
					      (aproc env))
					    aprocs)))))

(define (execute-application proc args)
  (cond ((primitive-procedure? proc)
	 (apply-primitive-procedure proc args))
	((compound-procedure? proc)
	 ((procedure-body proc)
	  (extend-environment
	   (procedure-parameters proc)
	   args
	   (procedure-environment proc))))
	(else
	 (error "Unkown procedure type -- EXECUTE-APPLICATION" proc))))
