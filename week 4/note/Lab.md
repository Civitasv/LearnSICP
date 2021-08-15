# CS 61 A Week 4 Lab

Problem 1:

pass

Problem 2:

pass

Problem 5:

```Scheme
(define (+rat a b)
  (make-rational (+ (* (numerator a) (denominator b)) (* (numerator b) (denominator a))) (* (denominator a) (denominator b))))
```

Problem 6:

**2.2:**

```Scheme
(define (make-segment p1 p2)
  (cons p1 p2))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (midpoint-segment segment)
  (make-point (/ (+ (x-point (start-segment segment)) (x-point (end-segment segment))) 2)
              (/ (+ (y-point (start-segment segment)) (y-point (end-segment segment))) 2)))
```

**2.3:**

Since the hint suggests using exercise 2.2, let's represent a rectangle as two adjacent sides (adjacent so that we get one length and one width).

```Scheme
(define (make-rectangle side1 side2)
  (cons side1 side2))

(define (first-leg rect)
  (car rect))

(define (second-leg rect)
  (cdr rect))
```

Perimeter and area:

```Scheme
(define (perimeter rect)
  (* 2 (+ (length-segment (first-leg rect))
          (length-segment (second-leg rect)))))

(define (area rect)
  (* (length-segment (first-leg rect))
     (length-segment (second-leg rect))))

(define (length-segment seg)
  (sqrt (+ (square (- (x-point (end-segment seg))
                      (x-point (start-segment seg))))
           (square (- (y-point (end-segment seg))
                      (y-point (start-segment seg)))))))
```

Different representation for rectangles: Note that the representation above really contains more information than necessary; it includes the common point twice, and it doesn't take into account that the angle between the two legs must be 90 degrees. So instead we could represent a rectangle using a BASE, which is a segment, and a HEIGHT, which is just a number (the length of the other segment).

```Scheme
(define (make-rectangle base height)
  (cons base height))

(define (base-rectangle rect)
  (car rect))

(define (height-rectangle rect)
  (cdr rect))
```

Making the same perimeter and area procedures work: To do this we have to redefine first-leg and second-leg in terms of the new representation. The first leg can be just the base, but for the second leg we need some analytic geometry. Specifically, we need to know that if the slope of the base segment is Dy/Dx (using D for delta) then the slope of a perpendicular height should be -Dx/Dy.

If we want the same perimeter and area procedures to work for either kind of rectangle, we have to have first-leg and second-leg check which kind we have, like this:

```Scheme
(define (first-leg rect)
  (if (pair? (cdr rect))
      (car rect)
      (base-rectangle rect)))

(define (second-leg rect)
  (if (pair? (cdr rect))
      (cdr rect)
      (let ((origin (start-segment (base-rectangle rect)))
            (endpoint (end-segment (base-rectangle rect)))
            (scale-factor (/ (height-rectangle rect)
            (length-segment (base-rectangle rect)))))
        (make-segment origin
                      (make-point (+ (x-point origin)
                                     (* scale-factor
                                       (- (y-point origin)
                                          (y-point endpoint))))
                                  (+ (y-point origin)
                                     (* scale-factor
                                       (- (x-point endpoint)
                                          (x-point origin)))))))))
```

Alternatively, you might find it easier to redefine perimeter and area in terms of the new representation, and then to make them work for the old representation you'll have to define base-rectangle and height-rectangle in terms of first-leg and second-leg:

```Scheme
(define (perimeter rect)
  (* 2 (+ (length-segment (base-rectangle rect))
          (height-rectangle rect))))

(define (area rect)
  (* (length-segment (base-rectangle rect))
     (height-rectangle rect)))

(define (base-rectangle rect)
  (if (pair? (cdr rect))
      (first-leg rect)
      (car rect)))

(define (height-rectangle rect)
  (if (pair? (cdr rect))
      (length-segment (second-leg rect))
      (cdr rect)))
```

Note that we don't want to check (pair? (cdr rect)) in the perimeter or area procedure, because those procedures are above the abstraction barrier -- they shouldn't have to know about the internal representation.

**2.4:**

```Scheme
(define (~cons x y)
  (lambda (m) (m x y)))

(define (~car z)
  (z (lambda (p q) p)))

(define (~cdr z)
  (z (lambda (p q) q)))
```

**2.18:**

```Scheme
(define (reverse lst)
  (if (null? lst)
      null
      (append (reverse (cdr lst)) (list (car lst)))))

(define (reverse2 lst)
  (define (helper lst res)
    (if (null? lst)
        res
        (helper (cdr lst) (cons (car lst) res))))
  (helper lst null))
```
