(module module-test-best-total simply-scheme
    (require "module-assert.rkt" "module-best-total.rkt")

    (assert = (best-total '()) 0 "() -> 0")
    
    (assert = (best-total '(ad as ab ah)) 14 "(ad as ab ah) -> 14")
    
    (assert = (best-total '(ad 8s)) 19 "(ad 8s) -> 19")

    (assert = (best-total '(ad 8s 5h)) 14 "(ad 8s 5h) -> 14")
    
    (assert = (best-total '(ad as 9h)) 21 "(ad as 9h) -> 21")
   )