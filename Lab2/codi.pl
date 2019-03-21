%Predicats auxiliars:
pert(X,[X|_]).
pert(X,[_|L]):-pert(X,L).

concat([],L,L).
concat([X|L1],[L2],[X|L]):-concat(L1,L2,L).

nat(0).
nat(N):-N1 is N-1,nat(N1).

sum([],0).
sum([X|L],S):-sum(L,S1), S is S1+X.

%Exercicis:
%2
prod([],1).
prod([X|L],Y):-prod(L,Z),Y is X*Z.

%3
pescalar([],[],0).
pescalar([X|L1],[Y|L2],Z):-pescalar(L1,L2,T),Z is T+X*Y.

%4
intersec([],_,[]).
intersec([X|L1],L2,[X|L3]):-pert(X,L2),!,intersec(L1,L2,L3).
intersec([_|L1],L2,L3):-intersec(L1,L2,L3).

union([],L,L).
union([X|L1],L2,L):-pert(X,L2),!,union(L1,L2,L). %Si pertany a L2, ja es posarà 
union([X|L1],L2,[X|L]):-union(L1,L2,L).

%5
ultim(L,X):-concat(_,[X],L).

%invers([],[]).
%invers(L,[X|L1]):-concat(L2,[X],L),invers(L2,L1).
invers([],[]).
invers([X|L1],L):-invers(L1,L2),concat(L2,[X],L).

%6
fib(1,1):-!,true.
fib(2,1):-!,true.
fib(N,F):-
	N>2,
	N1 is N-1,
	N2 is N-2,
	fib(N1,F1),fib(N2,F2), F is F1+F2.

fiblin(1,1,0).
fiblin(N,F1,F2):-
	N>1,
	N1 is N-1,
	fiblin(N1,F2,FF),
	F1 is F2+FF.
fiblin(N,F):-fiblin(N,F,_).

%7
dados(0,0,[]).
dados(P,N,[D|L]):-P>0, N>0, pert(D,[1,2,3,4,5,6]),P1 is P-D, N1 is N-1, dados(P1,N1,L).

%8
suma_demas([]).
suma_demas(L):- sum(L,X), pert(Y,L), X is 2*Y,!.

%9
suma_ants(L):-concat(L1,[X|_],L),suma(L1,X),!.
