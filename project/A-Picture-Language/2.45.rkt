#lang sicp
(#%require sicp-pict)

(define (split a1 a2)
  (define (helper painter n)
    (if (= n 0)
        painter
        (let ((smaller (helper painter (- n 1))))
          (a1 painter (a2 smaller smaller)))))
  helper)