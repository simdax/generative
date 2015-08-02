(


//melody which walk through line, but has an event every beat

Pbind(
	    \degree, Pn(Plazy({
		var start=3.rand.postln;
		Pseries(start, Prand(#[-2, -1, 1, 2], inf), 8).fold(2, 14)
	}))
	+ Pseq([0,0,0,
		Pwrand([4,-4,2, -2, 7], [1,1,2,2,0.1]) // event
	], inf).trace
	,
	\dur, 0.5,

).trace.play

)


(
Pbind(
	\degree, Pstep([0,2,1], 4),
	\dur, 0.5
).trace.play
)