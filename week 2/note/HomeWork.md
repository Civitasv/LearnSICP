# CS 61A Homework Week 2

Topic: Higher-order procedures

**Reading**: Abelson & Sussman, Section 1.3

**Note** that we are skipping 1.2; we’ll get to it later. Because of this, never mind for now the stuff about iterative versus recursive processes in 1.3 and in the exercises from that section.

Don’t panic if you have trouble with the half-interval example on pp. 67–68; you can just skip it. Try to read and understand everything else.

## Homework

Problem 1. Abelson & Sussman, exercises 1.31(a), 1.32(a), 1.33, 1.40, 1.41, 1.43, 1.46

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

```Lisp
(define (cubic a b c)
  (lambda (x) (+ (* x x x) (* a x x) (* b x) c)))
```

**1.41:**

```Lisp
(define (double f)
  (lambda (x) (f (f x))))
```

**1.43:**

```Lisp
(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (lambda (x)
    (if (= n 0)
        (lambda (x) x)
        (compose f (repeated f (- n 1))))))
```

**1.46:**

```Lisp
(define (iterative-improve good-enough? improve)
  (define (iterate guess)
    (if (good-enough? guess)
        guess
        (iterate (improve guess))))
  iterate)


(define (fixed-point f first-guess)
  ((iterate-improve (lambda (guess) (< (abs (- guess (f guess))) 0.001)) f) first-guess))
```

Problem 2. Last week you wrote procedures squares, that squared each number in its argument sentence, and saw pigl-sent, that pigled each word in its argument sentence. Generalize this pattern to create a higher-order procedure called every that applies an arbitrary procedure, given as an argument, to each word of an argument sentence. This procedure is used as follows:

(every square ’(1 2 3 4)) -> (1 4 9 16)

(every first ’(nowhere man)) -> (n m)

```Lisp
(define (every f sent)
  (if (empty? sent)
      '()
      (se (f (first sent)) (every f (bf sent)))))
```

Problem 3. Extra for experts: find a way to express the *fact* procedure in a Scheme without any way to define global names.

```Lisp
(  (  (lambda (f) (lambda (n) (f f n)))
      (lambda (fun x)
	(if (= x 0)
	    1
	    (* x (fun fun (- x 1)))))  )
   5)
```

```Lisp
((lambda (f n) (if (= n 0) 1 (* n (f f (- n 1)))))
 (lambda (f n) (if (= n 0) 1 (* n (f f (- n 1)))))
 5)
```
