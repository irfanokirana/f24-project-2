;;;;;;;;;;;;;;;;
;; TEST CASES ;;
;;;;;;;;;;;;;;;;

; REMOVE THIS LATER
(load "project-2.lisp")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; EXP -> CNF ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(format t "~%Negative Normal Form~%")
(print (exp->nnf '(not(:iff a b))))
(print (exp->nnf '(:iff a b)))
(print (exp->nnf '(:implies a b)))
(print (exp->nnf '(not(:implies a b))))
(print (exp->nnf '(:xor a b)))
(print (exp->nnf '(not(:xor a b))))
(print (exp->nnf '(not (or a (not b)))))
(print (exp->nnf '(not (and a b))))
(print (exp->nnf '(not (and a b (not c) d))))
(format t "~%")

(format t "~%Conjunctive Normal Form~%")
(print (exp->cnf '(and (not p0) (:iff p1 p3) (:iff p1 p3))))
(print (exp->cnf '(and (not p2) (or p0 p0 p1) (not p2))))
(print (exp->cnf '(:implies (:xor p3 p0) (not p2))))

(print (cnf-p (exp->cnf '(and (not p0) (:iff p1 p3) (:iff p1 p3)))))
(print (cnf-p (exp->cnf '(and (not p2) (or p0 p0 p1) (not p2)))))
(print (cnf-p (exp->cnf '(:implies (:xor p3 p0) (not p2)))))
(format t "~%")

;; ;; Use cnf-p to check if its in proper conjunctive normal form

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; DPLL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (format t "DPLL~%")
;; ;; (or a (and b c))
;; ;;     => (and (or a b) (or a c))

;; (%dist-or-and-1 '(a)
;;                 '(and (or b) (or c)))

;; ;; (or x (and a b c))
;; ;;     => (and (or x a) (or x b) (or x c))

;; (%dist-or-and-1 '(x)
;;                 '(and (or a) (or b) (or c)))

;; ;; (or (or x y) (and b c))
;; ;;      => (and (or x y b) (or x y c))

;; (%dist-or-and-1 '(x y)
;;                 '(and (or b) (or c)))

;; ;; (or (and x y) (and b c))
;; ;;     => (and (or (and x y) b) (or (and x y) c))
;; ;;     => (and (and (or b x) (or b y))
;; ;;             (and (or c x) (or c y)))
;; ;;     => (and (or b x) (or b y) (or c x) (or c y))

;; (%dist-or-and-and '(and (or x) (or y))
;;                   '(and (or b) (or c)))

;; ;; (or (and x y z) (and a b c))
;; ;;     => (and (or x (and a b c))
;; ;;             (or y (and a b c))
;; ;;             (or z (and a b c)))
;; ;;     => (and (and (or x a) (or x b) (or x c))
;; ;;             (and (or y a) (or y b) (or y c))
;; ;;             (and (or z a) (or z b) (or z c)))
;; ;;     => (and (or x a) (or x b) (or x c)
;; ;;             (or y a) (or y b) (or y c)
;; ;;             (or z a) (or z b) (or z c))

;; (%dist-or-and-and '(and (or x) (or y) (or z))
;;                   '(and (or a) (or b) (or c)))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SAT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (format t "SAT~%")
;; (sat-p '(and (not p0) (:iff p1 p3) (:iff p1 p3)))
;; (sat-p '(and (not p2) (or p0 p0 p1) (not p2)))
;; (sat-p '(:implies (:xor p3 p0) (not p2)))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; OFFICE HOURS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(format t "~%OFFICE HOURS TESTS:~%")
;; exp->nnf
(format t "~%exp -> nnf:")
(print (equal '(or (and a (and b (not c))) d ) (exp->nnf '(:implies (:implies a (:implies b c)) d)) ))
(print (equal '(or (and x (not y)) (and (or (not A) B) (not Y))) (exp->nnf '(not (not (not (not (not (not (:implies (:implies x y) (not (:implies (:implies a b) y)))))))))) ) )
(print (equal '(and a (not b) ) (exp->nnf '(not (:implies (not (not (not (not (not (not a)))))) (not (not (not (not (not (not b))))))))) ) )


;; dist or and 1
(format t "~%dist or and 1:")
(print (equal '(and (or a (not z) b) (or a (not z) c d) (or a (not z) e))   (%dist-or-and-1 '(a (not z)) '(and (or b) (or c d) (or e))      )))
(print (equal '(and (or a b) (or a c d) (or a e))   (%dist-or-and-1 '(a) '(and (or b) (or c d) (or e))      )))
(print (equal '(and (or a (not b)) (or a (not b)) (or a (not b)) (or a (not b)) )   (%dist-or-and-1 '(a (not b)) '(and (or) (or) (or) (or) )      )))


;; dist or and and
(format t "~%dist or and and:")
(print (equal '(and (or a (not d)) (or a e) (or a f) (or (not b) (not d)) (or (not b) e) (or (not b) f) (or c (not d)) (or c e) (or c f) )   (%dist-or-and-and '(and (or a) (or (not b)) (or c))    '(and (or (not d)) (or e) (or f))      )))
(print (equal '(and (or (not a) a b c d e f g h i j k) (or b a b c d e f g h i j k) )   (%dist-or-and-and '(and (or (not a)) (or b) ) '(and (or a b c d e f g h i j k))      )))
(print (equal '(and (or a z (not d) i) (or a z e j) (or a z f (not k)) (or (not b) (not x) y (not d) i) (or (not b) (not x) y e j) (or (not b) (not x) y f (not k)) (or c (not d) i) (or c e j) (or c f (not k)) )   (%dist-or-and-and '(and (or a z) (or (not b) (not x) y) (or c))    '(and (or (not d) i) (or e j) (or f (not k)))      )))



;; DPLL
;; (format t "~%DPLL:")
;; (print (equal '(((or (not a) (not b))  (or a (not b)) (or (not a) b)  (or a b) ) (e))     (multiple-value-list ( dpll-unit-propagate '((or e) (or a b) (or (not a) b) (or a (not b)) (or (not a) (not b))) '()   )))    )