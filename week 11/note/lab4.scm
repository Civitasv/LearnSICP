(define (even? n)
  (= (remainder n 2) 0))

(define (num-seq n)
  (cons-stream n (num-seq (if (even? n) (/ n 2) (+ (* n 3) 1)))))

(define (seq-length stream)
  (if (= (stream-car stream) 1)
      1
      (+ 1 (seq-length (stream-cdr stream)))))

(define (display-line x)
  (newline)
  (display x))

(define (show-stream stream)
  (define (helper stream count)
    (if (or (stream-null? stream) (= count 0))
        '...
        (begin (display-line (stream-car stream))
               (helper (stream-cdr stream) (- count 1)))))
  (helper stream 10))