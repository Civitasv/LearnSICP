(define (bubble-sort! vec)
  (define (swap i j)
    (let ((temp (vector-ref vec i)))
      (vector-set! vec i (vector-ref vec j))
      (vector-set! vec j temp)))
  (define (loop vec index n)
    (cond ((= index n) vec)
          ((> (vector-ref vec index) (vector-ref vec (+ index 1)))
           (swap index (+ index 1))
           (loop vec (+ index 1) n))
          (else (loop vec (+ index 1) n))))
  (loop vec 0 (- (vector-length vec) 1)))