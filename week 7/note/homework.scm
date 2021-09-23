(define-class (random-generator range)
    (instance-vars (random-count 0))

    (method (number)
        (set! random-count (+ random-count 1))
        (random range))
    (method (count)
        random-count))

(define-class (coke-machine number price)
    (instance-vars (total-cents 0))

    (method (deposit cents)
        (set! total-cents (+ total-cents cents)))

    (method (coke)
        (cond ((<= number 0) (error "Machine empty"))
              ((< total-cents price) (error "Not enough money"))
              (else (set! total-cents (- total-cents price))
                    total-cents)))
    (method (fill coke-number)
        (set! number (+ number coke-number))))

(define-class (deck ordered-deck)
    (initialize (set! ordered-deck (shuffle ordered-deck)))

    (method (deal)
        (if (null? ordered-deck)
            '()
            (let ((top-card (car ordered-deck)))
              (set! ordered-deck (cdr ordered-deck))
              top-card)))

    (method (empty?)
        (null? ordered-deck)))

(define-class (miss-manners obj)
    (method (please mes arg)
        (ask obj mes arg)))

