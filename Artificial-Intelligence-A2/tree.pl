%Syed Gilani - 500774969
%Shail Patel - 500766622
%Parth Patel - 500588969

replace(X,Y,tree(X,void,void),tree(Y,void,void)).
replace(X,Y,tree(E,void,void),tree(E,void,void)).
replace(X,Y,tree(X,L,void),tree(Y,T3,void)) :- replace(X,Y,L,T3).
replace(X,Y,tree(X,void,R),tree(Y,void,T3)) :- replace(X,Y,R,T3).
replace(X,Y,tree(X,L,R),tree(Y,T3,T4)) :- replace(X,Y,L,T3), replace(X,Y,R,T4).
replace(X,Y,tree(Element,L,void),tree(Element,T3,void)) :- replace(X,Y,L,T3).
replace(X,Y,tree(Element,void,R),tree(Element,void,T3)) :- replace(X,Y,R,T3).
replace(X,Y,tree(Element,L,R),tree(Element,T3,T4)) :- replace(X,Y,L,T3), replace(X,Y,R,T4).


elementOfTree(Element, tree(Root,Le,Ri) ) :- Element=Root.
elementOfTree(Element, tree(Node,Le,Ri) ) :- elementOfTree(Element,Le).
elementOfTree(Element, tree(Node,Le,Ri) ) :- elementOfTree(Element,Ri).

expand(X, Tree1, Tree2) :- elementOfTree(X, Tree1), Tree2 is Tree1.
expand(X, Tree1, Tree2) :- insert(X, Tree1, Tree2).

insert(X,tree(A,L,R),tree(A,LX,R)) :- A > X, insert(X,L,LX).
insert(X,tree(A,L,R),tree(A,L,RX)) :- A < X, insert(X,R,RX).
insert(X,void,tree(X,void,void)).
