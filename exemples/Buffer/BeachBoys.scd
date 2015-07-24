MIDIClient.init;
m=MIDIOut.connect(0)
m.noteOn(0)
(
PathName("/home/simdax/Musique").entries[3];
a=Buffer.read(s, PathName("/home/simdax/Musique").entries[3].absolutePath)
)
(
{PlayBuf.ar(1,d, startPos: 10 * 1000)}.play;
)
(
SynthDef(\help_autotrack,{arg vol=1.0, beepvol=1.0, lock=1;
var trackb,trackh,trackq,tempo;
var source, beep;

source= PlayBuf.ar(1, a, BufRateScale.kr(a));

#trackb,trackh,trackq,tempo=AutoTrack.kr(source, lock);
	~a=tempo;

beep= SinOsc.ar(1000,0.0,Decay.kr(trackb,0.1));

Out.ar(0,Pan2.ar((vol*source)+(beepvol*beep),0.0));

}).add;
)
)
(
SynthDef(\god, {
	var sig=PlayBuf.ar(1, a, BufRateScale.kr(a), startPos: 24* 1000);
	Out.ar(0, sig)
}).add
)
Synth(\god)
(

var accords=[11,6,9,1];
var couleurs=[0,2,3,7];

Pdef(\grille,
	Pbind(
		\type, \midi,
		\midiout, m,
		\amp, 2,
		\note, Pseq(accords, 4) + couleurs,
		\stretch, 2
	)
).play(quant:1);

Pbind(
	\instrument, \god,
	// \lock, 1,
\dur, 150
).play(quant:1)
)


(
Pbind(
	\instrument, \help_autotrack,
	\lock, 1,
\dur, 150
).play
)