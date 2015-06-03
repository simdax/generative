
(
// GENERATEURS
// On rentre une mel il en ressort du rythme
///// créé du rythme par rapports aux intervalles
///// (en fait par rapport à l'accentuation mélodique...)


//version linéaire
// gros intervalles = grosses durées

~rythmeIntervallique={ | mel, ecarts=#[0.5, 2], type='linlin' |
	var intervalles=mel.differentiate.abs;
	intervalles=intervalles.perform(type, intervalles.minItem, intervalles.maxItem, ecarts.minItem, ecarts.maxItem);
	("rythme généré = "++intervalles).postln;
	intervalles
};


// Fonction générant une mélodie simple sans répétitions
// renvoie un array avec la mélodie et son rythme

~pasRepetitions={ |dessinMel|

	var hauteur=~removeDuplicates.(dessinMel);
	var dur=~detectNbOccurences.(dessinMel);
	[hauteur, dur]
};


//FILTRES


// fonction plus évoluée permettant de slurer n'importe quel rythme de
// n'importe quelle mélodie

// TODO matcher avec les concepts de mesure pour déterminer si il y a des
// passages de mesure ou pas

~ties={ |mel, dur|

	var indices=(~detectDuplicates.(mel).indicesOfEqual(true))+1;
	indices.do({ |i|
		dur[i]=dur[i].neg
	});
	dur
};


// contraindre une mélodie à la durée d'une autre mélodie
// (
// var melUn=[1,5,1,4];
// var melDeux=[0,7,5,4];
// ~dureeGlobale.(melUn, 5);
// ~dureeGlobale.(melUn, melDeux)
// )

~dureeGlobale= { |dureesUn, dureesDeux|
	dureesUn.normalizeSum *
	(dureesDeux.isNumber).if {dureesDeux} {dureesDeux.sum}
};

// affine les durées trop exotiques selon un schema
//~affiner.([ 0.5, 2, 0.875, 2, 2, 1.25, 0.875, 1.625, 1.625 ], 0.25) ==> [ 0.5, 2, 1, 2, 2, 1, 1, 1.5, 2 ]


~affiner={ |ry, rounder=0.5, tolerance = 0.2|

	ry.integrate.collect({ |x|
		var y = x.round(rounder) ;
		(x absdif: y > tolerance).if
		{x}
		{y}
	}).differentiate
};
)



