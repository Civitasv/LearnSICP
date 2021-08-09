(module module-best-total simply-scheme
    
    (require "module-higher-order.rkt")
    (provide best-total)

    (define (best-total cards)
        (define (helper current-possible-values card-possible-values res)
            (if (empty? current-possible-values)
                res
                (helper (bf current-possible-values) card-possible-values (se (map (lambda (value) (+ value (first current-possible-values))) card-possible-values) res))))
        (define (helper2 cards res)
            (if (empty? cards)
                res
                (helper2 (bf cards) (helper res (card-possible-values (first cards)) '()))))
        
        (if (empty? cards)
            0
            (max-hand-valid (filter hand-valid? (helper2 (bf cards) (card-possible-values (first cards))))))
    )

    (define (max-hand-valid scores)
        (define (helper scores)
            (if (empty? scores)
                0
                (max (first scores) (helper (bf scores)))))
        (if (empty? scores)
            99
            (helper scores)))

    
    (define (hand-valid? sum)
        (<= sum 21))
    
    (define (card-possible-values card)
        (cond ((joker? card) (se 1 2 3 4 5 6 7 8 9 10 11))
              ((picture-card? card) (se 10))
              ((ace? card) (se 1 11))
              (else (se (butlast card)))))

    (define (picture-card? card)
        (member? (butlast card) '(j q k)))
    
    (define (ace? card)
        (equal? (butlast card) 'a))

    (define (joker? card)
        (equal? card 'jr)) 
)
