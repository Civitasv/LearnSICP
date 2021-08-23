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

(total-weight (make-mobile (make-branch 1 2) (make-branch 2 (make-mobile (make-branch 1 2) (make-branch 2 3)))))

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
               (and (mobile-balanced? (branch-structure (left-branch mobile)))
                    (mobile-balanced? (branch-structure (right-branch mobile)))))
              ((and left-pair? (not right-pair?))
               (mobile-balanced? (branch-structure (left-branch mobile))))
              ((and (not left-pair?) right-pair?)
               (mobile-balanced? (branch-structure (right-branch mobile))))
              (else #t)))))

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

(equal? '(a b c) '(a b c))