%%%%%%%%%%%%%%%%%%%%
% A) 1)
%%%%%%%%%%%%%%%%%%%%

camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
unPaso( EstadoActual, EstSiguiente ),
\+member(EstSiguiente,CaminoHastaAhora),
camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

nat(0).
nat(N):-
    nat(N1),
    N is N1 + 1.


solucionOptima:-
nat(N),
camino([0,0],[0,4],[[0,0]],C), 
length(C,N),
write(C).

unPaso([A,_],[A,0]).
unPaso([_,B],[0,B]).
unPaso([_,B],[5,B]).
unPaso([A,_],[A,8]).

% abocar A -> B 
unPaso([A,B],[X,Y]):-
    A + B - 8 >= 0, 
    Y is 8,
    X is A + B - 8.    
    
% abocar B -> A
unPaso([A,B],[X,Y]):-
    A + B - 8 >= 0,
    X is 5,
    Y is A + B - 5.
    
% abocar A -> B 
unPaso([A,B],[X,Y]):-
    Y is A + B,
    X is 0,
    Y =< 8.
    
    
% abocar B -> A
unPaso([A,B],[X,Y]):-
    X is B + A,
    Y is 0,
    X =< 5.

%%%%%%%%%%%%%%%%%%%
% A) 2)
%%%%%%%%%%%%%%%%%%%%%

camino( E,E, C,C,_,_).
camino(_,_,_,_,0,_):- !,fail.
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal , P, M):-
    unPaso( EstadoActual, EstSiguiente , M),
    \+member(EstSiguiente,CaminoHastaAhora),
    P1 is P-1,
    camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal , P1, M).


solucionOptima:-
    nat(N),
    camino([0,0],[0,4],[[0,0]],C,N,5),
    write(C).
    
nat(0).
nat(N):-
    nat(N1),
    N is N1 + 1.
    
unPaso([A,B],[X,Y],M):-
    X is A + 2,
    Y is B + 1, 
    X =< M,
    Y =< M.
    
unPaso([A,B],[X,Y],M):-
    X is A - 2,
    Y is B + 1, 
    Y =< M,
    X >= 0.

unPaso([A,B],[X,Y],M):-
    X is A + 2,
    Y is B - 1, 
    X =< M,
    Y >= 0.

unPaso([A,B],[X,Y],_):-
    X is A - 2,
    Y is B - 1,
    X >= 0,
    Y >= 0.
    
unPaso([A,B],[X,Y],M):-
    X is A + 1,
    Y is B + 2, 
    X =< M,
    Y =< M.
    
unPaso([A,B],[X,Y],M):-
    X is A - 1,
    Y is B + 2,
    Y =< M,
    X >= 0.
    
unPaso([A,B],[X,Y],M):-
    X is A + 1,
    Y is B - 2, 
    X =< M,
    Y >= 0.
    
unPaso([A,B],[X,Y],_):-
    X is A - 1,
    Y is B - 2,
    X >= 0,
    Y >= 0.

%%%%%%%%%%%%%
%B)
%%%%%%%%%%%%%%

programa([begin|X]):-
	append(IS,[end],X),
	instrucciones(IS),!.

instrucciones(I):-
	instruccion(I),!.

instrucciones(IS):-
	append(I,X,IS),
	append(J,[;],I),
	instruccion(J),
	instrucciones(X),!.

instruccion([A, =, B, +, C]):-
	variable(A),
	variable(B),
	variable(C),!.

instruccion([if,A,=,B,then,IS,else,ISS,endif]):-
	variable(A),
	variable(B),
	instrucciones(IS),
	instrucciones(ISS),!.

variable(x).
variable(y).
variable(z).
