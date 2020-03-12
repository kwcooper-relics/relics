
;; A Nucleotide is one of:
;  - 'a,
;  - 'c,
;  - 'g,
;  - 't

;; A Strand is one of:
;  - empty,
;  - (cons Nucleotide ListOfNucleotides)

;; DNAprefix : Strand Strand -> Boolean
;  purpose: accepts two strands, determining if the
;  initial part of the first is identical to that of
;  the second

(check-expect (DNAprefix
               '(a g a) '(a g a)) #true)
(check-expect (DNAprefix
               '(a g a c) '(a g t)) #false)
(check-expect (DNAprefix
               '(a g a c) '(a g a c a t)) #false)

(define (DNAprefix strand1 strand2)
  (cond
    [(empty? strand2) #true]
    [(empty? strand1) #false]
    [else (and (symbol=? (first strand1) (first strand2))
               (DNAprefix (rest strand1) (rest strand2)))]))

;; DNAprefix-overlap : Strand Strand -> Strand
;  purpose: accepts two strands, returning the Strand
;  which represents the shared prefix

(check-expect (DNAprefix-overlap (list 'a 'g 'a)
                                 (list 'a 'g 'a 'c 'a 't))
              '(a g a))

(check-expect (DNAprefix-overlap '(a g c)
                                 '(c t g a))
              empty)

(define (DNAprefix-overlap strand1 strand2)
  (cond
    [(or (empty? strand1) (empty? strand2)) empty]
    [(symbol=? (first strand1) (first strand2))
     (cons (first strand1)
           (DNAprefix-overlap (rest strand1) (rest strand2)))]
    [else empty]))

;; DNAsearch : Strand Strand -> Boolean
;  purpose: accepts two strands, returning true if the first
;  strand appears anywhere in the second strand

(check-expect
 (DNAsearch '(a g a) '(c a t a g a)) #true)
(check-expect
 (DNAsearch '(a g a) '(c a t a c a c)) #false)

(define (DNAsearch strand1 strand2)
  (cond
    [(or (empty? strand1) (empty? strand2)) #false]
    [else (if (symbol=? (first strand1) (first strand2))
              (if (DNAprefix (rest strand1) (rest strand2))
                  #true
                  (DNAsearch strand1 (rest strand2)))
              (DNAsearch strand1 (rest strand2)))]))

;; (HELPER) findrest : Strand Strand - > Strand
;  purpose: evaluates whether the first strand is held
;  within the second, and returns the string if so

(check-expect (findrest '(a g a) '(g c a g t)) '(a g))
(check-expect (findrest '(a g a) '()) '())

(define (findrest strand1 strand2)
  (cond
    [(or (empty? strand1) (empty? strand2)) empty]
    [else (if (equal? (first strand1) (first strand2))
              (DNAprefix-overlap strand1 strand2)
              (findrest strand1 (rest strand2)))]))

;; (HELPER) strand-compare : Strand Strand -> Strand
;  purpose: accepts two strands, determining where the union is

(check-expect (strand-compare '(a b c d) '(a b d c a b c))
              '(a b c))
(check-expect (strand-compare '(a g b g) '(a a g b g b c))
              '(a g b g))

(define (strand-compare strand1 strand2)
  (cond
    [(or (empty? strand1) (empty? strand2)) empty]
    [(>= (length (findrest strand1 strand2))
         (length (strand-compare strand1 (rest strand2))))
     (findrest strand1 strand2)]
    [(<= (length (findrest strand1 strand2))
         (length (strand-compare strand1 (rest strand2))))
     (findrest strand1 (rest strand2))]))

;; DNAlongest-common-seq : Strand Strand -> Strand
;  purpose: accepts two strands, returning the longest
;  common subsequence

(check-expect (lcs '(a b b c d e f) '(a h c d e f)) '(c d e f))
(check-expect (lcs '(a b b c d e f) '(a b b c d e)) '(a b b c d e))
(check-expect (lcs '(a b b c d e f) '()) '())
(check-expect (lcs '(a b b c d e f) '(b b c d e f)) '(b b c d e f))
(check-expect (lcs '(a b c) '(b c)) '(b c))
(check-expect (lcs '(a b c) '(a b c)) '(a b c))
(check-expect (lcs '(a b c d e f) '(a b c)) '(a b c))
(check-expect (lcs '(a b c d e f) '(d e f)) '(d e f))
(check-expect (lcs '(a b c d e f) '(d e )) '(d e))
(check-expect (lcs '(d e) '(a b c d e f) ) '(d e))
(check-expect (lcs '(d e f) '(d e a b c d e f) ) '(d e f))

(define (lcs strand1 strand2)
  (cond
    [(or (empty? strand1) (empty? strand2)) empty]
    [(>= (length (strand-compare strand1 strand2))
         (length (lcs (rest strand1) strand2)))
     (strand-compare strand1 strand2)]
    [(<= (length (strand-compare strand1 strand2))
         (length (lcs (rest strand1) strand2)))
     (lcs (rest strand1) strand2)]))

;; DNAjoin : Strand Strand -> Strand
;  purpose: accepts two strands and joins them at the
;  longest common subsequence

(check-expect (DNAjoin empty empty) empty)
(check-expect (DNAjoin '(acacgtac gtgtgt actgact)
                       '(tcagtcga gtgtgt aaacccaa))
              '(acacgtac gtgtgt aaacccaa))

(define (DNAjoin strand1 strand2)
  (local [(define mid (lcs strand1 strand2))]
    (cond
      [(or (empty? strand1) (empty? strand2)) empty]
      [(equal? (first mid) (first strand1)) (rest strand2)]
      [else (cons (first strand1) (DNAjoin (rest strand1) strand2))])))