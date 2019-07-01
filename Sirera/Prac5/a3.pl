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
