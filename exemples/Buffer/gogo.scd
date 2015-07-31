s.plotTree
s.meter


(
TempoClock.tempo=1.929;

a=Pdef(\grille2).trace.play(quant:0);
b=Pdef(\play).play(quant:0);
//
TempoClock.sched( 2 + 0.1 ,
	{Synth(\god)}
	);
Synth(\reverb, [\in, 17, \out, [0,1] ], s, \addToTail)

)

play {	PlayBuf.ar(2, 92) }
Synth(\buf)

(
SynthDef(\harp, { arg rate=1, out=0;
	var phase=Line.ar(0, BufFrames.kr(a)-1, dur: BufDur.kr(a)*rate.reciprocal, doneAction:2);
	var sig=BufRd.ar(1, a, phase);
	Out.ar(out, sig);
})
.add)
Synth(\harp, [rate:1, out:0])
s.plotTree
(
Pbind(
	\instrument,\harp,
	\rate, (Pseq([
		[10,3,6], [0,5,9], [0,4,7]
].midiratio))
).play
)