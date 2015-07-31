
Pdef(\melody).play
(
Pdef(\melody, PlazyEnvir({
	arg accords=[[0,1,2,3], [-1,-2,-3,-4]],
	durAccords=(accords.size ! 1);


		Pbind(
		\amp,0.5,
		\accords, Pstep(
			Pseq(accords, inf), Pseq(durAccords, inf)),
		\superStructure, Pkey(\accords)+1,
		\structure, Pkey(\accords),
		\accord, Pn(Plazy({ arg ev;
			Pseq([ ev.structure, ev.superStructure], 2)
	})),


		\index, Pfsm([
			#[0,1,2,3],
			0, [0,3],
			1, [0,1],
			2, [1,2],
			3, [2,3],
		], inf),

		\degree, Pfunc({ |ev|
			ev.accord[ev.index]
		}),


		\legato, 1,

		\dur, Pn(Pconst(,
			Pfsm([
				#[0,1,2,3],
				0.25, [0,3],
				1, [0,1],
				1.5, [1,2],
				0.5, [2,3],
			], inf)
		)),
	)
	}).trace()
);
)

(
var a= [-2, 0,2,4].bubble ++ [-1,1,3,5].bubble;
var b=[2];
Pdef(\a, Ppar([
	Pdef(\melody) <> (accords: a, durAccords:b),
	Pbind(\degree, Pseq(a, inf), \dur, b[0], \legato, 1)
])).play;
)


