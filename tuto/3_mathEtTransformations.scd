/*
Bon maintenant on veut commencer les choses sérieuses.
Harmonisation toute simple d'un thème ===> */

//au clair de la lune :)
(
~mel=[0,0,0,1,2,1,0,2,1,1,0];
var dur=[1,1,1,1,2,2,1,1,1,1,4];

Pdef(\mel,
Pbind(
	\degree, Pseq(mel),
	\dur, Pseq([1,1,1,1,2,2,1,1,1,1,4]),
	\stretch, 0.3
	)
);
Pdef(\harmo,
	Pbind(
		\degree, Pcollect({ |ev| ev[\degree]+3 }, Pdef(\mel)),
		\dur, Pseq(dur),
		\stretch, 0.3
	)
);
/*Pbindef(\harmo,
	\octave, 5
)*/
)

(
Psym(
	Pseq([
	\mel,
	[\mel, \harmo]
	], inf)
).play
)

// pendant le workflow, on change le type d'harmo
Pdef(\harmo).play

(
Pbindef(\harmo,
		\degree, Pcollect({ |ev| ev[\degree]+2 }, Pdef(\mel)),
)
)
(
Pbindef(\mel,
	\degree, Pseq([0,1,2,3]))
)
// bienvenue dans le monde de la folie :)