% Student exercise profile
:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space

% Your program goes here
%baza
parent(beata, krystian).
parent(beata, maja).
parent(beata,wiktor).
parent(krzysztof, krystian).
parent(krzysztof,wiktor).
parent(krzysztof,piotrek).
parent(krzysztof,maja).
parent(alicja,piotrek).
parent(bronek,malgosia).
parent(bronek,krzysztof).
parent(krystyna, krzysztof).
parent(krystyna, malgosia).
parent(malgosia, dawid).
parent(wiktor,iga).
parent(ola,iga).


male(piotrek).
male(wiktor).
male(krystian).
male(krzysztof).
male(dawid).
male(bronek).

person(krystyna).
person(maja).
person(beata).
person(malgosia).
person(ola).


%reguly:
female(X) :-
    \+male(X).
    
father(X,Y) :-
   parent(X,Y),
   male(X),
   X \= Y.
mother(X,Y) :-
    parent(X,Y),
    female(X),
    X \= Y.
daughter(X,Y) :-
    female(X),
    parent(Y,X),
    \+male(X).
brother(X,Y) :-
    male(X),
    father(D,X), father(D,Y),
    mother(M,X), mother(M,Y),
	X \= Y.
sister(X,Y) :-		%na potrzeby zeby bylo latwiej
    female(X),
    father(D,X), father(D,Y),
    mother(M,X), mother(M,Y),
	X\=Y.
step_brother(X, Y) :-
    (
        (father(D, X), father(D, Y), \+ (mother(M, X), mother(M, Y)));
        (mother(M, X), mother(M, Y), \+ (father(D, X), father(D, Y)))
    ),
    X \= Y.
cousin(X, Y) :-
    parent(R, X),
    parent(Q, Y),
    (sister(Q, R); brother(Q, R)),
    Q \= R. % uniknięcie sytuacji, gdy sprawdzamy, czy osoba jest kuzynem samej siebie
grandfather_from_father_site(X,Y) :-
    father(X,D),father(D,Y),
	X\= Y,
	D\=Y,
	X\=D.
grandfather_from_mother_site(X,Y) :-
    father(X,M), mother(M,Y),
	X \= M,
	Y \= M,
	X \= Y.
grandfather(X,Y) :-
    (   grandfather_from_father_site(X,Y);
    grandfather_from_mother_site(X,Y)),
    X \= Y.
grandmother(X,Y) :-
    (   mother(X,D),father(D,Y); mother(X,M),
        mother(M,Y)),
    X \= Y.
granddaughter(X,Y) :-
    female(Y),
    (   grandfather(X,Y);grandmother(X,Y)),
    X \= Y.
ancestor2(X,Y) :-
      (   grandfather(X,Y);grandmother(X,Y);
    	father(X,Y);mother(X,Y)),
    X \= Y.
ancestor3(X,Y) :-
   (    (   father(X,G),grandfather(G,Y);
    mother(X,M),grandfather(M,Y);
    father(X,Q),grandmother(Q,Y);
    mother(X,R),grandmother(R,Y));
    (   grandfather(X,Y);grandmother(X,Y);
    	father(X,Y);mother(X,Y))),
    X \= Y.
    
    



/** <examples> Your example queries go here, e.g.
?- member(X, [cat, mouse]).
*/
