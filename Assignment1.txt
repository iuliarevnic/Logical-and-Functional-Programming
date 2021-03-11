;9. Convert a tree of type (1) to type (2)
;(A 2 B 0 C 2 D 0 E 0) (1)
;(A (B) (C (D) (E))) (2)
;parseLeft(l1,...,ln,nv,nm)=(), if l is empty
;                           (), if nv=nm+1
;                           l1 U l2 U parseLeft(l3,...,ln,nv+1,nm+l2), otherwise
;left(l1,...,ln)=parseLeft(l3,...,ln,0,0)
;parseRight(l1,...,ln,nv,nm)=(), if l is empty
;                            l1,...,ln, if nv=nm+1
;                            parseRight(l3,...,ln,nv+1,nm+l2),otherwise
;right(l1,...,ln)=parseRight(l3,...,ln,0,0)
;main(l1,...,ln)=(), if l is empty
;                l1, if l2is 0
;                l1 U l3, if l2is 1
;                l1 U main(left(l1,...,ln)) U main(right(l1,...,ln)), if l2 is a number and l2is 2
;                l1,....,ln, otherwise
(defun parseLeft(l nv nm)
   (cond
      ((null l) l)
      ((= nv (+ 1 nm)) nil)
      (t (append (list (car l)) (list (cadr l)) (parseLeft (cddr l) (+ 1 nv) (+ (cadr l) nm))))
   )
)
(defun left(l)
 (parseLeft (cddr l) 0 0)
)
;(print (left '(a 2 b 2 c 1 i 0 f 1 g 0 d 2 e 0 h 0)))

(defun parseRight(l nv nm)
    (cond
        ((null l) l)
        ((= nv (+ 1 nm)) l)
        (t (parseRight (cddr l) (+ 1 nv) (+ (cadr l) nm)))
    )
)    

(defun right(l)
   (parseRight (cddr l) 0 0)
)    

;(print (right ' (a 2 b 2 c 1 i 0 f 1 g 0 d 2 e 0 h 0) ))          

 (defun main(l)
    (cond
        ((null l) l)
        ((equal (cadr l) 0) (list(car l)))
        ((equal (cadr l) 1) (append (list (car l)) (list (main (left l)))))
        ((and (numberp (cadr l)) (equal (cadr l) 2)) (append (list (car l)) (list (main (left l))) (list (main (right l)))))
        (t l)
    )
 )


(print (main '(A 2 B 0 C 2 D 0 E 0)))
(print (main '(a 2 b 2 c 1 i 0 f 1 g 0 d 2 e 0 h 0)))