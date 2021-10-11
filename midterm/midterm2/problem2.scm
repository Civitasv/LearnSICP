(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
    (list entry left right))

(define (all-smaller? tree val)
    (cond ((null? tree) #t)
          ((< (entry tree) val)
           (and (all-smaller? (left-branch tree) val)
                (all-smaller? (right-branch tree) val)))
          (else #f)))

(define (all-larger? tree val)
    (cond ((null? tree) #t)
          ((> (entry tree) val)
           (and (all-larger? (left-branch tree) val)
                (all-larger? (right-branch tree) val)))
          (else #f)))
(define (bst? tree)
    (cond ((null? tree) #t)
          ((and (all-smaller? (left-branch tree) (entry tree))
                (all-larger? (right-branch tree) (entry tree)))
           (and (bst? (left-branch tree))
                (bst? (right-branch tree))))
          (else #f)))
