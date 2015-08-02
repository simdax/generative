(
//harmo 1

var basses=[11,6,9,13,9,9];
var mineur9=[0,7,14,15,22];
var mineur96=[0,2,3];
var maj69=[0,11,14,16,24];
var min69=[0,11,14,15,24];

//harmo 2

var basses2 = [
	\rest, 3, 0, 3, 0, 4, 3, 4,
	0, 0, 4, 0, 0,0,  3, 0, 4, 0,
	4, 1, 4, 3,
	5b, 4, 5b, 4, 4, 1 ,4 ,4 ,4 ,0 ,1 ,4 ,0 ,4 ,0 ,4 ,0 ,4 ,0 ,4 ,0, 3
];
var dur = [
	[ 4*4, [
		2,
		[2, [1,1,1]],
		1, 0.60, 1.15 ,-0.20, -1,
		-1.60, 0.20, 0.2, 0.75, 0.25, 0.7, 0.3, -0.5, 0.3, 1.25, 0.25, 0.5, -1.5,
	], 2 ].convertRhythm ++
	[ 4*4, [
		2,
		0.75,0.25,0.5,-0.75,
		0.75,0.5,1,
		0.5,1,2.5
	]].convertRhythm ++
	[ 4*4, [
		2,
		[2, [1,1,1]],
		1, 0.60, 1.15 ,-0.20, -1,], 2]
].unbubble;



Pdef(\grille,
	Plambda(
		Ptpar([ 0,
			Pbind(
/*				\type, \midi,
				\midiout, m,
				\chan, 0,*/
				\note, Plet(\n,
					Pseq(basses, 6) + Pseq([ Pn(mineur9, 4), maj69, min69], inf)
				),
				// \detune, ~io,
				\legato, 1,
				\dur, 8,
				\amp, 0.15,
				\strum, 0.15,
				\StrumEndsTogether, true,
			),
			16*2,
			Pbind(
				\type, \midi,
				\midiout, m,
				\chan, 1,
				\note, Pindex(Pget(\n, 0, inf),
					Pxrand([0,1,2,3,4]),
					inf).wrap(0,11),
				\octave, 6,
				\amp, 0.24,
				\legato, 1.2,
				\dur, Pn(Pconst( 8,
					 Pwrand(
						[2, 1, Pseq([0.5, 0.5, 1]), Pseq([0.5, 1, 0.5]), Pseq([0.25, 0.25, 0.5])],
						[6, 3,3,1, 1].normalizeSum,
						inf)
				)),
			)
		])
	)
);

Pdef(\grille2,
	Pbind(
		// \instrument, \harpsichord1,
/*		\type, \midi,
		\midiout, m,*/
		\amp, 0.5,
		\degree, Pseq(basses2) + [0,2,4],
		\root, 9,
	/*	\rate, Pfunc({ arg ev; ev.use {
			var result=~midinote.value;
			result.postln;
			(result.isArray).if
			{result.wrap(0,11).postln.midiratio}
			{\rest}
		}}),*/

		\dur, Pseq(dur),
		\legato, 1
	)
);

)

 Pdef(\grille2).trace.play
Pdef(\grille).trace.play