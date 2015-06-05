(

/// checke deux mélodies pour voir si elles sont similaires, avec une tolérance d'écart
// de 2 par défaut
/*(
var a= [0,1,2,4,1,2];
var b= a++[1];

~comparer.(a, b, 0 ); //==> false
~comparer.(a, b, 1 ) //==> true

)*/


~comparer={ |melUn, melDeux, tolerance=2|
(melUn.absdif(melDeux).sum) <= tolerance
};


// calcule vite fait la direction mélodique

~direction={ |mel|
	mel.reject(_=='rest').sum;
};


// checke la mélodie avec en moyenne le moins de sauts

// TODO : réfléchir sur quelque chose au niveau d'une pondération des types d'intervalles

~melodieLaMoinsBougeante={ |mels|
mels.at(mels.collect({ |i|
		i.differentiate.abs.drop(1).sum
	}).minIndex)
};

// check le nombre de note en commun entre Deux mels de taille identiques
// sous forme de dictionnaire sous forme d'un array ou l'index correspond à l'index de la note
// et indiquant le nb d'occurence
	//TODO resteindre à la mélodie la plus courte
/*
(
var a = [0,1,2];
var b = [0,1,3];
~notesEnCommun.([a, b]) // [ IdentityDictionary[ (0 -> 2) ], IdentityDictionary[ (1 -> 2) ], IdentityDictionary[  ] ]

)*/

~notesEnCommun={ |mels|
	var result=
	mels.flop
	.collect({ |x, index|
		x.as(IdentityBag).contents
		.select({|y| y>1})
	});
	result.collect({ |dic, index|
		dic.as(Dictionary).keysValuesDo({ |k,v|
			("note :"++index++" occurences de "++v++": "++k).postln;
	})
	});
		result;
};

// TODO renvoyer un boolean

/*
(
var a = [0,1,2];
var b = [0, 2, 4];
~pasDeNotesEnCommun.([a, b])
)*/

~pasDeNotesEnCommun={ |arrays, nbVoix=2|
	var x= arrays.powerset.select({ |x| x.size==nbVoix });
	 x.select({
	 	|x| ~notesEnCommun.(x).every(_.isEmpty)
	 })
};
)