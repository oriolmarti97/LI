%% Complete the following well-known prolog scheme to find the fastest way
%% for three missionaries and three cannibals to cross a river from
%% side "a" to side "b".  They only have one boat that can carry at
%% most two people and, for obvious reasons, there can never be, at no
%% side of the river, some missionaries and strictly more cannibals than
%% missionaries.

optimalSolution:- 
    between(0,1000,NumSteps),                   % try for NumSteps=0,1,2,3...
    path( NumSteps,  [a,3,3], [b,0,0],  [[a,3,3]], Path ),
    reverse(Path,ReversedPath),                 % reverse the path to show it in the right order
    write(NumSteps),  write(' '), write(ReversedPath), nl, halt.

path( 0,  S,S, P,P ).
path( NumStepsRemaining,   CurrentState, FinalState, PathUntilNow, TotalPath ):-
    NumStepsRemaining > 0,   NumStepsRemaining1 is NumStepsRemaining-1,
    oneStep( CurrentState, NextState ),
    \+member(NextState,PathUntilNow),
    path( NumStepsRemaining1,   NextState, FinalState, [NextState|PathUntilNow], TotalPath ).


% Note that a state has the form: [BoatSide, NumMissionariesAtSideA, NumCannibalsAtSideA]:
validState( [BoatSide, NumMissionariesAtSideA, NumCannibalsAtSideA] ):-
    member( BoatSide, [a,b] ),
    
    notEaten( NumMissionariesAtSideA, NumCannibalsAtSideA ),!.         

    
oneStep( [a,M,C], [b,M1,C1] ):- M1 is M-2, C1 is C-0, validState( [b,M1,C1] ).
oneStep( [b,M,C], [a,M1,C1] ):- M1 is M+2, C1 is C-0, validState( [a,M1,C1] ).

oneStep( [a,M,C], [b,M1,C1] ):- M1 is M-0, C1 is C-2, validState( [b,M1,C1] ).
oneStep( [b,M,C], [a,M1,C1] ):- M1 is M-0, C1 is C+2, validState( [a,M1,C1] ).

oneStep( [a,M,C], [b,M1,C1] ):- M1 is M-1, C1 is C-1, validState( [b,M1,C1] ).
oneStep( [b,M,C], [a,M1,C1] ):- M1 is M+1, C1 is C+1, validState( [a,M1,C1] ).

oneStep( [a,M,C], [b,M1,C1] ):- M1 is M-0, C1 is C-1, validState( [b,M1,C1] ).
oneStep( [b,M,C], [a,M1,C1] ):- M1 is M-0, C1 is C+1, validState( [a,M1,C1] ).

oneStep( [a,M,C], [b,M1,C1] ):- M1 is M-1, C1 is C-0, validState( [b,M1,C1] ).
oneStep( [a,M,C], [b,M1,C1] ):- M1 is M+1, C1 is C-0, validState( [a,M1,C1] ).


notEaten(0,_).
notEaten(3,_).
notEaten(MA,MA).






