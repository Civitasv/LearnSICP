# CS 61A Week 6 Lab

Problem 1: pass

Problem 2:

```Scheme
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else let ((x1 (car set1))
                   (x2 (car set2)))
                (cond ((= x1 x2)
                    (cons x1 (union-set (cdr set1) (cdr set2))))
                    ((< x1 x2)
                    (cons x1 (union-set (cdr set1) set2)))
                    ((< x2 x1)
                    (cons x2 (union-set set1 (cdr set2))))))))
```

Problem 3:

```Scheme
(define tree1
  (adjoin-set 1
   (adjoin-set 5
    (adjoin-set 11
     (adjoin-set 3
      (adjoin-set 9
       (adjoin-set 7 '())))))))
```
