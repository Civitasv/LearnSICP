# CS 61A Week 5 Homework

Topic: Hierarchical data

Reading: Abelson & Sussman, Section 2.2.2-2.2.3, 2.3.1, 2.3.3

## Homework

Problem 1: Abelson & Sussman, exercises 2.24, 2.26, 2.29, 2.30, 2.31, 2.32, 2.36, 2.37, 2.38, 2.54

**2.24:**

value: '(1 (2 (3 4)))

box-and-pointer structure:

[box-and-pointer structure](../images/2.24-1.png)

tree structure:

[tree structure](../images/2.24-2.png)

**2.26:**

```Scheme
(append x y) ; (1 2 3 4 5 6)
(cons x y) ; ((1 2 3) 4 5 6)
(list x y) ; ((1 2 3) (4 5 6))
```

**2.29:**

a. define `left-branch` and `right-branch` and `branch-length` and `branch-structure`

```Scheme
(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))
```

b. define `total-weight`

```Scheme
(define (total-weight mobile)
  (if (null? mobile)
      0
      (let ((left-pair? (pair? (branch-structure (left-branch mobile))))
            (right-pair? (pair? (branch-structure (right-branch mobile)))))
        (cond ((and left-pair? right-pair?)
               (+ (total-weight (branch-structure (left-branch mobile)))
                  (total-weight (branch-structure (right-branch mobile)))))
              ((and left-pair? (not right-pair?))
               (+ (total-weight (branch-structure (left-branch mobile)))
                  (branch-structure (right-branch mobile))))
              ((and (not left-pair?) right-pair?)
               (+ (total-weight (branch-structure (right-branch mobile)))
                  (branch-structure (left-branch mobile))))
              (else (+ (branch-structure (left-branch mobile))
                       (branch-structure (right-branch mobile))))))))
```

c.

```Scheme
(define (branch-torque branch)
  (cond ((null? branch) 0)
        ((pair? (branch-structure branch)) (* (branch-length branch) (total-weight (branch-structure branch))))
        (else (* (branch-length branch) (branch-structure branch)))))

(define (mobile-balanced? mobile)
  (if (null? mobile)
      #t
      (let ((left-pair? (pair? (branch-structure (left-branch mobile))))
            (right-pair? (pair? (branch-structure (right-branch mobile))))
            (left-branch-torque (branch-torque (left-branch mobile)))
            (right-branch-torque (branch-torque (right-branch mobile))))
        (cond ((not (= left-branch-torque right-branch-torque)) #f)
              ((and left-pair? right-pair?)
               (and (mobile-balanced? (left-branch mobile)) (mobile-balanced? (right-branch mobile))))
              ((and left-pair? (not right-pair?))
               (mobile-balanced? (left-branch mobile)))
              ((and (not left-pair?) right-pair?)
               (mobile-balanced? (right-branch mobile)))
              (else #t)))))
```

d.

```Scheme
(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch))
```

**2.30:**

```Scheme
(define (square-tree tree)
  (if (list? tree)
      (map (lambda (t) (square-tree t)) tree)
      (square tree)))
```

**2.31:**

```Scheme
(define (tree-map fn tree)
  (if (list? tree)
      (forest-map fn tree)
      (fn tree)))

(define (forest-map fn forest)
  (if (null? forest)
      '()
      (cons (tree-map fn (car forest)) (forest-map fn (cdr forest)))))
```

**2.32:**

```Scheme
(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x)) rest)))))
```

for example, there is a set `(1 2 3)`.

firstly, `(1 2 3)` is not null, so rest equals subsets of list `(2 3)`

secondly, `(2 3)` is not null, so rest equals subsets of list `(3)`

thirdly, `(3)` is not null, so rest equals subsets of list `()`

fourthly, `()` is null, so return `(())`

so back to the third, rest equals to `(())`, so the subsets of `(3)` is `(() (3))`

so back to the second, rest equals to `(() (3))`, so the subsets of `(2 3)` is `(() (3) (2) (2 3))`

finally, back to the first, rest equals to `(() (3) (2) (2 3))`, so the subsets of `(1 2 3)` is `(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))`

**2.36:**

```Scheme
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map (lambda (seq) (car seq)) seqs))
            (accumulate-n op init (map (lambda (seq) (cdr seq)) seqs)))))
```

**2.37:**

```Scheme
(define (matrix-*-vector m v)
  (map (lambda (v1) (dot-product v1 v)) m))

(dot-product '(1 2 3) '(1 2 3))

(matrix-*-vector '((1 2 3) (4 5 6)) '(1 2 3))

(define (transpose mat)
  (accumulate-n cons '() mat))

(transpose '((1 2 3 4) (4 5 6 6) (6 7 8 9)))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (seq) (matrix-*-vector cols seq)) m)))

(matrix-*-matrix '((1 2 3 4) (4 5 6 6) (6 7 8 9))
                 '((1 4 6) (2 5 7) (3 6 8) (4 6 9)))
```

**2.38:**

```Scheme
(fold-right / 1 (list 1 2 3)) ; 2/3
(fold-left / 1 (list 1 2 3)) ; 1/6
(fold-right list nil (list 1 2 3)) ; (1 (2 (3 ())))
(fold-left list nil (list 1 2 3)) ; (((() 1) 2) 3)
```

op must to be communicative to guarantee that `fold-right` and `fold-left` produce the same values.

**2.54:**

```Scheme
(define (equal? lst1 lst2)
  (cond ((and (null? lst1) (null? lst2)) #t)
        ((and (null? lst1) (not (null? lst2))) #f)
        ((and (not (null? lst1)) (null? lst2)) #f)
        ((and (list? (car lst1)) (list? (car lst2)))
         (and (equal? (car lst1) (car lst2))
              (equal? (cdr lst1) (cdr lst2))))
        ((and (symbol? (car lst1)) (symbol? (car lst2)))
         (and (eq? (car lst1) (car lst2))
              (equal? (cdr lst1) (cdr lst2))))
        (else #f)))
```

Problem 2: See File [calc](calculator/calc.rkt)

## Extra for experts

**2.67:**

```Scheme
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree
                    (make-leaf 'D 1)
                    (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(decode sample-message sample-tree) ;(A D A B B C A)
```

**2.68:**

```Scheme
(define (encode-symbol symbol tree)
  (if (leaf? tree)
      (if (eq? symbol (symbol-leaf tree))
          '()
          (error "MISSING SYMBOL" symbol))
      (let ((left (left-branch tree)))
        (if (memq symbol (symbols tree))
            (cons 0 (encode-symbol symbol left))
            (cons 1 (encode-symbol symbol (right-branch tree)))))))
```

**2.69:**

```Scheme
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leafs)
  (cond ((null? leafs) (make-code-tree '() '()))
        ((null? (cdr leafs)) (car leafs))
        (else (let ((first (car leafs))
                    (second (cadr leafs)))
                (successive-merge (adjoin-set
                                   (make-code-tree first second)
                                   (cddr leafs)))))))
```

**2.70:**

```Scheme
(define rock-song (generate-huffman-tree
           '((A 2) (GET 2) (SHA 3) (WAH 1) (BOOM 1) (JOB 2) (NA 16) (YIP 9))))

(encode '(GET A JOB) rock-song)
(encode '(SHA NA NA NA NA NA NA NA NA) rock-song)
(encode '(GET A JOB) rock-song)
(encode '(SHA NA NA NA NA NA NA NA NA) rock-song)
(encode '(WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP) rock-song)
(encode '(SHA BOOM) rock-song)
```

So we need 84 bits to encode this song.

**2.71:**

We need only one bits to encode the most frequent symbol, and `n-1` bits to encode the least frequent symbol.

**2.72:**

pass

**Regroup:**
