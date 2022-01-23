;;; exp: the expression
;;; tag: the tag
;;; this function is used to check if the expression is a list with a designated tag.
(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))
