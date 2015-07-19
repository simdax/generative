/*

~getBuffers.()
"jkljk".postln
~playAllBuffers.()
*/
(
~getBuffers= { |path="/home/simdax/Freesound/snd"|
var folder=PathName(path);

b= Dictionary.newFrom(folder.entries.size.collect ({ |i|

		folder.entries[i].fileName ->
	Buffer.read(s, folder.entries[i].fullPath)
		})
	)
};


~playAllBuffers=
{
	b=~getBuffers.();

r {
b.size.do {|i|
		var buf = b[i];
	buf.query;
	buf.play;
		buf.duration.wait
	}
}.play
};

SynthDef( \bufLoop, { |bufnum=0, rate=1, start=0, end=(-1), env= (Env.perc), da=2|
	var sig;
	var phase=Phasor.ar(0, BufRateScale.kr(bufnum)*rate, start, BufFrames.kr(bufnum)-1, BufDur.kr(bufnum), doneAction:da);
	sig= BufRd.ar(1, bufnum, phase);
	// sig= sig * EnvGen.kr(env);
	Out.ar(0, sig);
	}
).add;

SynthDef( \bufNotes, { |bufnum=0, rate=1, start=0, end=(-1), env= (Env.perc), da=2|
	var sig;
	sig=PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*rate, 1, doneAction:2);

	Out.ar(0, sig);
	}
).add;

SynthDef( \buf, { |bufnum=0, rate=1, start=0, end=(-1), env= (Env.perc), da=2|
	var sig;
	var phase=Line.ar(start, BufFrames.kr(bufnum)-1, doneAction:da);

	sig= BufRd.ar(1, bufnum, phase, 0);
	// sig= sig * EnvGen.kr(env);
	Out.ar(0, sig);
	}
).add;


)
