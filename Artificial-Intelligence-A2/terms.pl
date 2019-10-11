%Syed Gilani - 500774969
%Shail Patel - 500766622
%Parth Patel - 500588969

cons([],null).
cons([X|[]],next(Term,null)) :- cons(X,Term).
cons([X|[]],next(X,null)) :- atomic(X).
cons([X|Y],next(X,Term)) :- atomic(X), cons(Y,Term).
cons([X|Y],next(Z,Term)) :- cons(X,Z), cons(Y,Term).
cons([X|[XT|YT]],next(Term,Z)) :- cons(XT,Term), cons(YT,Z).

linked2List(null,[]).
linked2List(next(Term,null),[X|[]]) :- linked2List(Term,X).
linked2List(next(X,null),[X|[]]) :- atomic(X).
linked2List(next(X,Term),[X|Y]) :- atomic(X), linked2List(Term,Y).
linked2List(next(Z,Term),[X|Y]) :- linked2List(Z,X), linked2List(Term,Y).
linked2List(next(Term,Z),[X|[XT|YT]]) :- linked2List(Term,XT), linked2List(Z,YT).
