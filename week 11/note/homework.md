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

(stream-ref x 5) will print `1 2 3 4 5`

(stream-ref x 7) will print `6 7`

**3.52:**

