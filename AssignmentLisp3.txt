;10.
; a) Write a function to return the product of all the numerical atoms from a list, at superficial level.
; product(l1,...,ln)= product(l2,...,ln), if l1 is not a numerical atom
;                     1, if l is empty
;                     l1 * product(l2,...,ln), if l1 is a numerical atom
; product(l:list)
;productwrapper(l1,...,ln)=0, if l is empty
;                          product(l1,...,ln), otherwise
;productwrapper(l:list)
(defun product(l)
     (cond
        ((null l) 1)
        ((numberp (car l)) (* (car l) (product (cdr l))))
        (t (product (cdr l)))
     )
)

(defun productwrapper(l)
       (cond
            ((null l) 0)
            (t (product l))
       )
)
(print (productwrapper '(5 7 x 9)))