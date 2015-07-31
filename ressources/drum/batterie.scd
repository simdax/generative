(
var bus=Bus.audio.index;

var elem=["kick", "hat", "snare"];
~getBuffers.("samples".resolveRelative);
elem=elem.collect({ |elem|
	var result;
	result=~buffers.keys.select({ |i| i.contains(elem)});
	topEnvironment.put(elem.asSymbol, ~buffers.atAll(result).asArray);
	"done";
});



PathName("/home/simdax/Musique").entries[3];
a !? {a=Buffer.read(s, PathName("/home/simdax/Musique").entries[3].absolutePath)}
;

SynthDef(\god, {
	var sig=PlayBuf.ar(1, a, BufRateScale.kr(a), startPos: 24* 1000);
	Out.ar([0,1], sig)
}).add
;


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
			([0.7,0]!8).flat +++
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
		\instrument, \basic,
		\kick, ~kick.choose,
		\hat, ~hat.choose,
		\snare, ~snare.choose,
		\dur, 4,
		\legato, 1,
		\out, bus
	)
);


SynthDef(\reverb, {
	arg in=0, out=0;

	var sig=FreeVerb.ar( In.ar(in) );
	Out.ar(out, sig);

	}
).add;


)



