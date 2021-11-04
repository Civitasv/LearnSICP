(define (count-pairs x)
  (let ((aux '()))
    (define (helper lst)
        (if (or (not (pair? lst))
                (in? lst aux))
            0
            (begin (set! aux (cons lst aux))
                   (+ (helper (car lst))
                      (helper (cdr lst))
                      1))))
    (helper x)))

(define (in? item lst)
  (if (null? lst)
      #f
      (or (eq? item (car lst))
          (in? item (cdr lst)))))
