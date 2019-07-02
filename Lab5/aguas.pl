camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
	unPaso( EstadoActual, EstSiguiente ),
	\+member(EstSiguiente,CaminoHastaAhora),
	camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

solucionOptima:-
	nat(N),                        % Buscamos soluci ́on de "coste" 0; si no, de 1, etc.
	camino([0,0],[0,4],[[0,0]],C), % En "hacer aguas": -un estado es [cubo5,cubo8], y
	length(C,N),                   % -el coste es la longitud de C.
	write(C).

unPaso([_,Y],[0,Y]). %Buidar galledes
unPaso([X,_],[X,0]).
unPaso([_,Y],[5,Y]). %Omplir galledes
unPaso([X,_],[X,8]).

unPaso([X,Y],[5,Z]):- %Traspassem tanta aigua com sigui possible del cubell de 8 al de 5
	X+Y-5>=0,
	Z is X+Y-5.
unPaso([X,Y],[Z,8]):- %Al revés que l'anterior
	X+Y-8>=0,
	Z is X+Y-8.

unPaso([X,Y],[0,Z]):-
	Z is X+Y,
	Z =<8.
unPaso([X,Y],[Z,0]):-
	Z is X+Y,
	Z=<8.

nat(0).
nat(N):-nat(N1),N is N1+1.

