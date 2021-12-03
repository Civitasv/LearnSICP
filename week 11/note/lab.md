# CS 61A Week 11 Lab

Problem 1:

The type of the value of `(delay (+ 1 127))` is `lambda`

The type of the value of `(force (delay (+ 1 127)))` is `Number`

Problem 2:

This produces an error cause '(2 3) is constructed by cons instead of cons-stream, thus cannot be invoked by stream-cdr(it's not be delayed, so cannot be forced).

Problem 3:

(enumerate-interval 1 3) will produce a list from 1 to 3, after delaying it, we will gain a lambda with no paramters and return the list.

However, (stream-enumerate-interval 1 3) will produce a stream whose car is 1 and cdr is a promise that will produce the list from 2 to 3, they are so different.

Problem 4:

a.

```Scheme
(define (even? n)
  (= (remainder n 2) 0))

(define (num-seq n)
  (cons-stream n (num-seq (if (even? n) (/ n 2) (+ (* n 3) 1)))))
```

b.

```Scheme
(define (seq-length stream)
  (if (= (stream-car stream) 1)
      1
      (+ 1 (seq-length (stream-cdr stream)))))
```
