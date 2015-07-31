
(

Pdef(\range,
	Penvir
	(( b:[nil], a:[0]),
	Pbind(
		\ambitus, [3,7], // en octave
		\intervalleMax, 3,
			\baseOctave, 5,
			\id, 0,
		\diff, Pfunc({ arg e;
				var diff;
				var last=~b[e.id];
				if (last.isNil)
				{last=0};
				diff= e.degree - last;
				~b[e.id]= e.degree;
				diff;
			}),

		\octave, Pfunc ({ arg ev;
			var inter=ev.diff;
			var voice=ev.id,
			maxInter=ev.intervalleMax,
			minAmbitus=ev.ambitus.first,
			maxAmbitus=ev.ambitus.last;

			if ( (inter > maxInter) && ((~a[voice]-1) > minAmbitus))
			{~a[voice]=~a[voice]-1} {};
			if ( (inter < maxInter.neg) && ((~a[voice]+1) < maxAmbitus))
			{~a[voice]=~a[voice]+1}{};
			~a[voice]
		}),
	))
)
)

Pdef(\test).trace.play
(
Pdef(\test, (
Pbind(
		\intervalleMax, 3
	)
	<>
	Pdef(\range)
<>
Pbind(
	\degree, Prand((0..12), inf),
	\dur, 0.2,
)
)
).trace
)