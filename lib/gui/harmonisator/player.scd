
son=(
// set des patterns et du player

	player:
	Pdef(\accompagnement,
		Pbind(
			\type, \midi,
			\midiout, m,
			\degree, Pdefn(\basses) + Pdefn(\couleurs),
			\amp, 0.6
		)
	).stop.quant=2; // on doit rajouter stop parce que sinon ce con part tout seul...

update:{

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
