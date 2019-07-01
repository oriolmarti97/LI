camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
    unPaso( EstadoActual, EstSiguiente ),
    \+member(EstSiguiente,CaminoHastaAhora),
    camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

solucionOptima:-
    nat(N),
    % Buscamos solución de "coste" 0; si no, de 1, etc.
    camino([0,0],[0,4],[[0,0]],C), % En "hacer aguas": -un estado es [cubo5,cubo8], y
    length(C,N),
    % -el coste es la longitud de C.
    write(C).
    
nat(0).
nat(N) :- nat(N1), N is N1 +1.

unPaso([_,X],[5,X]).    
unPaso([X,_],[X,8]).
unPaso([_,X],[0,X]).
unPaso([X,_],[X,0]).

% 5 -> 8
unPaso([X,Y],[A,B]):- 
    K is min(X,8-Y),
    B is Y + K,
    A is X - K,
    B =< 8,
    A >= 0.
    
% 8 -> 5    
unPaso([X,Y],[A,B]):- 
    K is min(Y,5-X),
    B is Y - K,
    A is X + K,
    B >= 0,
    A =< 5.

