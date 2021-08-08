# CS 61A Week 2 Lab

Monday afternoon, Tuesday, or Wendesday morning

This lab introduces a new special form, _lambda_.

Problem 1. just try learn lambda, easy.

Problem 2. Write a procedure _substitute_.

```Scheme
(define (substitute sent old new)
  (cond ((empty? sent) '())
        ((equal? (first sent) old) (se new (substitute (bf sent) old new)))
        (else (se (first sent) (substitute (bf sent) old new)))))
```

Problem 3.

a. If (g) is a legal expression, then g takes ZERO arguments.
b. If ((g) 1) has the value 3, then (g) has a PROCEDURE as its value.
c. (If we'd asked for more than one word, you could say "a procedure of one numeric argument that returns a number" or something.)

Problem 4. definition:

f: Any definition at all will do:

```Scheme
(define f 'hello)	f is  hello
(define f (+ 2 3) 	f is  5
(define (f x) (+ x 7) 	f is  #<procedure f>
```

(f) :This expression says to invoke f as a procedure with no arguments. For that to work, we must DEFINE f as a procedure with no arguments:

```Scheme
define (f) 'hello)	(f) is  hello
(define (f) (+ 2 3))	(f) is  5
;Each of these is shorthand for an explicit use of lambda:
(define f (lambda () 'hello))
(define f (lambda () (+ 2 3))
```

(f 3): This expression says to invoke f as a procedure with an argument, so we have to define it that way:

```Scheme
(define (f x) (+ x 5))		(f 3) is  8
(define (f x) 'hello)		(f 3) is  hello
(define (f x) (word x x))	(f 3) is  33
;Again, these definitions are shorthand for lambda expressions:
(define f (lambda (x) (+ x 5)))
(define f (lambda (x) 'hello))
(define f (lambda (x) (word x x)))
```

((f)): This expression says, first of all, to compute the subexpression (f), which invokes f as a procedure with no arguments. Then, the result of that invocation must be another procedure, which is also invoked with no arguments. So, we have to define f as a procedure that returns a procedure:

````Scheme
(define (f) (lambda () 'hello))	     ((f)) is  hello
(define (f) (lambda () (+ 2 3)))     ((f)) is  5

;Or without the shorthand,
(define f (lambda () (lambda () 'hello)))
(define f (lambda () (lambda () (+ 2 3))))
;Alternatively, we can let the procedure f return some procedure we already know about, supposing that that procedure can be invoked with no arguments:
(define (f) +)		((f)) is  0
(define f (lambda () +))
;As a super tricky solution, for hotshots only, try this:
(define (f) f)		((f)) is  #<procedure f>

(((f))) is.... ?

(((f)) 3): Sheesh!  F has to be a function.  When we invoke it with no arguments, we should get another function (let's call it G). When we invoke G with no arguments, we get a third function (call it H).  We have to be able to call H with the argument 3 and get some value.  We could spell this out as a sequence of definitions like this:

```Scheme
(define (h x) (* x x))
(define (g) h)
(define (f) g)		(((f)) 3) is  9
;Alternatively, we can do this all in one:
(define (f) (lambda () (lambda (x) (* x x))))
;or without the abbreviation:
(define f (lambda () (lambda () (lambda (x) (* x x)))))
````

Problem 5:

```Scheme
(define (t f)
  (lambda (x) (f (f (f x)))) )
```

```Scheme
((t 1+) 0) -> 3
((t (t 1+)) 0) -> 9
(((t t) 1+) 0) -> 27
```

Problem 6:

```Scheme
((t s) 0) -> 3
((t (t s)) 0) -> 9
(((t t) s) 0) -> 27
```

Problem 7:

```Scheme
(define (make-tester w)
  (lambda (x) (equal? x w)))
```
