;;; exp: the expression
;;; this function is used to check if the expression is a QUOTATION.
(define (quoted? exp)
  (tagged-list? exp 'quote))

;;; exp: the expression
;;; this function is used to get the value of the quotation
(define (text-of-quotation exp)
  (cadr exp))