
;; A ball is a structure: (make-ball Posn Number Number)
(define-struct ball  [ballposn xvel yvel])
;; A table is a structure: (make-table Number Posn)
(define-struct table [radius center])

;; distance  : Table Ball -> Number
;  purpose   : computes the distance formula to find distance
;  between the center and the ball

(check-expect (distance (make-table 20 (make-posn 2 2))
                        (make-ball (make-posn 2 2) 0 0)) 0)

(define (distance table ball)
  (sqrt (+ (sqr (- (posn-y (ball-ballposn ball))
                   (posn-y (table-center table))))
           (sqr (- (posn-x (ball-ballposn ball))
                   (posn-x (table-center table)))))))
              
;; on-table? : Ball Table -> Boolean
;  purpose   : evaluates whether the given ball is on the table

(check-expect (on-table? (make-table 20 (make-posn 10 10))
                         (make-ball (make-posn 15 15) 0 0)) #true)

(check-expect (on-table? (make-table 20 (make-posn 10 10))
                         (make-ball (make-posn 30 30) 0 0)) #false)

(define (on-table? table ball)
  (<= (distance table ball) (table-radius table)))

;; move-ball : Ball -> Ball
;  purpose: accepts a ball, moving the ball by adding the x/y
;  velocity and creating a new ball using these updated fields

(check-expect (move-ball (make-ball (make-posn 30 30) 5 5))
              (make-ball (make-posn 35 35) 5 5))

(check-expect (move-ball (make-ball (make-posn 22 23) 5 5))
              (make-ball (make-posn 27 28) 5 5))

(define (move-ball ball)
  (make-ball
   (make-posn
    (+ (posn-x (ball-ballposn ball)) (ball-xvel ball))
    (+ (posn-y (ball-ballposn ball)) (ball-yvel ball)))
   (ball-xvel ball)
   (ball-yvel ball)))

;; how-long : Ball Table -> Number
;  purpose  : evaluates how many steps are needed to move
;  the given ball off of the given table

(check-expect (how-long (make-ball (make-posn 20 20) 20 20)
                        (make-table 40 (make-posn 20 20))) 2)
(check-expect (how-long (make-ball (make-posn 50 50) 20 20)
                        (make-table 10 (make-posn 20 20))) 0)

(define (how-long ball table)
  (cond
    [(not (on-table? table ball)) 0]
    [else (+ 1 (how-long (move-ball ball) table))]))

;; make-grid : List -> List
;  purpose   : accepts a List, returning a list of list of numbers
;  if the given list is a perfect square; if not, returns the list

(check-expect (make-grid (list 17)) (list (list 17)))
(check-expect (make-grid (list 1 2 3 4 5 6 7 8 9))
              (list (list 1 2 3)
                    (list 4 5 6)
                    (list 7 8 9)))
(check-expect (make-grid (list 1 2 3 4 5 6))
              (list 1 2 3 4 5 6))

(define (make-grid list)
  (cond
    [(or (= (length list) 0)
         (equal? (integer? (sqrt (length list))) #false)) list]
    [else (list->chunks list (sqrt (length list)))]))