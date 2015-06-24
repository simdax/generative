(
// ~sequencator
// TODO : faire en sorte d'avoir une petite time line
~sequencator={


	var w=~fenetre.("SMS --- Super Mega Sequenceur", 1100,1000);
	var mel= CompositeView(w, 500@500).background_(Color.rand);
	var harmo= CompositeView(w, 500@500).background_(Color.rand);
	mel.addFlowLayout;
	harmo.addFlowLayout;

	~melodisator.(mel);
	~harmonisator.(harmo);



	Button(w, 100@100)
	.states_([
		["Jouer en boucle ???"],
		["stop ????"]
	])
	.action_({ |self|
		switch(self.value,
			1, {
		"hauteurs : ".postln;
		Pdefn(\deg).source.postcs;
		"rythme : ".postln;
		Pdefn(\dur).source.postcs;

		Psym(
			Pseq(
				[
					[\melodie, \accompagnement]
				],
				inf)
			).play(quant:1) },

			0, {     CmdPeriod.run } // oui c'est un peu feinteux :)
		)
	});

	Button(w, 100@100)
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
