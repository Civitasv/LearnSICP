(define (make-joint old-acc old-pw new-pw)
  (lambda (pw m)
    (if (eq? pw new-pw)
	(old-acc old-pw m)
	(lambda (x) "Incorrect password"))))