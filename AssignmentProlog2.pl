%9.
% b. Define a predicate to determine the greatest common divisor of all
% numbers from a list.
%
%gcd(l1,l2,...,ln,tempres)= tempres, if l is empty
%                               1,  if l1 is 1
%                               gcd(l2,...,ln,auxi(l1,tempres)),otherwise
%gcd(L:list,T:int,R:int)
%flow model (i,i,o)
%
%auxi(a,b)= b, if a = 0
%            auxi(b%a,a), otherwise
%auxi(A:int,B:int,R:int)
%flow model (i,i,o)
%
% gcdwrapper(l1,l2,...,ln)=gcd(l1,l2,...,ln,0)
% gcdwrapper(L:list,R:int)
% gcdwrapper(i,o)
auxi(A,B,R):-A=0,R=B.
auxi(A,B,R):-A\=0,A1 is mod(B,A),B1 is A,auxi(A1,B1,R).

gcd(L,B,B):-L=[].
gcd(L,_,R):-L=[H|_],H=1,R is 1.
gcd(L,B,R):-L=[H|T],H\=1,auxi(H,B,T1),gcd(T,T1,R).

gcdwrapper(L,R):-gcd(L,0,R).

% a. Insert an element on the position n in a list.
% insertOnPosition(e,l1,l2,...,lm,n)=
%                                      l, if n < 1 or m=0
%                                      l1 U
%                                      insertOnPosition(e,l2,...,lm,n-1),if
%                                      n-1>0
%                                      e U (l1,...,lm),if n-1=0
%
%insertOnPosition(E:int,L:list,N:int,R:list)
%flow model (i,i,i,o)
%
%insertOnPositionWrapper(e,l1,l2,...,lm,o,n)= e, if m=0
%                                             insertOnPosition(e,l1,l2,...,lm,n),if
%                                                        m!=0
%insertOnPositionWrapper(E:int,L:list,N:int,R:list)
%flow model (i,i,i,o)

insertOnPosition(_,L,N,R):-N<1,R=L.
insertOnPosition(_,L,_,R):-L=[],R=[].
insertOnPosition(E,L,N,R1):-N-1>0,L=[H|T],N1 is N-1,insertOnPosition(E,T,N1,R),R1=[H|R].
insertOnPosition(E,L,N,R):-N-1=:=0,R=[E|L].

insertOnPositionWrapper(E,L,_,R):-L=[],R=[E].
insertOnPositionWrapper(E,L,N,R):-L\=[],insertOnPosition(E,L,N,R).
