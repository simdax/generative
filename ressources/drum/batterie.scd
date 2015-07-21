(

var elem=["kick", "hat", "snare"];
~getBuffers.("samples".resolveRelative);
elem=elem.collect({ |elem|
	var result;
	result=~buffers.keys.select({ |i| i.contains(elem)});
	topEnvironment.put(elem.asSymbol, ~buffers.atAll(result).asArray);
	"done";
});
elem.postln;




SynthDef(\drum, {
	arg out=0, vol, bufnum;
	var sig=PlayBuf.ar(1, bufnum, doneAction:2);
	Out.ar(out, sig*vol);
}).add;


Pdef(\basic, { arg kick, hat, snare, dur=1;
		Pbind(
			\instrument, \drum,
			\bufnum, [kick, hat, snare],
			\vol, Pseq(
			([1,0]!8).flat +++
			([1,1]!8).flat +++
			([0,0, 1, 0]!4).flat
		),
		\dur, dur/8
		)
});

Pdef(\basic2, { arg kick, hat, snare, dur=1;
		Pbind(
			\instrument, \drum,
			\bufnum, [kick, hat, snare],
			\vol, Pseq(
			([1,0]!8).flat +++
			([1,1]!8).flat +++
			([0,1, 1, 0]!4).flat
		),
		\dur, dur/8
		)
});

a=Pdef(\play,
	Pbind(
	\type, \phrase,
		\instrument, Prand([\basic, \basic2], inf),
		\kick, Prand(~kick, inf),
		\hat, Prand(~hat, inf),
		\snare, Prand(~snare, inf),
		\dur, Pseq((0.5, 1..5).mirror1, inf),
	\legato, 1,
		\out, 17
)
)
)

// reverb

(

SynthDef(\reverb, {
	arg in=0, out=0;

	var sig=FreeVerb.ar( In.ar(in) );
	Out.ar(out, sig);

	}
).add;

)

// et on joue
s.plotTree
a.trace.play
Synth(\reverb, [\in, 17, \out, [0,1] ])

Synth(\reverb).autogui
Synth(\drum).autogui
Pdef(\a).gui
Quarks.gui
