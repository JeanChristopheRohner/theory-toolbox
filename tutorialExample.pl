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
