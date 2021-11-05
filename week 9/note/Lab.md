# CS 61 A Week 9 Lab

Problem 1:

![lab1](../images/lab1.png)

`append -> (b)`

`append! -> (b c d)`

`append` will make a brand new pair, instead `append!` will mutate the existing pairs.

Problem 2:

It'll get an error cause `(cdr x)` is not a variable.

Problem 3:

a:

- `(set-cdr! (car list2) (cdr list1))`
- `(set-cdr! (car list1) (car list2))`

b:

![lab3](../images/lab3.png)

Then list1 will be ((a x y) y), list2 will be ((x y) y).

Problem 4:

3.13:

The box-and-pointer diagram will be as:

![lab4-1](../images/lab4-1.png)

If we try to compute `(last-pair z)`, we'll and an infinite loop.

3.14:

![lab4-2](../images/lab4-2.png)

Then w will be `(d c b a)`, v will be `(a)`.
