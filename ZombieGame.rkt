(require 2htdp/image)
(require 2htdp/universe)

(define background (empty-scene 400 400))

;; Exercise 1
;  Create structure and data definitions for a world state
;  which holds the coordinates of a player and the mouse
;  coordinates.
 
(define-struct world (playerPosn mousePosn))
(define myWorld (make-world (make-posn 200 200) (make-posn 0 0)))

;; Exercise 2
;  Design a function which accepts the world state structure, and an
;  image, and draws the player at the specified coordinates. The player
;  should be drawn as a green circle.

;  Design a to-draw handler which uses the player-draw function to draw
;  the player onto the background image. Test your drawing code in
;  big-bang by creating a world state with different player coordinates.

(define player (circle 10 "solid" "green"))

(define (player-draw world-state player-img)
  (place-image player-img
               (posn-x (world-playerPosn world-state))
               (posn-y (world-playerPosn world-state))
               background))

(check-expect (player-draw myWorld player)
              (place-image (circle 10 "solid" "green")
                           200 200
                           (empty-scene 400 400)))

(define (draw-handler world-state)
    (player-draw world-state player))

(check-expect (draw-handler myWorld)
              (place-image (circle 10 "solid" "green")
                           200 200
                           (empty-scene 400 400)))

;; Exercise 3
;  Design an on-mouse event handler which accepts the world state and
;  updates the mouse coordinates in the world state. You should look
;  up the big-bang documentation for how to write a mouse event handler.
;  Hook up your on-mouse function to big-bang and verify that it works.

; my-on-mouse : WorldState Integer Integer MouseEvent -> EventHandler

(define (my-on-mouse world-state mPosX mPosY mouseEvent)
  (cond
    [(string=? "move" mouseEvent) (make-world
                                   (world-playerPosn world-state)
                                   (make-posn mPosX mPosY))]
    [else world-state]))

(check-expect (my-on-mouse myWorld 50 50 "move")
              (make-world (make-posn 200 200)
                          (make-posn 50 50)))
(check-expect (my-on-mouse myWorld 50 50 "drag")
              (make-world (make-posn 200 200)
                          (make-posn 0 0)))



;; Exercise 4
;  Design a player-move function which accepts a world state and
;  returns a new world state. This function should move the player
;  towards the mouse coordinates. You may have to experiment how big of
;  a step the player sould make in the x and y directions towards the
;  mouse location, try first with 1 pixel per tick.

(define (player-move world)
  (cond
    [(empty? world) empty]
    [else
     (make-world
      (make-posn
       (cond
         [(< (posn-x (world-mousePosn world)) (posn-x (world-playerPosn world)))
          (- (posn-x (world-playerPosn world)) 2)]
         [(> (posn-x (world-mousePosn world)) (posn-x (world-playerPosn world)))
          (+ (posn-x (world-playerPosn world)) 2)]
         [else (posn-x (world-playerPosn world))])
       (cond
         [(< (posn-y (world-mousePosn world)) (posn-y(world-playerPosn world)))
          (- (posn-y (world-playerPosn world)) 2)]
         [(> (posn-y (world-mousePosn world)) (posn-y (world-playerPosn world)))
          (+ (posn-y (world-playerPosn world)) 2)]
         [else (posn-y (world-playerPosn world))]))
      (world-mousePosn world))]))

;; Exercise 5

; Zombie is one of:
; - null,
; - (cons zombie-posn zombie))

(define-struct set-of-zombies (zombPos rest-of-zombies))

;; Exercise 6

(define (generate-zombies n)
  (cond
    [(< n 1) null]
    [(>= n 1) (cons (make-posn (random 400) (random 400))
                    (generate-zombies (- n 1)))]))

;; Exercise 7

(define-struct newWorld (playerPosn mousePosn zomPosn))

;; Exercise 8

(define zombieImage (circle 10 "solid" "red"))

(define (place-zombies set image)
  (cond
    [(empty? set) background]
    [(cons? set) (place-image image
                              (posn-x (first set))
                              (posn-y (first set))
                              (place-zombies (rest set) image))]))

;; Exercise 9

(define (my-draw2 ws)
  (cond
    [(empty? ws) background]
    [else (player-draw ws (place-zombies ws background))]))

;; Exercise 10

(define (move-zombies z pos)
  (cond
    [(empty? z) empty]
    [else
     (cons
      (make-posn
       (cond
         [(< (posn-x (first z)) (posn-x pos)) (+ (posn-x (first z)) 1)]
         [(> (posn-x (first z)) (posn-x pos)) (- (posn-x (first z)) 1)]
         [else (posn-x (first z))])
       (cond
         [(< (posn-y (first z)) (posn-y pos)) (+ (posn-y (first z)) 1)]
         [(> (posn-y (first z)) (posn-y pos)) (- (posn-y (first z)) 1)]
         [else (posn-y (first z))]))
      (move-zombies (rest z) pos))]))

;; Exercise 11

(define (new-both-move world)
  (cond
    [(empty? world) empty]
    [else
     (make-newWorld
      (make-posn
       (cond
         [(< (posn-x (world-mousePosn world)) (posn-x (world-playerPosn world)))
          (- (posn-x (world-playerPosn world)) 2)]
         [(> (posn-x (world-mousePosn world)) (posn-x (world-playerPosn world)))
          (+ (posn-x (world-playerPosn world)) 2)]
         [else (posn-x (world-playerPosn world))])
       (cond
         [(< (posn-y (world-mousePosn world)) (posn-y(world-playerPosn world)))
          (- (posn-y (world-playerPosn world)) 2)]
         [(> (posn-y (world-mousePosn world)) (posn-y (world-playerPosn world)))
          (+ (posn-y (world-playerPosn world)) 2)]
         [else (posn-y (world-playerPosn world))]))
      (world-mousePosn world)
      (move-zombies (newWorld-zomPosn world) (newWorld-playerPosn world)))]))

;(define (touching-zombies ws)
;  (cond
;    [(empty? ws) empty]
;    [else
;     (if
;      (and (< (abs (- (posn-x (first (newWorld-zomPosn ws)))
;                     (posn-x (newWorld-playerPosn ws)))) TOUCH_DISTANCE)
;           (< (abs (- (posn-y (first (newWorld-zomPosn ws)))
;                      (posn-y (newWorld-playPosn ws)))) TOUCH_DISTANCE))
;      #true

(big-bang myWorld
          [to-draw draw-handler]
          [on-mouse my-on-mouse]
          [on-tick player-move])

; ---------------------------------------------------------------------

; Zombie is a Posn
; Zombies is a list of positions

; A function which moves each item in a list of zombies toward a point
; Signatures:
; Args:
;     Z:list-of-zombies, a set of zombies to be moved
;     pos:posn, the position to move the zombies toward
; Returns: list-of-zombies


;
;(check-expect (move-zombies (list (make-posn 0 0)) (make-posn 5 20))
;              (list (make-posn 1 1)))
;(check-expect (move-zombies (list (make-posn 0 0)) (make-posn -12 20))
;              (list (make-posn -1 1)))
;(check-expect (move-zombies (list (make-posn 0 0)) (make-posn -5 20))
;              (list (make-posn 1 1)))
;(check-expect (move-zombies (list (make-posn 0 0)) (make-posn 5 20))
;              (list (make-posn 1 -1)))