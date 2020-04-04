:-include('theoryToolbox.pl').

human(somebody).
behavior(exercise).

time(1).
time(2).
time(3).

precedes(X, Y) ⇐ time(X) ∧ time(Y) ∧ {Y = X + 1}.

event(somebody, like, exercise, 1, 0.5).

event(H, perform, B, T1, X1) ⇐
	human(H) 
	∧ behavior(B)
	∧ event(H, like, B, T2, X2)
	∧ {X1 = 0.7 * X2}
	∧ precedes(T2, T1).