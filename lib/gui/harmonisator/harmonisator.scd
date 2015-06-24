(

// petit helper, simple question d'esthétique pour partir de "do" plutôt que de "si"

~deplier={|array|
	array.collect({ |i|
		switch(i,
			0,6,
			1,5,
			2,4,
			3,3,
			-3,2,
			-2,1,
			-1,0
		)
	})
};

// grosse fonction bien violente

~harmonisator={ |fenetre|

	// variable pour les fenetres

	var hauteurPrincipale=500;
	var largeurPrincipale=500;
	var hauteurBoutons=300;
	var largeurBoutons=largeurPrincipale;
	var analyse, boutonsCouleur, couleurs; // pour le son

	//lien avec la melodie a harmoniser
	var analyserMel={

		// on chope la mélodie via Pattern proxy
		var melodie= Pdefn(\deg).source.list.asInteger;

		~analyseHarmonique.(
			melodie,
			~troisAccords.().choose,
			false);
	};

	// les affichages

	var initialiserFenetre={

		if (fenetre.isNil,
			{~fenHarmo=Window.new("harmonisator",
				Rect(500,500,hauteurPrincipale,largeurPrincipale)
				).front.alwaysOnTop_(true);
			},
			{~fenHarmo=fenetre});
		~fenHarmo.addFlowLayout;
		~fenBoutons=CompositeView(~fenHarmo, 600 @ hauteurBoutons)
		.background_(Color.yellow);
		z=CompositeView(~fenHarmo, 500 @ 200)
		.background_(Color.red);

		~fenBoutons.addFlowLayout(15@15,5@5);
		z.addFlowLayout(15@15,5@5);
	};

	// on met nos beaux boutons

	var initialiserBoutons={

		var tailleMelodie= (
			if ( Pdefn(\deg).source.isNil,
				0,
				{Pdefn(\deg).source.list.size}
			)
		);

		var tailleBoutons=( largeurPrincipale / (1+tailleMelodie) ) - 8 @ 20 ;

		~boutons=["do", "re", "mi", "fa", "sol", "la", "si"].reverse.collect{ |i|
			var x;
			Button(~fenBoutons, tailleBoutons)
			.states_([
				[i.asString, Color.red, Color.black]
			]);
			x=Array.fill(tailleMelodie,{
				Button(~fenBoutons, tailleBoutons)
				.states_([
					['O', Color.green, Color.white],
				]);
			});
			~fenBoutons.decorator.nextLine;

			x;
		}.flop;
	};


	// set des patterns et du player

	var	player=
	Pdef(\accompagnement,
		Pbind(
			\type, \midi,
			\midiout, m,
			\degree, Pdefn(\basses) + Pdefn(\couleurs),
			\amp, 0.6
		)
	).stop.quant=2; // on doit rajouter stop parce que sinon ce con part tout seul...

	var update={

		// on règle les patterns

		var coul=boutonsCouleur.deepCollect(2, { |i|
			switch(i.value,
				0, [0,2,4],
				1, [0,2,5],
				2, [0,2,4,6]
			)
			});

		// TODO: pour l'instant, on choisit encore aléatoirement les accords

		Pdefn (\basses, Pseq(analyse.collect(_.choose)) );
		Pdefn (\couleurs, Pseq(coul.collect(_.choose)));

	};


	// fonction pour changer ce qui doit être harmonisé par rapport à la melodie

	var harmoniser={

		// on analyse
		analyse=analyserMel.();

		// on change les boutons comme il faut
		// on stocke le résultat dans pointsRouges

		boutonsCouleur=analyse.collect(~deplier.(_)).collect({ |item, index|
			item.collect({ |i|
				~boutons[index][i]
				.states_([
					['5', Color.yellow, Color.red],
					['6', Color.yellow, Color.red],
					['7', Color.yellow, Color.red]
				])
				.action_({
					update.(analyse, couleurs);
				});
			})
		});

		// et on update le son
		update.();
	};


	///// et on y va !

	initialiserFenetre.();

	~harmoniseur=Button(z, 100@30)
	.states_([
		["harmoniser"]
	])
	.action_({
		~fenBoutons.removeAll;
		~fenBoutons.decorator.reset;
		initialiserBoutons.();
		harmoniser.();
	});


	~onOffHarmo=Button(z, 50@50)
	.states_([
		["OFF"],
		["en écoute", Color.red]
	])
	.action_({ |self|
		if (self.value==1,
			{player.play},
			{player.stop})
	});

	initialiserBoutons.();

	Slider(z)
	.value_(0.6)
	.step_(0.1)
	.action_({ |self|
		Pbindef(\accompagnement, \amp, self.value);
	});

};

)
