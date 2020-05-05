% NOTES----------------------------------------------------------------------------------------------------------------

% Exactly like substanceMisuse.pl except that physical harm is propagated across time.


% =====================================================================================================================

:-include('theoryToolbox.pl').

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

time(1).
time(2).
time(3).
time(4).
time(5).
time(6).

precedes(X, Y) ⇐ time(X) ∧ time(Y) ∧ {Y = X + 1}.

event(useHeroin, cause, physicalHarm, T, 0.93) ⇐ time(T).
event(useCocaine, cause, physicalHarm, T, 0.78) ⇐ time(T).
event(useAlchohol, cause, physicalHarm, T, 0.47) ⇐ time(T).
event(useBenzodiazepines, cause, physicalHarm, T, 0.54) ⇐ time(T).
event(useAmphetamine, cause, physicalHarm, T, 0.60) ⇐ time(T).
event(useTobacco, cause, physicalHarm, T, 0.41) ⇐ time(T).
event(useCannabis, cause, physicalHarm, T, 0.33) ⇐ time(T).
event(useLSD, cause, physicalHarm, T, 0.38) ⇐ time(T).
event(useEcstasy, cause, physicalHarm, T, 0.35) ⇐ time(T).
event(useStreetMethadone, cause, physicalHarm, T, 0.62) ⇐ time(T).

event(useHeroin, cause, pleasure, T, 1.00) ⇐ time(T).
event(useCocaine, cause, pleasure, T, 1.00) ⇐ time(T).
event(useAlchohol, cause, pleasure, T, 0.77) ⇐ time(T).
event(useBenzodiazepines, cause, pleasure, T, 0.57) ⇐ time(T).
event(useAmphetamine, cause, pleasure, T, 0.67) ⇐ time(T).
event(useTobacco, cause, pleasure, T, 0.77) ⇐ time(T).
event(useCannabis, cause, pleasure, T, 0.63) ⇐ time(T).
event(useLSD, cause, pleasure, T, 0.73) ⇐ time(T).
event(useEcstasy, cause, pleasure, T, 0.50) ⇐ time(T).
event(useStreetMethadone, cause, pleasure, T, 0.60) ⇐ time(T).


% CORE RELATIONS

% 1 Theory of planned behavior: Expectancy-value beliefs and attitudes
event(H, represent, event(H, like, M, T1, 1), T1, X1) ⇐
	source(theoryOfPlannedBehavior)
	∧ human(H)
	∧ misuse(M)
	∧ outcome(PO) ∧ outcome(NO)
	∧ positive(PO) ∧ negative(NO)
	∧ precedes(T2, T1)
    ∧ exogenousEvent(H, represent, event(M, cause, PO, T2, 1), T2, X2)
    ∧ exogenousEvent(H, represent, event(M, cause, NO, T2, 1), T2, X3)
	∧ {X1 = X2 * (1 - X3)}.

% 2 Theory of planned behavior: Control beliefs and perceived control
event(H, represent, event(H, control, M, T1, 1), T1, X1) ⇐
	source(theoryOfPlannedBehavior)
	∧ human(H)
	∧ misuse(M)
	∧ precedes(T2, T1)
	∧ exogenousEvent(H, represent, event(environment, afford, M, T2, 1), T2, X2)
	∧ exogenousEvent(H, represent, event(H, influence, environment, T2, 1), T2, X3)
	∧ {X1 = X2 * X3}.

% 3 Theory of planned behavior: Norm beliefs and perceived norms
event(H, represent, event(H, should, M, T1, 1), T1, X1) ⇐
	source(theoryOfPlannedBehavior)
	∧ human(H)
	∧ referent(R, H)
	∧ misuse(M)
	∧ precedes(T2, T1)
	∧ exogenousEvent(R, represent, event(H, should, M, T2, 1), T2, X2)
	∧ exogenousEvent(H, represent, event(H, comply, R, T2, 1), T2, X3)
	∧ {X1 = X2 * X3}.

% 4 Theory of planned behavior: Attitude, control, norm and intention
event(H, represent, event(H, intend, M, T1, 1), T1, X1) ⇐
	source(theoryOfPlannedBehavior)
	∧ human(H)
	∧ misuse(M)
	∧ precedes(T2, T1)
	∧ event(H, represent, event(H, like, M, T2, 1), T2, X2)
	∧ event(H, represent, event(H, control, M, T2, 1), T2, X3)
	∧ event(H, represent, event(H, should, M, T2, 1), T2, X4)
	∧ {X1 = X2 * X3 * X4}.

% 5 Theory of planned behavior: Intention and behavior
event(H, perform, M, T1, X1) ⇐
	source(theoryOfPlannedBehavior)
	∧ human(H)
	∧ misuse(M)
	∧ precedes(T2, T1)
	∧ event(H, represent, event(H, intend, M, T2, 1), T2, X2)
	∧ {X1 = X2}.

% 6 Operant learning: Positive reinforcement
event(H, perform, M, T1, X1) ⇐
	source(operantLearning)
	∧ human(H)
	∧ misuse(M)
	∧ outcome(O)
	∧ positive(O)
	∧ reinforcer(O)
	∧ precedes(T2, T1)
	∧ event(M, cause, O, T2, X2)
	∧ event(H, perform, M, T2, X3)
	∧ {X1 = X2 * X3}.

% 7 Vicarious learning: Positive reinforcement
event(H, perform, M, T1, X1) ⇐
	source(vicariousLearning)
	∧ human(H)
	∧ misuse(M)
	∧ referent(R, H)
	∧ outcome(O)
    ∧ positive(O)
    ∧ reinforcer(O)
	∧ precedes(T2, T1)
    ∧ event(M, cause, O, T2, X2)
	∧ event(R, perform, M, T2, X3)
	∧ exogenousEvent(H, attend, R, T2, X4)
	∧ exogenousEvent(H, capable, M, T2, X5)
	∧ {X1 = X2 * X3 * X4 * X5}.

% 8 Physical harm from M is zero in time frame 1
event(M, harm, H, 1, 0) ⇐
	human(H)
	∧ misuse(M).

% 9 Performing M adds to previous harm weighted with the harmfulness of M
% and the constant 0.25 for a gradual increase. Harm asymptotically reaches 1.
event(M, harm, H, T1, X1) ⇐
	source(harmBehavior)
	∧ human(H)
	∧ misuse(M)
	∧ precedes(T2, T1)
	∧ event(M, harm, H, T2, X2)
	∧ event(M, cause, physicalHarm, T2, X3)
	∧ event(H, perform, M, T2, X4)
	∧ {X1 = X2 + (1 - X2) * X3 * X4 * 0.25}.

% 10 If performing M is not provable assume that harm at T1 is the same as harm at T2
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