
(
a=MP3.readToBuffer(s, "/home/simdax/Musique/generative/ressources/audio/Beach Boys - God Only Knows ( Vocals Only - Pet Sounds Sessions ).mp3")
)

(
SynthDef(\cristal, { arg freq, out=0, amp, dur, pan;
	Out.ar(
		out,
		Pan2.ar(
			SinOscFB.ar(freq, FSinOsc.kr(2.5))
			* EnvGate() * amp,
			SinOsc.kr(0.2), 0.4
		)
	)
}).add
)

(
	SynthDef(\tchioup, {
	Out.ar(0,
		Pan2.ar(
			Impulse.ar(LFGauss.kr(15) * 10000,0,0.1),
			FSinOsc.kr(2), 0.4)
	)
		}
	).add
)

Synth(\bufLoop, [bufnum: a, amp:0.25, start:34.5 * 1e5])


(
TempoClock.tempo=1.9268;

Pbindf(Pdef(\grille),
	\strum, 0.5,
	\amp, 0.025,  \instrument, \cristal).trace.play(quant:0);

TempoClock.sched( 48+5 ,
	{Synth(\tchioup)}
);

TempoClock.sched( 48 +1 ,
	{Synth(\bufLoop, [bufnum: a, amp:0.25, start: 34.48 * 1e5])}
);

)

s.prepareForRecord
s.record
s.stopRecording

