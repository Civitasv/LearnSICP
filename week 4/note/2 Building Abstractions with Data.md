# 2. Building Abstractions With Data

> We now come to the decisive step of mathematical abstraction: we forget about what the symbols stand for....[The mathematicial] need not be idle; there are many operations which he may carry out with these symbols, without ever having to look at the things thy stand for.

This chapter we are going to look at more complex data. Thus, Whereas our focus in chapter 1 was on building abstractions by combining procedures to form compound procedures, we turn in this chapter to another key aspect of any programming language: the means it provides for building abstractions by combining data objects to form _compound data_.

As with compound procedures, the main issue to be addressed is that of abstraction as a technique for coping with complexity, and we will see how data abstraction enables us to erect suitable _abstraction barriers_ between different parts of a program.

## 2.1 Introduction to Data Abstraction

We note that a procedure used as an element in creating a more complex procedure could be regarded not only as a collection of particular operations but also as a procedural abstraction.

The analogous notion for compound data is called _data abstraction_. Data abstraction is a methodology that enables us to isolate how a compound data object is used from the details of how it is constructed from more primitive data objects.

Our programs should use data in such a way as to make no assumptions about the data that are not strictly necessary for performing the task at hand. At the same time, a "concrete" data representation is defined independent of the programs that use the data. The interface between these two parts of our system will be a set of procedures, called _selectors_ and _constrctors_, that implement the abstract data in terms of the concrete representation.

### 2.1.1 Example: Arithmetic Operations for Rational Numbers

```Scheme
;_pair_
(define x (cons 1 2)
    (car x) ; 1
    (cdr x)) ; 2
```

- _cons_ stands for "construct".
- That machine had an addressing scheme that allowed one to reference the "address" and "decrement" parts of a memory location.
- _cars_ stands for "Contents of Address part of Register"
- _cdr_ stands for "Contents of Decrement part of Register"

Later we will see how this ability to combine pairs means that pairs can be used as general-purpose building blocks to create all sorts of complext data structures. The single compound-data primitive _pair_, implemented by the procedures _con_, _car_, and _cdr_, is the **only glue** we need.

#### Representing rational numbers

### 2.1.2 Abstraction Barriers

In general, the underlying idea of data abstraction is to identify for each type of data object a basic set of operations in terms of which all manipulations of data objects of that type will be expressed, and then to use only those operations in manipulating the data.

### 2.1.3 What is Meant by Data?

In general, we can think of data as defined by some collection of selectors and construtors, together with specified conditions that these procedures must fulfill in order to be a valid representation.

### 2.1.4 Extended Exercise: Interval Arithmetic

## 2.2 Hierarchical Data and the Closure Property

In general, an operation for combining data objects satisfies the closure property if the results of combining things with that operation can themselves be combined using the same operation. Closure is the key to power in any means of combination because it permits us to create _hierarchical_ structures-structures made up of parts, which themselves are made up of parts, and so on.

### 2.2.1 Representing Sequences

One of the useful structures we can build with pairs is a _sequence_-an ordered collection of data objects.

Scheme provides a primitive called _list_ to help in constructing lists. In general:

```Scheme
(list <a1> <a2> ... <an>)
```

is equivalent to

```Scheme
(cons <a1>
    (cons <a2>
        (cons ...
            (cons <an>
                nil)...)))
```

#### List Operations

```Scheme
(define (list-ref items n)
    (if (= n 0)
        (car items)
        (list-ref (cdr items) (- n 1))))

(define (length items)
    (if (null? items)
        0
        (+ 1 (length (cdr items)))))

(define (append list1 list2)
    (if (null? list1)
        list2
        (cons (car list1) (append (cdr list1) list2))))
```

#### Mapping over lists

One extremely useful operation is to apply some transformation to each element in alist and generate the list of results.

Scheme standardly provides a map procedure that is more general than the one described here. This more general map takes a procedure of n arguments, together with n lists, and applies the procedure to all the first elements of the lists, all the second elements of the lists, and so on, returning a list of the results.

```Scheme
(map + (list 1 2 3) (list 40 50 60) (list 700 800 900))
(741 852 963)

(map (lambda (x y) (+ x (* 2 y)))
    (list 1 2 3)
    (list 4 5 6))
(9 12 15)
```
