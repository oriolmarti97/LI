%2.- [2.5 points] In 2-SAT, a clause like \+3 v 4 can be seen as two

%different implications: 3 --> 4 and \+4 --> \+3.

%Using this idea, from a set of two-literal clauses S, we can create a

%directed graph G: for each clause lit1 v lit2 of S, the graph G gets

%the two edges \+lit1 --> lit2 and \+lit2 --> lit1.

%It is well known that then S is satisfiable iff there is no cycle in G

%containing some variable x and its negation \+x (i.e. a path from x to

%\+x and another path from \+x to x)

%2-SAT: Given a set of two-literal clauses S with variables numbered

%1..N, represented by a list such as [ [\+3,4],[8,\+2],...] to indicate

%clauses \+3 v 4, 8 v \+2, ... write a predicate sat(N,S) that tells us

%whether S is satisfiable.

%Example:

%?- sat(6,[[\+1,2],[\+2,3],[\+4,\+6],[\+2,\+4],[4,5],[\+6,1],[\+5,\+2],[2,1]]).

%false.

%?- sat(6,[[\+1,2],[\+2,3],[\+4,\+6],[4,5],[\+6,1],[\+5,\+2],[2,1]]).

%true.

%Hint:  The follow program pattern can be completed

%to obtain a valid solution.

% Should be used to negate literals

%negate(\+X,X):-!.

%negate(X,\+X).

%sat(N,S):-

   %findall(       ,     , G1 ),

   %findall(       ,     , G2 ),  append(G1,G2,G),

   %\+badCycle(N,G).

%badCycle(N,G):- .....

%Submit a single file named p2.pl (other names will not be accepted!) 

negate(\+X,X):-!.
 
negate(X,\+X).
 
sat(N,S):-
    between(1,N,A),
    findall(A,S, G1 ),
    negate(A,A2),
    findall(A2,S, G2 ),  append(G1,G2,G),
 
    \+badCycle(N,G).
 
badCycle(N,G):-between(1,N,X) ,negate(X,XX), path(G,X,XX).

path(_,X,X):-!.
path(G,X,Y):-select([X,Z],G,L),path(L,Z,Y).
