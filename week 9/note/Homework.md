# CS 61A Week9

Topic: Mutable data, vectors

**Reading**: Abelson & Sussman, Section 3.3.1-3

## Homework

Problem 1: Abelson & Sussman, exercises 3.16, 3.17, 3.21, 3.25, 3.27

**3.16:**

This procedure works fine when there are not two pointers point to the same pair in the list structure, rather it will have error result, especially, wehen there are loops in the list, this procedure never return at all.

![3.16](../images/3.16.png)

**3.17:**

```Scheme
(define (count-pairs x)
  (let ((aux '()))
    (define (helper lst)
        (if (or (not (pair? lst))
                (in? lst aux))
            0
            (begin (set! aux (cons lst aux))
                   (+ (helper (car lst))
                      (helper (cdr lst))
                      1))))
    (helper x)))

(define (in? item lst)
  (if (null? lst)
      #f
      (or (eq? item (car lst))
          (in? item (cdr lst)))))

```

There are two aspects that we have to attention:

1. To maintain an auxiliary data structure using Environment model, we have to make our `set!` code into the local state `aux`.
2. When we invoke the `count-pairs` again, the `aux` data should be reset.

**3.21:**

The print results are the value of queue, which is construct by front point and rear point.

The `print-queue` procedure as follows:

```Scheme
(define print-queue front-ptr)
```

**3.25:**

```Scheme
(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup keys)
      (define (helper keys table)
        (if (= (length keys) 1)
            (let ((record
                    (assoc (car keys) (cdr table))))
              (if record (cdr record) false))
            (let ((subtable
                    (assoc (car keys) (cdr table))))
              (if subtable
                  (helper (cdr keys) subtable)
                  false))))
      (helper keys local-table))
    (define (insert! keys value)
      (define (helper keys table)
        (if (= (length keys) 1)
            (let ((record
                    (assoc (car keys) (cdr table))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! table (cons (cons (car keys) value) (cdr table)))))
            (let ((subtable
                    (assoc (car keys) (cdr table))))
              (if subtable
                  (helper (cdr keys) subtable)
                  (begin 
                    (set-cdr! table (cons (cons (car keys) '()) (cdr table)))
                    (helper (cdr keys) (cadr table)))))))
      (helper keys local-table)
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc) insert!)
            (else (error "Unkown operation: TABLE" m))))
    dispatch))
```

**3.27:**

The trace is as follows:

![3.27](../images/3.27.png)

That'll work if we had simply defined `memo-fib` to be `(memoize fib)`.

Problem 2: Vector questions

vector-append:

```Scheme
(define (vector-append v1 v2)
  (let ((n1 (vector-length v1))
        (n2 (vector-length v2)))  
    (define (loop newvec n)
        (if (< n 1)
            newvec
            (begin (if (> n n1)
                    (vector-set! newvec (- n 1) (vector-ref v2 (- n n1 1)))
                    (vector-set! newvec (- n 1) (vector-ref v1 (- n 1))))
                   (loop newvec (- n 1)))))
    (loop (make-vector (+ n1 n2)) (+ n1 n2))))
```

vector-filter:

```Scheme
(define (vector-filter pred vec)
  (define (get-length n)
    (cond ((< n 0) 0)
          ((pred (vector-ref vec n)) (+ 1 (get-length (- n 1))))
          (else (get-length (- n 1)))))
  (define (loop newvec vecn n)
    (if (< n 0)
        newvec
        (if (pred (vector-ref vec n))
            (begin (vector-set! newvec vecn (vector-ref vec n))
                   (loop newvec (- vecn 1) (- n 1)))
            (loop newvec vecn (- n 1)))))
  (let ((l (get-length (- (vector-length vec) 1))))
    (loop (make-vector l) (- l 1) (- (vector-length vec) 1))))
```

Cause our `vector-filter` has to get the length of the length that can satisfy the predication, so it have loop this vector twice, but the `filter` of the list just need one loop.

Problem 3:

```Scheme
(define (bubble-sort! vec)
  (define (swap i j)
    (let ((temp (vector-ref vec i)))
      (vector-set! vec i (vector-ref vec j))
      (vector-set! vec j temp)))
  (define (loop vec index n)
    (cond ((= index n) vec)
          ((> (vec-ref vec index) (vec-ref vec (+ index 1)))
           (swap index (+ index 1))
           (loop vec (+ index 1) n))
          (else (loop vec (+ index 1) n))))
  (loop vec 0 (- (vector-length vec) 1)))
```

When we invoke bubble-sort!, in every loop, we can get a max value, so after `n-1` loop, we can get `n-1` max values, the last value will be the smallest.

## Extra for experts

TODO, later we will go on.
