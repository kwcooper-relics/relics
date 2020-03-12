;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname AstroDraw) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 1
;; quadrants : Number String String String String -> Image
;; Consumes a given width and four colors, then creates an image
;; of four objects with given width and colors

(define (quadrants width col1 col2 col3 col4)
  (above (beside (circle (/ width 2) "solid" col1)
                 (square width "solid" col2))
         (beside (ellipse width (/ width 2) "solid" col3)
                 (triangle width "solid" col4))))

(check-expect (quadrants 30 "red" "blue" "green" "purple")
              (above (beside (circle (/ 30 2) "solid" "red")
                             (square 30 "solid" "blue"))
                     (beside (ellipse 30 (/ 30 2) "solid" "green")
                             (triangle 30 "solid" "purple"))))

;; Exercise 2
;; Define a structure named sun which stores a sun

(define-struct sun ())
(define theSun (make-sun))

;; Exercise 3
;; Defines a structure named planet, which stores a distance (to
;; the center of the solar system) and the next innermost planet
;; (make-planet distance inner-planet)

(define-struct planet (dist inner-planet))
(define planet1 (make-planet 10 theSun))
(define planet2 (make-planet 20 planet1))
(define planet3 (make-planet 30 planet2))

;; Exercise 4
;; Defines a data definition solar-object, which is the union of a
;; planet and a sun.

; A solar-object is one of...
;   - Planet,
;   - Sun
; solar-object : Planet | Sun

;; Exercise 5

; (define (process-sun sun)
;   (sun-dist sun) ...)
;
; (define (process-planet planet)
;   (... (planet-dist planet) ... (planet-inner-planet planet)))
;
; (define (process-solar-object sol-obj)
;   (cond
;     [(planet? sol-obj)
;      ... (planet-dist sol-obj) ... (planet-inner-planet sol-obj)]
;     [(sun? solar-object)
;      ... (sun-dist solar-object) ...]))

;; Exercise 6

;; distance-to-center : solar-object -> Number
;; Consumes a given solar-object and calculates the distance
;; of the solar-object to the center of the solar system, which
;; in this case is represented by the Sun.

(define (distance-to-center solar-object)
  (cond
    [(sun? solar-object) 0]
    [(planet? solar-object) (+ (planet-dist solar-object)
                               (distance-to-center
                                (planet-inner-planet solar-object)))]))

(check-expect (distance-to-center theSun) 0)
(check-expect (distance-to-center planet2) 30)

;; Exercise 7
;; make-sol-obj : Number, sol-obj -> sol-obj
;; Consumes a given number and a solar-object and creates a new
;; solar-object, with the given number plus the given solar-object's
;; distance as the distance for the new solar-object, and then
;; the given solar-object as the inner-planet of the new object

(define (make-sol-obj distance sol-obj)
  (cond
    [(sun? sol-obj) (make-planet distance sol-obj)]
    [(planet? sol-obj) (make-planet
                        (+ distance (planet-dist sol-obj)) sol-obj)]))

(check-expect (make-sol-obj 30 planet2)
              (make-planet (+ 30 (planet-dist planet2)) planet2))

(check-expect (make-sol-obj 20 theSun)
              (make-planet 20 theSun))
                                  
;; Exercise 8
;; String -> Image
;; Consumes a given color, in the form of a string, and draws a circle
;; of size 20 of that color

(define (draw-sun color)
  (circle 20 "solid" color))

(check-expect (draw-sun "yellow") (circle 20 "solid" "yellow"))

;; Exercise 9
;; sol-obj -> Image
;; Accepts a given solar object, and draws a number of black circle
;; outlines depending on the amount of planets before the center of the
;; solar system is reached; at the center, a sun of size 20 is drawn

(define (draw-sol-obj obj)
  (cond
    [(sun? obj) (draw-sun "yellow")]
    [(planet? obj) (overlay
                    (circle (planet-dist obj) "outline" "black")
                    (draw-sol-obj (planet-inner-planet obj)))]))

(check-expect (draw-sol-obj planet1)
              (overlay (circle 10 "outline" "black")
                       (draw-sun "yellow")))

(draw-sol-obj planet1)