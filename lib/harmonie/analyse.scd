(

// TODO je pense que les deux fonctions suivantes sont dépréciées, car en fait il y a la fonction
// wrap


//// fonctions pour transformer une mélodie en ensemble de note sans souci d'intervalles

~reduireHarmo = { |n, modulo=7|
	var note=n%7;
	(note < (modulo/2)).if ({note}, { note - modulo });
};

// pareil pour toute une mélodie
~convertirMel={ |mels|
	var temp;
	temp=mels.flatten(mels.rank);
	temp=temp.collect(
		~reduireHarmo.(_)
	);
	temp.reshapeLike(mels);
};




)

