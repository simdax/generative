
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
//~schemaR.([1,2,4,1,2], [1,4]) ==> [1,28]
//~schemaR.([1,2,4,1,2], [1,2,2]) ==> [1,6,3]

~schemaR= { | durees, schema |
	var tempus=durees;
	tempus.clumps(schema)
	.collect(
		_.sum
	)
};


// détecte l'index des points forts d'un rythme, selon une découpe régulière
// pour une seule métrique, envoyer un array singleton
// pour un range, envoyer un chiffre
// ~detectMesure.([4,4,3,4,1,2], [4])
// ~detectMesure.([4,4,3,4,1,2], 4) ==> [ [ 0, 1, 2, 3, 4, 5 ], [ 0, 1, 4, 5 ], [ 3, 5 ], [ 0, 1, 4 ] ]

~detectMesure={ |ry, metriques=4|

	(metriques.isNumber).if { metriques = (1..metriques) };

	metriques.collect({ |x|
		~myDivAr.( ry.integrate, x)
	})
	.collect({ |res|
		~selectIndex.(res, {|x| x.isInteger })
	})
	.unbubble

};

// TODO : filtrer pour trouver la "meilleure" métrique

// ~detectMesurePos.(
//
// 	~detectMesurePos={ |ry|
//
// 		var x=~allPerm.(ry).collect(
// 			~detectMesure.( _ )
// 		);
// 		~detectSize.(x)
//
// 	}



)
