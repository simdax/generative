
//arpeggiator

(
//iterates through chords
Pdef(\arpeggiator,

		Pbind(
			\type, \phrase,
		// \instrument, 'sonatinaHarp',
			\accords, Pstutter(
				(5..10).choose,
				Pseq([ [0, 2, 4], [0,2,5], [0,3,5] ], inf)
			),
			\indices, Pwalk((0..7), Prand([1], inf), Pseq([1,-1], inf)),
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
).play
)