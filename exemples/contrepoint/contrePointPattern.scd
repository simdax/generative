(

//pour couleur 5, 6, 64
var cinq=[2,4, 7];
var six=[2,5, 7];
var sixQuatre=[3, 5, 7];
/*[cinq !3, six, sixQuatre !2, cinq, six, six, sixQuatre, cinq]
.reshapeLike( Array.fill([1,1,1].size, 1) !11 )
.collect({ |i| [0] ++ i.scramble })*/

a=6;
f = { |e|
	var diff, last = topEnvironment[t];
	if (last.isNil) {
		topEnvironment.put(t, e.degree);
		0
	}{
		diff = e.degree - last;
		topEnvironment.put(t, e.degree);
		diff
	}
};

Pdef(\a1,
	{ arg mel, cons;
		var maxInter=3, maxAmbitus=7, minAmbitus=3;

		Pbind(
			\degree, mel + cons,
			\diff, Pfunc(f),
			\octave, Pfunc ({ arg ev;
				var inter=ev[\diff];
				if (inter > maxInter and: ((a-1) > minAmbitus)) {a=a-1};
				if (inter < maxInter.neg and: ((a+1) < maxAmbitus)) {a=a+1};
				a
			}),
			\amp, Pif( cons == 0,
				Pexprand(0.5,0.7),
				Pexprand(0.15, 0.25)
			),
		).trace
	}
);


Pdef(\b,
	Pbind(
		\type, \phrase,
		\instrument, \a1,

		// mélodie de "au clair de la lune"

		\dur, Pseq([1,1,1,1,2,2,1,1,1,1,4 ], inf),
		\mel , Pseq([0,0,0,1,2,1,0,2,1,1,0], inf),
		\legato, 1,
		\stretch, 1,

		//harmonie
		\cons, Pn(Plazy({
			Pseq(
				[cinq !3, six, sixQuatre !2, cinq, six, six, sixQuatre, cinq]
				.reshapeLike( Array.fill(cinq.size, 1) !11 ).collect({ |i| [0] ++ i.scramble }), 1)
			})
			, inf),

		// ?
		\do, Pfunc { t = thisThread },

	)
).play
)