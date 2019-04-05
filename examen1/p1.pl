pert(X,[X|_]).
pert(X,[_|L]):- pert(X,L).


numTeams(9).

numPots(3).

teamsInPot(3).

interesting([1,6,3]). % t1, t6 and t3 is an interesting group

interesting([8,2,9]).

interesting([1,4,9]).

interesting([3,7,1]).

interesting([2,4,9]).



team(T):-numTeams(TT),between(1,TT,T).
%Crea un pot vàlid. Rep una llista amb els equips ja utilitzats i ens en dóna una afegint-li els que posa
%El primer element és la quantitat d'equips que volem posar al plot generat
%El segon és el plot resultat
%El tercer són els equips que no podem posar (perquè ja els hem utilitzat)
%El quart són els equips que no PODREM posar (els que ja havíem utilitzat i els que utilitzem ara)
createPot(0,[],U,U).
createPot(I,[T|P],U,[T|UU]):-team(T), \+pert(T,U), II is I-1, createPot(II,P,[T|U],UU).

pots(P1,P2,P3):-teamsInPot(TP),
	createPot(TP,P1,[],U),
	createPot(TP,P2,U,UU),
	createPot(TP,P3,UU,_).
