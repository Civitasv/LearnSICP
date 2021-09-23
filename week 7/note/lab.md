# CS 61A Week 7 Lab

Problem 1:

```scheme
(define-class (person name)
    (instance-vars (last-thing '()))
    (method (say stuff)
        (set! last-thing stuff)
        stuff)
    (method (ask stuff) (ask self 'say (se '(would you please) stuff)))
    (method (greet) (ask self 'say (se '(hello my name is) name)))
    (method (repeat) last-thing))
```

Problem 2:

```scheme
(define-class (double-talker name)
  (parent (person name))
  (method (say stuff) (se (usual 'say stuff) (ask self 'repeat))) )
```

There are two things wrong with this approach.  One is that it assumes that the two arguments to SE are evaluated left-to-right, since the use of REPEAT assumes that we've just said the new stuff.  That might work in some versions of Scheme but not in others.

The second problem is that the value remembered in old-text will be a single copy of the argument, rather than two copies; therefore, if we ask this double-talker to repeat, it'll only say the thing once.


```scheme
(define-class (double-talker name)
  (parent (person name))
  (method (say stuff) (se stuff stuff)) )
```

This would work except for the REPEAT feature.  We can ask a double-talker to ASK or to GREET and it will correctly say the right thing twice.  But if we ask this double-talker to REPEAT, it won't say anything at all, because it never remembered the stuff in old-text.

```scheme
(define-class (double-talker name)
  (parent (person name))
  (method (say stuff) (usual 'say (se stuff stuff))) )
```

This one works as desired.

