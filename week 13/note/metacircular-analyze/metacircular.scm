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
(load "application.scm")

(define (meta-analyze exp)
  (cond ((self-evaluating? exp) (analyze-self-evaluating exp))
        ((variable? exp)
	 (analyze-variable exp))
        ((quoted? exp) (analyze-quoted exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((undefine? exp) (analyze-undefine exp))
        ((if? exp) (analyze-if exp))
        ((and? exp) (analyze-and exp))
        ((or? exp) (analyze-or exp))
        ((let? exp) (meta-analyze (let->combination exp)))
        ((let*? exp) (meta-analyze (let*->nested-lets exp) env))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp)
         (analyze-sequence (begin-actions exp)))
        ((cond? exp) (meta-analyze (cond->if exp)))
        ((application? exp)
         (analyze-application exp))
        (else 
         (error "Unknown expression type: ANALYZE" exp))))

(define (meta-eval exp env)
  (with-timings
   (lambda () ((meta-analyze exp) env))
   (lambda (a b c)
     (display a)
     (display ", ")
     (display b)
     (display ", ")
     (display c))))
  
