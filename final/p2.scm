(define (count-evens ints)
  (define (helper index n result)
    (cond ((= index n) result)
          ((even? (list-ref ints index))
           (helper (+ 1 index) n (+ 1 result)))
          (else (helper (+ 1 index) n result))))
  (helper 0 (length ints) 0))

    
