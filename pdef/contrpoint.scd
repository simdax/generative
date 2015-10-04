
(


Pbind(
	\intervalle, Pxrand((-3..3), inf),
	\degree, Pwrap(
		Ptuple([
			Paccum(step: Pkey(\intervalle), start:0),
			Paccum(step: Pkey(\intervalle).neg, start:0),
	]), -3,3).trace

).play


;

)
