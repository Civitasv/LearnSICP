#lang simply-scheme

(define x '(1 3 (5 7) 9))
(define y '((7)))
(define z '(1 (2 (3 (4 (5 (6 7)))))))

(car (cdr (car (cdr (cdr x)))))
(car (car y))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr z))))))))))))

(list 'a 'b 'c)
(list (list 'george))
(cdr '((x1 x2) (y1 y2)))
(cadr '((x1 x2) (y1 y2)))
(pair? (car '(a short list)))
(memq 'red '((red shoes) (blue socks)))
(memq 'red '(red shoes blue socks))
(memq 'apple '(x (apple sauce) y apple pear))

(car '(quote abs))

(define (reverse lst)
  (define (helper lst result)
    (if (null? lst)
        result
        (helper (cdr lst) (cons (car lst) result))))
  (helper lst '()))

(define (deep-reverse lst)
  (if (list? lst) 
      (map deep-reverse (reverse lst))
      lst))
(reverse '(1 2 3))
(deep-reverse '((1 2) (2 3) (3 4)))