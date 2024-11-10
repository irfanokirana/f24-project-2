;;;;;;;;;;;;;;;;
;; TEST CASES ;;
;;;;;;;;;;;;;;;;

; REMOVE THIS LATER
(load "project-2.lisp")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; EXP -> CNF ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(format t "Conjunctive Normal Form~%")
(exp->cnf '(and (not p0) (:iff p1 p3) (:iff p1 p3)))
(exp->cnf '(and (not p2) (or p0 p0 p1) (not p2)))
(exp->cnf '(:implies (:xor p3 p0) (not p2)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; DPLL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(format t "DPLL~%")
;; (or a (and b c))
;;     => (and (or a b) (or a c))

(%dist-or-and-1 '(a)
                '(and (or b) (or c)))

;; (or x (and a b c))
;;     => (and (or x a) (or x b) (or x c))

(%dist-or-and-1 '(x)
                '(and (or a) (or b) (or c)))

;; (or (or x y) (and b c))
;;      => (and (or x y b) (or x y c))

(%dist-or-and-1 '(x y)
                '(and (or b) (or c)))

;; (or (and x y) (and b c))
;;     => (and (or (and x y) b) (or (and x y) c))
;;     => (and (and (or b x) (or b y))
;;             (and (or c x) (or c y)))
;;     => (and (or b x) (or b y) (or c x) (or c y))

(%dist-or-and-and '(and (or x) (or y))
                  '(and (or b) (or c)))

;; (or (and x y z) (and a b c))
;;     => (and (or x (and a b c))
;;             (or y (and a b c))
;;             (or z (and a b c)))
;;     => (and (and (or x a) (or x b) (or x c))
;;             (and (or y a) (or y b) (or y c))
;;             (and (or z a) (or z b) (or z c)))
;;     => (and (or x a) (or x b) (or x c)
;;             (or y a) (or y b) (or y c)
;;             (or z a) (or z b) (or z c))

(%dist-or-and-and '(and (or x) (or y) (or z))
                  '(and (or a) (or b) (or c)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SAT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(format t "SAT~%")
(sat-p '(and (not p0) (:iff p1 p3) (:iff p1 p3)))
(sat-p '(and (not p2) (or p0 p0 p1) (not p2)))
(sat-p '(:implies (:xor p3 p0) (not p2)))
