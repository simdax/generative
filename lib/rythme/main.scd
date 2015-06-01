(
~pasRepetitions={ |dessinMel|

	var hauteur=~removeDuplicates.(dessinMel);
	var dur=~detectOccurences.(dessinMel);
	[hauteur, dur]
};

~genPbind={ |mel|

	mel=~pasRepetitions.(mel);
	("voix et rythme = "++mel).postln;

	Pbind(
		\type, 'midi',
		'midiout', m,
		\degree, Pseq(mel[0]),
		\dur, Pseq(mel[1])
};

)


