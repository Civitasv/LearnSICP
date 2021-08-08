# Lab

## first Lab

...

## Second Lab

1. Predict what Lisp will print in response to each of these expressions. Then try it and make sure your answer was correct, or if not, that you understand why!

   ```Scheme
   (define a 3) ; a = 3
   (define b (+ a 1)) ; b = 4
   (+ a b (* a b)) ; 19
   (= a b) ; #f
   (if (and (> b a) (< b (* a b)))
       b
       a) ; 4
   (cond ((= a 4) 6)
       ((= b 4) (+ 6 7 a))
       (else 25)) ; 16
   (+ 2 (if (> b a) b a)) ; 6
   (* (cond ((> a b) a)
       ((< a b) b)
       (else -1))
       (+ a 1)) ; 16
   ((if (< a b) + -) a b) ; 7
   ```

2. In the shell, type the command:

   `cp ~cs61a/lib/plural.scm.`

   (Note the period at the end of the line!) This will copy a file from the class library to your own directory.

   Then, using emacs to edit the file, modify the procedure so that it correctly handles cases like (`plural ’boy`).

   answer:

   ```Scheme
   (define (plural wd)
       (if (and (equal? (last wd) 'y)
               (not (vowel? (last (bl wd)))))
           (word (bl wd) 'ies)
           (word wd 's)))
   ```

3. Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.

   answer:

   ```Scheme
   (define (square x) ((* x x)))

   (define (sumTwoLargerNumbers x y z)
   (cond ((and (<= x y) (<= x z)) (+ (square y) (square z)) )
           ((and (<= y x) (<= y z)) (+ (square x) (square z)) )
           ((and (<= z x) (<= z y)) (+ (square x) (square y)) )
   ))
   (sumTwoLargerNumbers 1 2 3) -> 13
   ```

4. Write a procedure `dupls-removed` that, given a sentence as input, returns the result of removing duplicate words from the sentence. It should work this way:

   answer:

   ```Scheme
   (define (dupls-removed sentence)
   (if (empty? sentence)
       '()
       (se
           (if (member? (first sentence) (butfirst sentence))
               '()
               (first sentence))
           (dupls-removed (butfirst sentence)))))
   ```
