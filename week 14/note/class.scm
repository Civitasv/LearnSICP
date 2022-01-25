(define (range bst low high)
  (define (helper root)
    (cond ((null? root) '())
	  ((< (val root) low) (helper (right root)))
	  ((> (val root) high) (helper (left root)))
	  (else (append (helper (left root)) (list (val root)) (helper (right root))))))
  (helper bst))

(define (make-tree root left right)
  (list root left right))

(define (left tree)
  (cadr tree))

(define (right tree)
  (caddr tree))

(define (val tree)
  (car tree))

(define x
  (make-tree
   37
   (make-tree
    25
    '()
    (make-tree
     30
     (make-tree 27 '() '())
     (make-tree 36 '() '())))
   (make-tree
    72
    (make-tree
     60
     (make-tree 45 '() '())
     (make-tree 65 '() '()))
    (make-tree 81 '() '()))))

(range x 25 80)
