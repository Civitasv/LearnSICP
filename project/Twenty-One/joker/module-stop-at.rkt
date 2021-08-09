(module module-stop-at simply-scheme
    (require "module-best-total.rkt")
    (provide stop-at)

    (define (stop-at n)
        (lambda (customer-hand-so-far dealer-up-card)
            (< (best-total customer-hand-so-far) n)))
)