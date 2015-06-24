(
// ~sequencator
// TODO : faire en sorte d'avoir une petite time line

~balancerMel={ |fenetre|

	var general, mel, harmo;
	 general=CompositeView(fenetre, Rect(0,0,1050,600)).background_(Color.black);
	general.addFlowLayout(15@15, 15@15);
	 mel= CompositeView(general, 500@500).background_(Color.rand);
	 harmo= CompositeView(general, 500@500).background_(Color.rand);

	mel.addFlowLayout;
	harmo.addFlowLayout;
	~melodisator.(mel);
	~harmonisator.(harmo);

};

~sequencator={ |fenetre|


/*	var w=~fenetre.("SMS --- Super Mega Sequenceur", 1100,1000);
	~balancerMel.(w);*/


	Button(fenetre, 100@100)
	.states_([
		["Jouer en boucle ???"],
		["stop ????"]
	])
	.action_({ |self|
		switch(self.value,
			1, { /// Ça, c'est pour jouer la mélodie
		"hauteurs : ".postln;
		Pdefn(\deg).source.postcs;
		"rythme : ".postln;
		Pdefn(\dur).source.postcs;
		"échelle : ".postln;
		Pdefn(\scale).source.postcs;
		Psym(
			Pseq(
				[
					[\melodie, \accompagnement]
				],
				inf)
			).play(quant:1)
			},
			// et ça c'est pour l'arrêter, et oui c'est un peu feinteux :)
			0, {     CmdPeriod.run }
		)
	});

	Button(fenetre, 100@100)
	.states_([
		["RANDOM", Color.red]
	])
	.action_({
		~randMel.doAction;
		~onOffMel.valueAction_(1);
		~harmoniseur.doAction;
		~onOffHarmo.valueAction_(1);
	})

}

)
