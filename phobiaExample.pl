% NOTES----------------------------------------------------------------------------------------------------------------

% Important parts of the DSM5® definition of simple phobia.


% SOURCES

% American Psychiatric Association. (2013). Diagnostic and statistical manual of mental disorders (DSM-5®). 
% American Psychiatric Publishers.

% © Jean-Christophe Rohner 2019, 2020
% Note: The theory below represents a hypothetical example


% ---------------------------------------------------------------------------------------------------------------------


:-include('theoryToolbox.pl').


% INPUT

% source(S) 
% human(H)
% event(H, phobia, _, time, X)

% S = dsm5 ∨ S = plausibleAssumption
% H is a constant
% {X ∈ ℝ | 0 =< X =< 1}


% THEORY

% BACKGROUND CLAUSES

object(spiders).
object(insects).
object(dogs).
object(heights).
object(storms).
object(water).
object(needles).
object(medicalProcedures).
object(airplanes).
object(elevators).
object(enclosedSpaces).


% MAIN CLAUSES

% 1 "Marked fear or anxiety about a specific object or situation (e.g., flying, 
% heights, animals, receiving an injection, seeing blood)." and "The fear, anxiety,
% or avoidance causes clinically significant distress or impairment in social, 
% occupational, or other important areas of functioning."
event(H, fear, O, time, X1) ⇐
	source(dsm5)
	∧ human(H)
	∧ object(O)
	∧ event(H, phobia, O, time, X2)
	∧ {X1 = X2}.

% 2 "The phobic object or situation almost always provokes immediate fear or anxiety."
event(H, fear, O, time, X1) ⇐
	source(dsm5)
	∧ human(H)
	∧ object(O)
	∧ event(H, phobia, O, time, X2)
	∧ event(H, encounter, O, time, X3)
	∧ {X1 = X2 * X3}.

% 3 "The phobic object or situation is avoided or endured with intense fear 
% or anxiety."
event(H, avoid, O, time, X1) ⇐
	source(dsm5)
	∧ human(H)
	∧ object(O)
	∧ event(H, phobia, O, time, X2)
	∧ {X1 = X2}.

% 4 Plausible assumption
event(H, encounter, O, time, X1) ⇐
	source(plausibleAssumption)
	∧ human(H)
	∧ object(O)
	∧ event(H, avoid, O, time, X2)
	∧ {X1 = 1 - X2}.


% EXAMPLE QUERIES------------------------------------------------------------------------------------------------------

q1 ⇐	GOAL = event(somebody, _, _, time, _)
	∧ INPUT = [
		source(dsm5),
		human(somebody),
		event(somebody, phobia, heights, time, 0.8)
	]
	∧ provable(GOAL, INPUT, RESULT)
	∧ showProvable(RESULT).

q2 ⇐	GOAL1 = event(S, V, O, T, X1)
	∧ GOAL2 = event(S, V, O, T, X2)
	∧ INPUT = [
		source(dsm5), 
		human(somebody),
		event(somebody, phobia, _, time, 1)
	]
	∧ THRESHOLD = 0.1
	∧ incoherence(INPUT, GOAL1, GOAL2, THRESHOLD, X1, X2)
	∧ showIncoherence(INPUT, GOAL1, GOAL2, THRESHOLD) ∧ fail.

q3 ⇐	GOAL1 = event(S, V, O, T, X1)
	∧ GOAL2 = event(S, V, O, T, X2)
	∧ INPUT = [
		source(dsm5), 
		source(plausibleAssumption), 
		human(somebody),
		event(somebody, phobia, _, time, 1)
	]
	∧ THRESHOLD = 0.1
	∧ incoherence(INPUT, GOAL1, GOAL2, THRESHOLD, X1, X2)
	∧ showIncoherence(INPUT, GOAL1, GOAL2, THRESHOLD) ∧ fail.