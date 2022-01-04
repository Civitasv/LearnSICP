(define (and? exp)
  (tagged-list? exp 'and))

(define (and-sequence exp)
  (cdr exp))

(define (eval-and exp env)
  (define (helper seq)
    (if (last-exp? seq)
        (meta-eval (first-exp seq) env)
        (let ((first (true? (meta-eval (first-exp seq) env))))
          (if (not first)
              false
              (helper (rest-exps seq))))))
  (helper (and-sequence exp)))