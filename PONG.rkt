;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname PONG) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;Ball is a struct:
;(make-ball Posn velocity)
(define-struct ball (posn velocity))

;Paddles is a struct:
;(make-paddles left-y right-y)
(define-struct paddles (left-y right-y))

;(Ball) Velocity is a struct:
;(make-vel dx dy)
(define-struct velocity (dx dy))

;Afterscore is a struct:
;(make-afterscore num Boolean)
;Shows score and replaces ball until timer reaches 0.
(define-struct afterscore (timer left))

;A Game is a structure:
;(make-game Ball Paddles num num)
(define-struct game (ball paddles l-score r-score))

;env varibles
(define WIDTH_FIELD 800)
(define HEIGHT_FIELD 600)
(define PADDLE-V 20)
(define LEFT-PADDLE-X 70)
(define RIGHT-PADDLE-X (- WIDTH_FIELD LEFT-PADDLE-X))
(define PADDLE-WIDTH 10)
(define PADDLE-HEIGHT 80)
(define BALL-RADIUS 5)
(define LEFT -1)
(define RIGHT 1)
(define TIMER-VALUE 60)

(define PADDLE (rectangle 5 80 "solid" "white"))
(define BALL (circle 3 "solid" "white"))
(define FIELD (rectangle WIDTH_FIELD HEIGHT_FIELD "solid" "Green"))

(define INITIAL-PADDLES (make-paddles 100 500))
(define INITIAL-BALL (make-ball (make-posn (/ WIDTH_FIELD 2) (/ HEIGHT_FIELD 2)) (make-velocity 6 2)))
(define INITIAL (make-game INITIAL-BALL INITIAL-PADDLES 0 0))

(define (render-game g)
  (render-objects g))

(define (render-objects s)
  (cond
       [(afterscore? (game-ball s))
        (cond
          [(equal? (process-afterscore (game-ball s)) (random-ball (afterscore-left (game-ball s))))
           (place-image PADDLE
               LEFT-PADDLE-X 
               (paddles-left-y
               (game-paddles s))
               (place-image PADDLE
                            RIGHT-PADDLE-X 
                            (paddles-right-y
                            (game-paddles s))
                            (place-image BALL
                                         (posn-x (ball-posn (update-posn (detect-collision (random-ball (game-ball s))))))
                                         (posn-y (ball-posn (update-posn (detect-collision (random-ball (game-ball s))))))
                                         
                                         
                            FIELD)))]
          [else (overlay/align "middle" "top"
                               (text (string-append (number->string (game-l-score s)) ":" (number->string (game-r-score s))) 50 "white")
                               (place-image PADDLE
                                            LEFT-PADDLE-X 
                                            (paddles-left-y
                                             (game-paddles s))
                                            (place-image PADDLE
                                                         RIGHT-PADDLE-X 
                                                         (paddles-right-y
                                                          (game-paddles s))           
                                                         FIELD)))])]
        
        [else 
         (place-image PADDLE
               LEFT-PADDLE-X 
               (paddles-left-y
               (game-paddles s))
               (place-image PADDLE
                            RIGHT-PADDLE-X 
                            (paddles-right-y
                            (game-paddles s))
                            (place-image BALL
                                         (posn-x (ball-posn (update-posn (detect-collision (game-ball s) (game-paddles s)))))
                                         (posn-y (ball-posn (update-posn (detect-collision (game-ball s) (game-paddles s)))))
                                         
                                         
                            FIELD)))]))

(define (translate p v)
  (make-posn (+ (posn-x p) (velocity-dx v)) (+ (posn-y p) (velocity-dy v))))

(define (update-posn b)
  (make-ball (translate (ball-posn b) (ball-velocity b)) (ball-velocity b)))

(define (off-top b)
  (and (< (velocity-dy (ball-velocity b)) 0) (<= (posn-y (ball-posn b)) BALL-RADIUS)))

(define (off-bottom b)
  (and (> (velocity-dy (ball-velocity b)) 0) (>= (posn-y (ball-posn b)) (- HEIGHT_FIELD BALL-RADIUS))))

(define (ex n)
  (cond
    [(< n 0) -1]
    [(> n 0) 1]
    [else 0]))

(define (within-vertical-range by py)
  (<= (abs (- by py))
      (+ BALL-RADIUS (/ PADDLE-HEIGHT 2))))

(define (within-horizontal-range bx px)
  (<= (abs (- bx px))
      (+ BALL-RADIUS (/ PADDLE-WIDTH 2))))
 
(define (collide-paddle b px py dir)
  (and (= (ex (velocity-dx (ball-velocity b))) dir)
       (within-vertical-range (posn-y (ball-posn b)) py)
       (within-horizontal-range (posn-x (ball-posn b)) px)))

(define (detect-collision b p)
  (cond
    [(or (off-top b) (off-bottom b))
     (make-ball (ball-posn b) (make-velocity (velocity-dx (ball-velocity b))
                                     (- (velocity-dy (ball-velocity b)))))]
    [(or (collide-paddle b LEFT-PADDLE-X (paddles-left-y p) LEFT)
         (collide-paddle b RIGHT-PADDLE-X (paddles-right-y p) RIGHT))
     (make-ball (ball-posn b) (make-velocity (- (velocity-dx (ball-velocity b))) (velocity-dy (ball-velocity b))))]
    [else b]))

(define (random-ball left)
  (make-ball
   (make-posn (if left 0 WIDTH_FIELD) (random HEIGHT_FIELD))
   (make-velocity (if left 7 -7) (- (random 7) 3))))

(define (process-afterscore b)
  (if (> (afterscore-timer b) 0)
      (make-afterscore (- (afterscore-timer b) 1) (afterscore-left b))
      (random-ball (afterscore-left b))))

(define (left-scored? b)
  (and (ball? b)
       (>= (posn-x (ball-posn b)) WIDTH_FIELD)
       (> (velocity-dx (ball-velocity b)) 0)))

(define (right-scored? b)
  (and (ball? b)
       (< (posn-x (ball-posn b)) 0)
       (< (velocity-dx (ball-velocity b)) 0)))

(define (update g)
  (cond
    [(left-scored? (game-ball g))
     (make-game (make-afterscore TIMER-VALUE true)
                (game-paddles g)
                (add1 (game-l-score g))
                (game-r-score g))]
    [(right-scored? (game-ball g))
     (make-game (make-afterscore TIMER-VALUE false)
                (game-paddles g)
                (game-l-score g)
                (add1 (game-r-score g)))]
    [else (make-game (if (afterscore? (game-ball g))
                         (process-afterscore (game-ball g))
                         (update-posn (detect-collision (game-ball g) (game-paddles g))))
                     (game-paddles g)
                     (game-l-score g) (game-r-score g))]))
    

(define (restraints y)
  (cond
    [(< y 0) 0]
    [(>= y HEIGHT_FIELD) (sub1 HEIGHT_FIELD)]
    [else y]))

(define (move-left s pd)
  (make-paddles (restraints (+ (paddles-left-y s) pd))
                (paddles-right-y s)))


(define (move-right s pd)
  (make-paddles (paddles-left-y s)
                (restraints (+ (paddles-right-y s) pd))))
  
(define (move-paddles s cmd)
  (cond
    [(key=? cmd "w") (move-left s (- PADDLE-V))]
    [(key=? cmd "s") (move-left s PADDLE-V)]
    [(key=? cmd "up") (move-right s (- PADDLE-V))]
    [(key=? cmd "down") (move-right s PADDLE-V)]
    [else s]))

(define (control-game g cmd)
  (make-game (game-ball g) (move-paddles (game-paddles g) cmd) (game-l-score g) (game-r-score g)))

(big-bang INITIAL
          (on-tick update)
          (on-key control-game)
          (to-draw render-game))