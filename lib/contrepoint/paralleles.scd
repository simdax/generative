/// créer toutes les doublures possibles par rapport à un set de consonnances
/// ATTENTION, le chiffre grossit très vite selon la taille de la mélodie et le nombre de consonances
// TODO : raffiner pour créer des classes de classes, car très vite le nombre devient très grand !

~eachHarmos={ |mel, cons=#[0, 2,-2]|
	(mel +.t cons).allTuples
};


// Version améliorée de la suite précédente

///// génère tous les accompagnements
///// demandés par rapport à une suite d'intervalles et une mélodie
// avec gestion de 'nil' = consonance aléatoire dans un set

(
~accompagnement={ |mel, mObl=#[nil], consonances=#[2]|
	var mvtsObliges=Pseq(mObl, inf).asStream;
	~convertirMel.(mel).collect({ |i|
		all {: y,
			var x = i, var m=mvtsObliges.next,
			y <- (i-3..i+3)++\rest,
			switch (m)
				{'rest'} {y==\rest}
				{nil} { consonances.includes(x.absdif(y)) }
				{ x.absdif(y) == m };
		}
	}).allTuples
}
)
