/*

Syed Gilani - 500774969 - section 2
Shail Patel - 500766622 - section 4
Parth Patel - 500588969 - section 4

*/


dig(0).
dig(1).
dig(2).
dig(3).
dig(4).
dig(5).
dig(6).
dig(7).
dig(8).
dig(9).

all_diff([]).
all_diff([H|T]) :- \+(member(H,T)), all_diff(T).

member(N,[N|_L]).
member(N,[_M|L]) :- member(N,L).

solve([G,E,T,B,Y,A,R]) :-
dig(G),dig(E),dig(T),dig(B),dig(Y),dig(A),dig(R),
G > 0, B > 0,
/*Here we are computing the values without interleaving. It finds a value of dig(X) and
starts to test the values below. This method takes long because its pure generate and test. If
the test fails, it has to go all the way back up to the generating step again, and try the entire thing
once again.*/
E is (Y*T) mod 10, Car is (Y*T) // 10,
B is (Y*E+Car) mod 10, Car1 is (Y*E+Car) // 10,
A is (Y*G+Car1) mod 10,
B is (Y*G+Car1) // 10,
T is (B*T) mod 10, Car3 is (B*T) // 10,
E is (B*E+Car3) mod 10, Car4 is (B*E+Car3) // 10,
G is (B*G+Car3) mod 10,
R is (B+T) mod 10, Car5 is (B+T) // 10,
A is (A+E+Car5) mod 10, Car6 is (A+E+Car5) // 10,
E is (B+G+Car6) mod 10,
B is (B+G+Car6) // 10,
all_diff([G,E,T,B,Y,A,R]).


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
