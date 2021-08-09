(module module-reckless simply-scheme
    (provide reckless)

    (define (reckless strategy)
        (lambda (customer-hand-so-far dealer-up-card)
            (or (strategy customer-hand-so-far dealer-up-card)
                (and (not (empty? customer-hand-so-far)) (strategy (butlast customer-hand-so-far) dealer-up-card)))))
)