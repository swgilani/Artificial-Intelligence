
/* Syed Gilani 500774969 Section 02 */





/* FACTS */

/*atomic facts about the blocks on the table */
block(b0).
block(b1).
block(b2).
block(b3).
block(b4).
block(b5).
block(b6).
block(b7).
block(b8).
block(b9).
block(b10).
block(b11).
block(b12).

/* atomic facts about the shape of the blocks */
shape(b0,wedge).
shape(b1,cube).
shape(b2,cube).
shape(b3,cube).
shape(b4,pyramid).
shape(b5,wedge).
shape(b6,cube).
shape(b7,wedge).
shape(b8,pyramid).
shape(b9,cube).
shape(b10,cube).
shape(b11,cube).
shape(b12,wedge).

/* atomic facts about the color of the blocks */
color(b0,blue).
color(b1,black).
color(b2,red).
color(b3,green).
color(b4,yellow).
color(b5,orange).
color(b6,blue).
color(b7,green).
color(b8,red).
color(b9,blue).
color(b10,black).
color(b11,red).
color(b12,purple).

/* atomic facts about the size of the blocks */
size(b0,huge).
size(b1,large).
size(b2,medium).
size(b3,big).
size(b4,small).
size(b5,huge).
size(b6,medium).
size(b7,big).
size(b8,small).
size(b9,large).
size(b10,medium).
size(b11,medium).
size(b12,small).
/* facts about where on the table the blocks are located */
locatedOn(b0,1).
locatedOn(b1,2).
locatedOn(b2,b1).
locatedOn(b3,b2).
locatedOn(b4,b3).
locatedOn(b5,3).
locatedOn(b6,4).
locatedOn(b7,b6).
locatedOn(b8,5).
locatedOn(b9,6).
locatedOn(b10,b9).
locatedOn(b11,b10).
locatedOn(b12,b11).
/* facts about which table section is to the left of which table section */
justLeftOf(1,2).
justLeftOf(2,3).
justLeftOf(3,4).
justLeftOf(4,5).
justLeftOf(5,6).
/* atomic facts about the different table surfaces*/
tableSurface(1).
tableSurface(2).
tableSurface(3).
tableSurface(4).
tableSurface(5).
tableSurface(6).


/* RULES FOR THE BLOCKS */

/*block X is beside block Y, and both blocks are located on the table */
beside(X,Y) :- locatedOn(X,Area), locatedOn(Y,Area2), tableSurface(Area), tableSurface(Area2), Area2 is Area + 1.
beside(X,Y) :- locatedOn(X,Area), locatedOn(Y,Area2),tableSurface(Area), tableSurface(Area2), Area2 is Area - 1.

/* block X is above block Y */
above(X,Y) :- locatedOn(X,Y).
above(X,Y) :- locatedOn(X,Z), above(Z,Y).

/* block X is left of block Y */
leftOf(X,Y) :- locatedOn(X,X1), locatedOn(Y,Y1), justLeftOf(X1,Y1).
leftOf(X,Y) :- locatedOn(X,X1), locatedOn(Z,Z1), justLeftOf(X1,Z1), leftOf(Z,Y).
/* X is higher */
leftOf(X,Y) :- above(X,Z), leftOf(Z,Y).
/*X is lower */
leftOf(X,Y) :- above(Y,Z), leftOf(X,Z).

rightOf(X,Y) :- leftOf(Y,X).

/* B is between X and Y  */
betweenOf(X,B,Y) :- leftOf(B,Y), rightOf(B,X).
betweenOf(X,B,Y):- leftOf(B,X),rightOf(B,Y).


/*LEXICON*/

/* all types of articles in our grammar */
article(a).
article(the).
article(any).
article(an).



/* list of all the common nouns */
common_noun(block,X) :- block(X).
common_noun(wedge,X) :- shape(X,wedge).
common_noun(pyramid,X) :- shape(X, pyramid).
common_noun(cube,X) :- shape(X, cube).
common_noun(table,X) :- locatedOn(Y,X), tableSurface(X).

/* list of all the adjectives */
adjective(big,X) :- size(X,big).
adjective(huge,X) :- size(X,huge).
adjective(large,X) :- size(X,large).
adjective(medium,X) :- size(X,medium).
adjective(small,X) :- size(X,small).
adjective(black,X) :- color(X,black).
adjective(blue,X) :- color(X,blue).
adjective(red,X) :- color(X,red).
adjective(green,X) :- color(X,green).
adjective(yellow,X) :- color(X,yellow).
adjective(orange,X) :- color(X,orange).
adjective(purple,X) :- color(X,purple).

/* list of all the prepositions */
preposition(on,X,Y) :- locatedOn(X,Y).
preposition(above,X,Y) :- block(X), block(Y), above(X,Y).
preposition(below,X,Y) :- block(X), block(Y), above(Y,X).
preposition(beside,X,Y) :- beside(X,Y).
preposition(betweenOf, X,B,Y):-  betweenOf(X,B,Y).


/******************* parser **********************/


what(Words, Ref) :- np(Words,Ref).

/* Noun phrase can be a proper name or can start with an article */

np([Name],Name) :- proper_noun(Name).
/* use the regular parsar given if the the sentence does not start with a 'the' */
np([Art|Rest], Who) :- \+(Art = the), article(Art), np2(Rest, Who).

/* if the noun phrase starts with 'the', it will check the amount of answers returned (using findall predicate), and only states true if
there is only 1 single answer in the array, or the answer array contains all the sections of the table (in that case, theres also only 1 answer) */
np([the|Rest], Who) :- np2(Rest, Who), findall(X, np2(Rest, X), Z),single(Z).
single([Z]).
single([1,2,3,4,5,6]).



/* If a noun phrase starts with an article, then it must be followed
   by another noun phrase that starts either with an adjective
   or with a common noun. */


   np2([Adj|Rest],Who) :- adjective(Adj,Who), np2(Rest, Who).
   np2([Noun|Rest], Who) :- common_noun(Noun, Who), mods(Rest,Who).


/* Modifier(s) provide an additional specific info about nouns.
   Modifier can be a prepositional phrase followed by none, one or more
   additional modifiers.  */

mods([], _).
mods(Words, Who) :-
	appendLists(Start, End, Words),
	prepPhrase(Start, Who),	mods(End, Who).

prepPhrase([Prep|Rest], Who) :-
	preposition(Prep, Who, Ref), np(Rest, Ref).

appendLists([], L, L).
appendLists([H|L1], L2, [H|L3]) :-  appendLists(L1, L2, L3).
