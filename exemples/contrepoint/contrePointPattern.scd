(

Pdef(\a, {arg mel=Pxrand( (0..7), inf), cons=Prand([2,5], inf);

	Pbind(
		\mel, mel,
		\harmo, Pkey(\mel) + cons,
		\degree, Ptuple( [ Pkey(\mel),Pkey(\harmo)]),
		\amp, Ptuple([
			Pexprand( 0.7, 0.8),
			Pexprand(0.4, 0.5)
		])
	).trace([\mel, \harmo])
	}
);

// au clair de la lune

Pdef(\clairLune,
Pbind(
	\type, \phrase,
	\instrument, \a,
	\mel, Pseq([0,0,0,1,2,1,0,2,1,1,0], inf),
	\dur, Pseq([1,1,1,1,2,2,1,1,1,1,4] + 0.7.rand2 , inf),
	\cons, Pwrand([2,-2], [0.8, 0.2], inf),
	\stretch, 1,
)
).play

)

Synth(\reverb, addAction:\addToTail)