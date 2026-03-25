
;; mustHb for P2
(declare-rel mustHbP2 (stmt stmt))
(rule (=> (mustHb s1 s2 #b1) (mustHbP2 s1 s2)))
(query mustHbP2 :print-answer true)
