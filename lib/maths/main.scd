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

//***************************

// découpage automatique d'array

~eachSub={ |arr, taille|
	(arr.size - taille+1 ).collect({ |i|
		arr[0+i..taille+i-1]
	})
};



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
	var y=~detecterDuplicates.(array);
	[array[0]]++array.at(
		y.indicesOfEqual(false)+1
	)
};
~detectNbOccurences={ |array|
	var y=~detecterDuplicates.(array);
	var debut=List[1];
	y.collect({ |x|
		switch (x,
			true, {debut.put(debut.size-1, debut.last+1)},
			false, {debut.add(1)}
		)
	});
	debut
};

///////////////////////////
///////////////
/// simple helpers pour la lisibilité


~convertirNotes={ |x|
	switch (x,
		-3, {"so"},
		-2, {"la"},
		-1, {"si"},
		0, {"do"},
		1, {"ré"},
		2, {"mi"},
		3, {"fa"}
	)
};

~enNotes= { |mels|
	~convertirMel.(mels)
	// .flatten(mels.rank)
	.collect(
		~convertirNotes.(_)
	)
	// .reshapeLike(mels.shape[1]+1);
};

)