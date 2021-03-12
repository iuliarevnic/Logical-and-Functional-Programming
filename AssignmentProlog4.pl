%Find all permutations where the absolute value of the difference of two consecutive elements <=3

appendlist([], X, X).
appendlist([H|T], X, [H|L]) :- appendlist(T, X, L).
%flow model(i,i,o)

absValue(X,Y):-X<0,Y is -X.
absValue(X,Y):-X>=0,!,Y is X.

sum3([_],1).
sum3([H1,H2],R):-D is H1-H2,absValue(D,Res),Res=<3,!,R is 1.
sum3([H1,H2|_],R):-D is H1-H2,absValue(D,Res),Res>3,!,R is 0.
sum3([H1,H2,H3|T],R):-D is H1-H2,absValue(D,Res),Res=<3,!,sum3([H2,H3|T],R).

perm([],R):-R=[].
perm([Y],[Y]):-!.
perm([H|T],R):- perm(T, T1), appendlist(L1, L2, T1), appendlist(L1, [H], X1), appendlist(X1, L2, R0),sum3(R0,C),C=:=1,R=R0.
permwrapper(L,R):-findall(L0,perm(L,L0),R).