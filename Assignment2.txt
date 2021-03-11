;6. Write a function that returns the maximum of numeric atoms in a
;list, at any level.
;maximum(l)=l,if l is empty
;           l,if l is a number
;           -9999, if l is a non numerical atom
;           MAX i=1,n (maximum(li)),if l is a list


;maxwrapper(l)=-9999, if l is empty
;               maximum(l),otherwise
(defun maximum(l)
     (cond
         ((null l) l)
         ((numberp l) l)
         ((atom l) -9999)
         (t (apply #'max (mapcar #' (lambda (e) (maximum e)) l)))
     )
)


(defun maxwrapper(l)
     (cond
         ((null l) -9999)
         (t (maximum l))
     )
)
(print (maxwrapper '(1 2 3 4 5)))
(print (maxwrapper '(B d (4 g (h 8) 9 (7 j)) (j 5 (99 (h 154 f))) j s 1)))
(print (maxwrapper '(1 (A b (15 90 97 G 5) 95) h 99)))