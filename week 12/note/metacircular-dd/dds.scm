(define (lookup keylist table)
  (cond    ; *** the clause ((not table) #f) is no longer needed
   ((null? keylist) (CAR table))	; ***
   (else (LET ((RECORD (assoc (car keylist) (cdr table))))
	   (IF (NOT RECORD)
	       false
	       (lookup (cdr keylist) (CDR RECORD)))))))	; ***

(define (insert! keylist value table)
  (if (null? keylist)
      (SET-CAR! table value)	; ***
      (let ((record (assoc (car keylist) (cdr table))))
				(if (not record)
	    		(begin
	     			(set-cdr! table
		       		(cons (LIST (CAR keylist) false) (cdr table))) ; ***
	     			(insert! (cdr keylist) value (CDADR table)))
	    		(insert! (cdr keylist) value (CDR RECORD))))))	; ***

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define the-table (list '*table*))

(define get
	(lambda (op type-tags)
		(lookup (list op type-tags) the-table)))

(define put 
	(lambda (op type-tags value)
		(insert! (list op type-tags) value the-table)))