% NOTES----------------------------------------------------------------------------------------------------------------

% A simple theory about the effects of smoking on cancer and the effects of social influence on smoking inspired 
% by a model from the DTAI research group at KU Leuwen. The magnitude of the relation between (lung) cancer and 
% smoking is based on the frequencies reported in Ordóñez-Mena et al (2016).


% SOURCES

% Ordóñez-Mena, J. M., Schöttker, B., Mons, U., Jenab, M., Freisling, H., Bueno-de-Mesquita, B., . . . Brenner, H. (2016). 
% Quantification of the smoking-associated cancer risk with rate advancement periods: meta-analysis of individual 
% participant data from cohorts of the CHANCES consortium. BMC Medicine, 14(1), 62.

% https://dtai.cs.kuleuven.be/problog/tutorial/basic/05_smokers.html

% © Jean-Christophe Rohner 2020
% Note: The theory below represents a hypothetical example


% ---------------------------------------------------------------------------------------------------------------------


:-include('theoryToolbox.pl').


% INPUT

% human(H1)
% human(H2)
% friends(H1, H2)
% event(H1, does, smoke, T, X)

% H1 and H2 are constants
% {T ∈ ℤ | 1 =< T =< 3}
% {X ∈ ℝ | 0 =< X =< 1}


% THEORY

time(1).
time(2).
time(3).

precedes(X, Y) ⇐ time(X) ∧ time(Y) ∧ {Y = X + 1}.

friendsSymmetric(X, Y) ⇐ friends(X, Y) ∨ friends(Y, X).

event(H1, influences, H2, T, 0.6) ⇐
	human(H1)
	∧ human(H2)
	∧ time(T)
	∧ friendsSymmetric(H1, H2).

event(H1, does, smoke, T1, X1) ⇐
	human(H1)
	∧ human(H2)
	∧ precedes(T2, T1)
	∧ event(H2, does, smoke, T2, X2)
	∧ event(H2, influences, H1, T2, X3)
	∧ {X1 = 1.000 * X2 * X3}.

event(H, has, cancer, T1, X1) ⇐
	human(H)
	∧ precedes(T2, T1)
	∧ event(H, does, smoke, T2, X2)
	∧ {X1 = 0.003 + 0.046 * X2}.


% EXAMPLE QUERIES------------------------------------------------------------------------------------------------------

q1 ⇐	GOAL = event(_, has, cancer, _, _)
	∧ INPUT = [
		human(somebody), human(somebodyElse), 
		friends(somebodyElse, somebody), 
		event(somebodyElse, does, smoke, 1, _)
	]
	∧ prove(GOAL, INPUT, PROOF)
	∧ showProof(PROOF) ∧ fail.

q2 ⇐	GOAL = event(somebody, has, cancer, 3, X)
	∧ INPUT = [
		human(somebody), 
		human(somebodyElse), 
		friends(somebodyElse, somebody), 
		event(somebodyElse, does, smoke, 1, 0.1),
		event(somebodyElse, does, smoke, 1, 0.5),
		event(somebodyElse, does, smoke, 1, 0.9)	
	]
	∧ maxValue(X, GOAL, INPUT)
	∧ showMaxValue(GOAL, INPUT) ∧ fail.