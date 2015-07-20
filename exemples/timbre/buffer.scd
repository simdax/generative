// au clair de la lune :)

(
Pbind(
	\instrument, \bufNotes,
	// \bufPath, 0,
	\rate, Pseq([0, 0, 0, 2, 4, 2, 0, 4, 2, 2, 0].midiratio),
	\dur, Pseq([ 0.5, 0.5, 0.5, 0.5, 1, 1, 0.5, 0.5, 0.5 ,0.5 ,2 ]),
).play
)

