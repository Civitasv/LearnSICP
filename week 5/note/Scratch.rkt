#lang simply-scheme

(define (make-tree root left right)
  (list root left right))

(define (left tree)
  (cadr tree))

(define (right tree)
  (caddr tree))

(define (inorder tree)
  (define (helper tree lst)
    (if (null? tree)
        lst
        (helper (left tree) (cons (car tree) (helper (right tree) lst)))))
  (helper tree '()))

(inorder (make-tree 1 (make-tree 2 '() '()) (make-tree 3 '() '())))