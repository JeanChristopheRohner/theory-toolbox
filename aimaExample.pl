% NOTES----------------------------------------------------------------------------------------------------------------

% Classic example from Russel and Norvig (2010, p 297) with some additions.


% SOURCES

% Russell, S. J., Norvig, P., & Davis, E. (2010). Artificial Intelligence : A Modern Approach (3rd ed.). 
% Prentice Hall. 


% ---------------------------------------------------------------------------------------------------------------------


:-include('theoryToolbox.pl').


% INPUT

% No input necessary


% THEORY

missile(scud).
tank(leopardIII).
owns(someCountry, scud).
owns(anotherCountry, leopardIII).
enemy(someCountry, america).
enemy(anotherCountry, america).
american(west).
american(east).
weapon(X) ⇐ missile(X) ∨ tank(X) ∨ grenade(X).
sells(west, X, someCountry) ⇐ missile(X) ∧ owns(someCountry, X).
sells(east, X, anotherCountry) ⇐ tank(X) ∧ owns(anotherCountry, X).
hostile(X) ⇐ enemy(X, america).
criminal(X) ⇐ american(X) ∧ weapon(Y) ∧ sells(X, Y, Z) ∧ hostile(Z).


% EXAMPLE QUERIES------------------------------------------------------------------------------------------------------

q1 ⇐	GOAL = criminal(_) 
	∧ INPUT = [] 
	∧ provable(GOAL, INPUT, RESULT) 
	∧ showProvable(RESULT) ∧ fail.

q2 ⇐	GOAL = criminal(_) 
	∧ INPUT = [] 
	∧ prove(GOAL, INPUT, PROOF) 
	∧ showProof(PROOF) ∧ fail.