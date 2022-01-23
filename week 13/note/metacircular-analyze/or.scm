(define (or? exp)
  (tagged-list? exp 'or))

(define (or-sequence exp)
  (cdr exp))

(define (eval-or exp env)
  (define (helper seq)
    (if (last-exp? seq)
        (meta-eval (first-exp seq) env)
        (let ((first (true? (meta-eval (first-exp seq) env))))
          (if first
              true
              (helper (rest-exps seq))))))
  (helper (or-sequence exp)))

(define (analyze-or exp)
  (define (helper seq env)
    (if (last-exp? seq)
        (meta-eval (first-exp seq) env)
        (let ((first (true? (meta-eval (first-exp seq) env))))
          (if first
              true
              (helper (rest-exps seq))))))
  (let ((seq (or-sequence exp)))
    (lambda (env) (helper seq env))))
