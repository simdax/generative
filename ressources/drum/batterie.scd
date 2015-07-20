(

var elem=["kick", "hat", "snare"];
~getBuffers.("samples".resolveRelative);
elem=elem.collect({ |elem|
	var result;
	result=~buffers.keys.select({ |i| i.contains(elem)}).choose;
	~buffers[result]
});
elem.postln;


SynthDef(\drum, {
	arg out=0, vol, bufnum;
	var sig=PlayBuf.ar(1, bufnum, doneAction:2);
	Out.ar(out, sig*vol);
}).add;

Synth(\drum, [\bufnum, [6,5,5], \vol, [1,1,1] ])
Synth(\drum, [\bufnum, 6, \vol, 1 ])


Pdef(\basic, { arg kick, hat, snare, dur=1;
		Pbind(
			\instrument, \buf,
			\bufnum, [kick, hat, snare],
			\vol, Pseq(
			([1,0]!8).flat +++
			([1,1]!8).flat +++
			([0,0, 1, 0]!4).flat
		),
		\dur, dur/8
		).trace
});

Pbind(
	\type, \phrase,
	\instrument, \basic,
	\kick, elem[0],
	\hat, elem[1],
	\snare, elem[2],
	\dur, 8
).play

)

(
Pdef(\test,
Pbind(
	\degree, [0,1],
	\amp, [0.05,0.2]
	)
)
)

