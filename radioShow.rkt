;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname radioShow) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;; rec-fcn: ListOfX -> Y
;;; produce a value of the type Y from the given list of X
;(define (rec-fcn alox)
;  (rec-fcn-acc alox initial-acc-value))
; 
;;; rec-fcn-acc: ListOfX Y -> Y
;;; recur with updated accumulator, unless the end of list is reached
;(define (rec-fcn-acc alox acc)
;  (cond
;    ;; at the end produce the accumulated value
;    [(empty? alox) acc]
; 
;    ;; otherwise invoke rec-fcn-acc with updated accumulator and the rest of the list
;    [(cons? alox)  (rec-fcn-acc (rest alox)
;                                (update (first alox) acc))]))



;; Data definitions
 
;; Radio Show  (RS) is a (make-rs String Number ListOfAd)
(define-struct rs (name minutes ads))
 
;; Ad is a (make-ad String Number Number)
(define-struct ad (name minutes profit))
 
;; a ListfAd is either
;; empty, or
;; (cons Ad ListOfAd)
 
;; Examples of data:
 
(define ipod-ad (make-ad "ipod" 2 100))
(define ms-ad (make-ad "ms" 1 500))
(define xbox-ad (make-ad "xbox" 2 300))
 
(define news-ads (list ipod-ad ms-ad ipod-ad xbox-ad))
(define game-ads (list ipod-ad ms-ad ipod-ad ms-ad xbox-ad ipod-ad))
(define bad-ads (list ipod-ad ms-ad ms-ad ipod-ad xbox-ad ipod-ad))
 
(define news (make-rs "news" 60 news-ads))
(define game (make-rs "game" 120 game-ads))
 
 
 
;; compute the total time for all ads in the given list
;; total-time: ListOfAd -> Number
(define (total-time adlist)
  (cond
    [(empty? adlist) 0]
    [(cons? adlist) (+ (ad-minutes (first adlist))
                       (total-time (rest adlist)))]))
 
(check-expect (total-time news-ads) 7)
(check-expect (total-time game-ads) 10)


;ex 1
; total-time-acc : [List-of Ad] Number -> Number
;  calculates the total time 
(define (total-time-acc list acc)
  (cond
    [(empty? list) acc]
    [else (+ (total-time-acc (rest list)
                             (ad-minutes (first list))) acc)]))

(check-expect (total-time-acc news-ads 0) 7)
(check-expect (total-time-acc game-ads 0) 10)

; ex. 2
; total-ad-profit : [List-of Ad] Number -> Number
;  calculates the total profit from all ads in the list
(define (total-ad-profit list acc)
  (cond
    [(empty? list) acc]
    [else (+ (total-ad-profit (rest list)
                              (ad-profit (first list))) acc)]))

(check-expect (total-ad-profit news-ads 0) 1000)
(check-expect (total-ad-profit game-ads 0) 1600)

;ex. 3
; no-repeat/a : [List-of Ad] Ad -> Boolean
;  insures that a given list of ads does not repeat
(define (no-repeat/a list a)
  (cond
    [(empty? list) #true]
    [else (if (equal? (first list) a)
              #false
              (no-repeat/a (rest list) (first list)))]))

(check-expect (no-repeat/a bad-ads empty) #false)
(check-expect (no-repeat/a news-ads empty) #true)
























