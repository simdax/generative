(

//pour couleur 5, 6, 64
var cinq=[2,4, 7];
var six=[2,5, 7];
var sixQuatre=[3, 5, 7];
var suiteAccords=

[cinq !3, six, sixQuatre !2, cinq, six, six, sixQuatre, cinq]


.reshapeLike( Array.fill(cinq.size, 1) ! 11 )
.collect({ |i| [0] ++ i.scramble })
;


a=5 ! 4; //octaves
b=nil ! 4; // prems diffs

//avec des sons différents
SynthDef( \SinOsc, { arg freq, amp, dur, shape, out=0;
	Out.ar(out,
		Pulse.ar(freq, 0.60)
		*EnvGen.kr(Env.perc(0.1, releaseTime:dur), doneAction:2)
		*amp)
}).add;
SynthDef(\sync, { arg freq, out=0, amp, gate=1;
	Out.ar(out,
		Saw.ar(freq) * EnvGen.kr(Env.adsr(releaseTime:0.2), gate, doneAction:2) *amp )
}).add;



SynthDef( \mechant, {
		arg freq, amp, dur, shape, out=0,
	lFO=40;
	Out.ar(out, LFPar.ar(LFPar.ar(lFO)*freq)*EnvGen.kr(Env.perc(0.1, releaseTime:dur*2), doneAction:2)* (amp/5)
	)
}).add;



Pdef(\a1,
	{ arg mel, cons, voice, maxInter=3, maxAmbitus=7, minAmbitus=3, instr;

		Pbind(

			\lFO, 40,

			\instrument, instr,

			\degree, mel + cons,
			\voice, voice,
			\diff, Pfunc({ arg e;
				var diff;
				var last=b[voice];
				if (last.isNil)
				{last=0};
				diff= e.degree - last;
				b[voice]= e.degree;
				diff;
			}),

			\octave, Pfunc ({ arg ev;
				var inter=ev.diff;
				if ( (inter > maxInter) && ((a[voice]-1) > minAmbitus))
				{a[voice]=a[voice]-1} {};
				if ( (inter < maxInter.neg) && ((a[voice]+1) < maxAmbitus))
				{a[voice]=a[voice]+1}{};
				a[voice]
			}),
			\amp, Pif( cons == 0,
				Pexprand(0.5,0.7) + Pkey(\octave).reciprocal,
				Pexprand(0.15, 0.25) + Pkey(\octave).reciprocal,
			),
		)
	.trace(key: [\instrument])
	}
);

Pdef(\b,
	Pbind(
		\type, \phrase,
		\instrument, \a1,

		// rythme de "au clair de la lune"

		\dur, Pseq([1,1,1,1,2,2,1,1,1,1,4 ], inf),
		\legato, 1,
		\stretch, 1,


		//melodie original ou au hasard
		\mel , Prand([
		Pseq([0,0,0,1,2,1,0,2,1,1,0], inf),
			Pwrand((0..5), [5,2,1].normalizeSum, inf)
		]),

		//harmonie a peu près de au clair de la lune :)
		\cons, Pn(Plazy({
			Pseq(
				suiteAccords, 1
			)
		}), inf),

		// les voix et leur timbre
		\voice, Pfunc({ arg e;
			Array.series(e.cons.size)
		}),
		\instr, Array.fill(4, {[/*\mechant, */\sync, \SinOsc].choose}),


		\finish, Pfunc({ "NEW EVENT !!!".postln; })
	)
).play
)
