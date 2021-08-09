(module module-stop-at-17 simply-scheme
    (require "module-best-total.rkt")
    (provide stop-at-17)

    (define (stop-at-17 customer-hand-so-far dealer-up-card)
        (< (best-total customer-hand-so-far) 17)))