(module module-best-total simply-scheme
    
    (require "module-higher-order.rkt")
    (provide best-total)

    (define (best-total cards)
        (define (helper sum ace-size)
            (if (or (hand-valid? sum) (= ace-size 0))
                sum
                (helper (- sum 10) (- ace-size 1))))
        (helper (sum-of-cards cards) (reduce + (map (lambda (x) 1) (filter ace? cards)) 0)))
    
    (define (hand-valid? sum)
        (<= sum 21))
    
    (define (sum-of-cards cards)
        (reduce + (map card-value cards) 0))

    (define (card-value card)
        (cond ((picture-card? card) 10)
              ((ace? card) 11)
              (else (butlast card))))

    (define (picture-card? card)
        (member? (butlast card) '(j q k)))
    
    (define (ace? card)
        (equal? (butlast card) 'a))
)
