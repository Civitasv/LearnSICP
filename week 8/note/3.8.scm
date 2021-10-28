(define f
  (let ((a 1))
    (lambda (x)
      (begin (set! a (* a x))
             (if (= (/ a 2) 0)
                 0
                 1)))))