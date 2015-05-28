(

SynthDef(\dissonator, {
	|out = 0, mix = 1.0|
	var filterfreqs = Array.geom(23, 60, 2**(1/3));
	var rq = ((2**(1/3)) - 1) / (2**(1/6));
	var width = 2**(1/6);
	var fmin = filterfreqs / width;
	var fmax = filterfreqs * width;
	var g = { |f| 2.27 * (f**0.477) };
	var snd, mod;
	snd = In.ar(out);
	snd = BPF.ar(snd, filterfreqs, rq);
	mod = SinOsc.ar(0.5 * g.value((0.2*fmin) + (0.8*fmax)));
	mod = (1 - mix) + (mix * mod);
	snd = snd * mod;
	snd = Mix(snd);
	ReplaceOut.ar(out, snd);
}).add;
)

Synth(\dissonator)