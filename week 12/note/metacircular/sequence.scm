;;; seq: the sequence
;;; this function is used to check if the sequence has only one expression.
(define (last-exp? seq)
  (null? (cdr seq)))

;;; seq: the sequence
;;; this function is used to get the first expression of the sequence.
(define (first-exp seq)
  (car seq))

;;; seq: the sequence
;;; this function is used to get the rest expressions of the sequence.
(define (rest-exps seq)
  (cdr seq))

;;; seq: the sequence expressions
;;; this function is used to transform a sequence into a single expression, using begin.
(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))

;;; exps: the sequence of expressions
;;; env: the environment
;;; this function is used by APPLY to evaluate the sequence of expressions in a procedure
;;; body and by EVAL to evaluate the sequence of expressions in a BEGIN expression.
;;; this function return the value of the final expression
(define (eval-sequence exps env)
  (cond ((last-exp? exps)
         (meta-eval (first-exp exps) env))
        (else
         (meta-eval (first-exp exps) env)
         (eval-sequence (rest-exps exps) env))))
