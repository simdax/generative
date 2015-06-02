//FILTRES
(
~pasRepetitions={ |dessinMel|

	var hauteur=~removeDuplicates.(dessinMel);
	var dur=~detectOccurences.(dessinMel);
	[hauteur, dur]
};

// contrainte à une certaine durée

~dureeGlobale= { |durees, dur|
	durees.normalizeSum * dur
};


// GENERATEURS
// On rentre une mel il en ressort du rythme
///// créé du rythme par rapports aux intervalles
///// (en fait par rapport à l'accentuation mélodique...)


//version linéaire
// gros intervalles = grosses durées
~rythmeIntervalliques={ | mel, ecarts=#[0.5, 2], type='linlin' |
	var intervalles=mel.differentiate.abs;
	intervalles=intervalles.perform(type, intervalles.minItem, intervalles.maxItem, ecarts.minItem, ecarts.maxItem);
	("rythme généré = "++intervalles).postln;
	intervalles
};

)

