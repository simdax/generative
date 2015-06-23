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

	var hauteurPrincipale=500;
	var largeurPrincipale=500;
	var hauteurBoutons=300;
	var largeurBoutons=largeurPrincipale;

	//lien avec la melodie a harmoniser


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
	// fonction pour changer ce qui doit être harmonisé

	var harmoniser={
		var melodie= Pdefn(\deg).source.list.asInteger;

		// on analyse


		var analyse=~analyseHarmonique.(
			melodie,
			~troisAccords.().choose,
			false);


		// on change les boutons comme il faut
		// on stocke le résultat dans pointsRouges

		var pointsRouges=analyse.collect(~deplier.(_)).collect({ |item, index|
			item.collect({ |i|
				~boutons[index][i]
				.states_([
					['5', Color.yellow, Color.red],
					['6', Color.yellow, Color.red],
					['7', Color.yellow, Color.red]
				]);
			})
		});

		// on règle les patterns
		var couleurs=pointsRouges.collect(_.choose).value;
		Pdefn (\basses, Pseq(analyse.collect(_.choose)) );
		Pdefn (\couleurs, Pseq(couleurs.collect({ |i|
			switch(i.value,
				0, [0,2,4],
				1, [0,2,5],
				2, [0,2,4,6]
			)
			})
		));

	};

	// set des patterns et du player

	var	player=
	Pdef(\accompagnement,
		Pbind(
			\type, \midi,
			\midiout, m,
			\degree, Pdefn(\basses) + Pdefn(\couleurs)
		)
	).stop;


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
		["ON"]
	])
	.action_({ |self|
		if (self.value==1,
			{player.play},
			{player.stop})
	});

	initialiserBoutons.();

	Slider(z)
	.value_(0.8)
	.step_(0.1)
	.action_({ |self|
		Pbindef(\accompagnement, \amp, self.value);
	});

};

)
