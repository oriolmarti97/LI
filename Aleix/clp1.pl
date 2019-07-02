:- use_module(library(clpfd)).

% We re-visit the CLP(FD) problem of: "how to place all squares of sizes S1...SN in a square of size Big?"
% But this is much simpler.
% We want to find examples of S1...SN that MIGHT have a solution, that is, such that S1^2  + ... + SN^2  = Big^2.

% Complete p(N,Big) to write a list [S1...SN] such that the
% S1...SN are all different, and S1^2 + ... + SN^2 = Big^2.

% examples:
% ?- p(3,7).
% [2,3,6]
%
% ?- p(19,60).
% [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,22,36]

fits([],0).
fits([V|Vars], R):- fits(Vars, R1), R = R1 + V*V.

p(N,Big):-
    length(Vars,N),
    
    Vars ins 1..Big,    %amb un domini de 0 a Big funciona pero l'auput no es el mateix que el de l'exemple.
    
    all_different(Vars),
    
    fits(Vars, R),
    
    R #= Big*Big,
    
    labeling([ff],Vars),
    
    write(Vars),nl,!.




		    
