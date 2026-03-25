(set-option :fixedpoint.engine datalog)
(define-sort pNumber () (_ BitVec 1))
(define-sort stmt () (_ BitVec 16))
(define-sort thread () (_ BitVec 16))
(define-sort var () (_ BitVec 16))
(define-sort id () (_ BitVec 16))
(define-sort lock () (_ BitVec 16))
(define-sort eq() (bool))


;;; definitions
; st (s1, th1, pNumber): statement s1 happens in thread th1
(declare-rel st (stmt thread pNumber))

; impo (s1, s2): immediate program order from s1 to s2 in the same thread
(declare-rel impo (stmt stmt pNumber))

; po (s1, s2): program order from s1 to s2 in the same thread
(declare-rel po (stmt stmt pNumber))

; dom (s1, s2): dominate relation from s1 to s2
(declare-rel dom (stmt stmt pNumber))

; postDom (s1, s2): post-dominate relation from s1 to s2
(declare-rel postDom (stmt stmt pNumber))

; cannotPresent (s1, s2): statement s1 and s2 cannot present in the same execution
(declare-rel cannotPresent (stmt stmt pNumber))

; threadCreate (th1, s1, th2): Thread t1 is created at statement s1 in thread th2
(declare-rel threadCreate (thread stmt thread pNumber))

; threadJoin (th1, s1, th2): Thread t1 joins at statement s1 in thread th2
(declare-rel threadJoin (thread stmt thread pNumber))

; threadCondWait (v1, l1, s1): conditional wait with conditional var v1 and lock l1 
(declare-rel threadCondWait (var lock stmt pNumber))

; threadCondSingnal (v1, s1): conditional signal with the conditional var v1 at s1
(declare-rel threadCondSignal (var stmt pNumber))

; afterCondWait (v1, s1, s2, p1): s1 statement is a statement after Conditional wait (s2) for conditional variable v1
(declare-rel afterCondWait (var stmt stmt pNumber))

; lockAcquire
(declare-rel lockAcquire (stmt lock pNumber))

; lockRelease
(declare-rel lockRelease (stmt lock pNumber))

; nonLock
(declare-rel nonLock (stmt pNumber))

; sameAtSec (s1, s2, l): Statement s1 and s2 are in the same lock region by lock l
(declare-rel sameAtSec (stmt stmt lock pNumber))

; inAtSec (s1, l): Statement s1 is in the lock region by lock l
(declare-rel inAtSec (stmt lock pNumber))

; diffAtSec (s1, s2, l): Statement s1 and s2 are in the range of lock l1 but int different regions
(declare-rel diffAtSec (stmt stmt lock pNumber))

; mustHb (s1, s2): statement s1 must happen before s2
(declare-rel mustHb (stmt stmt pNumber))

; mayHb (s1, s2): statement s1 may happen before s2
(declare-rel mayHb (stmt stmt pNumber))

; mayHbP1 (s1, s2): statement s1 may happen before s2 in P1
(declare-rel mayHbP1 (stmt stmt))

; mayHbP2 (s1, s2): statement s1 may happen before s2 in P2
(declare-rel mayHbP2 (stmt stmt))

; MustNotOccurSeq (mayHb(s1, s2), mayHb(s3, s4))
(declare-rel mustNotOccurSeq (stmt stmt stmt stmt pNumber))

; MustNotOccurSeq3 (mayHb(s1, s2), mayHb(s3, s4), mayHb(s5, s6))
(declare-rel mustNotOccurSeq3 (stmt stmt stmt stmt stmt stmt pNumber))

; MustNotOccur2 (mayHb(s1, s2), mayHb(s3, s4))
(declare-rel mustNotOccur2 (stmt stmt stmt stmt pNumber))

; MustNotOccur3 (mayHb(s1, s2), mayHb(s3, s4), mayHb(s5, s6))
(declare-rel mustNotOccur3 (stmt stmt stmt stmt stmt stmt pNumber))

; mayOccur2 (mayHb(s1, s2), mayHb(s3, s4))
(declare-rel mayOccur2 (stmt stmt stmt stmt pNumber))

; mayOccur3 (mayHb(s1, s2), mayHb(s3, s4), mayHb(s5, s6))
(declare-rel mayOccur3 (stmt stmt stmt stmt stmt stmt pNumber))

; read (s1, v1): s1 is a read of global variable v1
(declare-rel read (stmt var pNumber))

; write (s1, v1): s1 is a write of global variable v1
(declare-rel write (stmt var pNumber))

; busyRead (s1, v1): s1 is a read of global variable v1 for busy waiting
(declare-rel busyRead (stmt var pNumber))

; busyWrite (s1, v1): s1 is a write of global variable v1 for busy waiting signal
(declare-rel busyWrite (stmt var pNumber))

; access (s1, v1): s1 is an access of global variable v1
(declare-rel access (stmt var pNumber))

; mayRf (s1, s2, v1): possible readfrom from s1 to s2 for v1
(declare-rel mayRf (stmt stmt var pNumber))

; coveredReadByLock (s1, v1, l1, p1): s1 is covered by a statement at the same lock range
(declare-rel coveredReadByLock (stmt var lock pNumber))

; mayDoubleRf (s1, v1, p1): there are at least two possible Rf for the same destination
(declare-rel mayDoubleRf (stmt var pNumber))

; noRf (s1, s2, v1): impossible read from edge from s1 s2
(declare-rel noRf (stmt stmt var pNumber))

; maySo (s1, s2, v1): possible storeOrder from s1 to s2 for v1
(declare-rel maySo (stmt stmt var pNumber))

; mustSo (s1, s2, v1): storeOrder which must happen from s1 to s2 for v1
(declare-rel mustSo (stmt stmt var pNumber))

; coveredWriteByLock (s1, v1, l1, p1): s1 is covered by a statement at the same lock range
(declare-rel coveredWriteByLock (stmt var lock pNumber))

; noSo (s1, s2, v1): impossible read from edge from s1 s2
(declare-rel noSo (stmt stmt var pNumber))

; mayDep (s1, s2): statement s2 depends on statement s1 
(declare-rel mayDep (stmt stmt pNumber))

; p1Notp2Rank1(s1, s2): s1-s2 may occur in p1 but not in p2
(declare-rel p1Notp2Rank1 (stmt stmt))

; p2Notp1Rank1(s1, s2): s1-s2 may occur in p2 but not in p1
(declare-rel p2Notp1Rank1 (stmt stmt))

; p1Notp2Rank2(s1, s2, s3, s4): s1-s2 s3-s4 may occur together in p1 but not in p2
(declare-rel p1Notp2Rank2 (stmt stmt stmt stmt))

; p2Notp1Rank2(s1, s2, s3, s4): s1-s2 s3-s4 may occur together in p2 but not in p1
(declare-rel p2Notp1Rank2 (stmt stmt stmt stmt))

; p1Notp2Rank3(s1, s2, s3, s4, s5, s6): s1-s2 s3-s4 s5-s6 may occur together in p1 but not in p2
(declare-rel p1Notp2Rank3 (stmt stmt stmt stmt stmt stmt))

; p2Notp1Rank3(s1, s2, s3, s4, s5, s6): s1-s2 s3-s4 s5-s6 may occur together in p2 but not in p1
(declare-rel p2Notp1Rank3 (stmt stmt stmt stmt stmt stmt))

; p1p2Equal
(declare-rel p1p2Equal (eq))



;;; variable declaration
(declare-var s1 stmt)
(declare-var s2 stmt)
(declare-var s3 stmt)
(declare-var s4 stmt)
(declare-var s5 stmt)
(declare-var s6 stmt)

(declare-var p1 pNumber)

(declare-var th1 thread)
(declare-var th2 thread)

(declare-var id1 id)
(declare-var id2 id)
(declare-var A var)
(declare-var B var)
(declare-var C var)
(declare-var D var)
(declare-var l1 lock)
(declare-var l2 lock)

(declare-var E var)
(declare-var F var)


;; immediate program order implies program order
(rule (=> (impo s1 s2 p1) (po s1 s2 p1)))

;; program order is transitive closure
;(rule (=> (and
;           (po s1 s2 p1)
;           (po s2 s3 p1))
;       (po s1 s3 p1)))

;; 1) mustHb relates the relations insdie of a thread
;; 2) mustHb relates threadCreate and threadJoin

;; mustHb with reachability
(rule (=> (and
           (po s1 s2 p1) 
           (not (po s2 s1 p1)))
       (mustHb s1 s2 p1)))

;; mustHb with thread create
(rule (=> (and
           (access s2 A p1)
           (threadCreate th1 s1 th2 p1)
           (st s2 th1 p1)
           (nonLock s2 p1))
       (mustHb s1 s2 p1)))

;; mustHb with thread join
(rule (=> (and
           (access s1 A p1)
           (threadJoin th1 s2 th2 p1)
           (st s1 th1 p1)
           (nonLock s1 p1))
       (mustHb s1 s2 p1)))

;; mustHb with conditional wait and signal
;(rule (=> (and
;           (st s1 th1 p1)
;           (inAtSec s1 l1 p1)
;           (threadCondWait A l1 s2 p1)
;           (not (= s1 s2))
;           (sameAtSec s1 s2 l1 p1)
;           (po s1 s2))
;       (beforeCond s1 A)))


;(rule (=> (and
;           (st s1 th1 p1)
;           (inAtSec s1 l1 p1)
;           (threadCondWait A l1 s2 p1)
;           (not (= s1 s2))
;           (sameAtSec s1 s2 l1 p1)
;           (po s2 s1 p1))
;       (afterCondWait A s2 s1 p1)))

(rule (=> (and
           (busyWrite s1 A p1)
           (busyRead s2 A p1)
           (st s1 th1 p1)
           (st s2 th2 p1)
           (not (= th1 th2)))
       (mustHb s1 s2 p1)))

(rule (=> (and
           (threadCondSignal A s2 p1)
           (threadCondWait A l1 s3 p1))
       (mustHb s2 s3 p1)))

          

;; mayHb relation (assuming it is a loop-free program)

;; mayHb with threadCreate & join
(rule (=> (and
           (access s1 A p1)
           (access s2 B p1)
           (st s1 th1 p1)
           (nonLock s1 p1)
           (nonLock s2 p1)
           (st s2 th2 p1)
           (not (= th1 th2))
           (not (mustHb s1 s2 p1)))
       (mayHb s2 s1 p1)))

(rule (=> (mustHb s1 s2 p1) (mayHb s1 s2 p1)))


;; transitive closure for mustHB
(rule (=> (and
           (access s1 A p1)
           (mustHb s1 s2 p1)
           (mustHb s2 s3 p1)
           (not (= s1 s3)))
       (mustHb s1 s3 p1)))


;; transitive closure for mayHb only through global accesses
(rule (=> (read s1 A p1) (access s1 A p1)))
(rule (=> (write s1 A p1) (access s1 A p1)))

(rule (=> (and
            (access s1 A p1)
            (mayHb s1 s2 p1)
            (mayHb s2 s3 p1)
            (not (= s1 s3))
            (not (mustHb s3 s1 p1)))
       (mayHb s1 s3 p1)))


;; cannotPresent
;(rule (=> (and
;           (not (po s1 s2 p1))
;           (not (po s2 s1 p1))
;           (not (= s1 s2))
;           (st s1 th1 p1)
;           (st s2 th1 p1))
;       (cannotPresent s1 s2 p1)))

;; coveredReadByLock
;; lock(a)->w1(x)->r1(x)->unlock(a) => r1 is coveredRead by lock
(rule (=> (and
           (write s1 A p1)
           (read s2 A p1)
           (sameAtSec s1 s2 l1 p1)
           (dom s1 s2 p1))
       (coveredReadByLock s2 A l1 p1)))

;; coveredWriteByLock
;; lock(a)->w1(x)->w2(x)->unlock(a) => w1 is coveredWrite by lock
(rule (=> (and
           (write s1 A p1)
           (write s2 A p1)
           (sameAtSec s1 s2 l1 p1)
           (postDom s2 s1 p1))
       (coveredWriteByLock s1 A l1 p1)))

;; NoReadFrom 1 a->b->c
(rule (=> (and
           (write s1 A p1)
           (write s2 A p1)
           (mustHb s1 s2 p1)
           (mustHb s2 s3 p1)
           (not (= s1 s3))
           (read s3 A p1))
       (noRf s1 s3 A p1)))

;; NoRf with coveredReadByLock
(rule (=> (and
           (write s1 A p1)
           (read s2 A p1)
           (mayHb s1 s2 p1)
           (coveredReadByLock s2 A l1 p1)
           (diffAtSec s1 s2 l1 p1))
       (noRf s1 s2 A p1)))

;; NoRf with coveredWriteByLock
(rule (=> (and
           (write s1 A p1)
           (read s2 A p1)
           (mayHb s1 s2 p1)
           (coveredWriteByLock s1 A l1 p1)
           (diffAtSec s1 s2 l1 p1))
       (noRf s1 s2 A p1)))

;; NoStoreOrder
;(rule (=> (and
;           (write s1 A p1)
;           (write s2 A p1)
;           (mayHb s1 s2 p1)
;           (coveredWriteByLock s2 A l1 p1)
;           (diffAtSec s1 s2 l1 p1))
;       (noSo s1 s2 A p1)))

;; mayReadFrom and mayStoreOrder
(rule (=> (and
           (write s1 A p1)
           (read s2 A p1)
           (mayHb s1 s2 p1)
           (not (noRf s1 s2 A p1)))
       (mayRf s1 s2 A p1)))

;(rule (=> (and
;           (write s1 A p1)
;           (write s2 A p1)
;           (mayHb s1 s2 p1)
;           (not (noRf s1 s2 A p1)))
;       (maySo s1 s2 A p1)))
;

;; mustSo
;(rule (=> (and
;           (write s1 A p1)
;           (write s2 A p1)
;           (mustHb s1 s2 p1)
;           (not (noSo s1 s2 A p1)))
;       (mustSo s1 s2 A p1)))


;; mayDep
(rule (=> (mayRf s1 s2 A p1) (mayDep s1 s2 p1)))
;(rule (=> (and 
;           (maySo s1 s2 A p1)
;           (not (= s1 s2)))
;           (mayDep s1 s2 p1)))

;;(rule (=> (po s1 s2 p1) (dep s1 s2 p1)))




;;; rules for domination and post-domination transitive
(rule (=> (and
           (dom s1 s2 p1)
           (dom s2 s3 p1))
       (dom s1 s3 p1)))
(rule (=> (and
           (postDom s1 s2 p1)
           (postDom s2 s3 p1))
       (postDom s1 s3 p1)))

;;; rules for sameAtSec & inAtSec & diffAtSec
(rule (=> (and
           (lockAcquire s1 l1 p1)
           (impo s1 s2 p1)
           (not (lockRelease s2 l1 p1)))
       (inAtSec s2 l1 p1)))

(rule (=> (and
           (inAtSec s1 l1 p1)
           (impo s1 s2 p1)
           (not (lockRelease s2 l1 p1)))
       (inAtSec s2 l1 p1)))

(rule (=> (and
           (inAtSec s1 l1 p1)
           (inAtSec s2 l1 p1)
           (or
            (impo s1 s2 p1)
            (impo s2 s1 p1)))
       (sameAtSec s1 s2 l1 p1)))

(rule (=> (inAtSec s1 l1 p1) (sameAtSec s1 s1 l1 p1)))
       
(rule (=> (and
           (sameAtSec s1 s2 l1 p1)
           (sameAtSec s2 s3 l1 p1))
       (sameAtSec s1 s3 l1 p1)))

(rule (=> (and
           (inAtSec s1 l1 p1)
           (inAtSec s2 l1 p1)
           (not (sameAtSec s1 s2 l1 p1)))
       (diffAtSec s1 s2 l1 p1)))
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

(rule (threadCreate #x0001 #x0020 #x0000 #b0))
(rule (threadCreate #x0002 #x0021 #x0000 #b0))
(rule (threadJoin #x0001 #xf006 #x0000 #b0))
(rule (threadJoin #x0002 #xf007 #x0000 #b0))
(rule (threadCondSignal #x0002 #xf001 #b0))
(rule (threadCondWait #x0002 #x0000 #xf004 #b0))
(rule (st #x0000 #x0001 #b0))
(rule (st #x0001 #x0001 #b0))
(rule (st #x0002 #x0001 #b0))
(rule (st #x0003 #x0001 #b0))
(rule (st #x0004 #x0001 #b0))
(rule (st #x0005 #x0001 #b0))
(rule (st #x0006 #x0001 #b0))
(rule (st #x0007 #x0001 #b0))
(rule (st #x0008 #x0001 #b0))
(rule (st #x0009 #x0001 #b0))
(rule (st #x000a #x0001 #b0))
(rule (st #x000b #x0001 #b0))
(rule (st #x000c #x0001 #b0))
(rule (st #x000d #x0001 #b0))
(rule (st #xf000 #x0001 #b0))
(rule (st #x000e #x0001 #b0))
(rule (st #xf001 #x0001 #b0))
(rule (st #xf002 #x0001 #b0))
(rule (st #x000f #x0001 #b0))
(rule (st #x0010 #x0002 #b0))
(rule (st #x0011 #x0002 #b0))
(rule (st #x0012 #x0002 #b0))
(rule (st #x0013 #x0002 #b0))
(rule (st #x0014 #x0002 #b0))
(rule (st #x0015 #x0002 #b0))
(rule (st #xf003 #x0002 #b0))
(rule (st #x0016 #x0002 #b0))
(rule (st #x0017 #x0002 #b0))
(rule (st #x0018 #x0002 #b0))
(rule (st #xf004 #x0002 #b0))
(rule (st #x0019 #x0002 #b0))
(rule (st #xf005 #x0002 #b0))
(rule (st #x001a #x0002 #b0))
(rule (st #x001b #x0002 #b0))
(rule (st #x001c #x0002 #b0))
(rule (st #x001d #x0002 #b0))
(rule (st #x001e #x0000 #b0))
(rule (st #x001f #x0000 #b0))
(rule (st #x0020 #x0000 #b0))
(rule (st #x0021 #x0000 #b0))
(rule (st #x0022 #x0000 #b0))
(rule (st #xf006 #x0000 #b0))
(rule (st #x0023 #x0000 #b0))
(rule (st #xf007 #x0000 #b0))
(rule (st #x0024 #x0000 #b0))
(rule (impo #x0000 #x0001 #b0))
(rule (impo #x0001 #x0002 #b0))
(rule (impo #x0002 #x0003 #b0))
(rule (impo #x0003 #x0004 #b0))
(rule (impo #x0004 #x0005 #b0))
(rule (impo #x0006 #x0007 #b0))
(rule (impo #x0008 #x0009 #b0))
(rule (impo #x0009 #x000a #b0))
(rule (impo #x000a #x000b #b0))
(rule (impo #x000c #x000d #b0))
(rule (impo #xf000 #x000e #b0))
(rule (impo #x000e #xf001 #b0))
(rule (impo #xf001 #xf002 #b0))
(rule (impo #xf002 #x000f #b0))
(rule (impo #x0005 #x0006 #b0))
(rule (impo #x0005 #x0008 #b0))
(rule (impo #x000b #x000c #b0))
(rule (impo #x000b #xf000 #b0))
(rule (impo #x0010 #x0011 #b0))
(rule (impo #x0011 #x0012 #b0))
(rule (impo #x0012 #x0013 #b0))
(rule (impo #x0013 #x0014 #b0))
(rule (impo #x0014 #x0015 #b0))
(rule (impo #x0015 #xf003 #b0))
(rule (impo #xf003 #x0016 #b0))
(rule (impo #x0016 #x0017 #b0))
(rule (impo #x0017 #x0018 #b0))
(rule (impo #xf004 #x0019 #b0))
(rule (impo #xf005 #x001a #b0))
(rule (impo #x001a #x001b #b0))
(rule (impo #x001b #x001c #b0))
(rule (impo #x001c #x001d #b0))
(rule (impo #x0018 #xf005 #b0))
(rule (impo #x0018 #xf004 #b0))
(rule (impo #x0019 #xf005 #b0))
(rule (impo #x001e #x001f #b0))
(rule (impo #x001f #x0020 #b0))
(rule (impo #x0020 #x0021 #b0))
(rule (impo #x0021 #x0022 #b0))
(rule (impo #x0022 #xf006 #b0))
(rule (impo #xf006 #x0023 #b0))
(rule (impo #x0023 #xf007 #b0))
(rule (impo #xf007 #x0024 #b0))
(rule (lockAcquire #xf000 #x0000 #b0))
(rule (lockRelease #xf002 #x0000 #b0))
(rule (lockAcquire #xf003 #x0000 #b0))
(rule (lockRelease #xf005 #x0000 #b0))
(rule (nonLock #x0000 #b0))
(rule (nonLock #x0001 #b0))
(rule (nonLock #x0002 #b0))
(rule (nonLock #x0003 #b0))
(rule (nonLock #x0004 #b0))
(rule (nonLock #x0005 #b0))
(rule (nonLock #x0006 #b0))
(rule (nonLock #x0007 #b0))
(rule (nonLock #x0008 #b0))
(rule (nonLock #x0009 #b0))
(rule (nonLock #x000a #b0))
(rule (nonLock #x000b #b0))
(rule (nonLock #x000c #b0))
(rule (nonLock #x000d #b0))
(rule (nonLock #x000e #b0))
(rule (nonLock #xf001 #b0))
(rule (nonLock #x000f #b0))
(rule (nonLock #x0010 #b0))
(rule (nonLock #x0011 #b0))
(rule (nonLock #x0012 #b0))
(rule (nonLock #x0013 #b0))
(rule (nonLock #x0014 #b0))
(rule (nonLock #x0015 #b0))
(rule (nonLock #x0016 #b0))
(rule (nonLock #x0017 #b0))
(rule (nonLock #x0018 #b0))
(rule (nonLock #xf004 #b0))
(rule (nonLock #x0019 #b0))
(rule (nonLock #x001a #b0))
(rule (nonLock #x001b #b0))
(rule (nonLock #x001c #b0))
(rule (nonLock #x001d #b0))
(rule (nonLock #x001e #b0))
(rule (nonLock #x001f #b0))
(rule (nonLock #x0020 #b0))
(rule (nonLock #x0021 #b0))
(rule (nonLock #x0022 #b0))
(rule (nonLock #xf006 #b0))
(rule (nonLock #x0023 #b0))
(rule (nonLock #xf007 #b0))
(rule (nonLock #x0024 #b0))
(rule (read #x0002 #x0000 #b0))
(rule (read #x0008 #x0001 #b0))
(rule (read #x0013 #x0001 #b0))
(rule (write #x001a #x0001 #b0))
(rule (write #x001c #x0001 #b0))
(rule (dom #x0000 #x0001 #b0))
(rule (dom #x0001 #x0002 #b0))
(rule (dom #x0002 #x0003 #b0))
(rule (dom #x0003 #x0004 #b0))
(rule (dom #x0004 #x0005 #b0))
(rule (dom #x0006 #x0007 #b0))
(rule (dom #x0008 #x0009 #b0))
(rule (dom #x0009 #x000a #b0))
(rule (dom #x000a #x000b #b0))
(rule (dom #x000c #x000d #b0))
(rule (dom #xf000 #x000e #b0))
(rule (dom #x000e #xf001 #b0))
(rule (dom #xf001 #xf002 #b0))
(rule (dom #xf002 #x000f #b0))
(rule (dom #x0005 #x0006 #b0))
(rule (dom #x0005 #x0008 #b0))
(rule (dom #x000b #x000c #b0))
(rule (dom #x000b #xf000 #b0))
(rule (dom #x0010 #x0011 #b0))
(rule (dom #x0011 #x0012 #b0))
(rule (dom #x0012 #x0013 #b0))
(rule (dom #x0013 #x0014 #b0))
(rule (dom #x0014 #x0015 #b0))
(rule (dom #x0015 #xf003 #b0))
(rule (dom #xf003 #x0016 #b0))
(rule (dom #x0016 #x0017 #b0))
(rule (dom #x0017 #x0018 #b0))
(rule (dom #xf004 #x0019 #b0))
(rule (dom #xf005 #x001a #b0))
(rule (dom #x001a #x001b #b0))
(rule (dom #x001b #x001c #b0))
(rule (dom #x001c #x001d #b0))
(rule (dom #x0018 #xf004 #b0))
(rule (dom #x0018 #xf005 #b0))
(rule (dom #x001e #x001f #b0))
(rule (dom #x001f #x0020 #b0))
(rule (dom #x0020 #x0021 #b0))
(rule (dom #x0021 #x0022 #b0))
(rule (dom #x0022 #xf006 #b0))
(rule (dom #xf006 #x0023 #b0))
(rule (dom #x0023 #xf007 #b0))
(rule (dom #xf007 #x0024 #b0))
(rule (postDom #x0001 #x0000 #b0))
(rule (postDom #x0002 #x0001 #b0))
(rule (postDom #x0003 #x0002 #b0))
(rule (postDom #x0004 #x0003 #b0))
(rule (postDom #x0005 #x0004 #b0))
(rule (postDom #x0007 #x0006 #b0))
(rule (postDom #x0009 #x0008 #b0))
(rule (postDom #x000a #x0009 #b0))
(rule (postDom #x000b #x000a #b0))
(rule (postDom #x000d #x000c #b0))
(rule (postDom #x000e #xf000 #b0))
(rule (postDom #xf001 #x000e #b0))
(rule (postDom #xf002 #xf001 #b0))
(rule (postDom #x000f #xf002 #b0))
(rule (postDom #x0011 #x0010 #b0))
(rule (postDom #x0012 #x0011 #b0))
(rule (postDom #x0013 #x0012 #b0))
(rule (postDom #x0014 #x0013 #b0))
(rule (postDom #x0015 #x0014 #b0))
(rule (postDom #xf003 #x0015 #b0))
(rule (postDom #x0016 #xf003 #b0))
(rule (postDom #x0017 #x0016 #b0))
(rule (postDom #x0018 #x0017 #b0))
(rule (postDom #x0019 #xf004 #b0))
(rule (postDom #x001a #xf005 #b0))
(rule (postDom #x001b #x001a #b0))
(rule (postDom #x001c #x001b #b0))
(rule (postDom #x001d #x001c #b0))
(rule (postDom #xf005 #x0018 #b0))
(rule (postDom #xf005 #x0019 #b0))
(rule (postDom #x001f #x001e #b0))
(rule (postDom #x0020 #x001f #b0))
(rule (postDom #x0021 #x0020 #b0))
(rule (postDom #x0022 #x0021 #b0))
(rule (postDom #xf006 #x0022 #b0))
(rule (postDom #x0023 #xf006 #b0))
(rule (postDom #xf007 #x0023 #b0))
(rule (postDom #x0024 #xf007 #b0))
(rule (threadCreate #x0001 #x0020 #x0000 #b1))
(rule (threadCreate #x0002 #x0021 #x0000 #b1))
(rule (threadJoin #x0001 #xf006 #x0000 #b1))
(rule (threadJoin #x0002 #xf007 #x0000 #b1))
(rule (st #x0000 #x0001 #b1))
(rule (st #x0001 #x0001 #b1))
(rule (st #x0002 #x0001 #b1))
(rule (st #x0003 #x0001 #b1))
(rule (st #x0004 #x0001 #b1))
(rule (st #x0005 #x0001 #b1))
(rule (st #x0006 #x0001 #b1))
(rule (st #x0007 #x0001 #b1))
(rule (st #x0008 #x0001 #b1))
(rule (st #x0009 #x0001 #b1))
(rule (st #x000a #x0001 #b1))
(rule (st #x000b #x0001 #b1))
(rule (st #x000c #x0001 #b1))
(rule (st #x000d #x0001 #b1))
(rule (st #xf000 #x0001 #b1))
(rule (st #x000e #x0001 #b1))
(rule (st #xf001 #x0001 #b1))
(rule (st #xf002 #x0001 #b1))
(rule (st #x000f #x0001 #b1))
(rule (st #x0010 #x0002 #b1))
(rule (st #x0011 #x0002 #b1))
(rule (st #x0012 #x0002 #b1))
(rule (st #x0013 #x0002 #b1))
(rule (st #x0014 #x0002 #b1))
(rule (st #x0015 #x0002 #b1))
(rule (st #xf003 #x0002 #b1))
(rule (st #x0016 #x0002 #b1))
(rule (st #x0017 #x0002 #b1))
(rule (st #x0018 #x0002 #b1))
(rule (st #xf004 #x0002 #b1))
(rule (st #x0019 #x0002 #b1))
(rule (st #xf005 #x0002 #b1))
(rule (st #x001a #x0002 #b1))
(rule (st #x001b #x0002 #b1))
(rule (st #x001c #x0002 #b1))
(rule (st #x001d #x0002 #b1))
(rule (st #x001e #x0000 #b1))
(rule (st #x001f #x0000 #b1))
(rule (st #x0020 #x0000 #b1))
(rule (st #x0021 #x0000 #b1))
(rule (st #x0022 #x0000 #b1))
(rule (st #xf006 #x0000 #b1))
(rule (st #x0023 #x0000 #b1))
(rule (st #xf007 #x0000 #b1))
(rule (st #x0024 #x0000 #b1))
(rule (impo #x0000 #x0001 #b1))
(rule (impo #x0001 #x0002 #b1))
(rule (impo #x0002 #x0003 #b1))
(rule (impo #x0003 #x0004 #b1))
(rule (impo #x0004 #x0005 #b1))
(rule (impo #x0006 #x0007 #b1))
(rule (impo #x0008 #x0009 #b1))
(rule (impo #x0009 #x000a #b1))
(rule (impo #x000a #x000b #b1))
(rule (impo #x000c #x000d #b1))
(rule (impo #xf000 #x000e #b1))
(rule (impo #x000e #xf001 #b1))
(rule (impo #xf001 #xf002 #b1))
(rule (impo #xf002 #x000f #b1))
(rule (impo #x0005 #x0006 #b1))
(rule (impo #x0005 #x0008 #b1))
(rule (impo #x000b #x000c #b1))
(rule (impo #x000b #xf000 #b1))
(rule (impo #x0010 #x0011 #b1))
(rule (impo #x0011 #x0012 #b1))
(rule (impo #x0012 #x0013 #b1))
(rule (impo #x0013 #x0014 #b1))
(rule (impo #x0014 #x0015 #b1))
(rule (impo #x0015 #xf003 #b1))
(rule (impo #xf003 #x0016 #b1))
(rule (impo #x0016 #x0017 #b1))
(rule (impo #x0017 #x0018 #b1))
(rule (impo #xf004 #x0019 #b1))
(rule (impo #xf005 #x001a #b1))
(rule (impo #x001a #x001b #b1))
(rule (impo #x001b #x001c #b1))
(rule (impo #x001c #x001d #b1))
(rule (impo #x0018 #xf005 #b1))
(rule (impo #x0018 #xf004 #b1))
(rule (impo #x0019 #xf005 #b1))
(rule (impo #x001e #x001f #b1))
(rule (impo #x001f #x0020 #b1))
(rule (impo #x0020 #x0021 #b1))
(rule (impo #x0021 #x0022 #b1))
(rule (impo #x0022 #xf006 #b1))
(rule (impo #xf006 #x0023 #b1))
(rule (impo #x0023 #xf007 #b1))
(rule (impo #xf007 #x0024 #b1))
(rule (nonLock #x0000 #b1))
(rule (nonLock #x0001 #b1))
(rule (nonLock #x0002 #b1))
(rule (nonLock #x0003 #b1))
(rule (nonLock #x0004 #b1))
(rule (nonLock #x0005 #b1))
(rule (nonLock #x0006 #b1))
(rule (nonLock #x0007 #b1))
(rule (nonLock #x0008 #b1))
(rule (nonLock #x0009 #b1))
(rule (nonLock #x000a #b1))
(rule (nonLock #x000b #b1))
(rule (nonLock #x000c #b1))
(rule (nonLock #x000d #b1))
(rule (nonLock #xf000 #b1))
(rule (nonLock #x000e #b1))
(rule (nonLock #xf001 #b1))
(rule (nonLock #xf002 #b1))
(rule (nonLock #x000f #b1))
(rule (nonLock #x0010 #b1))
(rule (nonLock #x0011 #b1))
(rule (nonLock #x0012 #b1))
(rule (nonLock #x0013 #b1))
(rule (nonLock #x0014 #b1))
(rule (nonLock #x0015 #b1))
(rule (nonLock #xf003 #b1))
(rule (nonLock #x0016 #b1))
(rule (nonLock #x0017 #b1))
(rule (nonLock #x0018 #b1))
(rule (nonLock #xf004 #b1))
(rule (nonLock #x0019 #b1))
(rule (nonLock #xf005 #b1))
(rule (nonLock #x001a #b1))
(rule (nonLock #x001b #b1))
(rule (nonLock #x001c #b1))
(rule (nonLock #x001d #b1))
(rule (nonLock #x001e #b1))
(rule (nonLock #x001f #b1))
(rule (nonLock #x0020 #b1))
(rule (nonLock #x0021 #b1))
(rule (nonLock #x0022 #b1))
(rule (nonLock #xf006 #b1))
(rule (nonLock #x0023 #b1))
(rule (nonLock #xf007 #b1))
(rule (nonLock #x0024 #b1))
(rule (read #x0002 #x0000 #b1))
(rule (read #x0008 #x0001 #b1))
(rule (read #x0013 #x0001 #b1))
(rule (write #x001a #x0001 #b1))
(rule (write #x001c #x0001 #b1))
(rule (dom #x0000 #x0001 #b1))
(rule (dom #x0001 #x0002 #b1))
(rule (dom #x0002 #x0003 #b1))
(rule (dom #x0003 #x0004 #b1))
(rule (dom #x0004 #x0005 #b1))
(rule (dom #x0006 #x0007 #b1))
(rule (dom #x0008 #x0009 #b1))
(rule (dom #x0009 #x000a #b1))
(rule (dom #x000a #x000b #b1))
(rule (dom #x000c #x000d #b1))
(rule (dom #xf000 #x000e #b1))
(rule (dom #x000e #xf001 #b1))
(rule (dom #xf001 #xf002 #b1))
(rule (dom #xf002 #x000f #b1))
(rule (dom #x0005 #x0006 #b1))
(rule (dom #x0005 #x0008 #b1))
(rule (dom #x000b #x000c #b1))
(rule (dom #x000b #xf000 #b1))
(rule (dom #x0010 #x0011 #b1))
(rule (dom #x0011 #x0012 #b1))
(rule (dom #x0012 #x0013 #b1))
(rule (dom #x0013 #x0014 #b1))
(rule (dom #x0014 #x0015 #b1))
(rule (dom #x0015 #xf003 #b1))
(rule (dom #xf003 #x0016 #b1))
(rule (dom #x0016 #x0017 #b1))
(rule (dom #x0017 #x0018 #b1))
(rule (dom #xf004 #x0019 #b1))
(rule (dom #xf005 #x001a #b1))
(rule (dom #x001a #x001b #b1))
(rule (dom #x001b #x001c #b1))
(rule (dom #x001c #x001d #b1))
(rule (dom #x0018 #xf004 #b1))
(rule (dom #x0018 #xf005 #b1))
(rule (dom #x001e #x001f #b1))
(rule (dom #x001f #x0020 #b1))
(rule (dom #x0020 #x0021 #b1))
(rule (dom #x0021 #x0022 #b1))
(rule (dom #x0022 #xf006 #b1))
(rule (dom #xf006 #x0023 #b1))
(rule (dom #x0023 #xf007 #b1))
(rule (dom #xf007 #x0024 #b1))
(rule (postDom #x0001 #x0000 #b1))
(rule (postDom #x0002 #x0001 #b1))
(rule (postDom #x0003 #x0002 #b1))
(rule (postDom #x0004 #x0003 #b1))
(rule (postDom #x0005 #x0004 #b1))
(rule (postDom #x0007 #x0006 #b1))
(rule (postDom #x0009 #x0008 #b1))
(rule (postDom #x000a #x0009 #b1))
(rule (postDom #x000b #x000a #b1))
(rule (postDom #x000d #x000c #b1))
(rule (postDom #x000e #xf000 #b1))
(rule (postDom #xf001 #x000e #b1))
(rule (postDom #xf002 #xf001 #b1))
(rule (postDom #x000f #xf002 #b1))
(rule (postDom #x0011 #x0010 #b1))
(rule (postDom #x0012 #x0011 #b1))
(rule (postDom #x0013 #x0012 #b1))
(rule (postDom #x0014 #x0013 #b1))
(rule (postDom #x0015 #x0014 #b1))
(rule (postDom #xf003 #x0015 #b1))
(rule (postDom #x0016 #xf003 #b1))
(rule (postDom #x0017 #x0016 #b1))
(rule (postDom #x0018 #x0017 #b1))
(rule (postDom #x0019 #xf004 #b1))
(rule (postDom #x001a #xf005 #b1))
(rule (postDom #x001b #x001a #b1))
(rule (postDom #x001c #x001b #b1))
(rule (postDom #x001d #x001c #b1))
(rule (postDom #xf005 #x0018 #b1))
(rule (postDom #xf005 #x0019 #b1))
(rule (postDom #x001f #x001e #b1))
(rule (postDom #x0020 #x001f #b1))
(rule (postDom #x0021 #x0020 #b1))
(rule (postDom #x0022 #x0021 #b1))
(rule (postDom #xf006 #x0022 #b1))
(rule (postDom #x0023 #xf006 #b1))
(rule (postDom #xf007 #x0023 #b1))
(rule (postDom #x0024 #xf007 #b1))
(query p2Notp1Rank1 :print-answer true)
