#lang sicp 
(#%require sicp-pict)

(define wave2 (beside mark-of-zorro (flip-vert mark-of-zorro )))
(define wave4 (below wave2 wave2))

(paint wave2)
(paint wave4)

(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))

(paint (flipped-pairs mark-of-zorro))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(paint (right-split mark-of-zorro 2))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

(paint (up-split mark-of-zorro 2))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((up-left (beside up up))
              (bottom-right (below right right))
              (up-right (corner-split painter (- n 1))))
          (below (beside painter bottom-right) (beside up-left up-right))))))

(paint (corner-split mark-of-zorro 2))

(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))

(paint (square-limit mark-of-zorro 2))

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(paint ((square-of-four identity flip-vert
                       identity flip-vert) mark-of-zorro))

(paint ((square-of-four flip-horiz identity
                        (lambda (x) (flip-vert (flip-horiz x))) flip-vert) (corner-split mark-of-zorro 2)))

(define (split a1 a2)
  (define (helper painter n)
    (if (= n 0)
        painter
        (let ((smaller (helper painter (- n 1))))
          (a1 painter (a2 smaller smaller)))))
  helper)

(paint ((split beside below) mark-of-zorro 2))
(paint ((split below beside) mark-of-zorro 2))

(define (make-vect x y)
  (cons x y))

(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cdr vect))

(define (add-vect vect1 vect2)
  (make-vect (+ (xcor-vect vect1) (xcor-vect vect2))
             (+ (ycor-vect vect1) (ycor-vect vect2))))

(define (sub-vect vect1 vect2)
  (make-vect (- (xcor-vect vect1) (xcor-vect vect2))
             (- (ycor-vect vect1) (ycor-vect vect2))))

(define (scale-vect s vect)
  (make-vect (* s (xcor-vect vect))
             (* s (ycor-vect vect))))

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v) (edge1-frame frame))
               (scale-vect (ycor-vect v) (edge2-frame frame))))))
(define (segements->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame)
         (start-segment segment))
        ((frame-coord-map frame)
         (end-segment segment))))
     segment-list)))

(define (make-segment start-vect end-vect)
  (cons start-vect end-vect))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define outline
  (segments->painter
   (list (make-segment (make-vect 0 0) (make-vect 1 0))
         (make-segment (make-vect 1 0) (make-vect 1 1))
         (make-segment (make-vect 1 1) (make-vect 0 1))
         (make-segment (make-vect 0 1) (make-vect 0 0)))))

(define X
  (segments->painter
   (list (make-segment (make-vect 0 0) (make-vect 1 1))
         (make-segment (make-vect 0 1) (make-vect 1 0)))))

(define diamond
  (segments->painter
   (list (make-segment (make-vect 0 0.5) (make-vect 0.5 1))
         (make-segment (make-vect 0.5 1) (make-vect 1 0.5))
         (make-segment (make-vect 1 0.5) (make-vect 0.5 0))
         (make-segment (make-vect 0.5 0) (make-vect 0 0.5)))))

(define wave
  (segments->painter
    (list
      (make-segment (make-vect 0.354 1.000) (make-vect 0.284 0.876))
      (make-segment (make-vect 0.284 0.876) (make-vect 0.367 0.700))
      (make-segment (make-vect 0.367 0.700) (make-vect 0.279 0.700))
      (make-segment (make-vect 0.279 0.700) (make-vect 0.114 0.654))
      (make-segment (make-vect 0.114 0.654) (make-vect 0.000 0.828))
      (make-segment (make-vect 0.000 0.705) (make-vect 0.118 0.520))
      (make-segment (make-vect 0.118 0.520) (make-vect 0.273 0.627))
      (make-segment (make-vect 0.273 0.627) (make-vect 0.325 0.575))
      (make-segment (make-vect 0.325 0.575) (make-vect 0.232 0.000))
      (make-segment (make-vect 0.388 0.000) (make-vect 0.453 0.336))
      (make-segment (make-vect 0.453 0.336) (make-vect 0.576 0.000))
      (make-segment (make-vect 0.710 0.000) (make-vect 0.533 0.461))
      (make-segment (make-vect 0.533 0.461) (make-vect 1.000 0.260))
      (make-segment (make-vect 1.000 0.393) (make-vect 0.611 0.695))
      (make-segment (make-vect 0.611 0.695) (make-vect 0.535 0.695))
      (make-segment (make-vect 0.535 0.695) (make-vect 0.586 0.875))
      (make-segment (make-vect 0.586 0.875) (make-vect 0.507 1.000)))))

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter (make-frame
                  new-origin
                  (sub-vect (m corner1) new-origin)
                  (sub-vect (m corner2) new-origin)))))))

(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0 1)
                     (make-vect 1 1)
                     (make-vect 0 0)))


(define (shrink-to-upper-right painter)
  (transform-painter painter
                     (make-vect 0.5 0.5)
                     (make-vect 1 0.5)
                     (make-vect 0.5 1)))

(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1 0)
                     (make-vect 0 0)
                     (make-vect 1 1)))

(define (rotate180 painter)
  (transform-painter painter
                     (make-vect 1 1)
                     (make-vect 0 1)
                     (make-vect 1 0)))

(define (rotate270 painter)
  (transform-painter painter
                     (make-vect 0 1)
                     (make-vect 0 0)
                     (make-vect 1 1)))

(define (below painter1 painter2)
  (let ((split-point (make-vect 0 0.5)))
    (let ((paint-below
           (transform-painter painter1
                              (make-vect 0 0)
                              (make-vect 1 0)
                              split-point))
          (paint-up
           (transform-painter painter2
                              split-point
                              (make-vect 1 0.5)
                              (make-vect 0 1))))
      (lambda (frame)
        (paint-below frame)
        (paint-up frame)))))

(define (below-2 painter1 painter2)
  (rotate90 (beside (rotate270 painter1) (rotate270 painter2))))

