(

// fonction à la base de tout
// renvoie l'index de valeurs qui se répètent à l'intérieur d'un array

//TODO : la rendre adaptable aux types de patterns
// répétitions, inversion, détection de motif, etc.

//// TODO : filtrer les résultats pour les rendre plus expressifs !!
/// pas intéressant quand on a ~trouverPatterns.( [1,1,1,1,1] )
// d'avoir [ [ [ 0 ], [ 1 ] ], [ [ 0 ], [ 2 ] ], [ [ 0 ], [ 3 ] ], [ [ 0 ], [ 4 ] ], [ [ 0, 1 ], [ 2, 3 ] ], [ [ 0, 1 ], [ 3, 4 ] ], [ [ 1 ], [ 2 ] ], [ [ 1 ], [ 3 ] ], [ [ 1 ], [ 4 ] ], [ [ 1, 2 ], [ 3, 4 ] ] ]
// c'est TROP informatif !!

~trouverPatterns={ |array|
	var a=array;
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
	}
	.unbubble(2);/*
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

