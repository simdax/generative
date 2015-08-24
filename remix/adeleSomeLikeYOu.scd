//init
(
s.waitForBoot;
a=Buffer.read(s, (Platform.userHomeDir+/+"Musique/someoneLikeYou.wav"));
b=Buffer.read(s, (Platform.userHomeDir+/+"Musique/otherside.wav"));


SynthDef(\a, {
	arg freq, dur, amp,
	gate=1, atk=0.05, rel=0.1, sust=1,
	out=0, pan=0;

	var sig=
	//	BPF.ar(
	MdaPiano.ar(freq, sustain:sust)
	/*	LFNoise1.ar(0.5).exprange(700, 1200),
	LFNoise1.ar(1).exprange(0.2,0.7)
	)*/
	;

	var env=EnvGen.kr(Env.adsr(atk, 0.1, 1, rel), gate, amp, doneAction:2);

	Out.ar(
		out,
		Pan2.ar(sig*amp, pan)
	)
}).add;

SynthDef(\buf, { arg out=0, bufnum, offset=0, amp=0.3;
	Out.ar(out, PlayBuf.ar(2, bufnum, BufRateScale.kr(a), 1, s.sampleRate*offset) * amp)
}).add
)

(

var t= TempoClock.tempo=(67/60);

// forme de l'accompagnement
var grillePrincipale=[
	Prand([0,2, -2]),
	Prand([5,3, 1]),
	Prand([4,2, 0]),
	Prand([3,1])
];
var grille=[
	4b,
	grillePrincipale ! 4,
	4b,
	grillePrincipale.rotate(1) ! 4
].flat;
var dur= [
	4,
	4 ! 16,
	2,
	4 ! 16
].flat;

var formuleAcc=Pseq([0,1,2,3,1, 2, 4,5].reshape(8), inf);

Pdef(\mDroite,
	Pbind(
		\instrument, \a,

		\root, 9,
		\amp, 0.05,
		\legato, 0.95,
		\sust, 1,


		\grille, Pstep(
			Pseq(grille) +[0,2,4],
			Pseq(dur)
		),

		\arpeggiator, formuleAcc,
		\octave, Pif(Pkey(\arpeggiator) < 2, 3, 4),
		\degree, Pfunc({ |ev|
			var accord=ev.grille;
			var index=ev.arpeggiator %3;
			accord.at(index)
		}),

		\dur, Pstep(
			1/4,
			Pseq(dur)
		),
	).trace(\grille, prefix:"accord")
).quant([0,0]);

Pdef(\mGauche,

	Pbind(
		\instrument, \a,
		\legato, 1,
		\root, 9,

		\octave, [2,3],
		\amp, 0.08,


		\degree, Pseq(grille),
		\dur, Pseq(dur)

	).trace(\degree, prefix:"basse")
).quant([0,0]);


Ptpar([
	0, Pn(Pdef(\mDroite)),
	0, Pn(Pdef(\mGauche)),
	])
.play;

t.sched(3,
 	{ Synth(\buf, [bufnum: a, offset:1.75]) }
 );

// t.sched(3+16*4,
// 	{ Synth(\buf, [bufnum: b, offset:8.2]) }
// );

)