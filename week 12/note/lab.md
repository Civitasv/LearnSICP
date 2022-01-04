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

Because none of the arguments to lambda should be evaluated. In particular, the expressions that make up the body of the procedure are not evaluated until the procedure is *invoked*!

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

Logo " is like Scheme ' -- it's the quoting symbol.  But in Logo it is used only with words, not with lists, and there is no QUOTE special form which the quotation character abbreviates.

Logo [ ] are like '( ) in Scheme -- the brackets both delimit and quote a list.  But within a list, brackets are used to delimit sublists, and don't imply an extra level of quotation, so Logo [a [b c] d] means '(a (b c) d), not '(a '(b c) d).  So, how do you get the effect of Scheme's ( ) without quotation?  In Scheme that means to call a procedure; in Logo you don't need any punctuation to call a procedure!  You just give the procedure name and its arguments.  But in Logo you *can* use parentheses around a procedure call just as you would in Scheme.

Logo : means that you want the value of the variable whose name follows the colon.  In Scheme the name by itself means this -- if you want the value of variable X, you just say X.  The reason this doesn't work in Logo is that in Logo procedures aren't just another data type, and a procedure name isn't just the name of a variable whose value happens to be a procedure.  (In other words, Logo procedures are not first-class.)  In Logo there can be a procedure and a variable with the same name, so FOO means the procedure and :FOO means the variable.
