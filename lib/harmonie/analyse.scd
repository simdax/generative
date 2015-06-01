(

//// fonctions pour transformer une mélodie en ensemble de note sans souci d'intervalles

~reduireHarmo = { |n, modulo=7|
	var note=n%7;
	(note < (modulo/2)).if ({note}, { note - modulo });
};
~convertirMel={ |mels|
	var temp;
	temp=mels.flatten(mels.rank);
	temp=temp.collect(
		~reduireHarmo.(_)
	);
	temp.reshapeLike(mels);
};


/////
///// montre en console une petite matrice avec les possibilités harmoniques

~visualiserAnalyse= { |analyse, r=((0..6)) |
	var roots=~sortSolfege.(r);
	roots.collect({|x|
		analyse.collect(_.includes(x)) })
	.deepCollect(2, {|x| if(x) {'o'}{'x'} })
	.collect({ |i, index|
		((~convertirNotes.(roots[index])).asString+" = "+i).postln
	});
};


)

