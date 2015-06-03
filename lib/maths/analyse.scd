(

// fonction à la base

//TODO : la rendre adaptable aux types de patterns
// répétitions, inversion, détection de motif, etc.

~trouverPattern={ |mel|
	var a=mel;
	all {
		: [rangeUn, rangeDeux],
		drop <- (a.size/2).round(-1).asInt,
		taille <- (a.size/2).round(-1).asInt,
		increment <- (a.size) - (taille*2) -1 -drop,

		var rangeUn=(0+drop..taille+drop),
		var rangeDeux=( (taille+1+drop+increment)..( (taille*2)+1+drop+increment) ),
/*
		::(a[rangeUn]).postln,
		::(a[rangeDeux]).postln,
		::",".postln,*/

		a[rangeUn] == a[rangeDeux]
	};/*
	("trouvé "+b.size+" patterns").postln;
	b.postln;*/
};

// *******************
////////
/// toutes les combinaisons d'une mélodie

~allPerm={ |array|
	(array.size*(array.size-1)).collect({ |i|
		array.permute(i)
	})
};

//// toutes les combinaisons modulaires

~ttesPossibilites={ |x|
	x.size.collect(x.rotate(_))
};



)

