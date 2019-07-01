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
