:-include('theoryToolbox.pl').


% NOTES----------------------------------------------------------------------------------------------------------------

% DSM5 definition of simple phobia.

% SOURCES
% American Psychiatric Association. (2013). Diagnostic and statistical manual of mental disorders (DSM-5®). American Psychiatric Pub.


% INPUT----------------------------------------------------------------------------------------------------------------

% source(SO) 
% human(H)
% situation(S)
% event(H, phobia, S, 1, X)     

% SO = dsm5 ∨ SO = reasonableAssumption
% H is an atom or number
% S is an atom or number
% {X ∈ ℝ | 0 =< X =< 1}


% THEORY---------------------------------------------------------------------------------------------------------------

time(1).

% DSM5: "Marked fear or anxiety about a specific object or situation (e.g., flying, 
% heights, animals, receiving an injection, seeing blood)." and "The fear, anxiety, or 
% avoidance causes clinically significant distress or impairment in social, occupational, 
% or other important areas of functioning."
event(H, fear, S, T, X1) ⇐
	source(dsm5)
	∧ human(H)
	∧ time(T)
	∧ situation(S)
	∧ event(H, phobia, S, T, X2)
	∧ {X1 = X2}.

% DSM5: "The phobic object or situation almost always provokes immediate fear or anxiety."
event(H, fear, S, T, X1) ⇐
	source(dsm5)
	∧ human(H)
	∧ time(T)
	∧ situation(S)
	∧ event(H, phobia, S, T, X2)
	∧ event(H, encounter, S, T, X3)
	∧ {X1 = X2 * X3}.

% DSM5: The phobic object or situation is avoided or endured with intense fear or anxiety.
event(H, avoid, S, T, X1) ⇐
	source(dsm5)
	∧ human(H)
	∧ time(T)
	∧ situation(S)
	∧ event(H, phobia, S, T, X2)
	∧ {X1 = X2}.

% Reasonable assumption
event(H, encounter, S, T, X1) ⇐
	source(reasonableAssumption)
	∧ human(H)
	∧ time(T)
	∧ situation(S)
	∧ event(H, avoid, S, T, X2)
	∧ {X1 = 1 - X2}.


% EXAMPLE QUERIES------------------------------------------------------------------------------------------------------

q1 ⇐	GOAL1 = event(S, V, O, T, X1)
		∧ GOAL2 = event(S, V, O, T, X2)
		∧ INPUT = [
			source(dsm5), 
			human(somebody), 
			situation(spiders), 
			event(somebody, phobia, spiders, 1, 1)
		]
		∧ THRESHOLD = 0.1
		∧ incoherence(INPUT, GOAL1, GOAL2, THRESHOLD, X1, X2)
		∧ showIncoherence(INPUT, GOAL1, GOAL2, THRESHOLD, X1, X2) ∧ fail.

q2 ⇐	GOAL1 = event(S, V, O, T, X1)
		∧ GOAL2 = event(S, V, O, T, X2)
		∧ INPUT = [
			source(dsm5), 
			source(reasonableAssumption), 
			human(somebody), 
			situation(spiders), 
			event(somebody, phobia, spiders, 1, 1)
		]
		∧ THRESHOLD = 0.1
		∧ incoherence(INPUT, GOAL1, GOAL2, THRESHOLD, X1, X2)
		∧ showIncoherence(INPUT, GOAL1, GOAL2, THRESHOLD, X1, X2) ∧ fail.