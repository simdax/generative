
(

Pdef(\deuxVoix, {arg mel=Pxrand( (0..7), inf),
	intervalle,
	cons=Prand([2,5], inf);
	Pbind(
		\type, \phrase,
		\instrument, \wrapMel,
		\degree, Ptuple([mel, mel+cons]),
		\amp, Ptuple([
			Pexprand( 0.7, 0.8),
			Pexprand(0.4, 0.5)
		]),
		\root, 5
	).trace(prefix: "mel + harmonisation + inter : ",
		key: [\mel, \cons, \intervalle])
	}
);

Pdef( \wrapMel, { arg degree=Pexprand(0.1, 20).round, root=6, maxInter=3;
	Penvir(
		(a: root),
		Pbind(
			\degree, degree.wrap(0, 6),
			\new, Pkey(\intervalle)+Pkey(\cons),
			\octave,
			Pfunc ({ arg ev;
				var inter=ev[\intervalle];
				if (inter > maxInter) {~a=~a-1};
				if (inter < maxInter.neg) {~a=~a+1};
				~a
			}),
	)).trace(prefix:"wrap", key:[\new])
	}
);
// au clair de la lune

Pdef(\clairLune,
	Pbind(
		\type, \phrase,
		\instrument, \deuxVoix,
		\mel, Pseq([0,0,0,1,2,1,0,2,1,1,0], inf),
		\dur, Pseq([1,1,1,1,2,2,1,1,1,1,4], inf),
		\stretch, 1,
		\intervalle, Pdiff(Pkey(\mel)),
		\cons, Pwrand([2,-2], [0.8, 0.2], inf),
	)
).play(quant:2);
)

