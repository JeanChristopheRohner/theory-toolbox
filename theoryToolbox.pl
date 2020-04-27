% -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% INFO

% Theory Toolbox 1.0 beta.
% © Jean-Christophe Rohner 2020
% This is experimental software. Use at your own risk.


% -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% SETUP

:- use_module(library(clpr)).
:- op(1200, xfx, ⇐).
:- op(1000, xfy, ∧).
:- op(1100, xfy, ∨).
:- op(900, fy, ¬).
term_expansion(A ⇐ B, A:- B).
goal_expansion(A ∧ B, (A, B)).
goal_expansion(A ∨ B, (A; B)).


% -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% PROVABLE

% provable(GOAL, INPUT, RESULT). Query if GOAL is provable given INPUT and return the answer in RESULT. 
% GOAL should be a compound term where any argument can be a constant, a variable or an anonymous variable.
% INPUT should be a list of zero or more compound terms.
% RESULT is the returned answer.

% showProvable(RESULT). Prints the RESULT obtained from provable(GOAL, INPUT, RESULT) to the console.

% Usage examples:
% aimaExample.pl 
% collinsQuillianExample.pl
% genealogyExample.pl
% planningExample.pl
% substanceMisuseExample.pl
% substanceMisuseExample+.pl

provable(G, I, G):- provable0(G, I).

provable0(true, _):- !.
provable0((G1, G2), I):- !, provable0(G1, I), provable0(G2, I).
provable0((G1; G2), I):- !, (provable0(G1, I); provable0(G2, I)).
provable0(G, _):- G = {_}, !, call(G).
provable0(G, _):- predicate_property(G, built_in), !, call(G).
provable0(G, I):- G = ¬(G0), \+provable0(G0, I).
provable0(G, I):- copy_term(I, I1), member(G, I1).
provable0(H, I):- clause(H, Body), provable0(Body, I).

showProvable(G):- copy_term_nat(G, G1), numbervars(G1, 0, _, [attvar(bind)]), writeln(G1).


% -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% PROVE

% prove(GOAL, INPUT, PROOF). Find a PROOF for GOAL given INPUT.
% GOAL should be a compound term where any argument can be a constant, variable or anonymous variable.
% INPUT should be a list of zero or more compound terms.
% PROOF is the resulting proof.

% showProof(PROOF). Prints the PROOF obtained from prove(GOAL, INPUT, PROOF) to the console.

% Usage examples:
% aimaExample.pl
% emotionExample.pl
% genealogyExample.pl
% influenceExample.pl
% substanceMisuseExample.pl
% substanceMisuseExample+.pl

prove(true, _, true):- !.
prove((G1, G2), I, (P1, P2)):- !, prove(G1, I, P1), prove(G2, I, P2).
prove((G1; G2), I, (P1; P2)):- !, (prove(G1, I, P1); prove(G2, I, P2)).
prove(G, _, P):- G = {_}, !, call(G), P = subproof(G, true).
prove(G, _, P):- predicate_property(G, built_in), !, call(G), P = subproof(G, true).
prove(G, I, P):- G = ¬(G0), \+prove(G0, I, _), P = subproof(G, true).
prove(G, I, P):- copy_term(I, I1), member(G, I1), P = subproof(G, true).
prove(H, I, subproof(H, Subproof)):- clause(H, Body), prove(Body, I, Subproof).

showProof0(X, SUB):- X = subproof(G, P), P \= true, writeNTabs(SUB), format('~w~w~n', [G, ' ⇐']), SUB1 is SUB + 1, showProof0(P, SUB1).
showProof0(X, SUB):- X = ','(A, B), A \= true, B \= true, showProof0(A, SUB), showProof0(B, SUB).
showProof0(X, SUB):- X = ';'(A, _), A \= true, showProof0(A, SUB).
showProof0(X, SUB):- X = ';'(_, B), B \= true, showProof0(B, SUB).
showProof0(X, SUB):- X = subproof(G, true), writeNTabs(SUB), format('~w~w~n', [G, ' ⇐ true']).

showProof(P):- copy_term_nat(P, P1), numbervars(P1, 0, _, [attvar(bind)]), nl, writeln('PROOF'), showProof0(P1, 0).


% -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% MAXVALUE

% maxValue(X, GOAL, INPUT). Find GOAL given INPUT such that the argument X in GOAL is as high as possible.
% X is the returned maximum value
% GOAL should be a compound term where any argument can be a constant, variable or anonymous variable, and  where the argument X holds a numerical value.
% INPUT should be a list of zero or more compound terms.

% showMaxValue(GOAL, INPUT). Prints the results obtained from maxValue(X, GOAL, INPUT) to the console.

% Usage examples:
% emotionExample.pl
% influenceExample.pl
% planningExample.pl
% substanceMisuseExample.pl

maxValue(Y, G, I):-
	findall(
    	Y,
      	provable0(G, I),
      	L
   ),
   max_list(L, MAXY),
   Y = MAXY.

showMaxValue(G, I):-
   prove(G, I, P),
   copy_term_nat(P, P1), numbervars(P1, 0, _, [attvar(bind)]),
   nl, writeln('MAX VALUE (PROOF)'),
   showProof0(P1, 0).


% -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% MINVALUE

% minValue(X, GOAL, INPUT). Find GOAL given INPUT such that the argument X in GOAL is as low as possible.
% X is the returned minimum value
% GOAL should be a compound term where any argument can be a constant, variable or anonymous variable, and where the argument X holds a numerical value.
% INPUT should be a list of zero or more compound terms.

% showMMinValue(GOAL, INPUT). Prints the results obtained from maxValue(X, GOAL, INPUT) to the console.

% Usage examples:
% planningExample.pl
% substanceMisuseExample.pl

minValue(Y, G, I):-
   	findall(
    	Y,
      	provable0(G, I),
      	L
   ),
   min_list(L, MINY),
   Y = MINY.

showMinValue(G, I):-
   prove(G, I, P),
   copy_term_nat(P, P1), numbervars(P1, 0, _, [attvar(bind)]),
   nl, writeln('MIN VALUE (PROOF)'),
   showProof0(P1, 0).


% -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% INCOHERENCE

% incoherence(INPUT, GOAL1, GOAL2, THRESHOLD, X1, X2). Check if GOAL1 and GOAL2 differ with respect to their numerical values X1 and X2, more than THRESHOLD given INPUT.
% INPUT should be a list of zero or more compounds.
% GOAL1 and GOAL2 should be compound terms that each contain a variable which can be instantiated with a number; for example X1 and X2, respectively.
% THRESHOLD should be a number (integer or real).
% X1 and X2 are the variables that hold numbers in GOAL1 and GOAL2.

% showIncoherence(INPUT, GOAL1, GOAL2, THRESHOLD, X1, X2). Print the results obtained from incoherence(INPUT, GOAL1, GOAL2, THRESHOLD, X1, X2) to the console.

% Usage examples:
% phobiaExample.pl

incoherence(I, G1, G2, T, X1, X2):-
	provable0(G1, I),
	provable0(G2, I),
	{abs(X1 - X2) > T}, !.
incoherence(I, G1, G2, T, X1, X2):-
	provable0(G1, I),
	provable0(G2, I),
	{abs(X1 - X2) =< T}.

showIncoherence(I, G1, G2, T, X1, X2):- 
	{abs(X1 - X2) > T},
	nl,
	writeln('INCOHERENCE'), nl,
	copy_term_nat(I, I1), numbervars(I1, 0, _, [attvar(bind)]),
	writeln('Given inputs:'), maplist(writeln, I1), nl,
	write('These goals are incoherent at the threshold '), write(T), writeln('.'), nl,
	writeln('PROOFS'), nl,
	prove(G1, I, P1), 
	prove(G2, I, P2),
	copy_term_nat(P1, P12), numbervars(P12, 0, _, [attvar(bind)]),
	copy_term_nat(P2, P22), numbervars(P22, 0, _, [attvar(bind)]),
	showProof0(P12, 0),
	nl,
	showProof0(P22, 0),
	nl, nl.

showIncoherence(I, G1, G2, T, X1, X2):- 
	{abs(X1 - X2) =< T},
	nl,
	writeln('INCOHERENCE'), nl,
	copy_term_nat(I, I1), numbervars(I1, 0, _, [attvar(bind)]),
	writeln('Given inputs:'), maplist(writeln, I1), nl,
	write('These goals are not incoherent at the threshold '), write(T), writeln(':'),
	copy_term_nat(G1, G12), numbervars(G12, 0, _, [attvar(bind)]),
	copy_term_nat(G2, G22), numbervars(G22, 0, _, [attvar(bind)]),
	writeln(G12),
	writeln(G22), nl.


% -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% FALSIFIABILITY

% falsifiability(GOAL, INPUT, N). Count the number of unique predictions N with respect to GOAL given INPUT.
% GOAL should be a compound term where any argument can be a constant, variable or anonymous variable.
% INPUT should be a list of zero or more compound terms.
% N is the number of predictions

% showFalsifiability(GOAL, INPUT, N). Prints the results of falsifiability(GOAL, INPUT, N) to the console.

% Usage examples:
% distanceExample.pl

falsifiability(G, I, N):-
	findall(G, provable0(G, I), L),
	sort(L, L0),
	length(L0, N).
   
showFalsifiability(G, I, N):-
	nl,
	copy_term_nat(G, G1), numbervars(G1, 0, _, [attvar(bind)]),
	copy_term_nat(I, I1), numbervars(I1, 0, _, [attvar(bind)]),
	findall(G, provable0(G, I), L),
	copy_term_nat(L, L1), numbervars(L1, 0, _, [attvar(bind)]),
	writeln('FALSIFIABILITY'), nl,
	writeln('Given inputs:'), maplist(writeln, I1), nl,
	write('There are '), write(N), write(' predictions for the goal '), write(G1), write('.'), nl, nl,
	writeln('These are: '), maplist(writeln, L1), nl.


% -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% UTILITY PREDICATES

writeNTabs(N):- findall('     ', between(1, N, _), L), maplist(write, L).
