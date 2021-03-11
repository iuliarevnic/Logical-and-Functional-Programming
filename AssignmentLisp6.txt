;d) Write a function to produce the list of pairs (atom n), where atom appears for n times in the
; parameter list. Example:
; (A B A B A C A) --> ((A 4) (B 2) (C 1))
;unique(e,l1,...,ln)=true, if list is empty
;                    nil, if e=l1
;                    unique(e,l2,...,ln),otherwise

;countOccurences(e,l1,...,ln)=0, if list is empty
;                   1 + countOccurences(e,l2,...,ln), if e=l1
;                   countOccurences(e,l2,...,ln),otherwise

;pairs(l1,...,ln,cl,bl)=nil, if list is empty
;                        (l1,countOccurences(l1,cl)) U pairs(l2,...,ln,cl,bl U l1), if unique(l1,bl)=true
;                       pairs(l2,...,ln,cl,bl),otherwise

;pairswrapper(l1,...,ln)=nil, if l is empty
;                        pairs(l1,...,ln,l1,...,ln,nil),otherwise
(defun unique(e l)
     (cond
         ((null l) t)
         ((equal (car l) e) nil)
         (t (unique e (cdr l)))
     )
)


(defun countOccurences(e l)
     (cond
         ((null l) 0)
         ((equal (car l) e) (+ 1 (countOccurences e (cdr l))))
         (t (countOccurences e (cdr l)))
     )
)

(defun pairs(l cl bl)
     (cond
         ((null l) nil)
         ((unique (car l) bl) (append (list (list (car l) (countOccurences (car l) cl)) ) (pairs (cdr l) cl  (append bl (list (car l))))))
         (t (pairs (cdr l) cl bl))
     )
)

(defun pairswrapper(l)
     (cond
         ((null l) nil)
         (t (pairs l l nil))
     )
)

(print (pairswrapper '(A B A B A C A)))