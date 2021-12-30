# CS 61A Week 12 Lab

Problem 1:

All the procedures in the metacircular evaluator that call eval:

- eval-assignment
- eval-definition
- eval-if
- eval-sequence
- list-of-values
- driver-loop
- eval

Problem 2:

All the procedures in the metacircular evaluator that call apply:

- eval

Problem 3:

`make-procedure` just need to wrap the parameters and the body, when it is invoked, the metacircular evaluator will use eval to interpret body.

Problem 4:

**4.1:**

```Scheme
;;; left to right
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((val (eval (first-operand exps) env))
            (rest (list-of-values (rest-operands exps) env)))
        (cons val rest))))

;;; right to left
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((rest (list-of-values (rest-operands exps) env))
            (val (eval (first-operand exps) env)))
        (cons val rest))))
```

**4.2:**

a. We use `pair?` to check if the expression is a procedure call, if we move the procedure applications before assignment, then `(define x 3)` will be identified as a procedure call, which is wrong.

b. We should change the following code:

```Scheme
(define (application? exp)
  (tagged-list? exp 'call))

(define (operator exp)
  (cadr exp))

(define (operands exp)
  (cddr exp))
```

**4.4:**

```Scheme
(define (and? exp)
  (tagged-list? exp 'and))

(define (and-sequence exp)
  (cdr exp))

(define (eval-and exp env)
  (define (helper seq)
    (if (last-exp? seq)
        (meta-eval (first-exp seq) env)
        (let ((first (true? (meta-eval (first-exp seq) env))))
          (if (not first)
              false
              (helper (rest-exps seq))))))
  (helper (and-sequence exp)))

(define (or? exp)
  (tagged-list? exp 'or))

(define (or-sequence exp)
  (cdr exp))

(define (eval-or exp env)
  (define (helper seq)
    (if (last-exp? seq)
        (meta-eval (first-exp seq) env)
        (let ((first (true? (meta-eval (first-exp seq) env))))
          (if first
              true
              (helper (rest-exps seq))))))
  (helper (or-sequence exp)))
```

**4.5:**

```Scheme
(define (cond-recipient? clause)
  (eq? (cadr  clause) '=>))

(define (cond-predicate clause)
  (car clause))

(define (cond-actions clause)
  (if (cond-recipient? clause)
      (list (list (caddr clause) (cond-predicate clause)))
      (cdr clause)))
```

Problem 5:

a. Logo programming practice.

b.

```logo
make pi 3.1415926

to printPi
print pi
end

to another :pi
make pi :pi
printPi
end

printPi ; 3.1415926
another 2 ; 2
another 3 ; 3
```

This is an example that Logo uses dynamic scope rather than lexical scope.

c. the colon is used to identify formal paramters. the double-quote is used to identify variable. the square brackets is used to construct list or action.
