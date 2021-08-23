# CS 61A Week 5 Lab

Problem 1:

```Scheme
(define x '(1 3 (5 7) 9))
(define y '((7)))
(define z '(1 (2 (3 (4 (5 (6 7)))))))

(car (cdr (car (cdr (cdr x)))))
(car (car y))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr z))))))))))))
```

```Scheme
(a b c)
((george))
((y1 y2))
(y1 y2)
#f
#f
'(red shoes blue socks)
```

Problem2:

The expression `(car ''abracadabra)` is equaivalent to `(car (quote (quote avracadabra)))`, so the interpreter prints back `quote`.

Problem 3:

```Scheme
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
```
