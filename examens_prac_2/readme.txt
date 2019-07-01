


You have to submit 3 independent files with EXACTLY the following names (NO zip, etc.).

horaris.pl
tsp.pl
latin.pl



horaris.pl:

Modify your horaris.pl class exercise solution as follows
(or re-do from scratch from the original exercise horaris.pl given here):
Instead of minimizing the number of professors, now you can use at
most 6 professors and you must find a schedule that minimizes the
number of professors that teach courses from different years.

Also modify displaySol adding somewhere the following lines in order to show AT
THE END of displaySol the number of professors teaching in different years.

displaySol(M):-
    findall(P, (professor(P),hasDiffYears(P,M)), L),  length(L,N),
    nl,nl,write('There are '), write(N), write(' professors teaching in different years.'), nl,nl,fail.

hasDiffYears(P,M):-
    courseYear(C1,Y1), courseYear(C2,Y2), Y1 \= Y2,
    member(cp(C1,P),M),
    member(cp(C2,P),M),!.




tsp.pl:

Modify the program in order to drop the requirement of starting in
city 1. Now it does not matter any more in what cities the trip starts and ends.
For N=11 it should write: Optimal route: [8,2,6,9,1,5,10,3,4,7,11]. 508 km.
No need to optimize your code.


latin.pl:

Complete as indicated in the source file.




