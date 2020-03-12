;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname snakeL7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require  2htdp/image)
; A World is:
; -- (make-world Snake Food)
(define-struct world (snake food))
 
; A Snake is:
; -- (make-snake Direction Head Body)
(define-struct snake (direction head body))
 
; A Direction is one of:
; -- "north"
; -- "east"
; -- "south"
; -- "west"
 
; A Food is [Listof Posn]
 
; A Head is a Posn
 
; A Body is [Listof Posn]

;(define s1 (make-snake "North" (200,200) empty))

;(define f1 (list (300,300) (151,327)))

 
 
(define (w1 open)
  (underlay/xy (rectangle 100 100 "solid" "white") 50 open snakie))
 
(define snakie
  (underlay/align "center"
                  "center"
                  (circle 10 "outline" "red")
                  (circle 4 "solid" "green")))
 
;(animate w1)

(define (times2 n)
  (* 2 n))

(define l1 (list 1 2 3 4 5 6 7 8))

(map times2 l1)

(define (ballMakr n)
  (circle n "solid" "red"))

(map ballMakr l1)

(map ballMakr (map times2 l1))

(define (ballBeside lob)
  (cond [(empty? lob) (head lob)]
  [(cons? lob)(beside (first lob) (ballBeside (rest lob)))]))

(define (head loc)
(underlay (circle (+ 15 (length loc)) "solid" "green")
          (above (circle (+ 3 (length loc)) "solid" "black") (circle (+ 3 (length loc)) "solid" "black"))
  ))

(ballBeside (map ballMakr l1))
(define snake1 (ballBeside (map ballMakr l1)))

(define (snakeEat lon)
(append lon (+ 1 (last lon)))
  )







