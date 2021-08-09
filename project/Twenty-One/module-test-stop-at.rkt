(module module-test-stop-at simply-scheme
    (require "module-assert.rkt" "module-stop-at.rkt")

    (define stop-at-0 (stop-at 0))
    (assert equal? (stop-at-0 '() 'as) #f "empty hand -> #f")
    (assert equal? (stop-at-0 '(2s) 'as) #f "2s -> #f")

    (define stop-at-3 (stop-at 3))
    (assert equal? (stop-at-3 '() 'as) #t "empty hand -> #t")
    (assert equal? (stop-at-3 '(2s) 'as) #t "2s -> #t")
    (assert equal? (stop-at-3 '(3s) 'as) #f "3s -> #f")
    (assert equal? (stop-at-3 '(4s) 'as) #f "4s -> #f")

    (define stop-at-17 (stop-at 17))
    (assert equal? (stop-at-17 '() 'as) #t "empty hand -> #t")
    (assert equal? (stop-at-17 '(2s) 'as) #t "2s -> #t")
    (assert equal? (stop-at-17 '(10s 6s) 'as) #t "10s 6s -> #t")
    (assert equal? (stop-at-17 '(10s 7s) 'as) #f "10s 7s -> #f")
    (assert equal? (stop-at-17 '(as 5s) 'as) #t "as 5s -> #t") 
    (assert equal? (stop-at-17 '(as 6s) 'as) #f "as 6s -> #f") 
    (assert equal? (stop-at-17 '(3s 4s 5s as) 'as) #t "3s 4s 5s as -> #t") 
    (assert equal? (stop-at-17 '(4h 10h 10s) 'as) #f "4h 10h 10s -> #f")

    (define stop-at-100 (stop-at 100))
    (assert equal? (stop-at-100 '() 'as) #t "empty hand -> #t")
    (assert equal? (stop-at-100 '(10s 7s) 'as) #t "10s 7s -> #t")
    (assert equal? (stop-at-100 '(10s as) 'as) #t "10s as -> #t")
)