(


// *******************
// des helpers pour gérer les données en double dans
// les arrays

~detectDuplicates={ |array|
	var result=List.new;
array.doAdjacentPairs({ |a, b|
		if (
			a==b,
			{result.add(true)},
			{result.add(false)}
		)
	});
	result;
};
~removeDuplicates={ |array|
	var y=~detectDuplicates.(array);
	[array[0]]++array.at(
		y.indicesOfEqual(false)+1
	)
};
~detectNbOccurences={ |array|
	var y= ~detectDuplicates.(array);
	var debut=List[1];
	y.collect({ |x|
		switch (x,
			true, {debut.put(debut.size-1, debut.last+1)},
			false, {debut.add(1)}
		)
	});
	debut.asArray.flatten
};

// fonction améliorée de nbOccurences, avec les motifs
// renvoie l'index de "motifs" qui se répètent à l'intérieur d'un array
// les motifs ne sont pas de simples répétitions

//TODO : la rendre adaptable aux types de patterns
// répétitions, inversion, détection de motif, etc.

//// TODO : je suis sûr que l'écriture de cette fonction est très facilement optimisable

/*
~trouverPatterns.(~genererMel.())
===>
mel générée = [ 4, 1, 0, 3, 0, 0, 3, 1 ]
[ [ 2, 3 ], [ 5, 6 ] ]

~trouverPatterns.([ \o, \x, \x, \x, \x, \o, \x, \o ])
*/

~trouverPatterns={ |array|
	var a=array;
	all {
		: [rangeUn, rangeDeux].unbubble(1),
		drop <- (a.size-2),
		taille <- (a.size/2).floor,
		increment <- (a.size) - (taille*2) -1 -drop,

		var rangeUn=(0+drop..taille+drop),
		var rangeDeux=( (taille+1+drop+increment)..( (taille*2)+1+drop+increment) ),

		a[rangeUn] == a[rangeDeux]
	}
	// .reduce(\union)
	.select({ |x| x[0].isSequenceableCollection})
};





)

