%Una parella és vàlida sii el primer element acaba amb el que comença el segon
parella_valida([_,X],[X,_]).

%cadena_valida([[_,X],[X,Y]]|L):-cadena_valida([[X,Y]|L]).
cadena_valida([P1,P2|L]):-parella_valida(P1,P2),cadena_valida([P2|L]),!.
cadena_valida([[_,_]]).
cadena_valida([]).

peca_igual(P,P).
peca_igual([X,Y],[Y,X]).

chain([],[]).
chain([P|L],[Q|R]):- peca_igual(P,Q),chain(L,R), cadena_valida([Q|R]).

subcjto([],[]).  %subcjto(L,S) significa "S es un subconjunto de L".
subcjto([X|C],[X|S]):-subcjto(C,S).
subcjto([_|C],S):-subcjto(C,S).

permutacion([],[]).
permutacion(L,[X|P]) :- select(X,L,R), permutacion(R,P).

all_chains(L):-subcjto(L,R), permutacion(R,R2), chain(R2,RR),write(RR),nl,fail.
all_chains(_).
