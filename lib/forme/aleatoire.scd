
(

/// timbre ??
~melange={ |array, nbVoix=2|
	array.powerset
	.select(_.includes(array.first))
	.reject({ |i| i.size!=nbVoix}).postln
	.deepCollect(2, { |i, index|
			i <> (\chan : index,
			// \amp: 0.5*index
		)
		})
};


///// créé une forme à la récitation 11 d' Aperghis
///Pour cela, il faut donner un array de mélodies de même nombre de notes
// et ensuite les mélodies seront distribuées de la sorte

// -> [ [ 0 ], [ 0, 1 ], [ 0, 1, 2 ], [ 0, 1, 2, 3 ] ] etc.

/// TODO : implémenter en parallèle une fonction qui analyse en fonction des notes mélodiques de manière à répartir dans les octaves et les channels

~formePyramidale={ | melodies |


	// on créé la forme pyramidale
	var voix = melodies.size.collect ( ( .. _ ) ).postln;
    var octaves= Array.rand(melodies.size, 4, 8).pyramidg;


		// on définit chaque mélodie selon son id numérique
    melodies.do( { | mel, index |
		Pdefn (index.asSymbol,
			Pseq(mel)
		)
	});

	// et on fait un petit player
	Pdef(\playPyramide,
		Pbind(
			\degree, 	Pnsym ( 	Pseq (  voix ) ),
			// !!! attention ici on considère que toutes les voix ont la même durée
			\chan,  Pstutter(melodies[0].size , Pseq(  voix)).collect(_.asInt),
			\octave,  Pstutter(melodies[0].size , Pseq(  octaves  ))

		)
	)
};


	~morceauBasique={

	Pdef( \morceau,
	Psym(
			Pseq([
		[
			'mel',
			'accords'
		]
	]);
	))
};

~melEtAcc={ |mel|

	var voixPrincipale= ~genPbind.(mel);
	var voixSecondaires=
	{
		var basses=~analyseHarmonique.(
			mel,
			(~troisAccords.().choose)
		);
		(Pbind('chan', 2, 'amp', 0.75) <>
		~genPbind.(
			~filtrerVecteur.(basses.allTuples).postln
			 +.t [0,2,4]
	))
	};

	 ~morceauBasique.(
		voixPrincipale, voixSecondaires.value
	)

};



)