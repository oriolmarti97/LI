camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
	unPaso( EstadoActual, EstSiguiente ),
	\+member(EstSiguiente,CaminoHastaAhora),
	camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

solucionOptima:-
	nat(N),                        % Buscamos soluci ́on de "coste" 0; si no, de 1, etc.
	camino([a,3,3],[b,0,0],[[a,3,3]],C), % En "misioneros": -un estado es [ladoDelBote,MisionerosEnLadoA,CaníbalesEnLadoA], y
	length(C,N),                   % -el coste es la longitud de C.
	write(C).

estadoValido([Lado,MisionerosA,CanibalesA]):-
	ladoCorrecto(Lado),
	MisionerosA>=0,
	MisionerosA=<3,
	CanibalesA>=0,
	CanibalesA=<3,
	noComidos(MisionerosA,CanibalesA),
	MisionerosB is 3-MisionerosA,
	CanibalesB is 3-CanibalesA,
	noComidos(MisionerosB,CanibalesB).

ladoCorrecto(a). %Los lados pueden ser a o b, y ya está
ladoCorrecto(b).

noComidos(0,_). %Si no hay misioneros no pueden ser comidos
noComidos(M,C):-M>=C.

unPaso([a,M,C],[b,MM,C]):- %Movemos dos misioneros
	MM is M-2,
	estadoValido([b,MM,C]).
unPaso([a,M,C],[b,M,CC]):- %Movemos dos caníbales
	CC is C-2,
	estadoValido([b,M,CC]).
unPaso([a,M,C],[b,MM,CC]):- %Movemos uno de cada
	MM is M+1,
	CC is C+1,
	estadoValido([b,MM,CC]).
unPaso([a,M,C],[b,MM,C]):- %Movemos un misionero
	MM is M-1,
	estadoValido([b,MM,C]).
unPaso([a,M,C],[b,M,CC]):- %Movemos un caníbal
	CC is C-1,
	estadoValido([b,M,CC]).

unPaso([b,M,C],[a,MM,C]):- %Movemos dos misioneros
	MM is M+2,
	estadoValido([a,MM,C]).
unPaso([b,M,C],[a,M,CC]):- %Movemos dos caníbales
	CC is C+2,
	estadoValido([a,M,CC]).
unPaso([b,M,C],[a,MM,CC]):- %Movemos uno de cada
	MM is M+1,
	CC is C+1,
	estadoValido([a,MM,CC]).
unPaso([b,M,C],[a,MM,C]):- %Movemos un misionero
	MM is M+1,
	estadoValido([a,MM,C]).
unPaso([b,M,C],[a,M,CC]):- %Movemos un caníbal
	CC is C+1,
	estadoValido([a,M,CC]).


nat(0).
nat(N):-nat(N1),N is N1+1.

