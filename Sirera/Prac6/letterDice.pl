:- use_module(library(clpfd)).

%% A (6-sided) "letter dice" has on each side a different letter.
%% Find four of them, with the 24 letters abcdefghijklmnoprstuvwxy such
%% that you can make all the following words: bake, onyx, echo, oval,
%% gird, smug, jump, torn, luck, viny, lush, wrap.

%Some helpful predicates:

word( [b,a,k,e] ).
word( [o,n,y,x] ).
word( [e,c,h,o] ).
word( [o,v,a,l] ).
word( [g,i,r,d] ).
word( [s,m,u,g] ).
word( [j,u,m,p] ).
word( [t,o,r,n] ).
word( [l,u,c,k] ).
word( [v,i,n,y] ).
word( [l,u,s,h] ).
word( [w,r,a,p] ).

num(X,N):- nth1( N, [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,r,s,t,u,v,w,x,y], X ).

main:-
    length(D1,6),
    length(D2,6),
    length(D3,6),
    length(D4,6),
    
        
    D1 ins 1..24,
    D2 ins 1..24,
    D3 ins 1..24,
    D4 ins 1..24,
        
    append(D1,D2,DL),
    append(D3,D4,DD),
    append(DL,DD,L),
    all_different(L),    

    genera_parells_en_daus_diferents(P), %% P =  [ [2,1],[2,8],...]
    
    parells_no_en_dau(P,D1),
    parells_no_en_dau(P,D2),
    parells_no_en_dau(P,D3),
    parells_no_en_dau(P,D4),
     
    labeling([ff],L),
    
    writeN(D1), 
    writeN(D2), 
    writeN(D3), 
    writeN(D4), halt.
    

writeN(D):- findall(X,(member(N,D),num(X,N)),L), write(L), nl, !.

genera_parells_en_daus_diferents(P):-
    findall([X,Y],(word(L),member(X1,L),member(Y1,L),num(Y1,Y),num(X1,X),X<Y),P).
    %findall([X,Y],(word(L),member(X,L),member(Y,L),X\=Y),P).
    
parells_no_en_dau([],_).
parells_no_en_dau([[X,Y]|P],[A,B,C,D,E,F]):-
    ((A #= X) #==> (B #\= Y) #/\ (C #\= Y) #/\ (D #\= Y) #/\ (E #\= Y) #/\ (F #\= Y)),
    
    ((B #= X) #==> (A #\= Y) #/\ (C #\= Y) #/\ (D #\= Y) #/\ (E #\= Y) #/\ (F #\= Y)),
    
    ((C #= X) #==> (B #\= Y) #/\ (A #\= Y) #/\ (D #\= Y) #/\ (E #\= Y) #/\ (F #\= Y)),
    
    ((D #= X) #==> (B #\= Y) #/\ (C #\= Y) #/\ (A #\= Y) #/\ (E #\= Y) #/\ (F #\= Y)),
    
    ((E #= X) #==> (B #\= Y) #/\ (C #\= Y) #/\ (D #\= Y) #/\ (A #\= Y) #/\ (F #\= Y)),
    
    ((F #= X) #==> (B #\= Y) #/\ (C #\= Y) #/\ (D #\= Y) #/\ (E #\= Y) #/\ (A #\= Y)),
    
    parells_no_en_dau(P,[A,B,C,D,E,F]).


