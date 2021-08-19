(module module-valentine simply-scheme
    (require "module-higher-order.rkt" "module-best-total.rkt" "module-suit-strategy.rkt" "module-stop-at.rkt")
    (provide valentine)

    (define (valentine customer-hand-so-far dealer-up-card)
        (if (exist? (lambda (card) (equal? (last card) 'h)) customer-hand-so-far)
            (< (best-total customer-hand-so-far) 19)
            (< (best-total customer-hand-so-far) 17)))

    (define (valentine-2 customer-hand-so-far dealer-up-card)
        ((suit-strategy 'h (stop-at 19) (stop-at 17)) customer-hand-so-far dealer-up-card))

    
    (define (vowel? letter) (member? letter '(a e i o u)))

    (define (syllables word)
      (cond ((empty? word) 0)
            ((vowel? (first word))
             (cond ((empty? (bf word)) 1)
                   ((vowel? (first (bf word))) (syllables (bf word)))
                   (else (+ 1 (syllables (bf word))))))
            (else (syllables (bf word)))))

    (syllables 'aardvark)
)