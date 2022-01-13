(define input-prompt ";;; L-EVAL input:")
(define output-prompt ";;; L-EVAL value:")

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (meta-eval input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))


(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))

(define (announce-output string)
  (newline) (display string) (newline))

(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>))
      (display object)))
