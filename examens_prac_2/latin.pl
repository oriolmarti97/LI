:- use_module(library(clpfd)).

%% Complete the following program latin(Vars) that completes a given Latin
%% square: an NxN matrix, where, as in a Sudoku, ALL rows and columns have ALL
%% the numbers 1..N (but, unlike the sudoku, here there are no 3x3 "blocks").
%% In addition the four corners   A B   must be ordered A<B<C<D (see the example).
%%                                C D 
%% Example 1 below has three solutions (and example 2 has 2 solutions):
%% ?- main.
%%
%% 1 2 5 4 3 
%% 2 4 3 5 1 
%% 5 3 4 1 2 
%% 3 5 1 2 4 
%% 4 1 2 3 5 
%%
%%
%% 1 2 5 4 3 
%% 2 5 3 1 4 
%% 5 3 4 2 1 
%% 3 4 1 5 2 
%% 4 1 2 3 5 
%%
%%
%% 1 2 5 4 3 
%% 5 4 3 1 2 
%% 2 3 4 5 1 
%% 3 5 1 2 4 
%% 4 1 2 3 5 
%%
%% true.


example(1,
      [  _,2,_,_,_   ,
         _,_,_,_,_   ,
         _,_,4,_,_   ,
         3,_,_,_,_   ,
         _,_,_,3,_   ] ).


example(2,
      [  _,_,2,_,4,_   ,
         _,1,_,_,_,_   ,
         _,_,5,4,_,2   ,
         3,_,_,6,_,_   ,
         _,_,_,_,6,_   ,
         _,2,3,_,5,_   ] ).

concat([],L,L).
concat([X|L1],L2,[X|L3]):- concat(L1,L2,L3).

ultim(L,X):- concat(_,[X],L).

main:- example(1,Vars), latin(Vars), fail.
main.

latin(Vars):-
    length(Vars,NSq),       % NSq should be N^2 for some N
    N is round(sqrt(NSq)),  % square root
    Vars ins 1..N ,          
    matrixByRows(Vars, N ,SquareByRows),
    transpose(SquareByRows, SquareByCol),
    constraints(SquareByRows), 
    constraints(SquareByCol),
    corners(SquareByRows),
    !,
    labeling([ff],Vars),
    writeSquare(SquareByRows),nl,nl.


matrixByRows([], _, []).
matrixByRows(L,N,[A|M]):-
    append(A,B,L),
    length(A,N),
    matrixByRows(B,N,M).

constraints([]).
constraints([X|S]):- all_distinct(X), constraints(S).

corners([X|L]):- ultim(L,Y), cornersBy(X,Y).

cornersBy([X|L], [Y|M]):- ultim(L,W), ultim(M,Q),  X #< W, Y #< Q, W #< Y.

writeSquare(Square):- member(Row,Square), nl, member(N,Row), write(N), write(' '), fail.
writeSquare(_).

