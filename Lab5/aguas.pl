
nat(0).
nat(N):- nat(N1), N is N1+1.

unPaso([_,X],[5,X]):- X ins 0..8, true. %Omplir el cubell de 5
unPaso([X,_],[X,8]):- X in 0..5. %Omplir el cubell de 8
unPaso([_,X],[0,X]):- X in 0..8. %Buidar el cubell de 5
unPaso([X,_],[X,0]):- X in 0..5. %Buidar el cubell de 8
unPaso([X,Y],[Z,8]):- X in 1..5, Y in 0..8, Z in 0..5, X+Y == Z+8. % Passar el contingut del cubell de 5 al cubell de 8
unPaso([X,Y],[0,T]):- X in 1..5, Y in 0..8, T in 1..8, X+Y == T. % Ídem
unPaso([X,Y],[5,T]):- X in 0..5, Y in 1..8, T in 0..8, X+Y == 5+T, T>=0.
unPaso([X,Y],[Z,0]):- X in 0..5, Y in 1..8, Z in 1..5, X+Y == Z.

camino(E,E, C,C).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
	unPaso( EstadoActual, EstSiguiente ),
	\+member(EstSiguiente,CaminoHastaAhora),
	camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

solucionOptima:-
	nat(N),                        % Buscamos soluci ́on de "coste" 0; si no, de 1, etc.
	camino([0,0],[0,4],[[0,0]],C), % En "hacer aguas": -un estado es [cubo5,cubo8], y
	length(C,N),                   % -el coste es la longitud de C.
	write(C).
