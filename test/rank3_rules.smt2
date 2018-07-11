;;;;;;;;;;;;;;;;;;;;;; rank2 related rules ;;;;;;;;;;;;;;;;;;;;;;;;

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


;;; cycle with MustHb
(rule (=> (and
           (mayRf s1 s2 A p1)
           (mayRf s3 s4 B p1)
           (mustHb s2 s3 p1)
           (mustHb s4 s1 p1))
       (mustNotOccurSeq s1 s2 s3 s4 p1)))


;;; mustNotOccurSeq for mustNotOccur2

(rule (=> (and
           (mayRf s1 s2 A p1)
           (mayRf s3 s4 B p1)
           (not (and (= s1 s3) (= s2 s4)))
           (not (mustNotOccurSeq s1 s2 s3 s4 p1)))
       (mayOccur2 s3 s4 s1 s2 p1)))


;;;;;;;;;;;;;;;;;;;;;; rank3 related rules ;;;;;;;;;;;;;;;;;;;;;;;;


;;; cycle with MustHb
(rule (=> (and
           (mayRf s1 s2 A p1)
           (mayRf s3 s4 B p1)
           (mayRf s5 s6 C p1)
           (mustHb s2 s3 p1)
           (mustHb s4 s5 p1)
           (mustHb s6 s1 p1))
       (mustNotOccurSeq3 s1 s2 s3 s4 s5 s6 p1)))

;;; rules for may_occur_together for rank3
(rule (=> (and 
           (mayRf s1 s2 A p1)
           (mayRf s3 s4 B p1)
           (mayRf s5 s6 C p1)
           (not (and (= s1 s3) (= s2 s4)))
           (not (and (= s1 s3) (= s5 s6)))
           (not (and (= s2 s4) (= s5 s6)))
           (not (mustNotOccurSeq s1 s2 s3 s4 p1))
           (not (mustNotOccurSeq s1 s2 s5 s6 p1))
           (not (mustNotOccurSeq s3 s4 s5 s6 p1))
           (not (mustNotOccur3 s1 s2 s3 s4 s5 s6 p1)))
       (mayOccur3 s1 s2 s3 s4 s5 s6 p1)))

;;; Compare between two programs
(rule (=> (and
           (mayOccur3 s1 s2 s3 s4 s5 s6 #b0)
           (not (mayOccur3 s1 s2 s3 s4 s5 s6 #b1)))
       (p1Notp2Rank3 s1 s2 s3 s4 s5 s6)))

(rule (=> (and
           (mayOccur3 s1 s2 s3 s4 s5 s6 #b1)
           (not (mayOccur3 s1 s2 s3 s4 s5 s6 #b0)))
       (p2Notp1Rank3 s1 s2 s3 s4 s5 s6)))

;;; Equal compare
(rule (=> (or
           (p1Notp2Rank3 s1 s2 s3 s4 s5 s6)
           (p2Notp1Rank3 s1 s2 s3 s4 s5 s6))
       (p1p2Equal false)))
