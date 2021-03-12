%4.
% a. Write a predicate to determine the sum of two numbers written in
% list representation.
%
%concatenate(a1,...,an,b1,...,bm)= b, if a is empty
%                                  a1 U concatenate(a2,...,an,b1,...
%                                            ,bm),otherwise
%
% concatenate(A:list,B:list,C:list)
% flow model (i,i,o)
%
%
%inverse(a1,...,an)=empty list, if a is empty
%                   concatenate(inverse(a2,...,an),(a1)),otherwise
%inverse(A:list,B:list)
%flow model(i,o)
%
%sum(a1,...,an,b1,...,bm,tr)= (mod((b1,tr),10),div((b1,tr),10),if a is empty and m=1
%                             (mod((a1,tr),10),div((a1,tr),10) if b is empty and n=1
%                             mod((b1+tr),10) U sum(a1,...,an,b2,...,bm,div((b1+tr),10)),if a is empty and b has more elements
%                             mod((a1+tr),10) U sum(a2,...,an,b1,...,bm,div((a1+tr),10)),if b is empty and a has more elements
%                             (mod((a1+b1+tr),10),div((a1+b1+tr),10)),if m=n=1
%                             mod((a1+b1+tr),10) U sum(a2,...,an,b2,...,bm,div((a1+b1+tr),10)),otherwise
%
%sum(A:list,B:list,C:list,Tr:integer)
%flow model (i,i,o,i)
%
%
%
%
%sumwrapper(a1,...,an,b1,...,bm)= b, if a is empty
%                                 a, if b is empty
%                                 inverse(sum(inverse(a1,...,an),inverse(b1,...,bm),0)),otherwise
% sumwrapper(A:list,B:list,C:list)
% flow model(i,i,o)



concatenate([],B,B).
concatenate([H|T1],B,[H|T]):-concatenate(T1,B,T).

inverse(L,R):-L=[],R=[].
inverse(L,R):-L=[H|T],inverse(T,R1),concatenate(R1,[H],R).

sum(A,B,C,Tr):-A=[],B=[H],!,Tr1 is div((H+Tr),10),D is mod((H+Tr),10),C=[D,Tr1].
sum(A,B,C,Tr):-B=[],A=[H],!,Tr1 is div((H+Tr),10),D is mod((H+Tr),10),C=[D,Tr1].
sum(A,B,C,Tr):-A=[],B=[H|T],!,Tr1 is div((H+Tr),10),D is mod((H+Tr),10),C=[D|T1],sum(A,T,T1,Tr1).
sum(A,B,C,Tr):-B=[],A=[H|T],!,Tr1 is div((H+Tr),10),D is mod((H+Tr),10),C=[D|T1],sum(T,B,T1,Tr1).
sum([H1],[H2],C,Tr):-!,Tr1 is div((H1+H2+Tr),10),D is mod((H1+H2+Tr),10),C=[D,Tr1].
sum([H1|T1],[H2|T2],C,Tr):-Tr1 is div((H1+H2+Tr),10),D is mod((H1+H2+Tr),10),C=[D|T],sum(T1,T2,T,Tr1).

sumwrapper(A,B,C):-A=[],!,C=B.
sumwrapper(A,B,C):-B=[],!,C=A.
sumwrapper(A,B,C):-inverse(A,A1),inverse(B,B1),sum(A1,B1,C1,0),inverse(C1,C).



%b. For a heterogeneous list, formed from integer numbers and list of digits, write a predicate to compute the
% sum of all numbers represented as sublists.
% Eg.: [1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] => [8, 2, 2].

%sumList(a1,...,an,tempres1,...,tempresn)=tempres, if a is empty
%                           sumList(a2,...,an,sumwrapper((a1),tempres1,...,tempresn)), if a1 is a list
%                           sumList(a2,...,an,tempres1,...,tempresn),otherwise

%sumList(L:list,R:list,Tempres:list)
%flow model (i,o,i)

%sumListwrapper(a1,...,an)= sumList(a1,...,an,())
%sumListwrapper(L:list,R:list)
%flow model (i,o)


sumList([],R,Tempres):-R=Tempres.
sumList([H|T],R,Tempres):- is_list(H),!,sumwrapper(H,Tempres,T1),sumList(T,R,T1).
sumList([H|T],R,Tempres):-sumList(T,R,Tempres).

sumListwrapper(L,R):-sumList(L,R,[]).

%if we have a function which computes the length of a list, write a predicate which counts the sublists which have an odd number of elements
%Len(L,R)
odd([],0).
odd([H|T],C):-is_list(H),Len(H,R),M is mod(R,2),!,M=:=1,C1 is C+1,odd(T,C1).
odd([H|T],C):-is_list(H),Len(H,R),M is mod(R,2),!,M=:=0,odd(T,C).
odd([H|T],C):-odd(T,C).