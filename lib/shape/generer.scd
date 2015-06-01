(


////// génère une mel "à peu près" logique, pas trop de sensible
/// TODO, enlever des écarts nuls style 'fa-si'


~genererMel={ |nbNotes =((6..10).choose)|
	var mel=~verifierRepetitions.(
	Array.fill(nbNotes, { [0,1,2,3,4,5,6]
		.wchoose([0.4,0.25 ,0.25 ,0.35 ,0.4 ,0.25 ,0.15 ].collect(_/(1/0.5)))})
 );
	("mel généré = " ++mel).postln;
	mel
};


////
////  Essai d'utilisation d'une Env() pour générer une mélodie
////

~genererMeldepuisEnv={ arg ambitus, enveloppe=Env(), nbNotes=20, modulo=7;
	b= enveloppe.discretize(nbNotes);
c = b.linlin(b.minItem, b.maxItem, 0, ambitus)
.nearestInScale(~tetracorde, modulo)
}


)