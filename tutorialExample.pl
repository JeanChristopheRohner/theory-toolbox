:-include('theoryToolbox.pl').

human(h1).
human(h2).

time(1).
time(2).
time(3).

precedes(T1, T2) ⇐ time(T1) ∧ time(T2) ∧ {T2 = T1 + 1}.

opiate(heroin).
opiate(oxycodone).
hallucinogen(lsd).
hallucinogen(mescaline).

event(S, cause, pleasure, 0.80) ⇐ opiate(S).
event(S, cause, pleasure, 0.50) ⇐ hallucinogen(S).

event(h1, use, heroin, 1, 0.90).
event(h2, use, lsd, 1, 0.90).

event(H, use, S, T2, X3) ⇐
	human(H)
	∧ precedes(T1, T2)
	∧ event(H, use, S, T1, X1)
	∧ event(S, cause, pleasure, X2)
	∧ {X3 = X1 * X2}.

/*
event(H, use, S, T2, X3) unifies with the consequent on line 23
	human(H) unifies with the consequent on line 3
	H = h1
	precedes(T1, T2) unifies with the consequent on line 10
		time(T1) unifies with the consequent on line 6
		T1 = 1
		time(T2) unifies with the consequent on line 7
		T2 = 2
		{2 = 1 + 1} is true
	event(h1, use, S, 1, X1) unifies with the consequent on line 17
	S = heroin
	X1 = 0.90
	event(heroin, cause, pleasure, 1, X2) unifies with the consequent on line 20
		opiate(heroin) unifies with the consequent on line 12
		time(1) unifies with the consequent on line 1					
		X2 = 0.80
	{0.72 = 0.90 * 0.80}



*/
