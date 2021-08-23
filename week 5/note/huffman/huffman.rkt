#lang simply-scheme

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf leaf)
  (cadr leaf))

(define (weight-leaf leaf)
  (caddr leaf))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree)
  (car tree))

(define (right-branch tree)
  (cadr tree))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit: CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair) ; symbol
                               (cadr pair)) ; frequency
                    (make-leaf-set (cdr pairs))))))


; 2,67
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree
                    (make-leaf 'D 1)
                    (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(decode sample-message sample-tree) ;(A D A B B C A)

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (if (leaf? tree)
      (if (eq? symbol (symbol-leaf tree))
          '()
          (error "MISSING SYMBOL" symbol))
      (let ((left (left-branch tree)))
        (if (member? symbol (symbols left))
            (cons 0 (encode-symbol symbol left))
            (cons 1 (encode-symbol symbol (right-branch tree)))))))

(encode '(A D A B B C A) sample-tree)

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

(generate-huffman-tree '((A 4) (B 2) (C 1) (D 1)))

(define rock-song (generate-huffman-tree
                   '((A 2) (GET 2) (SHA 3) (WAH 1) (BOOM 1) (JOB 2) (NA 16) (YIP 9))))

(+ (length (encode '(GET A JOB) rock-song)) ;
   (length (encode '(SHA NA NA NA NA NA NA NA NA) rock-song))
   (length (encode '(GET A JOB) rock-song))
   (length (encode '(SHA NA NA NA NA NA NA NA NA) rock-song))
   (length (encode '(WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP) rock-song))
   (length (encode '(SHA BOOM) rock-song)))

(define alphabets (generate-huffman-tree
                   '((A 1) (B 2) (C 4) (D 8) (E 16) (F 32))))

(encode '(A) alphabets)
(encode '(B) alphabets)
(encode '(C) alphabets)
(encode '(D) alphabets)
(encode '(E) alphabets)
(encode '(F) alphabets)