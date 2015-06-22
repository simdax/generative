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
var w=Window.new;
var un= CompositeView(w, Rect(25, 0, 400, 400));
var deux= CompositeView(w, Rect(425, 400, 400, 400));

~faireMel.(un);

w.front
)
*/


~faireMel= { |fenetre|
	var fen, melodie, rythme, onOff,
	modes,	ambitus, scale, nbNotes;


	//on definit un player

	var player=Pdef( \player,
		Pbind(
			\degree, Pdefn(\deg),
			\dur, Pdefn(\dur),
			\type, 'midi',
			\midiout, m,
			\amp, 1
		)
	).stop;

	// definir fenetre

	(fenetre.isNil).if {fen=~fenetre.("melodisator",500,500)} {fen=fenetre};

	/// definir les boutons d'interaction

	ambitus=NumberBox(fen, 30@30)
	.value_(10);
	~texte.(fen, "ambitus");

	nbNotes=NumberBox(fen, 30@30)
	.value_((4..9).choose)
	.action_({ |obj|
		melodie.value_(Array.fill(obj.value,0));
		rythme.value_(Array.fill(obj.value,0));
	});
	~texte.(fen, "nombre de notes");

	// mes gros sliders que j'aime

	melodie=MultiSliderView(fen, 200@200)
	.elasticMode_(1)
	.step_(0.125)
	.size_(nbNotes.value);

	rythme=MultiSliderView(fen, 200@200)
	.elasticMode_(1)
	.step_(0.25)
	.value_(Array.fill(nbNotes.value, 0.5));

	Button(fen, 50@50)
	.states_([
		["random" , Color.red]
	])
	.action({
		melodie.value_(Array.rand(nbNotes.value))
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
			0, {Pbindef( \player, \scale, Scale.major)},
			1, {Pbindef( \player, \scale, Scale.minor)},
			2, {Pbindef( \player, \scale, Scale.majorPentatonic)},
			3, {Pbindef( \player, \scale, Scale.minorPentatonic)},
			4, {Pbindef( \player, \scale, Scale.chromatic)},
		);
	});

	onOff=Button(fen)
	.states_([
		["OFF", Color.black],
		["ON", Color.red]
	])
	.action_({ |b|
		if( b.value.asBoolean,
			{
				var mel=melodie.value.normalize(0,ambitus.value).round;
				var ry=rythme.value;
				"hauteurs : ".postln;
				Pdefn(\deg, Pseq(mel));
				Pdefn(\deg).source.postcs;
				"rythme : ".postln;
				Pdefn(\dur, Pseq(ry));
				Pdefn(\dur).source.postcs;

				player.play;
			},
			{
				"stop".postln;
				player.stop;
			}
		);

	});


};

)

