;;;;;;;;;;;;;;;;;;;;;; rank2 related rules ;;;;;;;;;;;;;;;;;;;;;;;;

;; mustNotOccur2 with cannotPresent
;(rule (=> (and
;           (mayHb s1 s2 p1)
;           (mayHb s3 s4 p1)
;           (or
;            (cannotPresent s1 s3 p1)
;            (cannotPresent s1 s4 p1)
;            (cannotPresent s2 s3 p1)
;            (cannotPresent s2 s4 p1))
;           (not (= s1 s3))
;           (not (= s2 s4)))
;       (mustNotOccur2 s1 s2 s3 s4 p1)))

;;; one another rule
(rule (=> (and
           (mayRf s1 s2 A p1)
           (mayRf s1 s4 A p1)
           (sameAtSec s2 s3 l1 p1)
           (postDom s3 s2 p1)
           (write s3 A p1)
           (diffAtSec s2 s4 l1 p1)
           (st s2 th1 p1)
           (st s4 th2 p1)
           (not (= th1 th2)))
       (mustNotOccurSeq s1 s2 s1 s4 p1)))


;; readFrom injective
(rule (=> (and 
           (mayRf s1 s3 A p1)
           (mayRf s2 s3 A p1)
           (not (= s1 s2)))
       (mustNotOccurSeq s1 s3 s2 s3 p1)))

;;; lock interleaving
(rule (=> (and
           (mayRf s1 s2 A p1)
           (mayRf s3 s4 B p1)
           (sameAtSec s1 s4 l1 p1)
           (sameAtSec s2 s3 l1 p1)
           (diffAtSec s1 s2 l1 p1))
       (mustNotOccurSeq s1 s2 s3 s4 p1)))

;(rule (=> (and
;           (mayRf s1 s2 A p1)
;           (mayRf s1 s3 A p1)
;           (write s4 A p1)
;           (write s5 A p1)
;           (postDom s4 s2 p1)
;           (postDom s5 s3 p1)
;           (sameAtSec s2 s4 l1 p1)
;           (sameAtSec s3 s5 l1 p1)
;           (diffAtSec s2 s3 l1 p1))
;       (mustNotOccurSeq s1 s2 s1 s3 p1)))

;;; cycle with MustHb
(rule (=> (and
           (mayRf s1 s2 A p1)
           (mayRf s3 s4 B p1)
           (mustHb s2 s3 p1)
           (mustHb s4 s1 p1))
       (mustNotOccurSeq s1 s2 s3 s4 p1)))

;(rule (=> (and
;           (mayHb s1 s2 p1)
;           (mayHb s2 s3 p1)
;           (mustHb s3 s1 p1))
;       (mustNotOccur2 s1 s2 s2 s3 p1)))

;;; mustNotOccurSeq for mustNotOccur2

;(rule (=> (and
;           (mayRf s1 s2 A p1)
;           (mayRf s3 s4 B p1)
;           (not (and (= s1 s3) (= s2 s4)))
;           (mustNotOccurSeq s1 s2 s3 s4 p1)
;           (not (mustNotOccurSeq s3 s4 s1 s2 p1)))
;       (mayOccur2 s3 s4 s1 s2 p1)))

(rule (=> (and
           (mayRf s1 s2 A p1)
           (mayRf s3 s4 B p1)
           (not (and (= s1 s3) (= s2 s4)))
           (not (mustNotOccurSeq s1 s2 s3 s4 p1)))
       (mayOccur2 s1 s2 s3 s4 p1)))


;;; Compare between two programs
(rule (=> (and
           (mayOccur2 s1 s2 s3 s4 #b0)
           (not (mayOccur2 s1 s2 s3 s4 #b1)))
       (p1Notp2Rank2 s1 s2 s3 s4)))

(rule (=> (and
           (mayOccur2 s1 s2 s3 s4 #b1)
           (not (mayOccur2 s1 s2 s3 s4 #b0)))
       (p2Notp1Rank2 s1 s2 s3 s4)))

;;; Equal compare
(rule (=> (or
           (p1Notp2Rank2 s1 s2 s3 s4)
           (p2Notp1Rank2 s1 s2 s3 s4))
       (p1p2Equal false)))

