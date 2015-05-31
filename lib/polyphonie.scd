(
~allPerm={ |array|
	(array.size*(array.size-1)).collect({ |i|
		array.permute(i)
	})
};

// permet de créer des ensembles de voix à partir d'une suite d'accords
//  chaque voix représentant un parcourds parmi les possibilités harmoniques

~differencierVoix={ |accords|
	accords.collect( ~allPerm.(_))
	.allTuples
	.collect(_.flop);
};
)
