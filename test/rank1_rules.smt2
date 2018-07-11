;;;;;;;;;;;;;;;;;;;;;; rank1 related rules ;;;;;;;;;;;;;;;;;;;;;;;;

;;; Compare between two programs
(rule (=> (and
           (mayDep s1 s2 #b0)
           (not (mayDep s1 s2 #b1)))
       (p1Notp2Rank1 s1 s2)))

(rule (=> (and
           (mayDep s1 s2 #b1)
           (not (mayDep s1 s2 #b0)))
       (p2Notp1Rank1 s1 s2)))

;;; Equal compare
(rule (=> (or
           (p1Notp2Rank1 s1 s2)
           (p2Notp1Rank1 s1 s2))
       (p1p2Equal false)))

