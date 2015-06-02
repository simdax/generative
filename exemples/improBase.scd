
/// variables basiques du morceau
(
~variables={
	~mel=~genererMel.();
	Pdefn(\mel, Pseq(~mel));

	~basses=~analyseHarmonique.(~mel, ~troisAccords.().choose);
	~basses=~trouverGrille.(~basses);
	Pdefn(\basses, [0,2,4] + Pseq ( (~pasRepetitions.(~basses))[0] ));
	Pdefn(\rBasses, Pseq((~pasRepetitions.(~basses))[1]));
	Pdefn(\natureAccords, Pn([0,2,4]));

};


//// +variables "d'interprétation" et "voix"
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
		\degree, Pdefn(\basses),
		\chan, 1,
		\amp, 0.7
	).trace
)
)
)
//// "forme" du morceau
(
Plazy({
	~variables.value();

	Pn(
		Psym(
			[
				\theme,
				\acc
			]
	), 4)
})	.play(quant:1)

)



