(define (enclosing-environment env)
  (cdr env))

(define (first-frame env)
  (car env))

(define the-empty-environment '())

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

(define (frame-variables frame)
  (car frame))

(define (frame-values frame)
  (cdr frame))

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

(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals base-env) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))
  