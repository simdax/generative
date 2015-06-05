
(

///////////// HELPERS //////////////////////

~melBienFormee={

	var hauteurs=~genererMel.();
	var durees= ~rythmeIntervallique.(hauteurs);
	[hauteurs, durees]

};

~genMel={ |mel|

	Pdef(\mel,
		Pbind(
			\degree, Pseq(mel[0]),
			\dur, Pseq(mel[1]),
			\amp, 1,
			// \legato, 0.8
	))
};


~genContinuo={ |acc|

	Pdef(\accords,
		Pbind(
			\degree, [0,2,4] + Pseq(acc[0]),
			\dur, Pseq(acc[1]),
			\amp, 0.7,
			\legato, 1
	))
};

)
//
// (
// mel=~genererMelodie;
// Pdefn(\mel, Pseq(mel));
// ~morceauBasique.(Pdefn(\mel), )
//
// )