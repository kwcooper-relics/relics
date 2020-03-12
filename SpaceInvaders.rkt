;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname SpaceInvaders) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Space invaders

;; A World is (make-world Player Shots Aliens)

;; An Aliens is a ListofPosn
;; A Shots is a ListofPosn
;; A Player is a Number
;; (interp: X coordinate)

;; A ListOfPosn is one of:
;; - empty
;; - (cons (make-Posn Number Number) ListOfPosn) -- inline, so the template is inline
(define-struct world (player shots aliens))
(define WIDTH 600)
(define HEIGHT 400)

;; render : World -> Image
;; draw the world onto a 600x400 scene
(define (render world)
  (render-player (world-player world)
                 (render-shots (world-shots world)
                               (render-aliens (world-aliens world)
                                              (empty-scene WIDTH HEIGHT)))))
;; render-player : Player Image -> Image
;; draw the player at the specified X coord on the given image
(define (render-player n scn)
  (place-image player-img n (- HEIGHT 5)
               scn))

;; render-shots : Shots Image -> Image
;; draw all the shots on the given image
(define (render-shots ss scn)
  (cond [(empty? ss) scn]
        [else (place-image shot-img
                           (posn-x (first ss))
                           (posn-y (first ss))
                           (render-shots (rest ss) scn))]))

;; render-aliens : Aliens Image -> Image
;; draw all the aliens on the given image
(define (render-aliens ss scn)
  (cond [(empty? ss) scn]
        [else (place-image alien-img
                           (posn-x (first ss))
                           (posn-y (first ss))
                           (render-aliens (rest ss) scn))]))

;; tick : World -> World
;; move all the aliens down, the shots up, maybe add an alien, and remove any collisions 
(define (tick w)
  (make-world (world-player w)
              (tick-shots (remove-shots (world-shots w) (world-aliens w)))
              (add-alien (tick-aliens (remove-aliens (world-aliens w) (world-shots w))))))

;; remove-shots : Shots Aliens -> Shots
;; remove any shots in the given list close to any of the aliens in the given list
(define (remove-shots ss as)
  (cond [(empty? ss) ss]
        [else (cond [(near-any? (first ss) as) (remove-shots (rest ss) as)]
                    [else (cons (first ss)     (remove-shots (rest ss) as))])]))

;; remove-aliens : Aliens Shots -> Aliens
;; remove any aliens in the given list close to any of the shots in the given list
(define (remove-aliens as ss)
  (cond [(empty? as) as]
        [else (cond [(near-any? (first as) ss) (remove-shots (rest as) ss)]
                    [else (cons (first as)     (remove-shots (rest as) ss))])]))

;; near-any? : Posn ListOfPosn -> Boolean
;; is the given posn close to any posn in the given list of posns?
(define (near-any? p lop)
  (cond [(empty? lop) false]
        [else (or (near? p (first lop))
                  (near-any? p (rest lop)))]))

;; near? Posn Posn -> Boolean
;; are the two given posns close together?
(define (near? p p2)
  (< (dist p p2) 15))

;; dist : Posn Posn -> Number
;; compute the distance between the given posns
(define (dist p p2)
  (sqrt (+ (sqr (- (posn-x p) (posn-x p2)))
           (sqr (- (posn-y p) (posn-y p2))))))

;; add-alien : Aliens -> Aliens
;; adds one alien, given a random choice
(define (add-alien as)
  (cond [(< (random 40) 1)
         (cons (make-posn (random WIDTH) 0) as)]
        [else as]))

;; tick-shots : Shots -> Shots
;; move all the shots up the screen
(define (tick-shots ss)
  (cond [(empty? ss) empty]
        [else (cons
               (make-posn (posn-x (first ss))
                          (- (posn-y (first ss)) 5))
               (tick-shots (rest ss)))]))

;; tick-aliens : Aliens -> Aliens
;; move all the aliens down the screen
(define (tick-aliens ss)
  (cond [(empty? ss) empty]
        [else (cons
               (make-posn (posn-x (first ss))
                          (add1 (posn-y (first ss))))
               (tick-aliens (rest ss)))]))

;; key : World KeyEvent -> World
;; move the player in response to left and right, shoot on space
(define (key world ke)
  (cond [(key=? ke " ") (add-shot world)]
        [(key=? ke "left") (move-player world -5)]
        [(key=? ke "right") (move-player world +5)]
        [else world]))

;; add-shot : World -> World
;; Add a new shot at the x coord of the player
(define (add-shot w)
  (make-world (world-player w)
              (cons (make-posn (world-player w)
                               (- HEIGHT 10))
                    (world-shots w))
              (world-aliens w)))

;; move-player : World Number -> World
;; move the player left or right the given amount
(define (move-player w dist)
  (make-world (+ dist (world-player w))
              (world-shots w)
              (world-aliens w)))

;; alien-on-ground : World -> Boolean
;; Are any of the aliens in the given world close to the ground?
(define (alien-on-ground w)
  (alien-on-ground-helper (world-aliens w)))

;; alien-on-ground-helper : Aliens -> Boolean
;; Are any of the given aliens close to the ground?
(define (alien-on-ground-helper as)
  (cond [(empty? as) false]
        [else (or (> (posn-y (first as)) 395)
                  (alien-on-ground-helper (rest as)))]))

;; you-lose : World -> Image
;; draw the world and say that the player lost
(define (you-lose w)
  (overlay (text "Maybe try again?" 40 "black")
           (render w)))

(require 2htdp/image)
(require 2htdp/universe)

(define alien-img (circle 10 "solid" "green"))
(define shot-img (circle 5 "solid" "red"))
(define player-img (square 20 "outline" "blue"))

(big-bang (make-world (/ WIDTH 2) empty empty)
          [on-tick tick 1/20]
          [to-draw render]
          [on-key key]
          [stop-when alien-on-ground you-lose])