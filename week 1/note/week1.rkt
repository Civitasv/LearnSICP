#lang simply-scheme

(define (squarter x)
    (* x x))

(define (squares sentence)
    (if (empty? sentence)
        '()
        (se (squarter (first sentence))
            (squares (butfirst sentence)))))

(squares '(1 2 3 4))

(define (switch sentence)
    (se (switch-first (first sentence))
        (switch-rest (butfirst sentence))))

(define (switch-first word)
    (cond ((equal? word 'I) 'you)
        ((equal? word 'i) 'you)
        ((equal? word 'me) 'you)
        ((equal? word 'Me) 'you)
        ((equal? word 'you) 'I)
        ((equal? word 'You) 'I)
        (else word)))

(define (switch-rest sentence)
    (if (empty? sentence)
        '()
        (se (switch-one (first sentence))
            (switch-rest (butfirst sentence)))))

(define (switch-one word)
    (cond ((equal? word 'I) 'you)
        ((equal? word 'i) 'you)
        ((equal? word 'me) 'you)
        ((equal? word 'Me) 'you)
        ((equal? word 'you) 'me)
        ((equal? word 'You) 'me)
        (else word)))
(switch '(You told me that I should wake you up))

(equal? 'a 'b)

(define (ordered? numbers)
    (cond ((empty? (butfirst numbers)) #t)
        (else (and (< (first numbers) (first (butfirst numbers))) (ordered? (butfirst numbers))))))

(ordered? '(1 2 4 3))

(last 'wo)

(define (ends-e sentence)
    (if (empty? sentence)
        '()
        (se 
            (if (equal? (last (first sentence)) 'e) 
                (first sentence) 
                '())
            (ends-e (butfirst sentence)))))
(ends-e '(please put the salami above the blue elephant))

(define x 0)
(or (= 1 1) (/ 2 x))
(* 4)

(define a 3) ; a = 3
    (define b (+ a 1)) ; b = 4
    (+ a b (* a b)) ; 19
    (= a b) ; #f
    (if (and (> b a) (< b (* a b)))
        b
        a) ; 4
    (cond ((= a 4) 6)
        ((= b 4) (+ 6 7 a))
        (else 25)) ; 16
    (+ 2 (if (> b a) b a)) ; 6
    (* (cond ((> a b) a)
        ((< a b) b)
        (else -1)) ; 4
       (+ a 1)) ; 4
    ((if (< a b) + -) a b) ; 7

(member? '2 '(2 3 45))
(define (dupls-removed sentence)
    (if (empty? sentence)
        '()
        (se 
            (if (member? (first sentence) (butfirst sentence))
                '()
                (first sentence))
            (dupls-removed (butfirst sentence)))))
(dupls-removed  '(a b c a e d e b))