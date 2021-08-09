(module module-test-suit-strategy simply-scheme
    (require "module-assert.rkt" "module-suit-strategy.rkt" "module-stop-at.rkt")

    
    (define (valentine-strategy customer-hand-so-far dealer-up-card)
        ((suit-strategy 'h (stop-at 19) (stop-at 17)) customer-hand-so-far dealer-up-card))

    (assert equal? (valentine-strategy '(10s 6s) 'as) #t "less than 17 always hits")
    (assert equal? (valentine-strategy '(10s 7h) 'as) #t "17 hits with hearts")
    (assert equal? (valentine-strategy '(10s 8h) 'as) #t "18 hits with hearts")
    (assert equal? (valentine-strategy '(10s 7c) 'as) #f "17 stands without hearts")
    (assert equal? (valentine-strategy '(10s 9h) 'as) #f "19 always stands")
)