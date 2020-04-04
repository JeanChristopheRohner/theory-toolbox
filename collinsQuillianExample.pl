﻿:-include('theoryToolbox.pl').


% NOTES----------------------------------------------------------------------------------------------------------------

% Recursive representation of Collins' and Quillian's (1969) ideas about how properties of subclasses
% are deduced from superclass-subclass relations and superclass-property relations.

% The theory below also formalizes the time it takes to make an inference (T) and the probability of the 
% inference (X). Making an A isa C inference from A isa B and B isa C is harder; hence the 0.8 penalty for 
%such inferences.  The same goes for the probability of making an A has property P inference from A isa B 
% and B has property P. The time to deduce a relation is linearly related to the number of links that have to 
% be traversed (isa links or property links).


% SOURCES

% Collins, A. M. and Quillian, M. R. (1969). Retrieval time from semantic memory. 
% Journal of Verbal Learning and Verbal Behavior, 8, 241–248.


% INPUT----------------------------------------------------------------------------------------------------------------

% human(H)
% event(H, represent, relation(A, isa, B), T, X) 	
% event(H, represent, relation(B, hasProperty, P), T, X) 	

% H is an atom or number
% A is an atom or number
% B is an atom or number
% P is an atom or number
% {T ∈ ℤ}
% {X ∈ ℝ | 0 =< X =< 1}


% THEORY---------------------------------------------------------------------------------------------------------------

event(H, deduce, relation(A, isa, B), T1, X1) ⇐
	human(H)
	∧ event(H, represent, relation(A, isa, B), T2, X2)
	∧ {X1 = X2}
	∧ {T1 = T2 + 1}.

event(H, deduce, relation(A, isa, C), T1, X1) ⇐
	human(H)
	∧ event(H, represent, relation(A, isa, B), T2, X2)
	∧ event(H, deduce, relation(B, isa, C), T3, X3)
	∧ {X1 = 0.8 * X2 * X3}
	∧ {T1 = T2 + 1 + T3}.

event(H, deduce, relation(A, hasProperty, P), T1, X1) ⇐
	human(H)
	∧ event(H, represent, relation(A, hasProperty, P), T2, X2)
	∧ {X1 = X2}
	∧ {T1 = T2}.

event(H, deduce, relation(A, hasProperty, P), T1, X1) ⇐
	human(H)
	∧ event(H, deduce, relation(A, isa, B), T2, X2)
	∧ event(H, represent, relation(B, hasProperty, P), T3, X3)
	∧ {X1 = 0.8 * X2 * X3}
	∧ {T1 = T2 + T3 + 1}.


% EXAMPLE QUERIES------------------------------------------------------------------------------------------------------

q1 ⇐	INPUT = [
		human(somebody),
		
		event(somebody, represent, relation(bird, isa, animal), 0, 1),
		event(somebody, represent, relation(fish, isa, animal), 0, 1),
		event(somebody, represent, relation(canary, isa, bird), 0, 1),
		event(somebody, represent, relation(ostrich, isa, bird), 0, 0.8),
		event(somebody, represent, relation(penguin, isa, bird), 0, 0.8),
		event(somebody, represent, relation(whale, isa, fish), 0, 0.8),
		event(somebody, represent, relation(shark, isa, fish), 0, 1),
		event(somebody, represent, relation(whiteShark, isa, shark), 0, 1),
		event(somebody, represent, relation(salmon, isa, fish), 0, 1),

		event(somebody, represent, relation(animal, hasProperty, skin), 0, 1),
		event(somebody, represent, relation(animal, hasProperty, moves), 0, 1),
		event(somebody, represent, relation(animal, hasProperty, eats), 0, 1),
		event(somebody, represent, relation(animal, hasProperty, breathes), 0, 1),
		event(somebody, represent, relation(bird, hasProperty, wings), 0, 1),
		event(somebody, represent, relation(bird, hasProperty, canFly), 0, 1),
		event(somebody, represent, relation(bird, hasProperty, feathers), 0, 1),
		event(somebody, represent, relation(canary, hasProperty, canSing), 0, 1),
		event(somebody, represent, relation(canary, hasProperty, yellow), 0, 1),
		event(somebody, represent, relation(ostrich, hasProperty, longLegs), 0, 1),
		event(somebody, represent, relation(ostrich, hasProperty, tall), 0, 1),
		event(somebody, represent, relation(fish, hasProperty, hasFins), 0, 1),
		event(somebody, represent, relation(fish, hasProperty, swims), 0, 1),
		event(somebody, represent, relation(fish, hasProperty, hasGills), 0, 1),
		event(somebody, represent, relation(shark, hasProperty, canBite), 0, 0.8),
		event(somebody, represent, relation(whiteShark, hasProperty, dangerous), 0, 0.8),
		event(somebody, represent, relation(salmon, hasProperty, pink), 0, 1),
		event(somebody, represent, relation(salmon, hasProperty, eadible), 0, 1)
	]
	∧ (AN = canary ∨ AN = penguin ∨ AN = ostrich ∨ AN = shark ∨ AN = whiteShark ∨ AN = salmon ∨ AN = whale)
	∧ GOAL = event(somebody, deduce, relation(AN, hasProperty, _), _, _)
	∧ provable(GOAL, INPUT, RESULT) 
	∧ showProvable(RESULT) ∧ fail.