(module module-test-dealer-sensitive simply-scheme
    (require "module-assert.rkt" "module-dealer-sensitive.rkt")

    (assert equal? (dealer-sensitive '(as) '2s) #t "as (2s) -> #t")
    (assert equal? (dealer-sensitive '(as) '6s) #t "as (6s) -> #t")
    (assert equal? (dealer-sensitive '(as) '7s) #t "as (7s) -> #t")
    (assert equal? (dealer-sensitive '(as) '10s) #t "as (10s) -> #t")
    (assert equal? (dealer-sensitive '(as) 'ks) #t "as (ks) -> #t")
    (assert equal? (dealer-sensitive '(as) 'as) #t "as (as) -> #t")

    (assert equal? (dealer-sensitive '(10s 2s) '2s) #f "10s 2s (2s) -> #f")
    (assert equal? (dealer-sensitive '(10s 2s) '6s) #f "10s 2s (6s) -> #f")
    (assert equal? (dealer-sensitive '(10s 2s) '7s) #t "10s 2s (7s) -> #t")
    (assert equal? (dealer-sensitive '(10s 2s) '10s) #t "10s 2s (10s) -> #t")
    (assert equal? (dealer-sensitive '(10s 2s) 'ks) #t "10s 2s (ks) -> #t")
    (assert equal? (dealer-sensitive '(10s 2s) 'as) #t "10s 2s (as) -> #t")

    (assert equal? (dealer-sensitive '(10s 7s) '2s) #f "10s 2s (2s) -> #f")
    (assert equal? (dealer-sensitive '(10s 7s) '6s) #f "10s 2s (6s) -> #f")
    (assert equal? (dealer-sensitive '(10s 7s) '7s) #f "10s 2s (7s) -> #f")
    (assert equal? (dealer-sensitive '(10s 7s) '10s) #f "10s 2s (10s) -> #f")
    (assert equal? (dealer-sensitive '(10s 7s) 'ks) #f "10s 2s (ks) -> #f")
    (assert equal? (dealer-sensitive '(10s 7s) 'as) #f "10s 2s (as) -> #f")

    ; joker test
    (assert equal? (dealer-sensitive '(10s 7s) 'jr) #f "10s 7s (jr) -> #f")
   )