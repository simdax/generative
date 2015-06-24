(

/*
/////TODO :

* faire avec une enveloppe
* faire avec un pen class

* faire un lecteur qui lit les index des notes pour faire voir où on en est de la melodie

*/


/*

créer un outil permettant de régler une mélodie


~faireMel.()

(
var w=~fenetre.("hjl");
var un= CompositeView(w, Rect(25, 0, 500, 500));

~faireMel.(Window.new.front)

)
*/


~melodisator= { |fenetre|

	// variables

	var fen, melodie, rythme,
	modes,	ambitus, scale, nbNotes,
	//TODO : faire en sorte de donner des ID aux melodies
	// regarder la classer ObjectTable ?
	name = "robert",
	player, update
	;

	// definir fenetre

	(fenetre.isNil).if
	{fen=~fenetre.("melodisator",500,500)}
	{fen=fenetre};

	// on donne un nom à notre melodie

	/*~id= TextField(fen, 50@60)
	.string_( name.asString )
*/
	//on definit un player

	player=
	Pdef( \melodie,
		Pbind(
			\degree, Pdefn(\deg),
			\dur, Pdefn(\dur),
			\type, 'midi',
			\midiout, m,
			\amp, 1
	)).stop.quant=2;

	// et une fonction permettant de l'updater

	update={

		// pour l'instant c'est un peu bourrin
		var mel=melodie.value.normalize(0,ambitus.value).round;
		var ry=rythme.value;

		Pdefn(\deg, Pseq(mel));
		Pdefn(\dur, Pseq(ry));
	};



	/// definir les boutons d'interaction

	// des variables

	ambitus=NumberBox(fen, 30@30)
	.value_(10)
	.action_({
		update.()
	});
	~texte.(fen, "ambitus");

	nbNotes=NumberBox(fen, 30@30)
	.value_((4..9).choose)
	.action_({ |obj|
		melodie.value_(Array.fill(obj.value,0));
		rythme.value_(Array.fill(obj.value,0));
		update.()
	});
	~texte.(fen, "nombre de notes");

	// mes gros sliders que j'aime

	melodie=MultiSliderView(fen, 200@200)
	.elasticMode_(1)
	.step_(1/ambitus.value)
	.size_(nbNotes.value)
	.action_({
		update.()
	});

	rythme=MultiSliderView(fen, 200@200)
	.elasticMode_(1)
	.step_(0.25)
	.value_(Array.fill(nbNotes.value, 0.5))
	.action_({
		update.()
	});


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
			0, {Pbindef( \melodie, \scale, Scale.major)},
			1, {Pbindef( \melodie, \scale, Scale.minor)},
			2, {Pbindef( \melodie, \scale, Scale.majorPentatonic)},
			3, {Pbindef( \melodie, \scale, Scale.minorPentatonic)},
			4, {Pbindef( \melodie, \scale, Scale.chromatic)},
		);
	});

	// les boutons qui sont d'interface, et utilisés par sequencator

	~randAll=Button(fen, 50@50)
	.states_([
		["RANDOM" , Color.red]
	])
	.action_({
		melodie.value_(Array.rand(nbNotes.value, 0.1, 1));
		rythme.value_(Array.rand(nbNotes.value, 0.25, 1))
	});

	~randMel=Button(fen, 50@50)
	.states_([
		["RANDOM" , Color.red]
	])
	.action_({
		melodie.value_(Array.rand(nbNotes.value, 0.1, 1));
		rythme.value_(Array.fill(nbNotes.value, 1))
	});

	// le déclencheur !

	~onOffMel=Button(fen, 100@25)
	.states_([
		["jouer ?", Color.black],
		["en écoute", Color.red]
	])
	.action_({ |b|
		b.value.postln;
		if( b.value.asBoolean,
			{
				update.();
				Pfset({},
					player,
					{
						{ ~onOffMel.value =0}.defer;
				}
				).play(quant:2);

			},
			{
				"stop".postln;
				player.stop;
			}
		);

	});

};

)

