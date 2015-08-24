
(

SynthDef(\tchiop, {
	arg freq, dur, amp, gate=1, out=0;

	var env=EnvGen.kr(Env.adsr(), gate, amp, doneAction:2);
	var sig= Saw.ar(freq);

	Out.ar(out,
		Pan2.ar(sig*env)
	)
}).add;
)

(

var basses=[0, 6, 11, 5, 10];
var couleurs=[0,4,7];

Pdef(\b,
Ppar([
Pbind(
		\instrument, \tchiop,
		\octave, 3,
			\amp, 0.6,
	\note, Ppatlace([
			Pseries(0, -1),
			Pseries(6, -1)
		], inf).wrap2(6)
	),
	Pbind(
			\instrument, \tchiop,
		\note, (Pseries()+couleurs).wrap(0,12),
			\amp, 0.45,
			\legato, 1.1,
)
]).trace
).play
)


s.plotTree