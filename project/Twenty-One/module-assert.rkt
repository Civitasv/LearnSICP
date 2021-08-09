(module module-assert simply-scheme
    (provide assert)

    (define (assert comparison actual expected message)
        (if (not (comparison actual expected))
            (display (format "ERROR ~s! Expected ~a, actual ~a\n" message expected actual))
            #t)))