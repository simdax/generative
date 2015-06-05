(



// découpage automatique d'array en groupe de taille similaires
// et qui avance item par item jusqu'a la fin de l'array
/*
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

