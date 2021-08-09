(module module-test-play-n simply-scheme
    (require "module-assert.rkt" "module-play-n.rkt" "module-stop-at-17.rkt" "module-dealer-sensitive.rkt")

    (play-n stop-at-17 10)
    (play-n dealer-sensitive 10)
   )