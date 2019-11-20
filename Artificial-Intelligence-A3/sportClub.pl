/*
Syed Gilani - 500774969 - section 2
Shail Patel - 500766622 - section 4
Parth Patel - 500588969 - section 4
*/

/*OUTPUT FOR THIS FILE

X is cputime, solve(L),  Y is cputime, Z is Y - X.

L = [0, 3, 4, 0, 2, 1],
X = 68901.94954,
Y = 68901.95268,
Z = 0.0031400000007124618



X is cputime, print_solution(L),  Y is cputime, Z is Y - X.

The decision for Arthur is: Not Elected
The decision for Bart is: Treasurer
The decision for Colleen is: Secretary
The decision for Donna is: Not Elected
The decision for Eva is: Vice-president
The decision for Frank is: President
X = 68904.69126,
Y = 68904.69642,
Z = 0.005159999986062758

*/


position(0). /*not elected*/
position(1).  /*president*/
position(2).  /*vice-president*/
position(3).  /*treasurer*/
position(4).  /*secretary*/


/*used to convert the numbers into strings for print_solution predicate */
conversion(0,'Not Elected').
conversion(1,'President').
conversion(2,'Vice-president').
conversion(3,'Treasurer').
conversion(4,'Secretary').


solve([Arthur,Bart,Colleen,Donna,Eva,Frank]) :-
position(Arthur),position(Bart),
/*constrait # 1*/
arthurandbart(Arthur,Bart),
/*constrait # 2*/
Arthur \= 2, Bart \= 2, Bart \= 4,
position(Colleen),position(Frank),
/*constrait # 3*/
\+(incompatible1(Colleen,Bart,Frank)),
position(Eva), position(Donna),
/*constrait # 5 */
\+(incompatible3(Eva,Arthur,Bart)),
/*constrait # 4 */
\+(incompatible2(Donna,Eva)),
\+(incompatible2(Donna,Frank)),
/*constrait # 6 */
condition(Frank,Colleen),
all_diff([Arthur, Bart, Colleen, Donna, Eva, Frank],0).

/*the reason for me to order the constraits in this order is because there is nothing that is being generating without it being
tested right after. Once I have a value, it is immediately being tested, and if test is fail it goes back to the generate stage.
If we generate anything without it being tested right after, we possibly increase the time it takes for the program to run, because
for any case the test fails, it has to go back to the last generated value, and do all the steps again.

*/



/*print solution to print who got elected and who did not */
print_solution(List) :-
    solve([Arthur,Bart,Colleen,Donna,Eva,Frank]),
    conversion(Arthur,A),
    conversion(Bart,B),
    conversion(Colleen,C),
    conversion(Donna,D),
    conversion(Eva,E),
    conversion(Frank,F),
    nl,
    write('The decision for Arthur is: '),write(A),nl,
    write('The decision for Bart is: '),write(B),nl,
    write('The decision for Colleen is: '),write(C),nl,
    write('The decision for Donna is: '),write(D),nl,
    write('The decision for Eva is: '),write(E),nl,
    write('The decision for Frank is: '),write(F),nl.


/*if arthur is not elected, then it is still possible for bart to be elected*/
arthurandbart(Arthur,Bart) :-
Arthur = 0, Bart \= 0.

/*if arthur is elected, then arthur should also be elected since constrait#1: arthur does not want to work without bart */
arthurandbart(Arthur,Bart) :-
Arthur \= 0, Bart \= 0.


/*if arthur is not elected, then it is also possible that bart is not elected */
arthurandbart(Arthur,Bart) :-
Arthur = 0, Bart = 0.


/*constrait #3: it is incompatible for colleen to be elected with bart if frank is not elected */
incompatible1(Colleen,Bart,Frank) :-
    Frank = 0, Colleen \= 0, Bart \= 0.

/*constrait #4: it is incompatible for donna to be elected if eva or frank are also elected */
incompatible2(Donna,EvaandFrank) :-
Donna \= 0, EvaandFrank \= 0.


/* constrait #5: it is incompatible for eva to be elected if both arthur and bart are also elected */
incompatible3(Eva,Arthur,Bart) :-
Eva \= 0, Arthur \= 0, Bart \= 0.


/* constrait#6: if frank is elected as president, then colleen cannot be elected as vice president */
condition(Frank,Colleen) :-
    Frank = 1, Colleen \= 2.
    /* if frank is not elected, then it is still possible for colleen to be elected without any issue */
condition(Frank,Colleen) :-
    Frank = 0, Colleen \= 0.
    /* it is perfectly fine for both frank and colleen to both not be elected. */
condition(Frank,Colleen) :-
    Frank = 0, Colleen = 0.



 /* all the output values must be different, other than 0, and 0 can only occur in list 2 times */
all_diff([], X).
all_diff([0|T], X) :- X < 2, all_diff(T, X+1).
all_diff([H|T], X) :- \+(H = 0), \+(member(H,T)), all_diff(T, X).

member(N,[N|L]).
member(N,[M|L]) :- member(N,L).
