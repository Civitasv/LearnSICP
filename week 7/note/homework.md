# CS 61A Week 7

Topic: Object-oriented programming

Reading: Read "Object-Oriented Programming--Above-the-line-view" (in course reader).

## Homework

Problem 1:

```scheme
(define-class (random-generator range)
    (instance-vars (random-count 0))

    (method (number)
        (set! random-count (+ random-count 1))
        (random range))
    (method (count)
        random-count))
```

Problem 2:

```scheme
(define-class (coke-machine number price)
    (instance-vars (total-cents 0) (cokes 0))

    (method (deposit cents)
        (set! total-cents (+ total-cents cents)))

    (method (coke)
        (cond ((<= cokes 0) (error "Machine empty"))
              ((< total-cents price) (error "Not enough money"))
              (else (set! total-cents (- total-cents price))
                    (set! cokes (- cokes 1))
                    total-cents)))
    (method (fill coke-number)
        (let ((new (+ cokes coke-number)))
          (set! cokes (if (> new number) number new)))))
```

Problem 3:

```scheme
(define-class (deck ordered-deck)
    (initialize (set! ordered-deck (shuffle ordered-deck)))

    (method (deal)
        (if (null? ordered-deck)
            '()
            (let ((top-card (car ordered-deck)))
              (set! ordered-deck (cdr ordered-deck))
              top-card)))

    (method (empty?)
        (null? ordered-deck)) )
```

Problem 4:

```scheme
(define-class (miss-manners obj)
    (method (please mes arg)
        (ask obj mes arg)))
```

EXTRA FOR EXPERTS:

Probably the easiest example to understand is one in which BOTH parents inherit from the same grandparent, like this:

```txt
                                +------------+
                                |   GP       |
                                |            |
                                | methods:   |
                                |   A, B, C  |
                                +------------+
                                    /     \
                                   /       \
                                  /         \
                       +------------+    +------------+
                       |  Parent1   |    |  Parent2   |
                       |            |    |            |
                       | methods:   |    | methods:   |
                       |   B, C     |    |   A, C     |
                       +------------+    +------------+
                                  \         /
                                   \       /
                                    \     /
                                +------------+
                                |   Child    |
                                +------------+

```

The methods in the classes Parent1 and Parent2 override more generic methods in the grandparent GP. Suppose we ask an instance of the Child class to use method A. Which method should it use? Since the Parent1 class doesn't have its own method A, it inherits the GP method A, which is the most generic version. Method A in the Parent2 class is more specific, so probably a better choice for the Child class.
