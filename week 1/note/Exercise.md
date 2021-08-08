# Exercise

## Exercise 1.1

```Scheme
10 -> 10
(+ 5 3 4) -> 12
(- 9 1) -> 8
(/ 6 2) -> 3
(+ (* 2 4) (- 4 6)) -> 6
(define a 3) -> a = 3
(define b (+ a 1)) -> b = 4
(+ a b (* a b)) -> 19
(= a b) -> #f
(if (and (> b a) (< b (* a b))) b a) -> 4
(cond ((= a 4) 6)
        ((= b 4) (+ 6 7 a))
        (else 25)) -> 16
(+ 2 (if (> b a) b a)) -> 6
(* (cond ((> a b) a)
        ((< a b) b)
        (else -1))
        (+ a 1)) -> 16
```

## Exercise 1.2

Translate the following expression into prefix form:

$$
\frac{5+4+(2-(3-(6+\frac{4}{5})))}{3(6-2)(2-7)}
$$

```Scheme
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))
```

## Exercise 1.3

Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.

```Scheme
(define (square x) ((* x x)))

(define (sumTwoLargerNumbers x y z)
  (cond ((and (<= x y) (<= x z)) (+ (square y) (square z)) )
        ((and (<= y x) (<= y z)) (+ (square x) (square z)) )
        ((and (<= z x) (<= z y)) (+ (square x) (square y)) )
  ))
(sumTwoLargerNumbers 1 2 3) -> 13
```

## Exercise 1.4

_a-plus-abs-b_ indicate a plus abs(b).

## Exercise 1.5

Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using applicative-order evaluation or normal-order evaluation. He defines the following two procedures:

```Scheme
(define (p) (p))
(define (test x y)
    (if (= x 0) 0 y))
```

(test 0 (p))

**applicative-order**: firstly, calculate the value of expression (p), then return 0.

**normal-order**: no need to calcaulate the value of expression (p).

## Exercise 1.6

_new-if_ follow the applicative order, so then-clause and else-clause always run even predicate return true.

## Exercise 1.7

```Scheme
; Modify version
(define (good-enough? guess x)
    (< (abs (- guess (improve guess x))) 0.001))
```
