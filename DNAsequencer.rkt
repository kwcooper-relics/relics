;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname DNAsequencer) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; (HELPER) num-sequence : [List-of 1Strings] String -> Number
;  evaluates how many times a letter appears in sequence

(check-expect (num-sequence empty "C") 0)
(check-expect (num-sequence (list "C" "C" "G" "A" "T") "C") 2)
              
(define (num-sequence list str)
  (cond
    [(or (empty? list) (not (string=? (first list) str))) 0]
    [(string=? (first list) str) (+ 1 (num-sequence (rest list) str))]))

;; rle-encode : String -> String
;  accepts a string of DNA characters (A, C, G, or T)
;  and counts the instances, returning a condensed version

(check-expect (rle-encode "") "")
(check-expect (rle-encode "AAGCCCTTAAAAAAAAAA") "A2G1C3T2A10")

(define (rle-encode str)
  (cond
    [(string=? "" str) str]
    [else
     (let* ([current-letter (first (explode str))]
            [current-total (num-sequence (explode str) current-letter)]
            [rest (substring str current-total (string-length str))])
       (string-append (string-append
                       current-letter (number->string current-total))
                      (rle-encode rest)))]))
       
;; (HELPER) next-number : [List-of 1String] -> String
;  evaluates whether the first of the list is a number,
;  and if so, appends that number and recurses back to
;  evaluate the second; once a letter is found, returns
;  any previously appended number values into one string

(check-expect (next-number empty) "")
(check-expect (next-number (list "A" "2" "3")) "")
(check-expect (next-number (list "2" "3" "A")) "23")

(define (next-number strlist)
  (cond
    [(or (empty? strlist)
         (not (number? (string->number (first strlist))))) ""]
    [else (string-append (first strlist)
                         (next-number (rest strlist)))]))

;; (HELPER) next-substring : [List-of 1String] -> Number
;  determines how much of the current string will need to be
;  dropped for the next recursive call by counting how many numbers
;  exist beyond the first letter; at the end, adds one to represent
;  the space of the previous letter

(check-expect (next-substring empty) 1)
(check-expect (next-substring (list "1" "0" "B")) 3)
(check-expect (next-substring (list "1" "0" "2" "B" "2")) 4)

(define (next-substring strlist)
  (cond
    [(empty? strlist) 1]
    [(not (number? (string->number (first strlist)))) 1]
    [else (+ 1 (next-substring (rest strlist)))]))

;; rle-decode : String -> String
;  accepts a run-lengtn encoding, expanding it according to
;  the letter and number combination given

(check-expect (rle-decode "") "")
(check-expect (rle-decode "A1G1C3T2A2") "AGCCCTTAA")
(check-expect (rle-decode "A2G1C3T2A10") "AAGCCCTTAAAAAAAAAA")

(define (rle-decode str)
  (cond
    [(string=? "" str) str]
    [else
     (let ([rest-string (rest (explode str))])
       (string-append (replicate (string->number
                                  (next-number rest-string))
                                 (first (explode str)))
                      (rle-decode (substring str (next-substring
                                                  rest-string)))))]))

;; Most efficient: Duplicated input, such as the same letter multiple
;  times in a row, would produce the highest level of compression.
;  (rle-encode "AAAAACCCCCCCCCC") -> "A2C10"

;; Least efficient: Single non-duplicated values one after another,
;  as they cannot compress as effectively and essentially double the
;  amount of compression needed
;  (rle-encode "ACGTCGT" -> "A1C1G1T1C1G1T1"


(define-struct pair [list num])

;; (HELPER) sort> : [List-of Numbers] -> [List-of Numbers]
;  produces a sorted version of a list of numbers

(check-expect (sort> (list 1 2 3 4)) (make-pair (list 4 3 2 1) 6))
(check-expect (sort> (list 4 3 2 1)) (make-pair (list 4 3 2 1) 3))

(define (sort> list)
  (cond
    [(empty? list) (make-pair empty 0)]
    [else (let ((srest (sort> (rest list))))
            (let ((sorted (insert (first list) (pair-list srest))))
              (make-pair (pair-list sorted) (+ (pair-num srest)
                                               (pair-num sorted)))))]))

;; (HELPER) insert : Number [List-of Numbers] -> [List-of Numbers]
;  inserts the given number into the sorted list of numbers

(check-expect (insert 2 empty) (make-pair (list 2) 0))
(check-expect (insert 0 (list 1 2 3 4)) (make-pair (list 1 2 3 4 0) 4))
(check-expect (insert 3 (list 2 3 4 5)) (make-pair (list 3 2 3 4 5) 1))

(define (insert n list)
  (cond
    [(empty? list) (make-pair (cons n empty) 0)]
    [else (if (>= n (first list))
              (make-pair (cons n list) 1)
              (local ((define ins-rest (insert n (rest list))))
                (make-pair (cons (first list) (pair-list ins-rest))
                           (add1 (pair-num ins-rest)))))]))

;; num-comps : [List-of Numbers] -> Number
;  evaluates how many comparisons were needed in sort

(check-expect (num-comps empty) 0)
(check-expect (num-comps (list 1 2 3 4)) 6)
(check-expect (num-comps (list 4 3 2 1)) 3)

(define (num-comps list)
  (pair-num (sort> list)))
