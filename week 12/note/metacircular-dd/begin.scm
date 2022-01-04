;;; exp: the expression
;;; this function is used to check if the expression is a BEGIN expression.
(define (begin? exp)
  (tagged-list? exp 'begin))

;;; exp: the expression
;;; this function is used to get the actions part of the BEGIN.
(define (begin-actions exp)
  (cdr exp))

;;; seq: the sequence
;;; this function is used to construct a BEGIN expression.
(define (make-begin seq)
  (cons 'begin seq))