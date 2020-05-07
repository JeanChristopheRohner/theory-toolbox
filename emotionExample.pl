% NOTES----------------------------------------------------------------------------------------------------------------

% An appraisal theory of emotion loosely based on Lazarus (1991), Smith and Ellsworth (1985), and 
% Smith and Lazarus (1993).


% SOURCES

% Lazarus, Richard S. (1991). Progress on a cognitive-motivational-relational theory of Emotion. 
% American Psychologist, 46(8), 819-834.

% Smith, C. & Ellsworth, P. (1985). Patterns of Cognitive Appraisal in Emotion. Journal of 
% personality and social psychology. 48. 813-38.

% Smith, C. A., & Lazarus, R. S. (1993). Appraisal components, core relational themes, 
% and the emotions. Cognition & Emotion, 7(3-4), 233-269.


% SETUP----------------------------------------------------------------------------------------------------------------

:-include('theoryToolbox.pl').


% INPUT----------------------------------------------------------------------------------------------------------------

% human(H1)
% human(H2)
% event(E)
% event(H1, appraise, _, present, X)

% H1 is an atom or number
% H2 is an atom or number
% E is an atom or number
% {X ∈ ℝ | 0 =< X =< 1}


% THEORY---------------------------------------------------------------------------------------------------------------

% BACKGROUND ASSUMPTIONS

time(past).
time(present).
time(future).
precedes(past, present).
precedes(present, future).

goal(socialApproval).
goal(achievement).
goal(autonomy).

event(H, value, socialApproval, T, 0.7) ⇐ human(H) ∧ time(T).
event(H, value, achievement, T, 0.6) ⇐ human(H) ∧ time(T).
event(H, value, autonomy, T, 0.5) ⇐ human(H) ∧ time(T).


% CORE RELATIONS

event(H1, experience, anger, T1, X1) ⇐
	human(H1)
	∧ human(H2)
	∧ ¬(H1 = H2)
	∧ event(E)
	∧ goal(G)
	∧ precedes(T2, T1)
	∧ event(H1, value, G, T1, X2)
	∧ event(H1, appraise, event(H1, experience, E, T2, 1), T1, X3)
	∧ event(H1, appraise, event(E, congruent, G, T2, 1), T1, X4)
	∧ event(H1, appraise, event(H1, cause, E, T2, 1), T1, X5)
	∧ event(H1, appraise, event(H2, cause, E, T2, 1), T1, X6)
	∧ event(H1, appraise, event(world, cause, E, T2, 1), T1, X7)
	∧ {X1 = X2 * X3 * (1 - X4) * (1 - X5) * X6 * (1 - X7)}.

event(H1, experience, shame, T1, X1) ⇐
	human(H1)
	∧ human(H2)
	∧ ¬(H1 = H2)
	∧ event(E)
	∧ goal(G)
	∧ precedes(T2, T1)
	∧ event(H1, value, G, T1, X2)
	∧ event(H1, appraise, event(H1, experience, E, T2, 1), T1, X3)
	∧ event(H1, appraise, event(E, congruent, G, T2, 1), T1, X4)
	∧ event(H1, appraise, event(H1, cause, E, T2, 1), T1, X5)
	∧ event(H1, appraise, event(H2, cause, E, T2, 1), T1, X6)
	∧ event(H1, appraise, event(world, cause, E, T2, 1), T1, X7)
	∧ {X1 = X2 * X3 * (1 - X4) * X5 * (1 - X6) * (1 - X7)}.

event(H, experience, fear, T1, X1) ⇐
	human(H)
	∧ event(E)
	∧ goal(G)
	∧ precedes(T1, T2)
	∧ event(H, value, G, T1, X2)
	∧ event(H, appraise, event(H, experience, E, T2, 1), T1, X3)
	∧ event(H, appraise, event(E, congruent, G, T2, 1), T1, X4)
	∧ {X1 = X2 * X3 * (1 - X4)}.

event(H1, experience, sadness, T1, X1) ⇐
	human(H1)
	∧ human(H2)
	∧ ¬(H1 = H2)
	∧ event(E)
	∧ goal(G)
	∧ precedes(T2, T1)
	∧ event(H1, value, G, T1, X2)
	∧ event(H1, appraise, event(H1, experience, E, T2, 1), T1, X3)
	∧ event(H1, appraise, event(E, congruent, G, T2, 1), T1, X4)
	∧ event(H1, appraise, event(H1, cause, E, T2, 1), T1, X5)
	∧ event(H1, appraise, event(H2, cause, E, T2, 1), T1, X6)
	∧ event(H1, appraise, event(world, cause, E, T2, 1), T1, X7)
	∧ {X1 = X2 * X3 * (1 - X4) * (1 - X5) * (1 - X6) * X7}.

event(H, experience, happiness, T1, X1) ⇐
	human(H)
	∧ event(E)
	∧ goal(G)
	∧ precedes(T2, T1)
	∧ event(H, value, G, T1, X2)
	∧ event(H, appraise, event(H, experience, E, T2, 1), T1, X3)
	∧ event(H, appraise, event(E, congruent, G, T2, 1), T1, X4)
	∧ {X1 = X2 * X3 * X4}.


% EXAMPLE QUERIES------------------------------------------------------------------------------------------------------

q1 ⇐	INPUT = [
		human(somebody),
		human(somebodyElse),
		event(anEvent),
		event(somebody, appraise, _, present, 0.1),
		event(somebody, appraise, _, present, 0.5),
		event(somebody, appraise, _, present, 0.9)
	]
	∧ (EMO = anger ∨ EMO = shame ∨ EMO = fear ∨ EMO = sadness ∨ EMO = happiness)
	∧ GOAL = event(somebody, experience, EMO, present, X)
	∧ maxValue(X, GOAL, INPUT)
	∧ showMaxValue(GOAL, INPUT) ∧ fail.

q2 ⇐	GOAL = event(h1, experience, _, present, _)
	∧ (T = past ∨ T = future)
	∧ INPUT = [
		human(h1), human(h2),
		event(jobLoss),
		event(h1, appraise, event(h1, experience, jobLoss, T, 1), present, 0.9),
		event(h1, appraise, event(jobLoss, congruent, achievement, T, 1), present, 0.1),
		event(h1, appraise, event(h1, cause, jobLoss, T, 1), present, 0.9),
		event(h1, appraise, event(h2, cause, jobLoss, T, 1), present, 0.1),
		event(h1, appraise, event(world, cause, jobLoss, T, 1), present, 0.1)
	]
	∧ prove(GOAL, INPUT, PROOF) ∧ showProof(PROOF) ∧ fail.