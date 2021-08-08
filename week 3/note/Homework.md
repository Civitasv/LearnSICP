# CS 61A Week 3 Homework

Topic: Recursion and iteration

Reading: Abelson & Sussman, Section 1.2 throgh 1.2.4

## Homework

Problem 1: Abelson & Sussman, exercises 1.16, 1.35, 1.37, 1.38

**1.16:**

```Scheme
(define (even? n)
  (= (remainder n 2) 0))

(define (square x)
  (* x x))

(define (fast-expt-iter b n a)
    (cond ((= n 0) a)
          ((even? n) (fast-expt-iter (square b) (/ n 2) a))
          (else (fast-expt-iter b (- n 1) (* a b)))))

(define (expt b n)
  (fast-expt-iter b n 1))
```

**1.35:**

```Scheme
(define (iterative-improve good-enough? improve)
  (define (iterate guess)
    (if (good-enough? guess)
        guess
        (iterate (improve guess))))
  iterate)


(define (fixed-point f first-guess)
  ((iterative-improve (lambda (guess) (< (abs (- guess (f guess))) 0.001)) f) first-guess))

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1)
```

**1.37:**

```Scheme
(define (cont-frac n d k)
    (cont-frac-iter n d 0 k))

(define (cont-frac-iter n d a b)
    (if (= b 0)
        a
        (cont-frac-iter n d (/ (n b) (+ (d b) a)) (- b 1))))

(define (phi k)
    (/ 1 (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) k)))
```

To get an approximation that is accurate to 4 decimal places, k should be bigger than 12.

Recursion process:

```Scheme
(define (cont-frac n d k)
    (define (helper i)
        (if (> i k)
            0
            (/ (n i) (+ (d i) (helper (+ i 1))))))
    (helper 1))
```

**1.38:**

```Scheme
(define approxi-e
    (+ 2 (cont-frac (lambda (x) 1.0)
               (lambda (x)
                    (cond ((= x 1) 1)
                          ((= x 2) 2)
                          ((= (remainder (- x 2) 3) 0) (* 2 (/ (- x 2) 3)))
                          (else 1))) 20)))
```

Problem2:

```Scheme
(define (next-perf n)
    (define (sum-of-factors num)
        (cond ((= num 0) 0)
              ((= (remainder n num) 0) (+ num (sum-of-factors (- num 1))))
              (else (sum-of-factors (- num 1)))))
    (if (= (sum-of-factors (- n 1)) n)
        n
        (next-perf (+ n 1))))
```

Problem 3:

How can changing the order of the first two clauses matter? It must
be a situation in which _both_ tests are satisfied. Then the original
program will give the result 1, while the reversed version will give
the result 0. But if both tests are satisfied, AMOUNT must be zero,
because of the first clause above. So it can't be less than zero also.
Therefore, the only way the second test can be satisfied is if
KINDS-OF-COINS is also zero. With the original version, (cc 0 0) will
give the result 1, whereas with the reordered version, (cc 0 0) will be 0.

As it turns out, no possible argument to COUNT-CHANGE will give rise to a call
to CC with both arguments zero. Therefore, it's fair to say that this
difference doesn't really make a difference, if you think of CC as just a
helper procedure of COUNT-CHANGE and not as something that could be called
independently for its own sake. But it's not quite trivial to _prove_ that CC
is never called with both arguments zero. The key point is that in each of
the two recursive invocations of CC, one argument changes and the other
remains the same. Therefore, unless one of the arguments was zero in the
outer invocation, both can't be zero in the recursive invocation. But if
either argument is zero we don't get to the recursive invocations; one of the
base cases will come into play instead.

What's the right answer to (cc 0 0)? That is, how many ways can we count out
zero cents using no coins? One way -- use no coins! So the book's order is
correct.

Problem 4:

```Scheme
(define (expt b n)
    (expt-iter b n 1))

(define (expt-iter b counter product)
    (if (= counter 0)
        1
        (expt-iter b (- counter 1) (* b product))))
```

$$
b^{counter} * product = b^n
$$

### Extra for experts

Problem 1:

```Scheme
(define (number-of-partitions n)
    (define (helper n type)
        (cond ((= n 0) 1)
              ((or (< n 0) (= type 0)) 0)
              (else (+ (helper n (- type 1))
                 (helper (- n type) type)))))
    (helper n n))
```

Problem 2: Counting partitions is like making change, where the coins are the positive integers.

Problem 3 (Awaiting Understanding...):

```Scheme
(define (partitions num)
  (pp num num (lambda (result) result)))

(define (pp num chunk next)
  (cond ((= num 0) (next 1))
  	((or (< num 0) (= chunk 0)) (next 0))
	(else (pp (- num chunk)
		  chunk
		  (lambda (result1)
		    (pp num
			(- chunk 1)
			(lambda (result2)
			  (next (+ result1 result2)))))))))
```
