(load "tagged-list.scm")
(load "self-evaluating.scm")
(load "variable.scm")
(load "quotation.scm")
(load "assignment.scm")
(load "definition.scm")
(load "predicate.scm")
(load "if.scm")
(load "lambda.scm")
(load "begin.scm")
(load "sequence.scm")
(load "cond.scm")
(load "procedure.scm")
(load "list-of-values.scm")
(load "environment.scm")
(load "primitive.scm")

(define (meta-eval exp env)
  (display "EXPRESSION:")
  (newline)
  (display exp)
  (newline)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp) (make-procedure (lambda-parameters exp)
                                       (lambda-body exp)
                                       env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (meta-eval (cond->if exp) env))
        ((application? exp)
         (meta-apply (meta-eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else 
         (error "Unknown expression type: EVAL" exp))))

(define (meta-apply procedure arguments)
  (display "APPLY")
  (newline)
  (user-print procedure)
  (newline)
  (display arguments)
  (newline)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure)
         (eval-sequence
           (procedure-body procedure)
           (extend-environment
             (procedure-parameters procedure)
             arguments
             (procedure-environment procedure))))
        (else (error "Unknown procedure type: APPLY" procedure))))
