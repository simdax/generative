
(

///////////// HELPERS //////////////////////

~melBienFormee={



};



~morceauBasique={ |mel, accords|

	Pdef('mel', mel);
	Pdef('accords', accords);

	Pseq([
		Pdef('mel').trace(prefix:"mel"),
		Ppar([
			Pdef('mel'),
			Pdef('accords').trace(prefix:"accom")
		])
	]).play;
};
~melEtAcc={ |mel|

	var voixPrincipale= ~genPbind.(mel);
	var voixSecondaires=
	{
		var basses=~analyseHarmonique.(
			mel,
			(~troisAccords.().choose)
		);
		(Pbind('chan', 2, 'amp', 0.75) <>
		~genPbind.(
			~filtrerVecteur.(basses.allTuples).postln
			 +.t [0,2,4]
	))
	};

	 ~morceauBasique.(
		voixPrincipale, voixSecondaires.value
	)

};
)
//
// (
// mel=~genererMelodie;
// Pdefn(\mel, Pseq(mel));
// ~morceauBasique.(Pdefn(\mel), )
//
// )