#lang simply-scheme

(list 1 (list 2 (list 3 4)))

(define x (list 1 2 3))

(define y (list 4 5 6))

(append x y)

(cons x y)

(list x y)

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(define (branch-weight branch)
  (let ((struct (branch-structure branch)))
    (if (number? struct)
        struct
        (total-weight struct))))

(display "total weight: ")
(total-weight (make-mobile (make-branch 1 2) (make-branch 2 (make-mobile (make-branch 1 2) (make-branch 2 3)))))

(define (branch-torque branch)
  (* (branch-length branch) (branch-weight branch)))

(define (mobile-balanced? mobile)
  (and (= (branch-torque (left-branch mobile))
          (branch-torque (right-branch mobile)))
       (branch-balanced? (left-branch mobile))
       (branch-balanced? (right-branch mobile))))

(define (branch-balanced? branch)
  (let ((struct (branch-structure branch)))
    (if (number? struct)
        #t
        (mobile-balanced? struct))))

(display "balanced check: ")
(mobile-balanced? (make-mobile (make-branch 1 2) (make-branch 2 (make-mobile (make-branch 1 2) (make-branch 2 3)))))
(mobile-balanced? (make-mobile (make-branch 1 2) (make-branch 1 2)))
(mobile-balanced? (make-mobile (make-branch 1 4) (make-branch 1 (make-mobile (make-branch 1 2) (make-branch 1 2)))))

(define (square x)
  (* x x))

(define (square-tree tree)
  (if (list? tree)
      (map (lambda (t) (square-tree t)) tree)
      (square tree)))

(square-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(define (tree-map fn tree)
  (if (list? tree)
      (forest-map fn tree)
      (fn tree)))

(define (forest-map fn forest)
  (if (null? forest)
      '()
      (cons (tree-map fn (car forest)) (forest-map fn (cdr forest)))))

(tree-map square (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x)) rest)))))

(subsets (list 1 2 3))

(define (accumulate op init seqs)
  (if (null? seqs)
      init
      (op (car seqs)
          (accumulate op init (cdr seqs)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map (lambda (seq) (car seq)) seqs))
            (accumulate-n op init (map (lambda (seq) (cdr seq)) seqs)))))


(accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

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


(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define fold-right accumulate)

(fold-left / 1 (list 1 2 3))
(fold-right / 1 (list 1 2 3))
(fold-right cons null (list 1 2 3))
(fold-left cons null (list 1 2 3))

(define (equal? a b)
  (cond ((and (symbol? a) (symbol? b)) (eq? a b))
	((or (symbol? a) (symbol? b)) #f)
	((and (number? a) (number? b)) (= a b))       ;; not required but
	((or (number? a) (number? b)) #f)             ;; suggested in footnote
	((and (null? a) (null? b)) #t)
	((or (null? a) (null? b)) #f)
	((equal? (car a) (car b)) (equal? (cdr a) (cdr b)))
	(else #f)))

(equal? '(a b c) '(a b c))