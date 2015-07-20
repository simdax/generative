/*

~getBuffers.("/home/simdax/freesound/drum")
~lbuf.()
~playAllBuffers.()
*/

(

~buffers=Dictionary.new;

~getBuffers= { |path="/home/simdax/Freesound/snd", extensions=#["wav"]|
var folder=PathName(path);


	folder.entries.do ({ |i|
		if( (extensions includesEqual: i.extension))
		{
			var buf=Buffer.read(s, i.fullPath);
			~buffers.add(
				i.fileName -> buf.bufnum
			)
		}
	});
};

~lbuf={
	~buffers.collect({ |k, v|
		("nom : " ++ v ++" num : "++ k).postln;
	})
};

~playAllBuffers=
{


r {
~buffers.size.do {|i|
			var buf = ~buffers[i];
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

SynthDef(\drum, {
	arg out=0, vol, bufnum;
	var sig=PlayBuf.ar(1, bufnum, doneAction:2);
	Out.ar(out, sig*vol);
}).add;

SynthDef( \bufNotes, { |bufnum=0, rate=1, start=0, end=(-1), env= (Env.perc), da=2|
	var sig;
	sig=PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*rate, 1, doneAction:2);

	Out.ar(0, sig);
	}
).add;

/*SynthDef( \buf, { |bufnum=0, rate=1, start=0, end=(-1), env= (Env.perc), da=2|
	var sig;
	var phase=Line.ar(start, BufFrames.kr(bufnum)-1, doneAction:da);

	sig= BufRd.ar(1, bufnum, phase, 0);
	// sig= sig * EnvGen.kr(env);
	Out.ar(0, sig);
	}
).add;*/


)
