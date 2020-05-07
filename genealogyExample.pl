% NOTES----------------------------------------------------------------------------------------------------------------

% Hello world example.


% SETUP----------------------------------------------------------------------------------------------------------------

:-include('theoryToolbox.pl').


% INPUT----------------------------------------------------------------------------------------------------------------

% female(A)
% male(B)
% parent(C, D)

% A is an atom or number
% B is an atom or number
% C is an atom or number
% D is an atom or number


% THEORY---------------------------------------------------------------------------------------------------------------

grandparent(G, C) ⇐ parent(G, P) ∧ parent(P, C).
brother(C1, C2) ⇐ parent(P, C1) ∧ parent(P, C2) ∧ male(C1) ∧ ¬(C1 = C2).
sister(C1, C2) ⇐ parent(P, C1) ∧ parent(P, C2) ∧ female(C1) ∧ ¬(C1 = C2).
aunt(A, C) ⇐ parent(P, C) ∧ sister(A, P).
uncle(U, C) ⇐ parent(P, C) ∧ brother(U, P).
cousin(C1, C2) ⇐ parent(G, P1) ∧ parent(G, P2) ∧ parent(P1, C1) ∧ parent(P2, C2) ∧ ¬(P1 = P2).


% EXAMPLE QUERIES------------------------------------------------------------------------------------------------------

q1 ⇐	GOAL = uncle(_, _)
	∧ INPUT = [
		parent(mona, homer),
		parent(mona, herb),
		parent(homer, bart),
		parent(homer, lisa),
		male(herb)
	],
	provable(GOAL, INPUT, RESULT)
	∧ showProvable(RESULT) ∧ fail.

q2 ⇐	GOAL = aunt(_, _)
	∧ INPUT = [
		female(patty),
		parent(jaqueline, patty),
		parent(jaqueline, marge),
		parent(marge, bart),
		parent(marge, lisa)
	]
	∧ prove(GOAL, INPUT, PROOF)
	∧ showProof(PROOF) ∧ fail.

q3 ⇐	GOAL = cousin(_, _)
	∧ INPUT = [
		parent(jaqueline, marge),
		parent(jaqueline, patty),
		parent(marge, maggie),
		parent(patty, ling)
	]
	∧ prove(GOAL, INPUT, PROOF)
	∧ showProof(PROOF) ∧ fail.
