%Syed Gilani - 500774969
%Shail Patel - 500766622
%Parth Patel - 500588969


count([],0).
count([H|Tail], N) :- count(Tail, N1), N is N1 + 1.

add(0,InputList, []).

add(N,InputList,OutputList) :-
length(InputList,InputListSize),
N \= 0,
N >= InputListSize, append(InputList,[], OutputList).

add(N,InputList,OutputList) :-
    N \= 0,
    length(OutputList, N),
    append(OutputList, AnyList,InputList).






dictionary([zero],[0]).
dictionary([one],[1]).
dictionary([two],[2]).
dictionary([three],[3]).
dictionary([four],[4]).
dictionary([five],[5]).
dictionary([six],[6]).
dictionary([seven],[7]).
dictionary([eight],[8]).
dictionary([nine],[9]).
dictionary([ten],[10]).

convert([],[]).

convert([H],[T]) :-
    dictionary([H],[T]).

convert([H|T],[H2|T2]) :-
    dictionary([H],[Element]),
    H2 is Element,
    convert(T,T2).



grep(E,List,Occ) :-
    grep_index(E, List, Occ, 1),
    Occ \= [].

grep_index(E, [H|T], Occ, I) :-
     H \= E,
    I1 is I + 1,
    grep_index(E, T, Occ, I1).

grep_index(E, [E|T], [I|Occ], I) :-
    I1 is I + 1,
    grep_index(E, T, Occ, I1).

grep_index(Anything, [], [], Anything2).
