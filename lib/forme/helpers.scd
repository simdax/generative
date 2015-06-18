
(

///////////// HELPERS //////////////////////

~melBienFormee={

	var hauteurs=~genererMel.();
	var durees= ~rythmeIntervallique.(hauteurs);
	[hauteurs, durees]

};

// array de hauteur+dur et en sort le Pbind correspondant

~genMel={ |mel|

	Pdef(\mel,
		Pbind(
			\degree, Pseq(mel[0]),
			\dur, Pseq(mel[1]),
			\amp, 1,
			// \legato, 0.8
	))
};

// chope un array de basses + rythme
// par défaut toutes les valeurs wrappent sauf les basses
// TODO ==> ajouter nature accords
/*
~genContinuo.([0,1,2, 1]).play
*/

~genContinuo={ |basses, ry=#[1], natures=#[[0,2,4]]|

	Pdef(\accords,
		Pbind(
			\degree, Pseq(natures, inf) + Pseq(basses),
			\dur, Pseq(ry, inf),
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