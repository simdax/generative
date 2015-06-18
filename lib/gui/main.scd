(
~fenetre={ |name|
	Window.new(name)
	.front
	.alwaysOnTop_(true)
};

/*
~faireMel.()
*/
~faireMel= {
	var fen, mSlid, button, modes,
	ambitus, scale, nbNotes;

	//on definit un player
	Pdefn(\deg, Pseq([0]));
	Pdef( \player,
		Pbind(
			\degree, Pdefn(\deg),
			\type, 'midi',
			\midiout, m
		)
	);

	// definir fenetre

	fen=~fenetre.("melodisator",0,0,500,500);
	fen.view.decorator_(FlowLayout(fen.bounds));
	mSlid=MultiSliderView(fen, 200@200)
	.isFilled_(true)
	.step_(0.01)
	.elasticMode_(1)
	.size_(10)
	.action_({ |sl|
		sl.value.postln;
		Pdefn(\deg, Pseq(mSlid.value*ambitus.value%scale.value));
				Pdef(\player).source.postcs;

	});

	/// definir les boutons d'interaction

	ambitus=NumberBox(fen, 15@15)
	.value_(10);
	scale=NumberBox(fen,15@15)
	.value_(7);
	nbNotes=NumberBox(fen, 15@15)
	.value_(9)
	.action_({ |obj|
		"prout".postln;
		mSlid.value_(Array.fill(obj.value,0));
		Pdefn(\deg, Pseq ( mSlid.value ));
	});
	fen.view.decorator.nextLine;
	StaticText(fen)
	.string_("nombre de notes");



	/* TODO : un bouton qui change le nombre de notes
	nbNotes= NumberBox(fen)
	.value_(10)
	.valueAction_(
	mSlid !? mSlid.remove;
	mSlid=MultiSliderView(fen);
	mSlid.size_(nbNotes.value);
	);*/

	modes=PopUpMenu(fen, 150@40)
	.items_( [
		"diatonique majeur",
		"diatonique mineur",
		"pentatonique majeure",
		"pentatonique mineure",
		"chromatique"
	])
	.action_({ |b|
		b.value.postln;
		switch(b.value,
		0, {Pbindef( \player, \scale, Scale.major)},
		1, {Pbindef( \player, \scale, Scale.minor)},
		2, {Pbindef( \player, \scale, Scale.majorPentatonic)},
		3, {Pbindef( \player, \scale, Scale.minorPentatonic)},
		4, {Pbindef( \player, \scale, Scale.chromatic)},
		);
		Pdef(\player).source.postcs;
	});

	button=Button(fen)
	.states_([
		["OFF", Color.black],
		["ON", Color.red]
	])
	.action_({ |b|
		if( b.value.asBoolean,
			{
				"on joue ça : ".postln;
		Pdefn(\deg).source.postcs;
				Pdef(\player).play;
				/*mSlid.showIndex_(true);
				fork{
					mSlid.index_();
					Pdef(\player).collect({
						|ev| ev[\dur].wait
					})
				}*/
			},
			{
				"stop".postln;
				Pdef(\player).stop;
			}
		);

	});


};
)

