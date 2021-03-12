%6.Generate the list of all arrangements of K elements of a given list.
%Eg:[2,3,4]K=2=>[[2,3],[3,2],[2,4],[4,2],[3,4],[4,3]]
%addElement(l1,...,l2,e)=(e,l1,...,ln)
%                         (l1,addElement(l2,...,ln,e))
%addElement(L:list,E:integer,R:list)
%flow model(i,i,o)
%arrangements(l1,...,ln,k)=arrangements(l2,...,ln,k)
%                          addElement(arrangements(l2,...,ln,k-1),l1),if
%                          k!=1
%                          (l1), if k=1
%arrangements(L:list,K:integer,R:list)
%flow model(i,i,o)
%arrangementswrapper(l1,...,ln,k)=empty list,if l is empty
%                                 (l1), if n=1 and k=1
%                                 U arrangements(l1,...,ln,k), otherwise
% arrangementswrapper(L:list,K:integer,R:list)
% flow model(i,i,o)
addElement(L,E,R):-R=[E|L].
addElement([H|T],E,R):-addElement(T,E,R1),R=[H|R1].

sum([],0).
sum([H|T],R):-R1 is H+R,sum(T,R1).
%findarrangements check if an arrangement has even sum(X,C),mod(C,2)=:=0
arrangements([_|T],K,R):-arrangements(T,K,R).
arrangements([H|T],K,R):-K=\=1, K1 is K-1,arrangements(T,K1,R1),addElement(R1,H,R).
arrangements([H|_],K,R):-K=:=1, R=[H].

arrangementswrapper([],_,[]):-!.
arrangementswrapper([H],1,[H]):-!.
arrangementswrapper(L,K,R):-findall(X,arrangements(L,K,X),R).
