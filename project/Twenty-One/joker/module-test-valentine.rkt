(module module-test-stop-at simply-scheme
    (require "module-assert.rkt" "module-valentine.rkt")

    (assert equal? (valentine '(10s 6s) 'as) #t "less than 17 always hits")
    (assert equal? (valentine '(10s 7h) 'as) #t "17 hits with hearts")
    (assert equal? (valentine '(10s 8h) 'as) #t "18 hits with hearts")
    (assert equal? (valentine '(10s 7c) 'as) #f "17 stands without hearts")
    (assert equal? (valentine '(10s 9h) 'as) #f "19 always stands")
)