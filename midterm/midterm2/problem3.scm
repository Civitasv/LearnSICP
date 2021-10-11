(define (max-fanout tree)
    (if (null? tree)
        0
        (max (fanout tree)
             (max (map max-fanout (children tree))))))

(define (fanout node)
    (if (null? node)
        0
        (length (children node))))
