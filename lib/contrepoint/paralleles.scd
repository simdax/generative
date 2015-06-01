/// créer toutes les doublures possibles par rapport à un set de consonnances
/// ATTENTION, le chiffre grossit très vite selon la taille de la mélodie et le nombre de consonances
// TODO : raffiner pour créer des classes de classes, car très vite le nombre devient très grand !

~eachHarmos={ |mel, cons=#[0, 2,-2]|
	(mel +.t cons).allTuples
};



///// génère l'accompagnement demandé par rapport à une suite d'intervalles et une mélodie

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
	})
}
)

// EXEMPLE
//
// (
// ~mel= [0, 4, 2, 3,4,5,1,3,7,5,4];
// a=~accompagnement.(~mel, [2, 1, 2]).allTuples;
//
// p=a.collect(_.reject(_=='rest')).select({ |i| (i.sum).isPositive });
// ("les positives: "+p.size).postln;
// n=a.collect(_.reject(_=='rest')).select({ |i| (i.sum).isNegative });
// ("les negatives: "+n.size).postln;
//
//
// ~res=~mel+++(n.choose).postln;
//
// (Pbind(\degree, Pseq([0, 1, 2, 3]) +.x
// Pseq(~res, inf), \dur, 1) ).play
//
// )
