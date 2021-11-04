(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup keys)
      (define (helper keys table)
        (if (= (length keys) 1)
            (let ((record
                    (assoc (car keys) (cdr table))))
              (if record (cdr record) false))
            (let ((subtable
                    (assoc (car keys) (cdr table))))
              (if subtable
                  (helper (cdr keys) subtable)
                  false))))
      (helper keys local-table))
    (define (insert! keys value)
      (define (helper keys table)
        (if (= (length keys) 1)
            (let ((record
                    (assoc (car keys) (cdr table))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! table (cons (cons (car keys) value) (cdr table)))))
            (let ((subtable
                    (assoc (car keys) (cdr table))))
              (if subtable
                  (helper (cdr keys) subtable)
                  (begin 
                    (set-cdr! table (cons (cons (car keys) '()) (cdr table)))
                    (helper (cdr keys) (cadr table)))))))
      (helper keys local-table)
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc) insert!)
            (else (error "Unkown operation: TABLE" m))))
    dispatch))