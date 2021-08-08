# CS 61A Week 3 Lab

Monday afternoon, Tuesday, or Wednesday morning

Problem 1:

```Scheme
(define (first-denomination kinds-of-coins)
    (cond ((= kind-of-icons 1) 50)
          ((= kind-of-icons 2) 25)
          ((= kind-of-icons 3) 10)
          ((= kind-of-icons 4) 5)
          ((= kind-of-icons 5) 1)))
```

Problem 2:

Explore the efficiency. Here is what happens with (cc 5 2) in the original order, as in the book:

```Scheme
> (cc 5 2)
"CALLED" cc 5 2
 "CALLED" cc 0 2
 "CALLED" cc 5 1
  "CALLED" cc 4 1
   "CALLED" cc 3 1
    "CALLED" cc 2 1
     "CALLED" cc 1 1
      "CALLED" cc 0 1
      "CALLED" cc 1 0
     "CALLED" cc 2 0
    "CALLED" cc 3 0
   "CALLED" cc 4 0
  "CALLED" cc 5 0
```

(I've deleted the "RETURNED" lines in the trace; it's easier to read this way and doesn't affect our analysis.)

To try out just pennies and nickels backwards, I modified first-denomination this way:

```Scheme
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 5)
	((= kinds-of-coins 2) 1)))
```

And here are the results:

```Scheme
> (cc 5 2)
"CALLED" cc 5 2
 "CALLED" cc 4 2
  "CALLED" cc 3 2
   "CALLED" cc 2 2
    "CALLED" cc 1 2
     "CALLED" cc 0 2
     "CALLED" cc 1 1
      "CALLED" cc -4 1
      "CALLED" cc 1 0
    "CALLED" cc 2 1
     "CALLED" cc -3 1
     "CALLED" cc 2 0
   "CALLED" cc 3 1
    "CALLED" cc -2 1
    "CALLED" cc 3 0
  "CALLED" cc 4 1
   "CALLED" cc -1 1
   "CALLED" cc 4 0
 "CALLED" cc 5 1
  "CALLED" cc 0 1
  "CALLED" cc 5 0
```

We get the same answer, but with 21 calls to CC instead of 13. Why? The extra calls are for attempts to match a small amount of money with a large coin -- for example, to use a nickel in counting four cents. When the coins are tried in the book's order, by the time we are thinking about four cents, we have already abandoned the idea of using nickels and so we quickly find the four-pennies solution. But in backward order, we have to discover that a nickel is too big for four cents, and then that a nickel is too big for three cents, and so on. (These situations give rise to the calls with a negative amount of money; notice that there aren't any like that in the first trace.)

Problem 3:

```Scheme
(define (cc amount kinds-of-coins)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (empty? kinds-of-coins)) 0)
          (else (+ (cc amount (bf kinds-of-coins))
                   (cc (- amount (first kinds-of-coins)) kinds-of-coins)))))
```

Problem 4:

```Scheme
(define (type-check f predicate? datum)
    (if (predicate? datum)
        (f datum)
        #f))
```

Problem 5:

```Scheme
(define (make-safe f predicate?)
    (lambda (x) (if (predicate? x) (f x) #f)))
```
