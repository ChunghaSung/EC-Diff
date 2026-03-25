
;; mustHb for P1
(declare-rel mustHbP1 (stmt stmt))
(rule (=> (mustHb s1 s2 #b0) (mustHbP1 s1 s2)))
(query mustHbP1 :print-answer true)
