(module module-test-stop-at-17 simply-scheme
    (require "module-assert.rkt" "module-stop-at-17.rkt")

    (assert equal? (stop-at-17 '() 'as) #t "empty hand -> #t")
    (assert equal? (stop-at-17 '(2s) 'as) #t "2s -> #t")
    (assert equal? (stop-at-17 '(10s 6s) 'as) #t "10s 6s -> #t")
    (assert equal? (stop-at-17 '(10s 7s) 'as) #f "10s 7s -> #f")
    (assert equal? (stop-at-17 '(as 5s) 'as) #t "as 5s -> #t") 
    (assert equal? (stop-at-17 '(as 6s) 'as) #f "as 6s -> #f") 
    (assert equal? (stop-at-17 '(3s 4s 5s as) 'as) #t "3s 4s 5s as -> #t") 
    (assert equal? (stop-at-17 '(4h 10h 10s) 'as) #f "4h 10h 10s -> #f")
)