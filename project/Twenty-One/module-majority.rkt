(module module-majority simply-scheme
    (require "module-higher-order.rkt")
    (provide majority)
    
    (define (majority first-strategy second-strategy third-strategy)
        (lambda (customer-hand-so-far dealer-up-card)
            (>= (reduce + (se (if (first-strategy customer-hand-so-far dealer-up-card) 1 0) 
                        (if (second-strategy customer-hand-so-far dealer-up-card) 1 0)
                        (if (third-strategy customer-hand-so-far dealer-up-card) 1 0)) 0) 2)))
)