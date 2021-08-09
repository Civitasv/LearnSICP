(module module-higher-order simply-scheme
    (provide map reduce filter exist?)
    (define (map f sent)
        (if (empty? sent)
            '()
             (se (f (first sent)) (map f (bf sent)))))
    
    (define (reduce f sent sum)
        (if (empty? sent)
            sum
            (reduce f (bf sent) (f sum (first sent)))))
    
    (define (filter PRED sent)
        (if (empty? sent)
            '()
            (if (PRED (first sent))
                (se (first sent) (filter PRED (bf sent)))
                (filter PRED (bf sent)))))

    (define (exist? PRED sent)
        (cond ((empty? sent) #f)
              ((PRED (first sent)) #t)
              (else (exist? PRED (bf sent)))))
)