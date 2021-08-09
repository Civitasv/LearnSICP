(module module-play-n simply-scheme
    (require "module-twenty-one.rkt")
    (provide play-n)
    
    (define (play-n strategy n)
        (if (= n 0)
            0
            (+ (twenty-one strategy) (play-n strategy (- n 1))))))