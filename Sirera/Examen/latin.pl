:- use_module(library(clpfd)).

%% Complete the following program latin(Vars) that completes a given Latin
%% square: an NxN matrix, where, as in a Sudoku, ALL rows and columns have ALL
%% the numbers 1..N (but, unlike the sudoku, here there are no 3x3 "blocks").
%% Moreover both diagonals also must have ALL the numbers 1..N (see the example).
%% Example 1 below has two solutions:
%% ?- main.
%%
%% 4 2 1 3 5 
%% 5 1 4 2 3 
%% 2 5 3 1 4 
%% 3 4 2 5 1 
%% 1 3 5 4 2 
%%
%%
%% 5 2 1 3 4 
%% 4 1 5 2 3 
%% 2 4 3 1 5 
%% 3 5 2 4 1 
%% 1 3 4 5 2 
%%
%% true.


example(1,
      [  _,2,_,_,_   ,
         _,_,_,_,_   ,
         _,_,_,_,_   ,
         3,_,_,_,_   ,
         1,3,_,_,2   ] ).


example(2,                      %  Example 2 also has 2 solutions.
      [  _,_,2,_,4,_   ,
         _,1,_,_,_,_   ,
         _,_,_,_,_,2   ,
         3,_,_,_,_,_   ,
         _,_,_,_,_,_   ,
         _,2,_,_,5,_   ] ).


main:- example(1,Vars), latin(Vars), fail.
main.

latin(Vars):-
    length(Vars,NSq),       % NSq should be N^2 for some N
    N is round(sqrt(NSq)),  % square root
    Vars ins 1..N ,          % 1. domains
    squareByRows(Vars,N,SquareByRows),
    constraints(SquareByRows),     
    columnsConstrait(SquareByRows,N),
    diagonals(SquareByRows),       %
    !,                      %
    labeling([ff],Vars),          % 3. labeling
    writeSquare(SquareByRows),nl,nl.


squareByRows([],_,[]) :- !.
squareByRows(L,N,[A|M]):-
    append(A,B,L),
    length(A,N),
    squareByRows(B,N,M).

constraints([]):- !.
constraints([L|Ls]):- 
    all_distinct(L),
    constraints(Ls).

columnsConstrait(_,0):- !.    
columnsConstrait(M,C):-
    getMatrixColumn(M,C,L),
    all_distinct(L),
    C1 is C - 1,
    columnsConstrait(M,C1).

getMatrixColumn([L],C,[A]):-
    nth1(C,L,A),!.
    
getMatrixColumn([L|Ls],C,[A|F]):-
    nth1(C,L,A),
    getMatrixColumn(Ls,C,F).
    
diagonal([L],C,[A]):-
    nth1(C,L,A),!.
    
diagonal([L|Ls],C,[A|F]):-
    nth1(C,L,A),
    C1 is C + 1,
    diagonal(Ls,C1,F).


diagonals( SquareByRows ):-
   diagonal( SquareByRows,  1, D1 ),  all_distinct(D1),
   reverse( SquareByRows,SquareByRows2 ),                      % reverse: reverses a list (built-in swipl predicate)
   diagonal( SquareByRows2,  1, D2 ),  all_distinct(D2),
   !.

%diagonal(SquareByRows,1,D). Given SquareByRows, instantiates D to the list of the diagonal (top-left to bottom-right):
%diagonal([],_,[]):-!.
%diagonal([Row|Ls],N,L):- nth1(N,Row,X),  N1 is N+1,diagonal(Ls,N1,),!.
						   						   

writeSquare(Square):- member(Row,Square), nl, member(N,Row), write(N), write(' '), fail.
writeSquare(_).

