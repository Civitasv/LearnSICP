# CS 61A Week 10

Topic: client/server, concurrency

**Reading:** Abelson & Sussman, Section 3.4

## Homework

I have no access to `im-*`, so I'll just pass it and do the concurrency part.

Problem 1: Abelson & Sussman, exercises 3.38, 3.39, 3.40, 3.41, 3.42, 3.44, 3.46, 3.48

**3.38:**

a. There are four possible values for balance after these three transactions.

1. Peter first, Paul second, Mary third, result 45
2. Peter first, Mary second, Paul third, result 35
3. Paul first, Peter second, Mary third, result 45
4. Paul first, Mary second, Peter third, result 50
5. Mary first, Peter second, Paul third, result 40
6. Mary first, Paul second, Peter third, result 40

b. There are lots of extra possibilities.  It's especially bad
because Mary's command is

```Scheme		
(set! balance (- balance (/ balance 2)))
```

which examines the value of balance twice, instead of the mathematically equivalent

```Scheme
(set! balance (/ balance 2))
```

which only examines the value once.  Here are just a few possibilities:

Peter examines balance, then Paul and Mary run in either order, then Peter sets balance.  Paul's and Mary's activities become irrelevant; the final balance will be 110.

Mary looks at balance, then Paul runs, then Mary looks at balance again to compute (/ balance 2), then Peter runs, then Mary sets the balance.  Peter's work is irrelevant, but Paul's isn't; Mary computes (- 100 (/ 80 2)) and the final balance is 60.

Paul examines balance, then Peter and Mary run in any order, then Paul sets balance.  The result is 80.

**3.39：**

Because multiplying x by itself is serialized, we can eliminate the case in which (* x x) gets two different values of x, which is the one that leads to a final answer of 110.

However, because the setting of x in P1 is not serialized along with P1's reading of x, we can still get the incorrect answer 100.

And because only the computation part of P1 is serialized, the incorrect answer 11 is also still possible.  It can't happen the way it's described in the book:

P2 accesses x, then P1 sets x to 100, then P2 sets x

but it can happen in this more complicated way:

1. P1 reads x and computes the value 100, then
2. P2 accesses x (still 10), then
3. P1 sets x to 100 (since this part isn't serialized), then
4. P2 sets x to 11.

(And of course the correct answers 101 and 121 are still possible.)

**3.40:**

1. 1000000: P1 sets x to 100, then P2 sets x to 1000000, or P2 sets x, then P1 sets x
2. 100000: P2 access x(once), then P1 sets x, then P2 access x, then P2 sets x
3. 10000: P2 access x(twice), then P1 sets x, then P2 access x, then P2 sets x; or P1 access x(once), then P2 sets x, then P1 access x, then P1 sets x
4. 1000: P2 access x(three times), then P1 sets x, then P2 sets x
5. 100: P1 access x(twice), then P2 sets x, then P1 sets x

after using `serializer`, the result will be only one: 1000000

**3.41:**

The reason we need serialization in the first place is that if a process makes more than one reference to the same variable, we want to be sure its value is consistent throughout that process.  But reading the balance only looks at the balance once; how could another process interrupt that?

Actually, this answer is a slight handwave.  In order to be confident about it, you must know that a number can be read from the computer's memory in a single, indivisible hardware operation.  This is true for every modern computer, provided that the number fits in the usual hardware representation of numbers.  However, Scheme supports "bignums", which are unlimited-precision integers.  That's why in Scheme you can compute the factorial of 1000 and get a precise answer, even though that answer has 2568 decimal digits.  Reading a bignum requires more than one memory reference, and so Ben is right if bignums are allowed.

The usual indivisible-lookup kind of integer can support values up to about 2 billion, so this means that the bank that handles Bill Gates' account should take Ben's advice, but the rest of us don't have to worry about it.

**3.42:**

when to serialize procedures

Ben is right.  The key point to understand is that there are three distinct steps in using a serializer:

1. Create the serializer.
2. Create a serialized procedure.
3. Invoke the serialized procedure.

Only step 3 involves concurrency problems.  Ben's proposal is to reduce the number of times step 2 is taken, which is fine. 

**3.44:**

I think Louis Reasoner is right, cause if there are mutiple people concurrently transferring money among these accounts, there will be many reference on the balance, which will make wrong answer.

But the `exchange` procedure is different from `transfer`, cause we need to calculate the **difference** between these two accounts, but we don't need to do that in the **transfer** procedure, so we don't need get two serializers simultaneously, instead we can get them separately.

**3.46:**

If the `set-car!` won't be atomic, then there might be more than one procedure enter into the mutex.

**3.48:**

`serialized-exchange` will always attempt to enter a procedure protecting the lowest-numbered account first, which means we'll check the numbers in the account first, then decide which account to protect first, easy to think.

## Extra for experts

TODO
