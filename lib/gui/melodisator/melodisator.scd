(

/*
/////TODO :

* faire avec une enveloppe
* faire avec un pen class

* faire un lecteur qui lit les index des notes pour faire voir où on en est de la melodie

*/


/*

créer un outil permettant de régler une mélodie

	//TODO : faire en sorte de donner des ID aux melodies
	// regarder la classer ObjectTable ?

(

a=~melodisator.()
a
)
*/


~melodisator= { |fen=(~fenetre.())|

	// variables

	var melodie, rythme,
	modes,	ambitus, scale, nbNotes,
	player, update,
	envir;


	//on definit un player

	/// definir les boutons d'interaction

	// des variables

	ambitus=NumberBox(fen, 30@30)
	.value_(10)
	.action_({
		update.()
	});
	~texte.(fen.view, "ambitus");

	nbNotes=NumberBox(fen, 30@30)
	.value_((4..9).choose)
	.action_({ |obj|
		melodie.value_(Array.fill(obj.value,0));
		rythme.value_(Array.fill(obj.value,0));
		update.()
	});
	~texte.(fen.view, "nombre de notes");

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


	// les boutons qui sont d'interface, et utilisés par sequencator

	~randAll=Button(fen, 50@50)
	.states_([
		["RANDOM tout" , Color.red]
	])
	.action_({
		melodie.value_(Array.rand(nbNotes.value, 0.1, 1));
		rythme.value_(Array.rand(nbNotes.value, 0.25, 1))
	});

	~randMel=Button(fen, 50@50)
	.states_([
		["RANDOM mélodie" , Color.red]
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

// on définit enfin notre environnement

	envir=
	(

		player:
	Pdef( \melodie,
		Pbind(
			\degree, Pdefn(\deg),
			\dur, Pdefn(\dur),
			\type, 'midi',
			\midiout, m,
			\amp, 1
	)).asESP,

	// et une fonction permettant de l'updater

	update:{ |self|

		// pour l'instant c'est un peu bourrin
		var mel=melodie.value.normalize(0,ambitus.value).round;
		var ry=rythme.value;

		Pdefn(\deg, Pseq(mel));
		Pdefn(\dur, Pseq(ry));
	}

	)


};

)
a.player.source.postcs
a.player.play
