# CS 61A Week 6

Topic: Generic Operators

Reading: Abelson & Sussman, Sections 2.4 through 2.5.2

## Homework

Problem 1: Abelson & Sussman, exercises 2.74, 2.75, 2.76, 2.77, 2.79, 2.80, 2.81, 2.83

**2.74:**

(a) Each division's package may look like this:

```Scheme
(define (install-research-division)
  (define (get-record employee file)
    ...)
  ...
  (put 'research 'record get-record)
  ...)

(define (get-record employee division-file)
  ((get (type-tag division-file) 'record)
   employee
   (contents division-file)))
```

It'll be invoked, for example, like this: `(get-record '(Alan Perlis) research-personnel-list)`

For this to work, each division's file must include a type tag specifying which division it is.

(b) Each division's package may look like this:

```Scheme
(define (install-research-division)
  (define (get-record employee file)
    ...)

  (define (get-salary record)
    ...)
  ...
  (put 'research 'record get-record)
  (put 'research 'salary get-salary)
  ...)

(define (get-salary record)
  ((get (type-tag record) 'salary)
   (contents record)))
```

(c)

```Scheme
(define (find-employee-record employee divisions)
  (cond ((null? divisions) (error "No such employee"))
	((get-record employee (car divisions)))
	(else (find-employee-record employee (cdr divisions)))))
```

(d) To add a new division, you must create a package for the division, make sure the division's personnel file is tagged with the division name, and add the division's file to the list of files used as argument to find-employee-record.

**2.75:**

```Scheme
(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* r (cos a)))
          ((eq? op 'imag-part) (* r (sin a)))
          ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          (else (error "ERROR NO SUCH OPERATION" op))))
  dispatch)
```

**2.76:**

1. For generic operations with explicit dispatch, if add a new type in system, we have to find the source code of all operations and add add this type to them, if add a new operation, we have to add a function to deal all types.
2. For data-directed style, if add a new type in system, we should associate it's tag with all the operations, the put it into the table of data type and operation, if add a new operation, we should find all the types, and add this operation to it's install procedure, and tag it surely.
3. For message-passing style, if add a new type in system, we should define a procedure, declare all the operations and implement them explicitly, if add a new operation, we should find all the types' procedure, and add this operation to it's dispatch procedure.

Which organization would be most appropriate:

1. For adding a new type, both data-directed style and message passing style work very well, but I think message passing is the most appropriate.
2. For adding an new operation, both data-directed style and message passing style work very well, but I think message passing is the most appropriate.

**2.77:**

When procedure `apply-generic` execute the statement `(get op type-tags)`, there is no one match the operation tag 'magnitude and type tag `complex` at the same time, so procedure `apply-generic` will throw an error message.

To evaluate the expression `(magnitude z)`, all the procedures called is showed below:

```txt
(magnitude z)
(apply-generic 'magnitude z)
The apply-generic function now looks up the entry for 'magnitude and '(rectangular) and finds the MAGNITUDE function from the RECTANGULAR package; that function is called with '(3 . 4) as its argument, which yields the final answer...  (sqrt (square 3) (square 4))  ==>  5
```

**2.79:**

```txt
(define (equ? x y)
  (apply-generic 'equ? x y))

In the scheme-number package:

  (put 'equ? '(scheme-number scheme-number) =)

In the rational package:

  (define (equ-rat? x y)
    (and (= (numer x) (numer y))
	 (= (denom x) (denom y))))
  ...
  (put 'equ? '(rational rational) equ-rat?)

In the complex package:

  (define (equ-complex? x y)
    (and (= (real-part x) (real-part y))
	 (= (imag-part x) (imag-part y))))
  ...
  (put 'equ? '(complex complex) equ-complex?)
```

**2.80:**

```txt
(define (=zero? x)
  (apply-generic '=zero? x))

In the scheme-number package:

  (put '=zero? '(scheme-number) (lambda (x) (= x 0)))

In the rational package:

  (define (=zero-rat? x)
    (= (numer x) 0))
  ...
  (put '=zero? '(rational) =zero-rat?)

In the complex package:

  (define (=zero-complex? x)
    (and (= (real-part x) 0)
         (= (imag-part x) 0)))

  ...
  (put '=zero? '(complex) =zero-complex?)
```

**2.81:**

(a). This will result in an infinite loop.

(b). Louis is wrong. If we have a complex exponentiation procedure and we PUT it into the table, then apply-generic won't try to convert the complex arguments. And if we don't have a complex exponentiation procedure, then apply-generic correctly gives an error message; there's nothing better it can do.

(Once we invent the idea of raising, it would be possible to modify apply-generic so that if it can't find a function for the given type(s), it tries raising the operand(s) just in case the operation is implemented for a more general type. For instance, if we try to apply EXP to two rational numbers, apply-generic could raise them to real and then the version of EXP for the scheme-number type will work. But it's tricky to get this right, especially when there are two operands -- should we raise one of them, or both?)

(c).

```Scheme
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (if (eq? type1 type2)
                    (error "No Method for these types"
                           (list op type-tags))
                    (let ((t1->t2 (get-coercion type1 type2))
                          (t2->t1 (get-coercion type2 type1)))
                      (cond (t1->t2
                             (apply-generic op (t1->t2 a1) a2))
                            (t2->t1
                             (apply-generic op a1 (t2->t1 a2)))
                            (else (error "No method for these types"
                                         (list op type-tags)))))))
              (error "No method for these types"
                     (list op type-tags)))))))

```

**2.83:**

```txt
(define (raise x)
  (apply-generic 'raise x))

In the integer package:

   (define (integer->rational int)
      (make-rational int 1))
   (put 'raise '(integer) integer->rational)

In the rational package:

   (define (rational->real rat)
      (make-real (/ (numer rat) (denom rat))))
   (put 'raise '(rational) rational->real)

In the real package:

   (define (real->complex Real)
      (make-complex-from-real-imag real 0))
   (put 'raise '(real) real->complex)
```

Problem 2:

```Scheme
(define (map-1 fn args)
  (if (null? args)
      '()
      (cons (apply-1 fn (list (car args)))
            (map-1 fn (cdr args)))))
```

Problem 3:

```txt
Here's what a LET expression looks like:

	(LET ((name1 value1) (name2 value2) ...) body)

A good starting point is to write selectors to extract the pieces.

(define let-exp? (exp-checker 'let))

(define (let-names exp)
  (map car (cadr exp))

(define (let-values exp)
  (map cadr (cadr exp))

(define let-body caddr)

As in last week's lab exercise, we have to add a clause to the COND in EVAL-1:

(define (eval-1 exp)
  (cond ((constant? exp) exp)
	((symbol? exp) (error "Free variable: " exp))
	((quote-exp? exp) (cadr exp))
	((if-exp? exp)
	 (if (eval-1 (cadr exp))
	     (eval-1 (caddr exp))
	     (eval-1 (cadddr exp))))
	((lambda-exp? exp) exp)
	((and-exp? exp) (eval-and (cdr exp)))	;; added in lab
	((LET-EXP? EXP) (EVAL-LET EXP))		;; ADDED
	((pair? exp) (apply-1 (car exp)
			      (map eval-1 (cdr exp))))
	(else (error "bad expr: " exp))))

We learned in week 2 that a LET is really a lambda combined with a procedure call, and one way we can handle LET expressions is just to rearrange the text to get

	( (LAMBDA (name1 name2 ...) body)  value1 value2 ... )

(define (eval-let exp)
  (eval-1 (cons (list 'lambda (let-names exp) (let-body exp))
		(let-values exp))))

Isn't that elegant?  It's certainly not much code.  You might not like the idea of constructing an expression just so we can tear it back down into its pieces for evaluation, so instead you might want to do the evaluation directly in terms of the meaning, which is to APPLY an implicit procedure to arguments:

(define (eval-let exp)
  (apply-1 (list 'lambda (let-names exp) (let-body exp))
	   (map eval-1 (let-values exp))))

We still end up constructing the lambda expression, because in this interpreter, a procedure is represented as the expression that created it.  (We'll see later that real Scheme interpreters have to represent procedures a little differently.)  But we don't construct the procedure invocation as an expression;  instead we call apply-1, and we also call eval-1 for each argument subexpression.
```

### Extra for experts

TODO
