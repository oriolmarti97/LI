:-dynamic(varNumber / 3).
symbolicOutput(0).  % set to 1 to see symbolic output only; 0 otherwise.

%% For the first round of a certain football competition, 32 teams
%% should be distributed into 8 different groups. In order to decide
%% the groups a draw takes place. In it, the teams are placed in 4
%% different pots (every pot has 8 teams) and every group is decided
%% by taking one team from each pot. A study has been done in order to
%% know which groups would be considered as interesting from the fans
%% viewpoint. The goal is to decide the pots composition in such a way
%% that that every interesting group is in principle possible in the
%% draw.  Example: if teams are t1,,...,t32 and the 4 pots are
%%
%% POT 1: [t1,t4, t6,t15,t21,t22,t30,t32]
%% POT 2: [t2,t5,t12,t13,t14,t23,t28,t29]
%% POT 3: [t3,t9,t11,t16,t17,t24,t26,t27] 
%% POT 4: [t7,t8,t10,t18,t19,t20,t25,t31]
%%
%% then group [t6,t22,t20,26] is not possible because t6 and t22 are in the same pot
%%      group [t4,t14,t3,t31] is possible


%%%%%%%%%%%%%%%%%%%% input %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numTeams(32).
numPots(4).
teamsInPot(8).

interesting([1,6,3,5]).
interesting([8,2,9,4]).
interesting([12,31,29,14]).
interesting([10,11,30,2]).
interesting([2,19,21,31]).
interesting([4,16,23,19]).
interesting([6,31,10,4]).
interesting([5,8,15,29]).
interesting([23,26,27,28]).
interesting([1,8,23,24]).
interesting([13,21,16,17]).
interesting([4,24,13,32]).
interesting([22,29,21,26]).
interesting([1,30,20,24]).

%%%%%% Some helpful definitions to make the code cleaner:
team(T):- numTeams(N), between(1,N,T).
pot(P):-  numPots(N),  between(1,N,P).
potPosition(I):- teamsInPot(N), between(1,N,I).

%%%%%%  SAT Variables:
% x(T,P,I) means "team T is the I-th team of pot P"
satVariable( x(T,P,I) ):- team(T), pot(P), potPosition(I).

writeClauses:- 
    numTeamsPot,
    eachTeamOnePot,
    allInterestingGroupsPossible,
    true,!.                    % this way you can comment out ANY previous line of writeClauses
writeClauses:- told, nl, write('writeClauses failed!'), nl,nl, halt.

numTeamsPot:-pot(P),teamsInPot(TP),findall(x(T,P,_),team(T),L),exactly(TP,L),fail.
numTeamsPot.

eachTeamOnePot:- team(T), findall(x(T,P,_),pot(P),L), exactly(1,L),fail.
eachTeamOnePot.

pert(X,[X|_]).
pert(X,[_|L]):- pert(X,L).

%Un grup interessant serà possible si per cada pot P només hi ha un equip pertanyent a P
allInterestingGroupsPossible:-interesting(L), pot(P), findall(pert(T,L),x(T,P,_),L), exactly(1,L),fail.
allInterestingGroupsPossible.

%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% show the solution. Here M contains the literals that are true in the model:

displaySol(M):-
    pot(P), write('Pot '), write(P), write(': '),
    findall(T,member(x(T,P,_),M),Teams), write(Teams), nl, fail.
displaySol(_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Everything below is given as a standard library, reusable for solving 
%    with SAT many different problems.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Express that Var is equivalent to the disjunction of Lits:
expressOr( Var, Lits) :- symbolicOutput(1), write( Var ), write(' <--> or('), write(Lits), write(')'), nl, !. 
expressOr( Var, Lits ):- member(Lit,Lits), negate(Lit,NLit), writeClause([ NLit, Var ]), fail.
expressOr( Var, Lits ):- negate(Var,NVar), writeClause([ NVar | Lits ]),!.

% Express that Var is equivalent to the conjunction of Lits:
expressAnd( Var, Lits) :- symbolicOutput(1), write( Var ), write(' <--> and('), write(Lits), write(')'), nl, !. 
expressAnd( Var, Lits):- member(Lit,Lits), negate(Var,NVar), writeClause([ NVar, Lit ]), fail.
expressAnd( Var, Lits):- findall(NLit, (member(Lit,Lits), negate(Lit,NLit)), NLits), writeClause([ Var | NLits]), !.

%%%%%% Cardinality constraints on arbitrary sets of literals Lits:

exactly(K,Lits):- symbolicOutput(1), write( exactly(K,Lits) ), nl, !.
exactly(K,Lits):- atLeast(K,Lits), atMost(K,Lits),!.

atMost(K,Lits):- symbolicOutput(1), write( atMost(K,Lits) ), nl, !.
atMost(K,Lits):-   % l1+...+ln <= k:  in all subsets of size k+1, at least one is false:
	negateAll(Lits,NLits),
	K1 is K+1,    subsetOfSize(K1,NLits,Clause), writeClause(Clause),fail.
atMost(_,_).

atLeast(K,Lits):- symbolicOutput(1), write( atLeast(K,Lits) ), nl, !.
atLeast(K,Lits):-  % l1+...+ln >= k: in all subsets of size n-k+1, at least one is true:
	length(Lits,N),
	K1 is N-K+1,  subsetOfSize(K1, Lits,Clause), writeClause(Clause),fail.
atLeast(_,_).

negateAll( [], [] ).
negateAll( [Lit|Lits], [NLit|NLits] ):- negate(Lit,NLit), negateAll( Lits, NLits ),!.

negate( -Var,  Var):-!.
negate(  Var, -Var):-!.

subsetOfSize(0,_,[]):-!.
subsetOfSize(N,[X|L],[X|S]):- N1 is N-1, length(L,Leng), Leng>=N1, subsetOfSize(N1,L,S).
subsetOfSize(N,[_|L],   S ):-            length(L,Leng), Leng>=N,  subsetOfSize( N,L,S).


%%%%%% main:

main:-  symbolicOutput(1), !, writeClauses, halt.   % print the clauses in symbolic form and halt
main:-  initClauseGeneration,
tell(clauses), writeClauses, told,          % generate the (numeric) SAT clauses and call the solver
tell(header),  writeHeader,  told,
numVars(N), numClauses(C),
write('Generated '), write(C), write(' clauses over '), write(N), write(' variables. '),nl,
shell('cat header clauses > infile.cnf',_),
write('Calling solver....'), nl,
shell('picosat -v -o model infile.cnf', Result),  % if sat: Result=10; if unsat: Result=20.
	treatResult(Result),!.

treatResult(20):- write('Unsatisfiable'), nl, halt.
treatResult(10):- write('Solution found: '), nl, see(model), symbolicModel(M), seen, displaySol(M), nl,nl,halt.
treatResult( _):- write('cnf input error. Wrote anything strange in your cnf?'), nl,nl, halt.
    

initClauseGeneration:-  %initialize all info about variables and clauses:
	retractall(numClauses(   _)),
	retractall(numVars(      _)),
	retractall(varNumber(_,_,_)),
	assert(numClauses( 0 )),
	assert(numVars(    0 )),     !.

writeClause([]):- symbolicOutput(1),!, nl.
writeClause([]):- countClause, write(0), nl.
writeClause([Lit|C]):- w(Lit), writeClause(C),!.
w(-Var):- symbolicOutput(1), satVariable(Var), write(-Var), write(' '),!. 
w( Var):- symbolicOutput(1), satVariable(Var), write( Var), write(' '),!. 
w(-Var):- satVariable(Var),  var2num(Var,N),   write(-), write(N), write(' '),!.
w( Var):- satVariable(Var),  var2num(Var,N),             write(N), write(' '),!.
w( Lit):- told, write('ERROR: generating clause with undeclared variable in literal '), write(Lit), nl,nl, halt.


% given the symbolic variable V, find its variable number N in the SAT solver:
var2num(V,N):- hash_term(V,Key), existsOrCreate(V,Key,N),!.
existsOrCreate(V,Key,N):- varNumber(Key,V,N),!.                            % V already existed with num N
existsOrCreate(V,Key,N):- newVarNumber(N), assert(varNumber(Key,V,N)), !.  % otherwise, introduce new N for V

writeHeader:- numVars(N),numClauses(C), write('p cnf '),write(N), write(' '),write(C),nl.

countClause:-     retract( numClauses(N0) ), N is N0+1, assert( numClauses(N) ),!.
newVarNumber(N):- retract( numVars(   N0) ), N is N0+1, assert(    numVars(N) ),!.

% Getting the symbolic model M from the output file:
symbolicModel(M):- get_code(Char), readWord(Char,W), symbolicModel(M1), addIfPositiveInt(W,M1,M),!.
symbolicModel([]).
addIfPositiveInt(W,L,[Var|L]):- W = [C|_], between(48,57,C), number_codes(N,W), N>0, varNumber(_,Var,N),!.
addIfPositiveInt(_,L,L).
readWord( 99,W):- repeat, get_code(Ch), member(Ch,[-1,10]), !, get_code(Ch1), readWord(Ch1,W),!. % skip line starting w/ c
readWord(115,W):- repeat, get_code(Ch), member(Ch,[-1,10]), !, get_code(Ch1), readWord(Ch1,W),!. % skip line starting w/ s
readWord(-1,_):-!, fail. %end of file
readWord(C,[]):- member(C,[10,32]), !. % newline or white space marks end of word
readWord(Char,[Char|W]):- get_code(Char1), readWord(Char1,W), !.
%========================================================================================
