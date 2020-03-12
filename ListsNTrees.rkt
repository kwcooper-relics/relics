(require 2htdp/batch-io)

; Frequency is a structure:
; - (make-frequency String Number)
(define-struct frequency (str freq))

; ListOfStrings is one of:
; - empty,
; - (cons String ListOfStrings)
(define ListOfStrings (list "keiland" "Austin" "Nathan" "keiland"))

; ListOfFrequency is one of:
; - empty,
; - (cons Frequency ListOfFrequencies)
(define ListOfFrequencies (list (make-frequency "keiland" 1)
                                (make-frequency "Austin" 2)))

; count-word : ListOfFrequencies String -> ListOfFrequencies
; purpose: consumes a ListOfFrequencies and a String, adding one to
; the given string if it is found in the LoF. If not, a new
; (make-frequency) is appended to the back of the existing LoF.

(define (count-word list str)
  (cond
    [(empty? list) (cons (make-frequency str 1) empty)]
    [(string=? str (frequency-str (first list)))
     (cons (make-frequency
            str (+ 1 (frequency-freq (first list)))) (rest list))]
    [else (cons (first list) (count-word (rest list) str))]))

(check-expect (count-word ListOfFrequencies "keiland")
              (list (make-frequency "keiland" 2)
                    (make-frequency "Austin" 2)))
(check-expect (count-word ListOfFrequencies "Austin")
              (list (make-frequency "keiland" 1)
                    (make-frequency "Austin" 3)))
(check-expect (count-word empty "Nathan")
              (list (make-frequency "Nathan" 1)))
(check-expect (count-word ListOfFrequencies "Brad")
              (list (make-frequency "keiland" 1)
                    (make-frequency "Austin" 2)
                    (make-frequency "Brad" 1)))

; count-all-words : ListOfStrings -> ListOfFrequencies
; Purpose: consumes a ListOfStrings, producing a ListOfFrequencies
; with the appropriate number of frequencies per word

(define (count-all-words list)
  (cond
    [(empty? (rest list)) (count-word empty (first list))]
    [(cons? list) (count-word (count-all-words (rest list))
                              (first list))]))

(check-expect (count-all-words (list "keiland" "Austin" "hal" "keiland"))
              (list (make-frequency "keiland" 2)
                    (make-frequency "hal" 1)
                    (make-frequency "Austin" 1)))

(define hamlet (read-words "hamlet.txt"))

; above-100? ListOfFrequency -> ListOfFrequency
; Purpose: Consumes a ListOfFrequency, selecting list elements with
; frequencies above 100 and placing them into a new ListOfFrequencies

(define (above-100? list)
  (cond
    [(empty? list) empty]
    [(and (cons? list)
          (> (frequency-freq (first list)) 100))
     (cons (first list) (above-100? (rest list)))]
    [else (above-100? (rest list))]))

; Was told by Somogyi not to include check-expect for this function
; since compiler takes too long to run through Hamlet.
              
; Book Exercises
; --------------

(define-struct no-parent [])
(define MTFT (make-no-parent))
(define-struct child [father mother name date eyes])

; Oldest Generation:
(define Carl (make-child MTFT MTFT "Carl" 1926 "green"))
(define Bettina (make-child MTFT MTFT "Bettina" 1926 "green"))
 
; Middle Generation:
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child MTFT MTFT "Fred" 1966 "pink"))
 
; Youngest Generation: 
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

; #296
; count-persons : FamilyTree -> Number
; Purpose: consumes a family-tree node and counts the child structures
; in the tree.

(define (count-persons ft)
  (cond
    [(and (no-parent? (child-father ft))
          (no-parent? (child-mother ft))) 1]
    [(child? ft) (add1 (+ (count-persons (child-mother ft))
                          (count-persons (child-father ft))))]))

(check-expect (count-persons Gustav) 5)
(check-expect (count-persons Eva) 3)

; #297
; average-age : FamilyTree Year -> Number
; Purpose: consumes a FamilyTree and the current year, producing average
;  age of all child structures

(define (average-age ft year)
  (cond
    [(and (no-parent? (child-father ft))
          (no-parent? (child-mother ft)))
     (- year (child-date ft))]
    [(child? ft) (/ (+ (average-age (child-father ft) year)
                       (average-age (child-mother ft) year)
                       (- year (child-date ft)))
                    (count-persons ft))]))

(check-expect (average-age Bettina 2015) 89)
(check-expect (average-age Eva 2015) 76)

; #298
; eye-colors : FamilyTree -> List
; Purpose: consumes a FamilyTree and produces a list of all eye colors
; in the tree

(define (eye-colors ft)
  (cond
    [(and (no-parent? (child-father ft))
          (no-parent? (child-mother ft))) (list (child-eyes ft))]
    [(child? ft) (append (list (child-eyes (child-father ft)))
                         (list (child-eyes (child-mother ft)))
                         (list (child-eyes ft)))]))

(check-expect (eye-colors Gustav) (list "pink" "blue" "brown"))
(check-expect (eye-colors Eva) (list "green" "green" "blue"))
(check-expect (eye-colors Bettina) (list "green"))

; #299
; blue-eyed-ancestor? : FamilyTree -> Boolean
; Purpose: consumes a FamilyTree and returns true if any of the child's
; ancestors are blue-eyes

(define (blue-eyed-ancestor? ft)
  (cond
    [(and (no-parent? (child-father ft))
          (no-parent? (child-mother ft)))
     #false]
    [else (or (string=? (child-eyes (child-father ft)) "blue")
              (string=? (child-eyes (child-mother ft)) "blue")
              (blue-eyed-ancestor? (child-father ft))
              (blue-eyed-ancestor? (child-mother ft)))]))

(check-expect (blue-eyed-ancestor? Gustav) #true)
(check-expect (blue-eyed-ancestor? Eva) #false)