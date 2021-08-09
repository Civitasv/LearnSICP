(module module-suit-strategy simply-scheme
    (require "module-higher-order.rkt")
    (provide suit-strategy)

    (define (suit-strategy suit suit-strategy not-suit-strategy)
        (lambda (customer-hand-so-far dealer-up-card)
            (if (exist? (lambda (card) (equal? (last card) suit)) customer-hand-so-far)
                (suit-strategy customer-hand-so-far dealer-up-card)
                (not-suit-strategy customer-hand-so-far dealer-up-card))))
)