
(
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
	~dureeGlobaleintervalles
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

~ties={ |mel, dur|

	var indices=(~detectDuplicates.(mel).indicesOfEqual(true))+1;
	indices.do({ |i|
		dur[i]=dur[i].neg
	});
	dur
};


// contrainte une mélodie à une certaine durée

~dureeGlobale= { |durees, dur|
	durees.normalizeSum * dur
};




