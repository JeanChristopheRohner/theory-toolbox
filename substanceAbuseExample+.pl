:-include('theoryToolbox.pl').


% NOTES----------------------------------------------------------------------------------------------------------------

% Same as substanceAbuseExample.pl except that physical harm is propagated across time frames.


% INPUT----------------------------------------------------------------------------------------------------------------

% source(S)	
% human(H)
% referent(R, H)
% exogenousEvent(_, _, _, _, X)

% S = theoryOfPlannedBehavior ∨ S = operantLearning ∨ S = vicariousLearning ∨ S = harmBehavior
% H is an atom or number
% R is an atom or number
% {X ∈ ℝ | 0 =< X =< 1}


% THEORY---------------------------------------------------------------------------------------------------------------

% BACKGROUND ASSUMPTIONS

misuse(useHeroin).
misuse(useCocaine).
misuse(useAlchohol).
misuse(useBenzodiazepines).
misuse(useAmphetamine).
misuse(useTobacco).
misuse(useCannabis).
misuse(useLSD).
misuse(useEcstasy).
misuse(useStreetMethadone).

outcome(pleasure).
outcome(physicalHarm).
positive(pleasure).
negative(physicalHarm).
reinforcer(pleasure).

causes(useHeroin, physicalHarm, 0.93).
causes(useCocaine, physicalHarm, 0.78).
causes(useAlchohol, physicalHarm, 0.47).
causes(useBenzodiazepines, physicalHarm, 0.54).
causes(useAmphetamine, physicalHarm, 0.60).
causes(useTobacco, physicalHarm, 0.41).
causes(useCannabis, physicalHarm, 0.33).
causes(useLSD, physicalHarm, 0.38).
causes(useEcstasy, physicalHarm, 0.35).
causes(useStreetMethadone, physicalHarm, 0.62).

causes(useHeroin, pleasure, 1.00).
causes(useCocaine, pleasure, 1.00).
causes(useAlchohol, pleasure, 0.77).
causes(useBenzodiazepines, pleasure, 0.57).
causes(useAmphetamine, pleasure, 0.67).
causes(useTobacco, pleasure, 0.77).
causes(useCannabis, pleasure, 0.63).
causes(useLSD, pleasure, 0.73).
causes(useEcstasy, pleasure, 0.50).
causes(useStreetMethadone, pleasure, 0.60).

time(1).
time(2).
time(3).
time(4).
time(5).
time(6).

precedes(X, Y) ⇐ time(X) ∧ time(Y) ∧ {Y = X + 1}.


% CORE RELATIONS

% Theory of planned behavior: Expectancy-value beliefs and attitudes
event(H, represent, event(H, like, M, T1, 1), T1, X1) ⇐
	source(theoryOfPlannedBehavior)
	∧ human(H)
	∧ misuse(M)
	∧ outcome(O)
	∧ positive(O)
	∧ precedes(T2, T1)
	∧ exogenousEvent(H, represent, event(M, cause, O, T2, 1), T2, X2)
	∧ exogenousEvent(H, represent, event(H, value, O, T2, 1), T2, X3)
	∧ {X1 = X2 * X3}.

% Theory of planned behavior: Expectancy-value beliefs and attitudes
event(H, represent, event(H, like, M, T1, 1), T1, X1) ⇐
	source(theoryOfPlannedBehavior)
	∧ human(H)
	∧ misuse(M)
	∧ outcome(O)
	∧ negative(O)
	∧ precedes(T2, T1)
	∧ exogenousEvent(H, represent, event(M, cause, O, T2, 1), T2, X2)
	∧ exogenousEvent(H, represent, event(H, dislike, O, T2, 1), T2, X3)
	∧ {X1 = 1 - X2 * X3}.

% Theory of planned behavior: Control beliefs and perceived control
event(H, represent, event(H, control, M, T1, 1), T1, X1) ⇐
	source(theoryOfPlannedBehavior)
	∧ human(H)
	∧ misuse(M)
	∧ precedes(T2, T1)
	∧ exogenousEvent(H, represent, event(environment, afford, M, T2, 1), T2, X2)
	∧ exogenousEvent(H, represent, event(H, influence, environment, T2, 1), T2, X3)
	∧ {X1 = X2 * X3}.

% Theory of planned behavior: Norm beliefs and perceived norms
event(H, represent, event(H, should, M, T1, 1), T1, X1) ⇐
	source(theoryOfPlannedBehavior)
	∧ human(H)
	∧ referent(R, H)
	∧ misuse(M)
	∧ precedes(T2, T1)
	∧ exogenousEvent(R, represent, event(H, should, M, T2, 1), T2, X2)
	∧ exogenousEvent(H, represent, event(H, comply, R, T2, 1), T2, X3)
	∧ {X1 = X2 * X3}.

% Theory of planned behavior: Attitude, control, norm and intention
event(H, represent, event(H, intend, M, T1, 1), T1, X1) ⇐
	source(theoryOfPlannedBehavior)
	∧ human(H)
	∧ misuse(M)
	∧ precedes(T2, T1)
	∧ event(H, represent, event(H, like, M, T2, 1), T2, X2)
	∧ event(H, represent, event(H, control, M, T2, 1), T2, X3)
	∧ event(H, represent, event(H, should, M, T2, 1), T2, X4)
	∧ {X1 = X2 * X3 * X4}.

% Theory of planned behavior: Intention and behavior
event(H, perform, M, T1, X1) ⇐
	source(theoryOfPlannedBehavior)
	∧ human(H)
	∧ misuse(M)
	∧ precedes(T2, T1)
	∧ event(H, represent, event(H, intend, M, T2, 1), T2, X2)
	∧ {X1 = X2}.

% Operant learning: Positive reinforcement
event(H, perform, M, T1, X1) ⇐
	source(operantLearning)
	∧ human(H)
	∧ misuse(M)
	∧ outcome(O)
	∧ positive(O)
	∧ reinforcer(O)
	∧ precedes(T2, T1)
	∧ causes(M, O, X2)
	∧ event(H, perform, M, T2, X3)
	∧ {X1 = X2 * X3}.

% Vicarious learning: Positive reinforcement
event(H, perform, M, T1, X1) ⇐
	source(vicariousLearning)
	∧ human(H)
	∧ misuse(M)
	∧ referent(R, H)
	∧ outcome(O)
	∧ positive(O)
	∧ precedes(T2, T1)
	∧ causes(M, O, X2)
	∧ event(R, perform, M, T2, X3)
	∧ exogenousEvent(H, attend, R, T2, X4)
	∧ exogenousEvent(H, capable, M, T2, X5)
	∧ {X1 = X2 * X3 * X4 * X5}.

% Vicarious learning: Punishment
event(H, perform, M, T1, X1) ⇐
	source(vicariousLearning)
	∧ human(H)
	∧ misuse(M)
	∧ referent(R, H)
	∧ outcome(O)
	∧ negative(O)
	∧ precedes(T2, T1)
	∧ causes(M, O, X2)
	∧ event(R, perform, M, T2, X3)
	∧ exogenousEvent(H, attend, R, T2, X4)
	∧ exogenousEvent(H, capable, M, T2, X5)
	∧ {X1 = 1 - X2 * X3 * X4 * X5}.

% Physical harm: Base case; at time 1 there is 0 harm from M
event(M, harm, H, 1, 0) ⇐
	human(H)
	∧ misuse(M).

% Physical harm: Performing M adds to previous harm weighted with the harmfulness of M
% and the constant 0.25 for a gradual increase. Harm asymptotically reaches 1.
event(M, harm, H, T1, X1) ⇐
	source(harmBehavior)
	∧ human(H)
	∧ misuse(M)
	∧ precedes(T2, T1)
	∧ event(M, harm, H, T2, X2)
	∧ causes(M, physicalHarm, X3)
	∧ event(H, perform, M, T2, X4)
	∧ {X1 = X2 + (1 - X2) * X3 * X4 * 0.25}.

% If performing M is not provable just assume that harm at T1 is the same as harm at T2
event(M, harm, H, T1, X1) ⇐
	source(harmState)
	∧ human(H)
	∧ misuse(M)
	∧ precedes(T2, T1)
	∧ event(M, harm, H, T2, X2)
	∧ ¬event(H, perform, M, T2, _)
	∧ {X1 = X2}.


% EXAMPLE QUERIES------------------------------------------------------------------------------------------------------

q1 ⇐ 	misuse(M)
	∧ GOAL = event(M, harm, somebody, 6, _)
	∧ INPUT = [
		source(_), 
		human(somebody), 
		referent(friend, somebody), 
		event(somebody, perform, M, 1, 1)
	]
	∧ provable(GOAL, INPUT, RESULT)
	∧ showProvable(RESULT) ∧ fail.

q2 ⇐	GOAL = event(useHeroin, harm, somebody, 6, _)
	∧ INPUT = [
		source(_), 
		human(somebody), 
		referent(friend, somebody), 
		exogenousEvent(_, _, _, _, _)
	]
	∧ prove(GOAL, INPUT, PROOF)
	∧ showProof(PROOF).
