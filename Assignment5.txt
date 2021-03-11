;c) Write a function to compute the result of an arithmetic expression memorised
;in preorder on a stack. Examples:
;(+ 1 3) ==> 4 (1 + 3)
;(+ * 2 4 3) ==> 11 [((2 * 4) + 3)
;(+ * 2 4 - 5 * 2 2) ==> 9 ((2 * 4) + (5 - (2 * 2))
;computeResult(t1,op,t2)=t1+t2, if op="+"
;                        t1*t2, if op="*"
;                        t1-t2, if op="-"
;                        t1/t2, if op="/"
(defun computeResult(t1 op t2)
     (cond
         ((equal op '+) (+ t1 t2))
         ((equal op '*) (* t1 t2))
         ((equal op '-) (- t1 t2))
         ((equal op '/) (/ t1 t2))
     )
)
;preorder(l1,...,ln)=nil, if l is empty
;                    computeResult(l2,l1,l3) U l4,...,ln, if l2 and l3 are numbers, l1 is not
;                    l1 U preorder(l2,....,ln), otherwise
(defun preorder(l)
     (cond
         ((null l) nil)
         ((and (and (not (numberp (car l))) (numberp (cadr l))) (numberp (caddr l))) (append (list (computeResult (cadr l) (car l) (caddr l))) (cdddr l))) ;calculate result
         (t (append (list (car l)) (preorder (cdr l)))) 
     )     
)
;result(l1,...,ln)=0, if l is empty
;                  l1, if n=1
;                  result(preorder(l1,...,ln)),otherwise
(defun result(l)
    (cond
        ((null l) 0)
        ((null (cdr l)) (car l))
        (t (result (preorder l)))
    )
)
(print (result '(+ * 1 3 3)))
(print (result '(+ * 2 4 - 5 * 2 2)))
(print (result '(+ 1 3)))
(print (result '(+ * 2 4 3)))