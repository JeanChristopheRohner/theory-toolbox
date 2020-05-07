% NOTES----------------------------------------------------------------------------------------------------------------

% A recursive theory about the transitivity of distance relations.


% SETUP----------------------------------------------------------------------------------------------------------------

:-include('theoryToolbox.pl').


% INPUT----------------------------------------------------------------------------------------------------------------

% source(S)
% human(H)
% event(H, represent, relation(A, beyond, B), time, X)

% H is an atom or number
% A is an atom or number
% B is an atom or number
% S = recursive ∨ S = nonrecursive
% {X ∈ ℝ | 0 =< X =< 1}


% THEORY---------------------------------------------------------------------------------------------------------------

% CORE RELATIONS

% 1 Base case
event(H, deduce, relation(A, beyond, B), time, X1) ⇐
	human(H)
	∧ event(H, represent, relation(A, beyond, B), time, X2)
	∧ {X1 = 1 * X2}.

% 2 Recursive clause
event(H, deduce, relation(A, beyond, C), time, X1) ⇐
	source(recursive)
	∧ human(H)
	∧ event(H, represent, relation(A, beyond, B), time, X2)
	∧ event(H, deduce, relation(B, beyond, C), time, X3)
	∧ {X1 = 0.8 * X2 * X3}.

% 3 Non-recursive clause
event(H, deduce, relation(A, beyond, C), time, X1) ⇐
	source(nonrecursive)
	∧ human(H)
	∧ event(H, represent, relation(A, beyond, B), time, X2)
	∧ event(H, represent, relation(B, beyond, C), time, X3)
	∧ {X1 = 0.8 * X2 * X3}.


% EXAMPLE QUERIES------------------------------------------------------------------------------------------------------

q1 ⇐	GOAL = event(somebody, deduce, relation(_, beyond, _), time, _)
	∧ INPUT = [
		source(recursive),
		human(somebody),
		event(somebody, represent, relation(earth, beyond, venus), time, 1),
		event(somebody, represent, relation(mars, beyond, earth), time, 1),
		event(somebody, represent, relation(jupiter, beyond, mars), time, 1),
		event(somebody, represent, relation(saturn, beyond, jupiter), time, 1),
		event(somebody, represent, relation(uranus, beyond, saturn), time, 1),
		event(somebody, represent, relation(neptune, beyond, uranus), time, 1),
		event(somebody, represent, relation(pluto, beyond, neptune), time, 1)
	]
	∧ falsifiability(GOAL, INPUT, N)
	∧ showFalsifiability(GOAL, INPUT, N).

q2 ⇐	GOAL = event(somebody, deduce, relation(_, beyond, _), time, _)
	∧ INPUT = [
		source(nonrecursive),
		human(somebody),
		event(somebody, represent, relation(earth, beyond, venus), time, 1),
		event(somebody, represent, relation(mars, beyond, earth), time, 1),
		event(somebody, represent, relation(jupiter, beyond, mars), time, 1),
		event(somebody, represent, relation(saturn, beyond, jupiter), time, 1),
		event(somebody, represent, relation(uranus, beyond, saturn), time, 1),
		event(somebody, represent, relation(neptune, beyond, uranus), time, 1),
		event(somebody, represent, relation(pluto, beyond, neptune), time, 1)
	]
	∧ falsifiability(GOAL, INPUT, N)
	∧ showFalsifiability(GOAL, INPUT, N).