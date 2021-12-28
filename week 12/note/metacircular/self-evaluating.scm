;;; exp: the expression
;;; this function is used to check if the expression is SELF EVALUATING, our language
;;; see number and string as self evaluating.
(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))