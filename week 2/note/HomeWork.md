# CS 61A Homework Week 2

Topic: Higher-order procedures

**Reading**: Abelson & Sussman, Section 1.3

**Note** that we are skipping 1.2; we’ll get to it later. Because of this, never mind for now the stuff about iterative versus recursive processes in 1.3 and in the exercises from that section.

Don’t panic if you have trouble with the half-interval example on pp. 67–68; you can just skip it. Try to read and understand everything else.

## Homework

1. Abelson & Sussman, exercises 1.31(a), 1.32(a), 1.33, 1.40, 1.41, 1.43, 1.46

**1.31(a):**

a. product definition:

```Lisp
(define (product fn a next b)
        (if (> a b)
            1
            (* (fn a) (product fn (next a) next b))))
```

b. factorial definition:

```Lisp
(define (factorial n)
	(product (lambda (x) x) 1 (lambda (x) (+ 1 x)) n))
```

c. compute approximations to PI:

```Lisp
(define (pi terms)
  (* 4 (product (lambda (x) (/ (* (- x 1) (+ x 1))
                               (* x x)))
                3
                (lambda (x) (+ x 2))
                terms)))
```

**1.32(a):**

a. define accumulate

```Lisp
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate combiner null-value term (next a) next b))))
```

b. use accumulate define sum and product:

```Lisp
(define (sum fn a next b)
  (accumulate + 0 fn a next b))

(define (product fn a next b)
  (accumulate * 1 fn a next b))
```

**1.33:**

a. define filtered-accumulate:

```Lisp
(define (filtered-accumulate PRED combiner null-value term a next b)
  (if (> a b)
      null-value
      (if (PRED a)
          (combiner (term a) (filtered-accumulate PRED combiner null-value term (next a) next b))
          (filtered-accumulate PRED combiner null-value term (next a) next b))
      ))
```

b. the sum of the squares of the prime numbers in the interval a to b.

```Lisp
(define (sum-square-prime a b)
  (filtered-accumulate prime? + 0 (lambda (x) (* x x)) a (lambda (x) (+ x 1)) b))
```

c. the product of all the positive integers less than n

```Lisp
(define (product-positive n)
  (filtered-accumulate (lambda (x) (= 1 (gcd x n))) * 1 (lambda (x) x) 1 (lambda (x) (+ 1 x)) n))
```

**1.40:**


