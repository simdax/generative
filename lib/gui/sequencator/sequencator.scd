(

/*
ensemble d'un melodisator et d'un harmonisator
(

~balancerMel.()

)
*/

~balancerMel={
	arg fenetre=~fenetre.();

	var general, mel, harmo;

	general=CompositeView(fenetre, fenetre.bounds).background_(Color.black);
	general.addFlowLayout(15@15, 15@15);

	mel= CompositeView(general,
	(general.bounds.width/2)@(general.bounds.height))
	.background_(Color.rand);

	harmo= CompositeView(general,
	(general.bounds.width/2)@(general.bounds.height))
	.background_(Color.rand);

	mel.addFlowLayout;
	harmo.addFlowLayout;
	~melodisator.(mel);
	~harmonisator.(harmo);

};

/*
dirige les patterns
permet de choisir un pattern parmi ceux présents

(
Pdef(\truc,
Pbind(
\degree, Pseq([0,1,2], inf)
)
);

a=~sequencator.()
)

*/

~sequencator={ | fenetre=( ~fenetre.() ) |


	// la timeline

	var timeLine=
	(
		fenetre: CompositeView(fenetre, 300@100)
		.layout_(
			HLayout()
		)
		.background_(Color.red),

		patterns: List.new,

		addPatterns: {|self|
			var name=(self.patterns.size+1).asSymbol;
			self.patterns.add(( name -> Pbind() ));
			self.fenetre.children.collect({ |i|
				i.items_(
					self.patterns.collect(_.key)
				)
			})
		},

		ajouterCase:
		{ |self|
			self.fenetre.layout.add({
				var v=ListView(fenetre, fenetre.sizeHint)
				.items_(
					self.patterns.collect(_.key)
				);
				// on rajoute une fonction clique-droit
				v.mouseDownAction={|view, x, y, mod, butNum|
					if (  butNum==1,
						{ "hjk".postln}
					)
				};
				}.value
			)
		},

		player:{ |self, midi=true|
			var ordre=
			self.fenetre.children.collect({ |i|
				i.value
			});
			var dict=a.patterns.collect{ |a|
				[a.key,a.value]
			}.flatten.as(Dictionary);

			ordre=(ordre+1).collect(_.asSymbol);
			x=Pdict(dict,
				Pseq(ordre,	inf)
			);
			(midi).if {~enMidi.(x)} {x}
		}
	);

	//// les boutons

	Button(fenetre, "ajouter une partie".bounds.resizeBy(7, 7))
	.states_([
		["ajouter une partie"],
	])
	.action_({
		timeLine.ajouterCase
	});

	Button(fenetre, "supprimer une partie".bounds.resizeBy(7, 7))
	.states_([
		["supprimer une partie"]
	])
	.canFocus_(false)
	.action_({
		var foc=timeLine.fenetre.children.collect({ |i| i.hasFocus});
		if (foc.includes(true).postln,
			{timeLine.fenetre.children.at(foc.indexOf(true)).remove},
			{timeLine.fenetre.children.postln.last.remove}
		)
	});

	Button(fenetre, "ajouter mel".bounds.resizeBy(10,10))
	.states_([
		["ajouter mel"]
	])
	.action_({
		timeLine.addPatterns
	});


	Button(fenetre, 100@100)
	.states_([
		["Jouer en boucle ???"],
		["stop ????"]
	])
	.action_({ |self|
		switch(self.value,
			1, { /// Ça, c'est pour jouer la mélodie
				timeLine.player.play(quant:1)
			},
			// et ça c'est pour l'arrêter, et oui c'est un peu feinteux :)
			0, {
				timeLine.player.stop
				// CmdPeriod.run
			}
		)
	});

	timeLine;
}
)
