(

// comme 'shape', mais en mieux
// donne le vrai squelette d'un array multi-dimensionel
/*
~shapePlus.([0,1,[2], [[], 'ti', [[\o], 9, 0], 5] ]).shape
==> [ 1, 1, [ 1 ], [ [  ], 1, [ [ 1 ], 1, 1 ], 1 ] ]

*/

~shapePlus = { |array|

	array.collect({ |item|
		(item.isSequenceableCollection).if
		{ ~shapePlus.(item) }
		{1}
	})
};

// découpage automatique d'array en groupe de tailles similaires
// c'est comme 'reshape', mais ça avance incrémentalement
// item par item jusqu'a la fin de l'array
/*
~eachSub.([0,1,2,3,4,5], 2) ==> [ [ 0, 1 ], [ 1, 2 ], [ 2, 3 ], [ 3, 4 ], [ 4, 5 ] ]
~eachSub.([0,1,2,3,4,5], 4) ==> [ [ 0, 1, 2, 3 ], [ 1, 2, 3, 4 ], [ 2, 3, 4, 5 ] ]
*/

~eachSub={ |arr, taille|
	(arr.size - taille+1 ).collect({ |i|
		arr[0+i..taille+i-1]
	})
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

