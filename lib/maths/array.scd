(

// version collect de PairsDo et doAdjacentPairs

~collectAdjacentTuples={ |ar, fonc, taille=2|
	~eachSub.(ar, taille)
	.collect({ |x| fonc.performList(\value, x) })

};
~collectTuples={ |ar, fonc, taille=2|
	ar.clump(taille)
	.collect({ |x| fonc.performList(\value, x) })

};

// comme select, mais renvoie l'index
// ATTENTION : PARTIALS NE MARCHENT PAS !
/*
~selectIndex.([0,5,1,4,2,1,5,1], {|x| x.even}) ==> [ 0, 3, 4 ]
~selectIndex.([0,5,1,4,2,1,5,1], {_.even}) ==> error
*/

~selectIndex={  |array, function|

	array.collect({ |i, index|
		if(
		(function.(i) == true),
		{index},
		{nil}
		)
	}).reject(_.isNil)
};

//détecte l'array le plus conséquent dans un array multi-dimensions
//
//~selectSize.([ [0,5,1,2,4], [2,4,1,5,1,5,1], [5,4,1] ])

~selectSize={ |arr|
	var x=arr.collect(_.size).maxIndex;
	arr[x]
};

// comme 'shape', mais en mieux
// donne le vrai squelette d'un array multi-dimensionel
/*
~shapePlus.([0,1,[2], [[], 'ti', [[\o, 5], 9, 0], 5] ])
==> [ 1, 1, [ 1 ], [ [  ], 1, [ [ 1 ], 1, 1 ], 1 ] ]

*/

~shapePlus = { |array|

array.collect({ |item|
		(item.isSequenceableCollection).if
		{ ~shapePlus.(item) }
		{1}
	});

};

// découpage automatique d'array en groupe de tailles similaires
// c'est comme 'reshape', mais ça avance incrémentalement
// item par item jusqu'a la fin de l'array
/*
~eachSub.([0,1,2,3,4,5], 2) ==> [ [ 0, 1 ], [ 1, 2 ], [ 2, 3 ], [ 3, 4 ], [ 4, 5 ] ]
~eachSub.([0,1,2,3,4,5], 4) ==> [ [ 0, 1, 2, 3 ], [ 1, 2, 3, 4 ], [ 2, 3, 4, 5 ] ]
*/

~eachSub={ |arr, taille=2|
	(arr.size - taille+1 ).collect({ |i|
		arr[0+i..taille+i-1]
	})
};


// *******************
////////
/// toutes les combinaisons d'une mélodie

///versions pimpés de rotate et permute

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

