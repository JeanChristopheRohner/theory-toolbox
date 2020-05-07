% NOTES----------------------------------------------------------------------------------------------------------------

% The theory below is loosely based on the work of Ajzen (1991), Bandura(2004), Nutt et al (2007), Skinner (1953), 
% and Walters and Rotgers (2011). Pleasure values and harm values for different substances were obtained by dividing 
% the expert ratings in  Nutt et al (2007, Table 3) by 3 to standardize values to the 0-1 range. Note that only 
% relative comparisons between probabilities are meaningful, since the works on which the theory is based are not that 
% detailed about various background assumptions that impact different parameter values (e.g. how long does one have 
% to use heroin to get a harm value of 3, etc). Relative comparisons between probabilities should however be meaningful.
% Physical harm does not appear as an outcome in the operant learning clause because physical harm does not produce 
% immediate displeasure (i.e. not a reinforcer). For the sake of clarity the theory also uses a simple 
% representation of the relation between substance misuse and physical harm: It does not increment harm as a function 
% of the number of misuse episodes. Harm values should insted be interpreted as the harm that results from one misuse 
% episode. The file substanceAbuseExampleState.pl contains a more advanced state representation of harm.


% SOURCES

% Ajzen, I. (1991). The theory of planned behavior. Organizational behavior and human decision 
% processes, 50(2), 179-211. 

% Nutt, D., King, L., Saulsbury, W., & Blakemore, C. (2007). Development of a rational scale to assess the harm of 
% drugs of potential misuse. Lancet, 369, 1047-1053.

% Skinner, B. F. (1953). Science and human behavior: Simon and Schuster.

% Bandura, A. (2004). Observational Learning. In J. H. Byrne (Ed.), Learning and Memory (2nd ed. ed., pp. 482-484). 
% New York, NY: Macmillan Reference USA.

% Walters, S. T., & Rotgers, F. (Eds.). (2011). Treating substance abuse: Theory and technique. Guilford Press.


% SETUP----------------------------------------------------------------------------------------------------------------

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
	∧ exogenousEvent(H, represent, event(H, affect, environment, T2, 1), T2, X3)
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

% 8 Misuse behavior and physical harm
event(H, experience, physicalHarm, T1, X1) ⇐
	source(harmBehavior)
	∧ human(H)
	∧ misuse(M)
	∧ precedes(T2, T1)
    ∧ event(H, perform, M, T2, X2)
    ∧ event(M, cause, physicalHarm, T2, X3)
	∧ {X1 = X2 * X3}.


% EXAMPLE QUERIES------------------------------------------------------------------------------------------------------

% PROVABLE

q1 ⇐	GOAL = event(_, _, _, _, _)
	∧ INPUT = [
		source(_),
		human(somebody),
		referent(friend, somebody),
		exogenousEvent(_, _, _, _, _)
	]
	∧ provable(GOAL, INPUT, RESULT)
	∧ showProvable(RESULT) ∧ fail.

q2 ⇐ 	GOAL = event(somebody, experience, physicalHarm, 6, _)
	∧ misuse(MISUSE)
	∧ INPUT = [
		source(_), 
		human(somebody), 
		referent(friend, somebody), 
		event(somebody, perform, MISUSE, 1, 1)
	]
	∧ provable(GOAL, INPUT, RESULT)
	∧ write(MISUSE) ∧ write(': ') ∧ showProvable(RESULT) ∧ fail.


% PROVE

q3 ⇐  	GOAL = event(somebody, perform, useTobacco, 6, _)
	∧ INPUT = [
		source(_), 
		human(somebody), human(friend),
		referent(friend, somebody), referent(somebody, friend),
		exogenousEvent(_, _, _, _, _)
	]
	∧ prove(GOAL, INPUT, PROOF)
	∧ showProof(PROOF).


% MAXVALUE

q4 ⇐ 	GOAL = event(somebody, experience, physicalHarm, _, X)
	∧ INPUT = [
		source(_), 
		human(somebody), 
		referent(friend, somebody),
		exogenousEvent(_, _, _, _, 0.1),
		exogenousEvent(_, _, _, _, 0.5),
		exogenousEvent(_, _, _, _, 0.9)
	]
	∧ maxValue(X, GOAL, INPUT)
	∧ showMaxValue(GOAL, INPUT).

q5 ⇐ 	GOAL = event(somebody, perform, eatUnhealthy, 6, X)
	∧ INPUT = [
		source(_),
		misuse(eatUnhealthy),
		human(somebody), human(friend),
		referent(friend, somebody), referent(somebody, friend),
		exogenousEvent(_, _, _, _, 0.1),
		exogenousEvent(_, _, _, _, 0.5),
		exogenousEvent(_, _, _, _, 0.9)
	]
	∧ maxValue(X, GOAL, INPUT)
	∧ showMaxValue(GOAL, INPUT).


% MINVALUE

q6 ⇐ 	GOAL = event(somebody, experience, physicalHarm, 6, X)
	∧ INPUT = [
		source(_), 
		human(somebody), 
		referent(friend, somebody), 
		event(somebody, perform, _, 1, 0.1),
		event(somebody, perform, _, 1, 0.5),
		event(somebody, perform, _, 1, 0.9)
	]
	∧ minValue(X, GOAL, INPUT)
	∧ showMinValue(GOAL, INPUT).