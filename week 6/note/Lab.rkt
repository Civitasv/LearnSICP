#lang simply-scheme

((lambda (f n) ; this lambda is defining MAP
   ((lambda (map) (map map f n))
    (lambda (map f n)
      (if (null? n)
          '()
          (cons (f (car n)) (map map f (cdr n))) )) ))
 first ; here are the arguments to MAP
 '(the rain in spain))
