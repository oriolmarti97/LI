camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
    unPaso( EstadoActual, EstSiguiente ),
    \+member(EstSiguiente,CaminoHastaAhora),
    camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

solucionOptima:-
    nat(N),
    % Buscamos solución de "coste" 0; si no, de 1, etc.
    camino([[3,3],[0,0]],[[0,0],[3,3]],[[[3,3],[0,0]]],C),
    length(C,N),
    write(C).
    
nat(0).
nat(N) :- nat(N1), N is N1 + 1.

notEaten([0,_]).
notEaten([A,B]):-
    B =< A.

checkState([[X,K],[Y,Q]]):-
    notEaten([X,K]),
    notEaten([Y,Q]),
    X >= 0, K >= 0, Y >= 0, Q >= 0,
    X =< 3, K =< 3, Y =< 3, Q =< 3. 

unPaso([[X,A],[Y,B]],[[X,K],[Y,Q]]):-
    K is A-1,
    Q is B+1,
    checkState([[X,K],[Y,Q]]).
    
unPaso([[X,A],[Y,B]],[[X,K],[Y,Q]]):-
    K is A-2,
    Q is B+2,
    checkState([[X,K],[Y,Q]]).
    
unPaso([[X,A],[Y,B]],[[K,A],[Q,B]]):-
    K is X-1,
    Q is Y+1,
    checkState([[K,A],[Q,B]]).
    
unPaso([[X,A],[Y,B]],[[K,A],[Q,B]]):-
    K is X-2,
    Q is Y+2,
    checkState([[K,A],[Q,B]]).
    

unPaso([[X,A],[Y,B]],[[X,K],[Y,Q]]):-
    K is A+1,
    Q is B-1,
    checkState([[X,K],[Y,Q]]).
    
unPaso([[X,A],[Y,B]],[[X,K],[Y,Q]]):-
    K is A+2,
    Q is B-2,
    checkState([[X,K],[Y,Q]]).
    
unPaso([[X,A],[Y,B]],[[K,A],[Q,B]]):-
    K is X+1,
    Q is Y-1,
    checkState([[K,A],[Q,B]]).
    
unPaso([[X,A],[Y,B]],[[K,A],[Q,B]]):-
    K is X+2,
    Q is Y-2,
    checkState([[K,A],[Q,B]]).
    



