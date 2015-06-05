(


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

)