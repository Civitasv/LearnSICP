# CS 61A Week 11

Topic: Streams

**Reading:** Abelson & Sussman, Section 3.5.1-3, 3.5.5

## Homework

Problem 1:

**3.50:**

```Scheme
(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
        (apply proc (map stream-car argstreams))
        (apply stream-map
               (cons proc (map stream-cdr argstreams))))))
```

**3.51:**

(define x (stream-map show (stream-enumerate-interval 0 10))) will print 0.

(stream-ref x 5) will print `1 2 3 4 5 5`

(stream-ref x 7) will print `6 7 7`

**3.52:**

```Scheme
(define sum 0) ;0
(define (accum x) (set! sum (+ x sum)) sum) ;0
(define seq
  (stream-map accum
              (stream-enumerate-interval 1 20))) ;1 seq: 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 66, 78, 91, 105, 120, 136, 153, 171, 190, 210
(define y (stream-filter even? seq)) ;6
(define z
  (stream-filter (lambda (x) (= (remainder x 5) 0)) seq)) ;6
(stream-ref y 7) ;136
(display-stream z) ; 210
```

The responses will differ if the implemention don't use the optimization procedure, it will recalculate the value even we have calculated it, thus will change the value of sum.

**3.53:**

`(define s (cons-stream 1 (add-stream s s)))` will be `1, 2, 4, 8, ...`

**3.54:**

```Scheme
(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define factorials
  (cons-stream 1 (mul-streams factorials integers)))
```

**3.55:**

```Scheme
(define (partial-sums s)
  (define helper (cons-stream (stream-car s)
                              (add-streams helper (stream-cdr s))))
  helper)
```

**3.56:**

```Scheme
(define S (cons-stream 1 (merge (scale-stream S 2) (merge (scale-stream S 3) (scale-stream S 5)))))
```

**3.64:**

```Scheme
(define (abs x)
  (if (< x 0)
      (- x)
      x))

(define (stream-limit s tolerance)
  (cond ((or (stream-null? s) (stream-null? (stream-cdr s))) -1)
        ((< (abs (- (stream-car s) (stream-car (stream-cdr s)))) tolerance) (stream-car (stream-cdr s)))
        (else (stream-limit (stream-cdr s) tolerance))))
```

**3.66:**

1. f(i,j) = 2^i - 2, i = j
2. f(i,j) = 2^i * (j-i) + 2^(i-1) - 2, i < j

**3.68：**

INTERLEAVE is an ordinary Scheme procedure, so its arguments must be computed before INTERLEAVE is called.  One of those arguments is a recursive call to PAIRS.  This will be an infinite loop. The book's version works because it uses CONS-STREAM, which doesn't evaluate its second argument until later, if ever.

Problem 2:

```Scheme
(define (fract-stream lst)
  (let ((numerator (car lst))
        (denominator (cadr lst)))
    (cons-stream (floor (/ (* numerator 10) denominator))
                 (fract-stream (list (remainder (* numerator 10) denominator) denominator) ))))

(define (approximation s numdigits)
  (if (= numdigits 0)
      '()
      (cons (stream-car s)
            (approximation (stream-cdr s) (- numdigits 1)))))
```

## Extra for experts

TODO
