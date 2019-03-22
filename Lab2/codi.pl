%Predicats auxiliars:
pert(X,[X|_]).
pert(X,[_|L]):-pert(X,L).

concat([],L,L).
concat([X|L1],L2,[X|L]):-concat(L1,L2,L).

pert_con_resto(X,L,R):-concat(L1,[X|L2],L),concat(L1,L2,R).


nat(0).
nat(N):-nat(N1),N1 is N+1.

sum([],0).
sum([X|L],S):-sum(L,S1), S is S1+X.

permutacion([],[]).
permutacion(L,[X|P]):-pert_con_resto(X,L,R),permutacion(R,P).

insertion(X,[],[X]).
insertion(X,[Y|L],[X,Y|L]):-X<Y.
insertion(X,[Y|L],[Y|R]):-insertion(X,L,R).

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
suma_ants(L):-concat(L1,[X|_],L),sum(L1,X),!.
%10
card([],[]).
card([X|L],[[X,N1]|Cr]):-card(L,C), pert_con_resto([X,N],C,Cr),!,N1 is N+1.
card([X|L],[[X,1]|C]):-card(L,C).

card(L):-card(L,C),write(C).

%11
esta_ordenada([]).
esta_ordenada([_]).
esta_ordenada([X,Y|L]):-X=<Y, esta_ordenada([Y|L]),!.

%12

ordenacion(L1,L2):-permutacion(L1,L2),esta_ordenada(L2),!.

%14
insertionsort([],[]).
insertionsort([X|L],R):-insertionsort(L,LL),insertion(X,LL,R).

%16
split([],[],[]).
split([A],[A],[]).
split([A,B|R],[A|Ra],[B|Rb]):-split(R,Ra,Rb).

merge(L,[],L):-!.
merge([],L,L).
merge([X|L1],[Y|L2],[X|L]):-X=<Y,merge(L1,[Y|L2],L).
merge(L1,[Y|L2],[Y|L]):-merge(L1,L2,L).

mergesort([],[]):-!.
mergesort([X],[X]):-!.
mergesort(L,R):-split(L,L1,L2),mergesort(L1,R1),mergesort(L2,R2),merge(R1,R2,R),!.

%17
escriu([]):-write(' '),nl,!.
escriu([X|L]):-write(X),escriu(L).
nmembers(_,0,[]):-!.
nmembers(A,N,[X|S]):-pert(X,A),NN is N-1, nmembers(A,NN,S).

diccionario(A,N):-nmembers(A,N,L),escriu(L),fail.

%18
es_capicua([X|L]):-concat(_,[X],L).
palindromos(L):-permutacion(L,R),es_capicua(R),write(R),fail.
