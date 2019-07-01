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
