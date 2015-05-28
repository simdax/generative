(
~mel={ |dessinMel|

	var hauteur=~removeDuplicates.(dessinMel);
	var dur=~detectOccurences.(dessinMel);
	[hauteur, dur]
};

~genPbind={ |mel|

	mel=~mel.(mel);
	("voix et rythme = "++mel).postln;

	Pbind(
		\type, 'midi',
		'midiout', m,
		\degree, Pseq(mel[0]),
		\dur, Pseq(mel[1]),
		\chan, 3,
		\amp, 0.9,
		'legato', 1)/*.trace*/;
};

)


