
/// variables basiques du morceau
(
~variables={
	~mel=~genererMel.((10..15).choose);
	~melD=~rythmeIntervallique.(~mel);
	~mel=~intervalleMax.(~mel);


	~basses=~analyseHarmonique.(~mel, ~troisAccords.().choose);
	~basses=~trouverGrille.(~basses);
    ~basses=~pasRepetitions.(~basses);

	~bassesH=~basses[0];
	~bassesR=~schemaR.(~melD, ~basses[1]);
};


//// +variables "d'interprétation" et "voix"
(
Pdef(\theme,
	Pbind(
		\type, \midi,
		\midiout, m,
		\degree, Pdefn(\melH),
		\dur, Pdefn(\melD),
		\chan, 0,
		\amp, 1,
		\legato, 1
)//.trace([\degree], prefix:"mel")
);
Pdef(\acc,
	Pbind(
		\type, \midi,
		\midiout, m,
		\degree, Pdefn(\basses),
		\dur, Pdefn(\rBasses),
		\chan, 1,
		\amp, 0.5,
		\legato, 1
	)//.trace([\degree], prefix:"acc")
)
)
)

//// "forme" du morceau

(


Pdef(\morceau,
Pn(
	Plazy({
		// TODO : il y a du temps de calcul un peu casse-couilles

		"

		NOUVEAU THEME


		".postln;
	~variables.value();
	Pdefn(\melH, Pseq(~mel));
	Pdefn(\melD, Pseq(~melD));
	Pdefn(\basses, [0,2,4] + Pseq (~bassesH));
	Pdefn(\rBasses, Pseq((~bassesR)));

			Psym(
			Prand([

					Pseq([[\theme,\acc]]),

			])
			) <> (scale: Pseq([ Scale.major, Scale.lydian, Scale.mixolydian], inf).iter.next)
})
)).play(quant:1)

)




