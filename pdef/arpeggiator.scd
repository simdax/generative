
//arpeggiator

(
//iterates through chords
Pdef(\arpeggiator,
PlazyEnvir	{ arg accords=[[0,2,4]], ambitus=(0..8);

		Pbind(
//			\type, \phrase,
		// \instrument, 'sonatinaHarp',


			\accords, Pstutter( (2*ambitus.size)-2, Pseq(accords, inf)),
			\indices, Pwalk(ambitus, Prand([1], inf), Pseq([1,-1], inf)),

			\degree, Pfunc({ |ev|
				var e=ev.indices % ev.accords.size;
				ev.accords[e];
			}),
			\octave, Penvir(
				(base:4),
				Pfunc({ |ev|
					~base  + (ev.indices div: ev.accords.size)
				})
			),

			\dur, 0.2
		)
	}
)
)

Pdef(\arpeggiator).play //default

(
var accords=[0, 3,4,0] +.t [0,2,4];

(
	Pdef(\arpeggiator) <> (accords:accords)
).trace.play
)
