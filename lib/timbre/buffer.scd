/*

~getBuffers.("/home/simdax/freesound/drum")
~lbuf.()
~playAllBuffers.()


(
a=~getBuffers.("/home/simdax/soundfonts/sonatina/sonatina/*/Samples/*ello*/".pathMatch[0])
~lbuf.(a)
*/
*/

(

~buffers=Dictionary.new;

~getBuffers= { |path="/home/simdax/Freesound/snd", extensions=#["wav"]|
var folder=PathName(path);
var buffers=Dictionary.new;

	folder.entries.do ({ |i|
		if( (extensions includesEqual: i.extension))
		{
			var buf=Buffer.read(s, i.fullPath);
			buffers.add(
				buf.bufnum -> buf
			)
		}
	});
	buffers;
};

~lbuf={ |a|
	a.collect({ |k, v|
		("NOM : " ++ k.path ++" NUM : "++ v ).postln;
	});
	"done";
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

(
SynthDef(\warp, {arg buffer = 0, dur=1, pitch=1;
	var out, env;
	env = EnvGen.kr(Env([0.01, 1, 1, 0.01], [0.1, dur, 0.3], 'exp'), doneAction: 2);
	//warp factor of 0.25- stretch sound by 4 times
	out = Warp0.ar(2, buffer, dur, pitch, 0.1, -1, 8, 0.05, 4);
	Out.ar(0, out*env);
}).add;
)

/*SynthDef( \bufNotes2, { |bufnum=0, rate=1, start=0, end=(-1), env= (Env.perc), da=2, n=1, noteDep=1, out=0|

	var phase= Line.ar(0, BufFrames, BufDur.ir(bufnum)/n, doneAction:2);
	var sig=BufRd.ar(1, bufnum,phase);
	Out.ar(out, sig);
	}
).add;

Synth(\bufNotes2, [bufnum:96, n: 9.midiratio])*/

/*SynthDef( \buf, { |bufnum=0, rate=1, start=0, end=(-1), env= (Env.perc), da=2|
	var sig;
	var phase=Line.ar(start, BufFrames.kr(bufnum)-1, doneAction:da);

	sig= BufRd.ar(1, bufnum, phase, 0);
	// sig= sig * EnvGen.kr(env);
	Out.ar(0, sig);
	}
).add;*/


)