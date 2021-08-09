(module module-dealer-sensitive simply-scheme
    (require "module-best-total.rkt")
    (provide dealer-sensitive)

    (define (dealer-sensitive customer-hand-so-far dealer-up-card)
        (if (equal? dealer-up-card 'jr) 
            #f
            (or (and (member? (butlast dealer-up-card) '(a 7 8 9 10 j q k)) (< (best-total customer-hand-so-far) 17))
                (and (member? (butlast dealer-up-card) '(2 3 4 5 6)) (< (best-total customer-hand-so-far) 12)))))
)