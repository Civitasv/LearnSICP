(module module-test-majority simply-scheme
    (require "module-assert.rkt" "module-majority.rkt")

    (define (hit hand dealer-card) #t)
    (define (stand hand dealer-card) #f)

    (assert equal? ((majority stand stand stand) '() 'as) #f "#f #f #f -> #f")

    (assert equal? ((majority hit stand stand) '() 'as) #f "#t #f #f -> #f")

    (assert equal? ((majority hit hit stand) '() 'as) #t "#t #t #f -> #t")

    (assert equal? ((majority hit hit hit) '() 'as) #t "#t #t #t -> #t")
   )