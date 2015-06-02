
/// variables basiques du morceau
(
~variables={
	~mel=~genererMel.();
	~melD=~rythmeIntervallique.(~mel);
	~mel=~intervalleMax.(~mel);
	Pdefn(\melH, Pseq(~mel));
	Pdefn(\melD, Pseq(~melD));

	~basses=~analyseHarmonique.(~mel, ~troisAccords.().choose);
	~basses=~trouverGrille.(~basses);
	~bassesR=~schemaR.(~melD, ~pasRepetitions.(~basses)[1]).postln;

	Pdefn(\basses, [0,2,4] + Pseq (~basses));
	Pdefn(\rBasses, Pseq((~bassesR)));

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
	Psym(
			Prand([
				Pseq([\theme,[\theme,\acc]]),
				Pseq([\theme,\acc]),
				Pseq([\acc])
			])
			) <> (scale: [ Scale.minor, Scale.major].choose)
})
)).play(quant:1)

)




