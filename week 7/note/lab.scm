(define-class (person name)
    (instance-vars (last-thing '()))
    (method (say stuff)
        (set! last-thing stuff)
        stuff)
    (method (ask stuff) (ask self 'say (se '(would you please) stuff)))
    (method (greet) (ask self 'say (se '(hello my name is) name)))
    (method (repeat) last-thing))