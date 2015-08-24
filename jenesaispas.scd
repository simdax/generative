(
a=40;
{
	BPF.ar(
		WhiteNoise.ar(),
		MouseX.kr*300,
		0.5
	)
}.play

)

{LFNoise1.ar(10)}.scope

s.plotTree

(
var mel= Array.rand(6, 0,5);
var dur= (mel.size-1).collect(1);
dur.putLast(2);

Pbind(
	\degree, Pseq(mel +.x mel.reverse),
	\dur, Pseq(dur, 2)
).collect({ |ev| x=ev }).play;

Pbind(
	\degree, Pfunc({ x.degree +[0, 2, 4] })
).play;


)