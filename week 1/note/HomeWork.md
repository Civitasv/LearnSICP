# HomeWork

1. Do exercise 1.6, page 25. This is an essay question; you needn’t hand in any computer printout, unless you think the grader can’t read your handwriting. If you had trouble understanding the square root program in the book, explain instead what will happen if you use new-if instead of if in the pigl Pig Latin procedure.

   answer: _new-if_ follow the applicative order, so then-clause and else-clause always run even the _predicate_ return true.

2. Write a procedure squares that takes a sentence of numbers as its argument and returns a sentence of the squares of the numbers:

   ```Scheme
   > (squares ’(2 3 4 5))
   (4 9 16 25)
   ```

   answer:

   ```Scheme
   (define (squarter x)
   (* x x))

   (define (squares sentence)
       (if (empty? sentence)
           '()
           (se (squarter (first sentence))
               (squares (butfirst sentence)))))
   ```

3. Write a procedure switch that takes a sentence as its argument and returns a sentence in which every instance of the words I or me is replaced by you, while every instance of you is replaced by me except at the beginning of the sentence, where it’s replaced by I. (Don’t worry about capitalization of letters.) Example:

   ```Scheme
   > (switch ’(You told me that I should wake you up))
   (i told you that you should wake me up)
   ```

   answer:

   ```Scheme
   (define (switch sentence)
       (se (switch-first (first sentence))
           (switch-rest (butfirst sentence))))

   (define (switch-first word)
       (cond ((equal? word 'I) 'you)
           ((equal? word 'i) 'you)
           ((equal? word 'me) 'you)
           ((equal? word 'Me) 'you)
           ((equal? word 'you) 'I)
           ((equal? word 'You) 'I)
           (else word)))

   (define (switch-rest sentence)
       (if (empty? sentence)
           '()
           (se (switch-one (first sentence))
               (switch-rest (butfirst sentence)))))

   (define (switch-one word)
       (cond ((equal? word 'I) 'you)
           ((equal? word 'i) 'you)
           ((equal? word 'me) 'you)
           ((equal? word 'Me) 'you)
           ((equal? word 'you) 'me)
           ((equal? word 'You) 'me)
           (else word)))
   (switch '(you told me that I should wake you up))
   ```

4. Write a predicate ordered? that takes a sentence of numbers as its argument and returns a true value if the numbers are in ascending order, or a false value otherwise.

   answer:

   ```Scheme
   (define (ordered? numbers)
   (cond ((empty? (butfirst numbers)) #t)
       (else (and (< (first numbers) (first (butfirst numbers)))
                   (ordered? (butfirst numbers))))))
   ```

5. Write a procedure ends-e that takes a sentence as its argument and returns a sentence containing only those words of the argument whose last letter is E:

   ```Scheme
   > (ends-e ’(please put the salami above the blue elephant))
   (please the above the blue)
   ```

   answer:

   ```Scheme
   (define (ends-e sentence)
   (if (empty? sentence)
       '()
       (se
           (if (equal? (last (first sentence)) 'e)
               (first sentence)
               '())
           (ends-e (butfirst sentence)))))
   ```

6. Most versions of Lisp provide `and` and `or` procedures like the ones on page 19. In principle there is no reason why these can’t be ordinary procedures, but some versions of Lisp make them special forms. Suppose, for example, we evaluate
   `(or (= x 0) (= y 0) (= z 0))`, If or is an ordinary procedure, all three argument expressions will be evaluated before or
   is invoked. But if the variable `x` has the value 0, we know that the entire expression has to be true regardless of the values of `y` and `z`. A Lisp interpreter in which or is a special form can evaluate the arguments one by one until either a true one is found or it runs out of arguments.

   Your mission is to devise a test that will tell you whether Lisp’s `and` and `or` are special forms or ordinary functions. This is a somewhat tricky problem, but it’ll get you thinking about the evaluation process more deeply than you otherwise might.

   Why might it be advantageous for an interpreter to treat `or` as a special form and evaluate its arguments one at a time? Can you think of reasons why it might be advantageous to treat `or` as an ordinary function?

   answer:

   ```Scheme
   (define x 0)
   (or (= 1 1) (/ 2 x))
   ```

   if an interpreter treat `or` as a special form, then this will report an error: `/: division by zero`, else not.

   Why might a special form be a good idea? Here are a few reasons:

   (a) Efficiency. Suppose instead of numbers or symbols I used combinations as the arguments to "or", and each combination takes several minutes to compute. If the first one happens to be true, it'd be a shame to waste all that time computing the others.

   (b) Conditions that depend on each other. Consider the expression

   ```Scheme
   > (or (= x 0) (> 5 (/ y x)))
   ```

   This will work fine if "or" is special and evaluates left-to-right, otherwise we may be dividing by zero.

   Reasons why an ordinary function might be preferred:

   (c) Fewer kludges. It's very easy to read and understand a Lisp program if you can be sure that everything that looks like (blah glorp zilch) is evaluated by evaluating the subexpressions and then applying the procedure "blah" to the arguments "glorp" and "zilch". Everything that looks like a procedure application but is really a special case just makes things that much harder to understand.

   (d) Creeping featurism. Where do we stop? Maybe we should make multiplication a special form; after all, in the expression

   ```Scheme
   > (* 0 x)
   ```

   there's no real reason to evaluate x because we know zero times anything is zero. Pretty soon there are no real functions left in the language.

   (e) Functional objects. You're not expected to know this yet, but next week you'll learn that procedures can be manipulated as data, just as numbers can. But special forms aren't procedures and there are some things we can't do to them.
