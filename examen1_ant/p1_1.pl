%1.- [2.5 points] We use a list like [ [1,4],[4,3],[3,2],[2,1] ] to

%represent a directed graph with edges 1-->4, 4-->3, etc.  Write a

%predicate path(G,N1,N2) that, given a graph G and nodes N1 and N2 of

%G, is satisfied if there is a (directed) path in G from N1 to N2.

%Example:

%?- path([[1,2],[2,3],[3,1],[1,3],[3,4],[4,5],[5,4],[4,6]],1,6).

%true.

%?- path([[1,2],[2,3],[3,1],[1,3],[3,4],[4,5],[5,4],[4,6]],5,1).

%false.

%Hint: the follow program pattern can be completed to obtain a valid

%solution. The built-in predicate select (pert_con_resto) means "X is a

%member of the list L, and R is the list of remaining elements of L".

%path( ,  ,  ):- !.

%path( ,  ,  ):- select( , , ), path( , , ),!.

%Submit a single file named p1.pl (other names will not be accepted!) 

path(_,X,X):-!.
path(G,X,Y):-select([X,Z],G,L),path(L,Z,Y).
