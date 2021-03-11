;b) Write a function to replace the first occurence of an element E in a given list with an other element
;O.
;main(l1,...,ln)=l, if list is empty
;                main(l1) U l2,...,ln, if l1 is a list and E is in l1
;                O U l2,...,ln, if l1 is E
;                l1 U main(l2,...,ln), otherwise
;mymember(e,l1,...,ln)=nil, if l is empty
;                      true, if l1=e
;                      mymember(e,l1) or mymember(e,l2,...,ln), if l1 is a list
;                      mymember(e,l2,...,ln), otherwise
(defun mymember(e l)
     (cond
         ((null l) nil)
         ((equal (car l) e) t)
         ((listp (car l)) (or (mymember e (car l)) (mymember e (cdr l))))
         (t (mymember e (cdr l)))
         ))


(defun main(l)
      (cond
          ((null l) l)
          ((and (listp (car l)) (mymember 'E (car l))) (append (list
(main (car l))) (cdr l)));
          ((equal (car l) 'E) (append (list 'O) (cdr l)))
          (t (append (list (car l)) (main (cdr l))))
      )
)
(print (main '(A B 3 (C E T) E)))
(print (main '(A 3 B (C D (r F E) E) E)))
(print (main '(B D (R 2 3 (D R)) E F)))
(print (main '(F (F S (G 4 2 E) D) E H 4)))
(print (main '(G (4 1 3) R (6 2 (D F) T (S 1 (5 E T) E) G T E) E E E)))
