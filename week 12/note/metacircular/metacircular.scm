(load "tagged-list.scm")
(load "self-evaluating.scm")
(load "variable.scm")
(load "quotation.scm")
(load "assignment.scm")
(load "definition.scm")
(load "undefine.scm")
(load "predicate.scm")
(load "if.scm")
(load "and.scm")
(load "or.scm")
(load "let.scm")
(load "letstar.scm")
(load "lambda.scm")
(load "begin.scm")
(load "sequence.scm")
(load "cond.scm")
(load "procedure.scm")
(load "list-of-values.scm")
(load "environment.scm")
(load "primitive.scm")

(define (meta-eval exp env)
  (with-timings
   (lambda ()
     (cond ((self-evaluating? exp) exp)
           ((variable? exp) (lookup-variable-value exp env))
           ((quoted? exp) (text-of-quotation exp))
           ((assignment? exp) (eval-assignment exp env))
           ((definition? exp) (eval-definition exp env))
           ((undefine? exp) (eval-undefine exp env))
           ((if? exp) (eval-if exp env))
           ((and? exp) (eval-and exp env))
           ((or? exp) (eval-or exp env))
           ((let? exp) (meta-eval (let->combination exp) env))
           ((let*? exp) (meta-eval (let*->nested-lets exp) env))
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
            (error "Unknown expression type: EVAL" exp))))))

(define (meta-apply procedure arguments)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure)
         (eval-sequence
           (procedure-body procedure)
           (extend-environment
             (JUST-NAMES (procedure-parameters procedure))
             (USE-DEFAULTS (PROCEDURE-PARAMETERS PROCEDURE) arguments)
             (procedure-environment procedure))))
        (else (error "Unknown procedure type: APPLY" procedure))))

(DEFINE (JUST-NAMES VARS)
  (MAP (LAMBDA (X)
               (IF (PAIR? x)
                   (CAR X)
                   X))
       VARS))
(DEFINE (USE-DEFAULTS VARS VALS)
  (DEFINE (HELPER VARS)
    (COND ((NULL? VARS) '())
          ((PAIR? (CAR VARS))
           (CONS (CADAR VARS) (HELPER (CDR VARS))))
          (ELSE '())))

  (CONS ((NULL? VARS) VALS)
        ((NULL? VALS) (HELPER VARS))
        (ELSE (CONS (CAR VALS) (USE-DEFAULTS (CDR VARS) (CDR VALS))))))
