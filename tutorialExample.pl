:-include('theoryToolbox.pl').

human(h1).
human(h2).

opiate(heroin).
opiate(oxycodone).
hallucinogen(lsd).
hallucinogen(mescaline).

event(h1, used, heroin, 0.90).
event(h2, used, lsd, 0.90).

causes(S, pleasure, 0.90) ⇐ opiate(S).
causes(S, pleasure, 0.50) ⇐ hallucinogen(S).

event(H, uses, S, X3) ⇐
	human(H)
	∧ event(H, used, S, X1)
	∧ causes(S, pleasure, X2)
	∧ {X3 = X1 * X2}.