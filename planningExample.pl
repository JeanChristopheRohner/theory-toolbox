:-include('theoryToolbox.pl').


% NOTES----------------------------------------------------------------------------------------------------------------

% A recursive theory about how people make plans by connecting actions between 
% sequences of state transitions to find a goal.
% The theory uses a very basic (unary) state representation for the sake of clarity.
% More complex state representations are possible by having multiple arguments for each
% state (e.g. both if one has a beverage and if one has a container for the beverage).


% INPUT----------------------------------------------------------------------------------------------------------------

% human(H)
% event(H, represent, transition(START, ACTION, GOAL), time, X)

% H is an atom or number
% START is an atom or number
% ACTION is an atom or number
% GOAL is an atom or number
% {X ∈ ℝ | 0 =< X =< 1}


% THEORY---------------------------------------------------------------------------------------------------------------

% CORE RELATIONS

event(H, deduce, plan(START, ACTIONS, GOAL), time, X1) ⇐
	human(H)
	∧ event(H, represent, transition(START, ACTION, GOAL), time, X2)
	∧ ACTIONS = ACTION
	∧ {X1 = 1.0 * X2}.

event(H, deduce, plan(START, ACTIONS, GOAL), time, X1) ⇐
	human(H)
	∧ event(H, represent, transition(START, ACTION, INTERIMGOAL), time, X2)
	∧ event(H, deduce, plan(INTERIMGOAL, DEDUCEDACTIONS, GOAL), time, X3)
	∧ ACTIONS = (ACTION, DEDUCEDACTIONS)
	∧ {X1 = 0.8 * X2 * X3}. 


% EXAMPLE QUERIES------------------------------------------------------------------------------------------------------

q1 ⇐	GOAL = event(somebody, deduce, plan(start, _, satisfied), time, _)
	∧ INPUT = [
		human(somebody),
		event(somebody, represent, transition(start, openFridge, fridgeOpen), time, 1),
		event(somebody, represent, transition(start, openWaterFaucet, haveBeverage), time, 1),
		event(somebody, represent, transition(fridgeOpen, getMilk, haveBeverage), time, 1),
		event(somebody, represent, transition(fridgeOpen, getJuice, haveBeverage), time, 1),
		event(somebody, represent, transition(haveBeverage, getGlass, haveGlass), time, 1),
		event(somebody, represent, transition(haveBeverage, drinkBeverage, satisfied), time, 1),
		event(somebody, represent, transition(haveGlass, pourBeverageInGlass, beverageInGlass), time, 1),
		event(somebody, represent, transition(beverageInGlass, drinkBeverage, satisfied), time, 1)
	]
	∧ provable(GOAL, INPUT, RESULT)
	∧ showProvable(RESULT) ∧ fail.

q2 ⇐	GOAL1 = event(somebody, deduce, plan(inCopenhagen, _, inApartment), time, X1)
	∧ GOAL2 = event(somebody, deduce, plan(inCopenhagen, _, inApartment), time, X2)
	∧ INPUT = [
		human(somebody),
		event(somebody, represent, transition(inCopenhagen, takeTrainToMalmo, inMalmo), time, 1),
		event(somebody, represent, transition(inMalmo, takeBussToLund, inLund), time, 1),
		event(somebody, represent, transition(inMalmo, takeTrainToLund, inLund), time, 1),
		event(somebody, represent, transition(inLund, walkToApartment, outsideApartment), time, 1),
		event(somebody, represent, transition(inLund, callTaxi, haveTaxi), time, 1),
		event(somebody, represent, transition(outsideApartment, lookForKeys, keysThere), time, 1),
		event(somebody, represent, transition(outsideApartment, lookForKeys, keysMissing), time, 1),
		event(somebody, represent, transition(keysThere, unlockDoor, doorOpen), time, 1),
		event(somebody, represent, transition(keysMissing, getLadder, haveLadder), time, 1),
		event(somebody, represent, transition(keysMissing, callLocksmith, haveLocksmit), time, 1),
		event(somebody, represent, transition(haveTaxi, rideTaxiToApartment, outsideApartment), time, 1),
		event(somebody, represent, transition(haveLadder, moveLadderToWindow, ladderBelowWindow), time, 1),
		event(somebody, represent, transition(ladderBelowWindow, getRock, haveRock), time, 1),
		event(somebody, represent, transition(haveRock, climbLadder, atWindow), time, 1),
		event(somebody, represent, transition(atWindow, breakWindow, windowBroken), time, 1),
		event(somebody, represent, transition(windowBroken, enterApartment, inApartment), time, 1),
		event(somebody, represent, transition(haveLocksmit, payLocksmith, doorOpen), time, 1),
		event(somebody, represent, transition(doorOpen, enterApartment, inApartment), time, 1)
	]
	∧ maxValue(X1, GOAL1, INPUT)
	∧ showMaxValue(GOAL1, INPUT)
	∧ minValue(X2, GOAL2, INPUT)
	∧ showMinValue(GOAL2, INPUT).