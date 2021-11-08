(define (vector-append v1 v2)
  (let ((n1 (vector-length v1))
        (n2 (vector-length v2)))  
    (define (loop newvec n)
        (if (< n 1)
            newvec
            (begin (if (> n n1)
                    (vector-set! newvec (- n 1) (vector-ref v2 (- n n1 1)))
                    (vector-set! newvec (- n 1) (vector-ref v1 (- n 1))))
                   (loop newvec (- n 1)))))
    (loop (make-vector (+ n1 n2)) (+ n1 n2))))