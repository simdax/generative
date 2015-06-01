//// pour classer les consonnances ??

~sortSolfege={ |mel, ordreGrandeur=#[0,1, 2, 3, -3, -2, -1]|
	~convertirMel.(mel).sort({ |a, b|
		ordreGrandeur.indexOf(a)
		< 		ordreGrandeur.indexOf(b)
	})
};


// permet de définir une grille par rapport à une basse harmo
// de base, definit juste trois accords majeurs, do fa sol
// TODO : faire en sorte que la structure se répètent aussi
// pour s'accorder avec les basses, et pouvoir créer des grilles
// de style jazzy

//(type est pour définir des structures de clusters ou quartes

~structureHarmonique ={ | accords=#[0,3,-3], structure=3, type=2 |
	accords.collect(
		Array.series(structure, _, type)
	);
} ;

~troisAccords={ |ml=#[0,1,2,3,4,5,6], modulo=((-3..3))|
	var mil, accords, resultat;
	mil=~convertirMel.(ml);
	accords=all{
		: Set[x,y,z],

		x <- modulo,
		y <- modulo,
		z <- modulo,

		var mel=mil.as(Set),
		var a=~convertirMel.(Array.series(3, x, 2)).as(Set),
		var b=~convertirMel.(Array.series(3, y, 2)).as(Set),
		var c=~convertirMel.(Array.series(3, z, 2)).as(Set),
		var d=  (a | b | c),
		// var mel=~convertirMel.(ml),
		// ::d.postln,
		// ::mel.postln,
		mel == d
	};
	resultat=accords.species.new(accords.size);
	accords.collect({|i|
		if ( resultat.collect(_ == i).includes(true) ,
			{},
			{resultat.add(i)}
		)
	});
	resultat.collect(_.as(Array))
	.collect(_+.t [0,2,4]);
};

//FIX !!

~quatreAccords={ |ml=((..12)), modulo=((-6..6))|
	var mil, accords, resultat;
	 mil=(ml);
	accords=all{
		: Set[x,y,z, w],

		x <- modulo,
		y <- modulo,
		z <- modulo,
		w <- modulo,

		var mel=mil.as(Set),
		var a=(Array.series(4, x, 2)).as(Set),
		var b=(Array.series(4, y, 2)).as(Set),
		var c=(Array.series(4, z, 2)).as(Set),
		var e=(Array.series(4, w, 2)).as(Set),
		var d=  (a | b | c | e),

		 ::d.postln,
		 ::mel.postln,
		mel == d
	};
	resultat=accords.species.new(accords.size);
	accords.collect({|i|
		if ( resultat.collect(_ == i).includes(true) ,
			{},
			{resultat.add(i)}
		)
	});
	resultat.collect(_.as(Array))
	.collect(_+.t [0,2,4,6]);
};
~analyseHarmonique={ |mel,structAccords=(~structureHarmonique.())|
	var result=
	~convertirMel.(mel)
	.collect({ |i|
		~convertirMel.(structAccords).collect({ |j|
			j.includes(i).if
			(j.first)
		})
	})
	.collect( _.reject(_.isNil) );
	~visualiserAnalyse.(result);
	result

};