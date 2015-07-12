
(
~getBuffers= { |path="/home/simdax/Freesound/snd"|
var folder=PathName(path);

b= folder.entries.size.collect ({ |i|

	Buffer.read(s, folder.entries[i].fullPath)
		})
};

b=~getBuffers.();

~playAllBuffers=
{
r {
b.size.do {|i|
		var buf = b[i];
	buf.query;
	buf.play;
		buf.duration.wait
	}
}.play
}

)

(
SynthDef( \buf, { |bufnum=0, rate=1, start=0, end=(-1), env= (Env.perc), da=2|
	var sig;
	var phase=Phasor.ar(0, BufRateScale.kr(bufnum)*rate, start, BufFrames.kr(bufnum)-1, BufDur.kr(bufnum), doneAction:da);
	sig= BufRd.ar(1, bufnum, phase);
	// sig= sig * EnvGen.kr(env);
	 Out.ar(0, sig);
	}
).add
)


Synth(\buf, [\bufnum, 0])

// au clair de la lune :)

(
Pbind(
	\instrument, \buf,
	// \bufPath, 0,
	\rate, Pseq([0, 0, 0, 2, 4, 2, 0, 4, 2, 2, 0].midiratio),
	\dur, Pseq([ 0.5, 0.5, 0.5, 0.5, 1, 1, 0.5, 0.5, 0.5 ,0.5 ,2 ]),
).play
)

0.midiratio
