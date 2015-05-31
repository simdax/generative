
/// variables basiques du morceau
(
~mel=~genererMel.();
Pdefn(\mel, Pseq(~mel));
)
(
var accords=~analyseHarmonique.(~mel, ~troisAccords.().choose);
Pdefn(\accords, Pseq ( accords))
)

//// variables "d'interprétation"
(
Pdef(\theme,
	Pbind(
		\type, \midi,
		\midiout, m,
		\degree, Pdefn(\mel),
		\chan, 0,
		\amp, 1
	)
);
Pdef(\acc,
	Pbind(
		\type, \midi,
		\midiout, m,
		\degree, Pdefn(\accords),
		\chan, 1,
		\amp, 0.7
	)
)
)

//// "forme" du morceau
(
Pdef(\morceau,
Psym(
		[\theme,
			\acc
		]
))
	.play(quant:1)

)

