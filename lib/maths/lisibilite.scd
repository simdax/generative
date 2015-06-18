(

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

// TODO : pour plusieurs melodies

~enNotes= { |mels|
	~convertirMel.(mels)
	// .flatten(mels.rank)
	.collect(
		~convertirNotes.(_)
	)
	// .reshapeLike(mels.shape[1]+1);
};



/////
///// montre en console une petite matrice avec les possibilités harmoniques

~visualiserAnalyse= { |matrice, r=((0..6)) |
	var roots=~sortSolfege.(r);
	roots.collect({|x|
		matrice.collect(_.includes(x)) })
	.deepCollect(2, {|x| if(x) {'o'}{'x'} })
	.collect({ |i, index|
		((~convertirNotes.(roots[index])).asString+" = "+i).postln
	});
};

///////////////////////////
///////////////   Petits Helpers rythmiques

~dur2points={ |durs|
	[0] ++ durs.integrate
};
~points2dur= {|points|
	~eachSub.(points, 2)
	.collect(
		(_[0] absdif:  _[1])
	 )
};
)