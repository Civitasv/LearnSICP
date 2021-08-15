# CS 61A Week4 Homework

Topic: Data abstraction

Reading: Abelson & Sussman, Sections 2.1 and 2.2.1

## Homework

Problem 1: Abelson & Sussman, exercises 2.7, 2.8, 2.10, 2.12, 2.17, 2.20, 2.22, 2.23

**2.7:**

```Scheme
(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))
```

**2.8:**

```Scheme
(define (sub-interval x y)
  (add-interval x (make-interval (- (upper-bound y)) (- (lower-bound y)))))
```

**2.10:**

```Scheme
(define (div-interval x y)
  (if (and (<= (lower-bound y) 0) (>= (upper-bound y) 0))
        (error "Can't divide by an interval that spans error!")
        (mul-interval
            x
            (make-interval (/ 1.0 (upper-bound y))
                        (/ 1.0 (lower-bound y))))))
```

**2.12:**

```Scheme
(define (make-center-percent center tolorence)
  (let ((dist (* center tolorence 0.01)))
    (make-interval (- center dist) (+ center dist))))

(define (center interval)
  (/ (+ (upper-bound interval) (lower-bound interval)) 2))

(define (percent interval)
  (* 100 (/ (- (upper-bound interval) (center interval)) (center interval))))
```

**2.17:**

```Scheme
(define (last-pair elements)
  (if (null? (cdr elements))
      elements
      (last-pair (cdr elements))))
```

**2.20:**

```Scheme
(define (same-parity x . w)
  (if (= (remainder x 2) 0)
      (append (list x) (filter (lambda (x) (= (remainder x 2) 0)) w))
      (append (list x) (filter (lambda (x) (= (remainder x 2) 1)) w))))
```

**2.22:**

A list MUST be made with `(cons new-member rest-of-list)`.

Even thougn he does have the members in correct left-to-right order. He'll get ((((() . 1) . 4) . 9) . 16) instead of (1 . (4 . (9 . (16 . ())))).

That's all.

**2.23:**

```Scheme
(define (for-each f data)
  (if (null? data)
      (exit)
      (let ((ignore (f (car data))))
         (for-each f (cdr data)))))
```

Problem 2:

```Scheme
(define (substitute lst old new)
  (cond ((null? lst) '())
        ((equal? lst old) new)
        ((pair? lst) (cons (substitute (car lst) old new)
                           (substitute (cdr lst) old new)))
        (else lst)))
```

Problem 3:

```Scheme
(define (find-match ele old-lst new-lst)
  (cond ((null? old-lst) ele)
        ((equal? ele (car old-lst)) (car new-lst))
        (else (find-match ele (cdr old-lst) (cdr new-lst)))))

(define (substitute2 lst old-lst new-lst)
  (cond ((null? lst) '())
        ((pair? lst)
         (cons (substitute2 (car lst) old-lst new-lst)
               (substitute2 (cdr lst) old-lst new-lst)))
        (else (find-match lst old-lst new-lst))))
```

### Extra for Experts

Problem 1:

```Scheme
(define (cxr-function word)
  (define (helper word)
    (if (empty? word)
        (lambda (x) x)
        (compose (if (equal? (first word) 'a) car cdr)
                 (cxr-function (bf word)))))
  (helper (bf (bl word))))
```

Problem 2:

An easier explanation:

```Scheme
(define zero
  (lambda (f) (lambda (x) x)))
(define one
  (lambda (f) (lambda (x) (f x))))
(define two
  (lambda (f) (lambda (x) (f (f x)))))

#|
It can be easily proved that (n f) is (lambda (x) (f (f .. (f x) .. ))) where f is repeated n times, by induction.

((add n m) f) = ((n+m) f)
              = (lambda (x) (f^(n+m) x))
              = (lambda (x) ((lambda (x) (f^n x)) (f^m x)))
              = (lambda (x) ((lambda (x) (f^n x)) ((lambda (x) (f^m x)) x)))
              = (lambda (x) ((n f) ((m f) x)))
|#
(define (add n m)
  (lambda (f) (lambda (x) ((n f) ((m f) x)))))
```
