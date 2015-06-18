(
~fenetre={ |name|
	Window.new(name)
	.front
	.alwaysOnTop_(true)
};

/*
~faireMel.(1)
*/
~faireMel= { |nbNotes=10|
	var fen, mSlid, button, modes,
	ambitus=10, scale=7;



	// definir fenetre

	fen=~fenetre.("melodisator",0,0,500,500);
	fen.view.decorator_(FlowLayout(fen.bounds));

	mSlid=MultiSliderView(fen, 200@200)
	.isFilled_(true)
	.step_(0.1)
	.elasticMode_(1)
	.size_(nbNotes)
	.action_({ |sl|
		sl.value.postln;
		Pdefn(\deg, Pseq(mSlid.value*ambitus%scale));
	});

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
				Pdef(\player).stop;
				mSlid.showIndex_(false);
			}
		);
		Pdefn(\deg).source.postcs
	});

	//on definit un player
	Pdefn(\deg, Pseq([0]));
	Pdef( \player,
		Pbind(
			\degree, Pdefn(\deg),
			\type, 'midi',
			\midiout, m,
			\finish, Pfunc({ button.valueAction_(0)})
		)
	);

};
)


~faireMel.(4)
