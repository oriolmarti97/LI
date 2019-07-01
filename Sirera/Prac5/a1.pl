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
