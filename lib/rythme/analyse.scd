
////§§§§***
////ANALYSE

(

//cherche les points de rencontre entre deux rythmes
// ce sont les 0
// (on considère évidemment que les deux mélodies partent en même temps)

~matchPoints= { | dureeUn, dureeDeux |
	(dureeUn.integrate) absdif: (dureeDeux.integrate)
};


//TODO ?
// cette fonction transforme un array de points, en un array de durées
//
// ~points2durees = { |points, array|
//
// }

// fonction qui permet de découper un rythme selon un schema qui regroupe les notes
// ensemble
//~shapeR.([1,2,4,1,2], [1,4]) ==> [1,28]
//~shapeR.([1,2,4,1,2], [1,2,2]) ==> [1,6,3]

~shapeR= { | durees, schema |
	durees.clumps(schema)
	.collect(_.sum)
};


// détecte l'index des points forts d'un rythme, selon une découpe régulière
// pour une seule métrique, envoyer un array singleton
// pour un range, envoyer un chiffre
/*
~detectTpsFort.([4,4,3,4,1,2], [4])
==> [ 0, 1, 2, 5 ]
    // dans une découpe en 4, les temps forts arrivent sur la note numéro 0, 1, 2, et 5
 ~detectTpsFort.([4,4,3,4,1,2], 5)
    // renvoie un array avec une découpe, en 2,3,4 et 5
==> [ [ 0, 1, 2, 5, 6 ], [ 0, 4, 6 ], [ 0, 1, 2, 5 ], [ 0, 4 ] ]

// à utiliser avec shapeR pour voir si cela correspond à des durées régulières
(
var rythme=[4,4,3,4,1,2];
var analyse= ~detectTpsFort.(rythme, 5);
analyse.collect(~shapeR.(rythme, _))

// ==> [ [ 4, 4, 7, 3 ], [ 4, 12, 2 ], [ 4, 4, 7, 3 ], [ 4, 12, 2 ] ]
)

// retourne nil si la métrique ne tombe sur aucune note

(
var rythme=[ 1.625, 0.875, 1.25, 2, 0.875, 1.25, 1.625, 0.5, 1.625 ]
;
var analyse= ~detectTpsFort.(rythme, 5).postln;
analyse.collect( _ !? ~shapeR.(rythme, _))

// ==> [ [ 1.625, 10 ], nil, nil, [ 1.625, 10 ] ]

)
*/

~detectTpsFort={ |durs, metriques=4|

	(metriques.isNumber).if { metriques = (2..metriques) };

	metriques.collect({ |x|
		~myDivAr.( durs.integrate, x)
	})
	.collect({ |res|
		~selectIndex.(res, {|x| x.isInteger })
	})
	.unbubble
	.collect({ |x| (x.isEmpty.not).if {x+1} })
	.collect({ |x| x !? {x.addFirst(0)} })

};


// TODO : filtrer pour trouver la "meilleure" métrique


	~detectMesurePos={ |ry|

	var result=~ttesPossibilites.(ry).collect(
			~detectMesure.( _ )
		);
	// ~selectSize.(result)
	result
	};

/*
~detectMesurePos.([0,1,1]).postln;

*/

)
