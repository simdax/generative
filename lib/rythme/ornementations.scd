
///ORNEMENTS
(

// ****************
// rythmique

// transforme longue court court en tresillo

//TODO pour l'instant c'est recursif de manière bourrine
// et ça bugue en fait même
//  p etre faudrait il voir à privilégier certaines valeurs
//  objectives de durées (entre 1 et 2 secondes ?)

~funky={ |rythme, depart = #[0.25,0.25,0.5], resultat = #[1.5,1.5,0.5], nbRecursion=1|

	var index=(0..rythme.size-1).detectIndex({ |index|
		rythme.copyRange( index, index+depart.size-1)
		.normalizeSum == depart
});
	rythme=rythme.replace(rythme[index..index+2], resultat);

	(nbRecursion > 0).if
	{ ~funky.(rythme, nbRecursion: nbRecursion-1) }
	{ rythme}

};


// **************
//  rythmico-mélodique
~ornerRythmiquement={

}
)
