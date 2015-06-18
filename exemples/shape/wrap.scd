/// tentative d'écriture mélodique à coup de wrappage de motif

(
var mel=Array.rand(5,0,6).postln;
var mels=Array.fill(8,
	{  Array.series(14,-7,2).collect(
		~wrapMel.(mel, _)
		)
}).postln.flat;

~enMidi.(

	Pbind(
		\degree, Pseq(mels),
		\dur, 0.4

	)
).play

)

