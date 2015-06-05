
/////
///// ensemble de fonctions pour générer à partir d'un thème
///// les transformations contrapuntiques qui peuvent s'harmoniser
///// avec l'original


(

// analyserIntervalles sort tous les intervalles possibles entre une mélodie et plusieurs
// autres, tout en variant le placement rythmique de la première.
// avec changements rythmiques et de hauteur
/// TODO intégrer les changements de hauteurs

~analyserIntervalles={ |mel ... hypotheses|
	~ttesPossibilites.(mel).collect({ |x|
		hypotheses.size.collect(
			x absdif: hypotheses[_]
		)
	}).unbubble(1)
};
// ~analyserIntervalles.( [0,1,2,5], [1,5,7,4], [9, 5])

/// pareil que analyserIntervalles, mais par rapport à elle-même, et avec des transformations
// TODO : la transformer en quelque chose de propre qui analyse le rapport entre une
// mel et un ensemble de fonction qui la transforme, de la forme
// analyse. ( mel,  'neg', { |x| x+4} ) etc.
/// avec visualisation du résultat

~laTotale={ |mel|
	~convertirMel.(
		(0..6).collect({ |i, index|
			~analyserIntervalles.(mel-i, mel, mel.neg, mel.reverse, mel.reverse.neg)
		})
	)
};

//// grosse fonction
// qui calcule automatiquement à partir d'une mélodie
/// l'ensemble de ses propres transformations qui satisfont
/// à quelques règles
//
// pour l'instant on a que des intervalles interdits

// TODO: améliorer les règles, améliorer TOUT


~trouverTransformations={ |mel, notesInterdites=#[3,-3,1,-1]|
	var temp= ~laTotale.(mel);
	("melodie : "++ mel).postln;
	("nb de notes : "++ mel.size).postln;
	temp.collect({ |h, hauteur|
		h.collect({ |d, indexDeca|
		  d.collect({ |i, index|
				(i.includesAny(notesInterdites)).if(
					nil, {case
						{index==0}{("soi-même, décalé de "++indexDeca++" et transposé de "++hauteur).postln; (hauteur+mel).rotate(indexDeca.neg)}
						{index==1}{("inverse, décalé de "++indexDeca++" et transposé de "++hauteur).postln;   (hauteur+mel.neg).rotate(indexDeca.neg)}
						{index==2}{("retrograde, décalé de "++indexDeca++" et transposé de "++hauteur).postln;  (hauteur+mel.reverse).rotate(indexDeca.neg)}
						{index==3}{("inverse retro, décalé de "++indexDeca++" et transposé de "++hauteur).postln;  (hauteur+mel.reverse.neg).rotate(indexDeca.neg)};
				})
			})
		})
	}).deepCollect(2, _.reject(_.isNil));

};

)