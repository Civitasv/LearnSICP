# CS 61A Week 12

Topic: Metacircular evaluator

## Reading

Abelson & Sussman, 4.1.1-6

MapReduce paper in course reader.

## Homework

Problem 1:

**4.3:**

```Scheme
(define (meta-eval exp env)
  (display "EXPRESSION:")
  (newline)
  (display exp)
  (newline)

  (put 'quote 'eval text-of-quotation)
  (put 'set! 'eval eval-assignment)
  (put 'define 'eval eval-definition)
  (put 'if 'eval eval-if)
  (put 'and 'eval eval-and)
  (put 'or 'eval eval-or)
  (put 'lambda 'eval
    (lambda (exp env)
      (make-procedure (lambda-parameters exp)
                      (lambda-body exp)
                      env)))
  (put 'begin 'eval
    (lambda (exp env)
      (eval-sequence (begin-actions exp) env)))
  (put 'cond 'eval
    (lambda (exp env)
      (meta-eval (cond->if exp) env)))
  
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        (else (let ((form (get (operator exp) 'eval)))
                (if form
                  (form exp env)
                  (meta-apply (meta-eval (operator exp) env)
                              (list-of-values (operands exp) env)))))))
```

**4.6:**

```Scheme
(define (let? exp)
  (display "LET")
  (newline)
  (display exp)
  (newline)
  (tagged-list? exp 'let))

(define (let-assignments exp)
  (cadr exp))

(define (let-body exp)
  (cddr exp))

(define (let->combination exp)
  (display "LET->COMBINATION")
  (let ((parameters (map car (let-assignments exp)))
        (body (let-body exp))
        (expressions (map cadr (let-assignments exp))))
    (cons (make-lambda parameters body)
          expressions)))
```

**4.7:**

```Scheme
(define (let*? exp)
  (tagged-list? exp 'let*))

(define (let*-assignments exp)
  (cadr exp))

(define (let*-body exp)
  (cddr exp))

(define (let*->nested-lets exp)
  (define (helper assignments)
    (if (null? assignments)
        (let*-body exp)
        (make-let (list (car assignments)) (helper (cdr assignments)))))
  (helper (let*-assignments exp)))
```

It is sufficient.

**4.10:**

```Scheme
;;; exp: the expression
;;; this function is used to check if the expression is a QUOTATION.
(define (quoted? exp)
  (tagged-list? exp 'quotes))

;;; exp: the expression
;;; this function is used to get the value of the quotation
(define (text-of-quotation exp)
  (cadr exp))
```

By changing the quote to quotes, now we can use `(quotes 2)` to quote something.

**4.11:**

```Scheme
(define (make-frame variables values)
  (attach-tag 'frame (map cons variables values)))

(define (frame-variables frame)
  (map car (contents frame)))

(define (frame-values frame)
  (map cdr (contents frame)))

(define (add-binding-to-frame! var val frame)
  (set-cdr! frame (cons (cons var val) (contents frame))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (DEFINE (SCAN ALIST)
      (LET ((RESULT (ASSOC VAR ALIST)))
	      (IF RESULT
	          (CDR RESULT)
	          (ENV-LOOP (ENCLOSING-ENVIRONMENT ENV)))))
    (if (eq? env the-empty-environment)
	      (error "Unbound variable" var)
	      (let ((frame (first-frame env)))
	        (SCAN (CONTENTS FRAME)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (DEFINE (SCAN ALIST)
      (LET ((RESULT (ASSOC VAR ALIST)))
	      (IF RESULT
	        (SET-CDR! RESULT VAL)
	        (ENV-LOOP (ENCLOSING-ENVIRONMENT ENV)))))
    (if (eq? env the-empty-environment)
	      (error "Unbound variable -- SET!" var)
	      (let ((frame (first-frame env)))
	        (SCAN (CONTENTS FRAME)))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (DEFINE (SCAN ALIST)
      (LET ((RESULT (ASSOC VAR ALIST)))
	      (IF RESULT
	          (SET-CDR! RESULT VAL)
	          (ADD-BINDING-TO-FRAME! VAR VAL FRAME))))
    (SCAN (CONTENTS FRAME))))
```

**4.13:**

```Scheme
(define (undefine? exp)
  (tagged-list? exp 'undefine))

(define (undefine-variable exp)
  (cadr exp))

(define (eval-undefine exp env)
  (define (unbind-in-frame sym frame)
    (frame-remove-binding! sym frame))
  (define (env-iter sym env)
    (cond ((eq? env the-empty-environment) 'okay)
	        ((memq sym (frame-variables (first-frame env)))
	         (unbind-in-frame sym (first-frame env)))
	        (else (env-iter sym (enclosing-environment env)))))
  (env-iter (undefine-variable exp) env))

(define (frame-remove-binding! sym frame)
  (define (remove-not-first-binding vars vals)
    (if (eq? sym (cadr vars))
        (begin (set-cdr! vars (cddr vars))
               (set-cdr! vals (cddr vals)))
        (remove-not-first-binding (cdr vars) (cdr vals))))
  (if (eq? sym (car (frame-variables frame)))
      (begin (set-car! frame (cdr (frame-variables frame)))
             (set-cdr! frame (cdr (frame-values frame))))
      (remove-not-first-binding (frame-variables frame)
                                (frame-values frame))))
```

**4.14:**

This question is about level confusion.  Let's talk about meta-Scheme, the one implemented by the metacircular evaluator, and under-Scheme, the regular Scheme in which the MCE is written.

Eva defines MAP in meta-Scheme.  In particular, when MAP tries to invoke a meta-Scheme procedure for each element of the list, it's doing a meta-Scheme invocation.

Louis uses the MAP that's defined in under-Scheme.  When he calls MAP, he is giving it a meta-Scheme procedure as its first argument, but it's expecting an under-Scheme procedure.  From the point of view of under-Scheme, a meta-Scheme procedure isn't a procedure at all -- it's a list whose car is the word PROCEDURE.

**4.15:**

This is the most famous problem in automata theory, the most elegant proof that some things can't be done no matter how sophisticated our computers become. The proof was first given using the "Turing machine," an abstract machine that's used only for proving theorems.  But the same idea works in any formal system that's capable of representing a procedure as data; the key element of the proof is the fact that the hypothetical HALTS? is a higher-order function.

Suppose that (HALTS? TRY TRY) returns #T.  Then when we call (TRY TRY) it says, after argument substitution,

```Scheme
(if (halts? try try)
  (run-forever)
	'halted)
```

But this will run forever, and so (TRY TRY) runs forever, and so (HALTS? TRY TRY) should have returned #F.

Similarly, suppose that (HALTS? TRY TRY) returns #F.  Then (TRY TRY) turns into the same IF expression shown above, but this time the value of that expression is the word HALTED -- that is, it halts. So (HALTS? TRY TRY) should have returned #T.

Problem 2:

```Scheme
(define (extend-environment vars vals base-env)
  (let ((res-vars '())
        (res-vals '()))
    (define (helper vars vals)
      (cond ((null? vars) (make-frame res-vars res-vals))
            (else
              (let ((has-validation? (pair? (car vars))))
                  (if has-validation?
                      (if (true? (meta-eval (car vars) (cons (make-frame (list (cadar vars)) (list (car vals))) base-env)))
                          (begin (set! res-vars (cons (cadar vars) res-vars))
                                 (set! res-vals (cons (car vals) res-vals))
                                 (helper (cdr vars) (cdr vals)))
                          (error "ERROR: wrong argument type--" (cadar vars)))
                      (begin (set! res-vars (cons (car vars) res-vars))
                             (set! res-vals (cons (car vals) res-vals))
                             (helper (cdr vars) (cdr vals))))))))
  
    (if (= (length vars) (length vals))
        (cons (helper vars vals) base-env)
        (if (< (length vars) (length vals))
            (error "Too many arguments supplied" vars vals)
            (error "Too few arguments supplied" vars vals)))))

;; A better solution
(define (make-frame variables values base-env)
  (define (type-check var val)
    (if (and (pair? var)
             (not (meta-apply (meta-eval (car var) base-env)
                              (list val))))
        (error "WRONG ARGUMENT TYPE" val)))
        
  (define (scan vars vals)
    (cond ((null? vars) #t)
	        (else (type-check (car vars) (car vals))
		            (scan (cdr vars) (cdr vals)))))
  (scan variables values)
  (cons (just-names variables) values))

(define (just-names vars)
  (cond ((null? vars) '())
	      ((pair? (car vars))
	       (cons (cadar vars) (just-names (cdr vars))))
	      (else (cons (car vars) (just-names (cdr vars))))))

(define (extend-environment vars vals base-env) 
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals base-env) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals)))) 
```

## Extra for experts

TODO
