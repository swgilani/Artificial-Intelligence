/*

Syed Gilani - 500774969 - section 2
Shail Patel - 500766622 - section 4
Parth Patel - 500588969 - section 4

*/


dig(2).
dig(3).
dig(4).
dig(5).
dig(6).
dig(7).
dig(8).
dig(9).
car(0).
car(1).
all_diff([]).
all_diff([H|T]) :- \+member2(H,T), all_diff(T).

member2(N, [N|L]).
member2(N, [M|L]) :- member2(N,L).


/*this is more effective because we are doing the addition part of the multiplication, and then doing the multiplication part */
/* we are basically going in the opposite directions, and guessing the values of the answers, and then verifying the values and carrys that come before it */
/* this is more effective because we don't have to keep guessing values and proceeding, only to find out that our values don't match, therefore
the prolog backtracking to its initial guessing values and doing the entire operations again */

solve([G,E,T,B,Y,A,R]) :-
car(B), B > 0, car(C100), dig(G), G > 0,    /*Guess B and G, and then calculate E */
B is (B+G+C100) // 10, E is (B+G+C100) mod 10,
dig(A), car(C10),                             /*Guess A and then calculate O */
A is (A+E+C10) mod 10, C100 is (A+E+C10) // 10,
dig(T), car(C1),
R is (B+T) mod 10, C10 is (B+T) // 10,     /*Guess T, and then verify choice for B*/
dig(Y),
E is (Y*T) mod 10, Car is (Y*T) // 10,     /*Verify choices for E, B, and A*/
B is (Y*E+Car) mod 10, Car1 is (Y*E+Car) // 10,
A is (Y*G+Car1) mod 10,
B is (Y*G+Car1) // 10,
all_diff([G,E,T,B,Y,A,R]).


/*used to print the solution in a way its easy to read */
print_solution(List) :-
  solve([G,E,T,B,Y,A,R]),
  nl,
  write(' '),write(' '),
  write(' '),write(' '),
  write(G),write(E),write(T),nl,
  write('*'),write(' '),
  write(' '),write(' '),
  write(' '),write(B),write(Y),nl,
  write('-'),write('-'),write('-'),
  write('-'),write('-'),write('-'),write('-'),write('-'),
  nl,
  write(' '),write(' '),write(' '),write(B),write(A),write(B),
  write(E),nl,
  write(' '),write('+'),write(' '),write(G),write(E),write(T),nl,
  write('-'),write('-'),write('-'),
  write('-'),write('-'),write('-'),write('-'),write('-'),
  nl,write(' '),write(' '),write(B),write(E),write(A),
  write(R),write(E),nl.
