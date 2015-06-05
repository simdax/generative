(
//permet de retourner un int quand le résultat est rond
// code emprunté à daniel Meyer

// ~myDiv.(5, 5).class   ==> Integer

~myDiv = { |a, b, prec = 1e-10|
	var q = a/b;
	var qR = q.round;
	q.equalWithPrecision(qR, prec).if { qR.asInteger }{ q }
};


// surcharge de comportements
// ~myDivAr.([5,4,1,2], 3)

~myDivAr = { |a, b, prec = 1e-10|
		a.collect({ |x|
		~myDiv.(x, b, prec)
	})

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