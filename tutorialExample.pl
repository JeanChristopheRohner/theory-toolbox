﻿:-include('theoryToolbox.pl'). :-style_check(-discontiguous).

human(h1).
human(h2).

opiate(heroin).
opiate(oxycodone).
hallucinogen(lsd).
hallucinogen(mescaline).

event(h1, used, heroin, 0.90).
event(h2, used, lsd, 0.90).

cause(S, pleasure, 0.90) ⇐ opiate(S).
cause(S, pleasure, 0.50) ⇐ hallucinogen(S).

event(H, uses, S, X3) ⇐
	human(H)
	∧ event(H, used, S, X1)
	∧ cause(S, pleasure, X2)
	∧ {X3 = X1 * X2}.