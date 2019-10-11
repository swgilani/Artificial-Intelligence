
/*
Syed Gilani - 500774969
Shail Patel - 500766622
Parth Patel - 500588969
*/







/*atomic statements*/
at(honda,11,-26).
at(subaru,-3,34).
at(bmw,-22,-19).
at(ford,21,14).

light(green,11,-26).
light(green,-3,34).
light(red,-22,-19).
light(red,21,14).

/* distance between two points using euclidean distance */
distance(X1,Y1,X2,Y2,D) :-
D is sqrt((X2-X1)^2 + (Y2-Y1)^2).

/* the bounds of the lanes */
eastbound(X,Y) :-
X=< -20, X>= -220,
Y=< 0 , Y >= -20.



southbound(X,Y) :-
X =< 0, X >= -20,
Y >= 20, Y =< 220.



northbound(X,Y) :-
X >= 0, X =< 20,
Y =< -20, Y >= -220.
westbound(X,Y) :-
X >= 20, X =< 220,
Y >= 0, Y =< 20.

/*opposite directions of the points */
oppDir(X1,Y1,X2,Y2) :-
eastbound(X1,Y1),
westbound(X2,Y2).

oppDir(X1,Y1,X2,Y2) :-
eastbound(X2,Y2),
westbound(X1,Y1).

oppDir(X1,Y1,X2,Y2) :-
northbound(X1,Y1),
southbound(X2,Y2).

oppDir(X1,Y1,X2,Y2) :-
northbound(X2,Y2),
southbound(X1,Y1).
/* right turns from incoming eastbound */
perpendicDir(X1,Y1,X2,Y2) :-
light(red,X1,Y1),
eastbound(X1,Y1),
\+southbound(X2,Y2).
/*right turns from incoming southbound*/
perpendicDir(X1,Y1,X2,Y2) :-
light(red,X1,Y1),
southbound(X1,Y1),
\+westbound(X2,Y2).
/*right turns from incoming westbound*/
perpendicDir(X1,Y1,X2,Y2) :-
light(red,X1,Y1),
westbound(X1,Y1),
\+northbound(X2,Y2).
/*right turns from incoming northbound*/
perpendicDir(X1,Y1,X2,Y2) :-
light(red,X1,Y1),
northbound(X1,Y1),
\+eastbound(X2,Y2).

/*can drive straight*/
canDriveStraight(Car,X,Y) :-
light(green,X,Y),
at(Car,X,Y).


/*can turn right on a green light*/
canTurnRight(Car,X,Y) :-
light(green,X,Y).
/*can turn right on a red light (if car is westbound)*/
canTurnRight(Car,X,Y) :-
light(red,X,Y),
at(Car,X,Y),
westbound(X,Y),
light(green,X2,Y2),northbound(X2,Y2),
distance(X,Y,X2,Y2,D),
D < 45.
/*can turn right on a red light (if car is northbound)*/
canTurnRight(Car,X,Y) :-
light(red,X,Y),
at(Car,X,Y),
northbound(X,Y),
light(green,X2,Y2),eastbound(X2,Y2),
distance(X,Y,X2,Y2,D),
D < 45.
/*can turn right on a red light (if car is eastbound)*/
canTurnRight(Car,X,Y) :-
light(red,X,Y),
at(Car,X,Y),
eastbound(X,Y),
light(green,X2,Y2),southbound(X2,Y2),
distance(X,Y,X2,Y2,D),
D < 45.
/*can turn right on a red light (if car is southbound)*/
canTurnRight(Car,X,Y) :-
light(red,X,Y),
at(Car,X,Y),
southbound(X,Y),
light(green,X2,Y2),westbound(X2,Y2),
distance(X,Y,X2,Y2,D),
D < 45.

/*can turn left for northbound cars*/
canTurnLeft(Car,X,Y) :-
light(green,X,Y),
northbound(X,Y),
light(green,X2,Y2),southbound(X2,Y2),
distance(X,Y,X2,Y2,D),
D < 80.
/*can turn left for southbound cars*/
canTurnLeft(Car,X,Y) :-
light(green,X,Y),
southbound(X,Y),
light(green,X2,Y2),northbound(X2,Y2),
distance(X,Y,X2,Y2,D),
D < 80.
/*can turn left for eastbound cars*/
canTurnLeft(Car,X,Y) :-
light(green,X,Y),
eastbound(X,Y),
light(green,X2,Y2),westbound(X2,Y2),
distance(X,Y,X2,Y2,D),
D < 80.
/*can turn left for westbound cars*/
canTurnLeft(Car,X,Y) :-
light(green,X,Y),
westbound(X,Y),
light(green,X2,Y2),southbound(X2,Y2),
distance(X,Y,X2,Y2,D),
D < 80.

opposite(X1,Y1,X2,Y2) :- at(Car1,X1,Y1),
at(Car2,X2,Y2).
