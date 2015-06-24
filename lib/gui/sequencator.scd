(
// ~sequencator
// TODO : faire en sorte d'avoir une petite time line
~sequencator={

	var w=~fenetre.("SMS --- Super Mega Sequenceur", 100,100, 1100, 500);
	/*var mel= CompositeView(w, Rect(0, 0, 500, 500));
	var harmo= CompositeView(w, Rect(500, 500, 500, 500));

*/
/*
	w.addFlowLayout(30@30);*/
	~faireMel.();
	~harmonisator.();



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
