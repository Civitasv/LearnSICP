(module module-twenty-one simply-scheme
    (provide twenty-one)
    (require "module-best-total.rkt")
    
    ; 1, 0, -1 represent customer won tie and lost.
    (define (twenty-one strategy)
        ; secondly, the dealer choose cards or not
        ; finnaly, compare the dealer's hand vs the customer's
        (define (play-dealer customer-hand dealer-hand-so-far rest-of-deck)
            (cond ((> (best-total dealer-hand-so-far) 21) 1)
	              ((< (best-total dealer-hand-so-far) 17)
	               (play-dealer customer-hand (se dealer-hand-so-far (first rest-of-deck)) (bf rest-of-deck)))
	              ((< (best-total customer-hand) (best-total dealer-hand-so-far)) -1)
	              ((= (best-total customer-hand) (best-total dealer-hand-so-far)) 0)
	              (else 1)))
        
        ; firstly, the customer choose cards or not
        (define (play-customer customer-hand-so-far dealer-up-card rest-of-deck)
            (cond ((> (best-total customer-hand-so-far) 21) -1)
    	          ((strategy customer-hand-so-far dealer-up-card)
    	           (play-customer (se customer-hand-so-far (first rest-of-deck)) dealer-up-card (bf rest-of-deck)))
    	          (else
    	           (play-dealer customer-hand-so-far (se dealer-up-card (first rest-of-deck)) (bf rest-of-deck)))))

        (let ((deck (make-deck)))
            (play-customer (se (first deck) (first (bf deck))) (first (bf (bf deck))) (bf (bf (bf deck))))) )

    (define (make-ordered-deck)
        (define (make-suit s)
            (every (lambda (rank) (word rank s)) '(a 2 3 4 5 6 7 8 9 10 j q k)) )
        (se (make-suit 'h) (make-suit 's) (make-suit 'd) (make-suit 'c)) )

    (define (make-deck)
        (define (shuffle deck size)
            (define (move-card in out which)
                (if (= which 0)
                    ; then the first of cards is shuffed, and then shuffer others
                    (se (first in) (shuffle (se (bf in) out) (- size 1)))
                    (move-card (bf in) (se (first in) out) (- which 1)) ))
            (if (= size 0)
                deck
                (move-card deck '() (random size)) ))
        (shuffle (make-ordered-deck) 52) )
)