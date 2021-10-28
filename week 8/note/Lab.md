# CS 61A Week 8 Lab

Problem 1:

`(balance init-amount)`

Problem 2:

```Scheme
(define (make-account balance)
  (define init balance)
  (define (withdraw amount)
    (set! balance (- balance amount)) balance)
  (define (deposit amount)
    (set! balance (+ balance amount)) balance)
  (define (dispatch msg)
    (cond
      ((eq? msg 'withdraw) withdraw)
      ((eq? msg 'balance) balance)
      ((eq? msg 'init-balance) init)
      ((eq? msg 'deposit) deposit) ) )
  dispatch)
```

Problem 3:

```Scheme
(define (make-account balance)
  (define init balance)
  (define transactions '())

  (define (withdraw amount)
    (set! transactions (append transactions (list (list 'withdraw amount))))
    (set! balance (- balance amount)) balance)
  (define (deposit amount)
    (set! transactions (append transactions (list (list 'deposit amount))))
    (set! balance (+ balance amount)) balance)
  (define (dispatch msg)
    (cond
      ((eq? msg 'withdraw) withdraw)
      ((eq? msg 'balance) balance)
      ((eq? msg 'transactions) transactions)
      ((eq? msg 'init-balance) init)
      ((eq? msg 'deposit) deposit) ) )
  dispatch)
```

Problem 4:

if use substitution model, the result will be 5, but actually, it is 6.
