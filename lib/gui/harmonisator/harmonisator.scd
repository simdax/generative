// HARMONISATOR

// basiquement, une interface au fichier "matrice"
// qu'on fout dans une fenêtre et qu'on relie à des patterns
// stockés
// on peut interpréter la matrice comme une suite de basse + couleur + probabilité de jouer le truc


// TODO, il faudrait gérer le fait que le nom du player soit celui
// du nom dans le textfield


// EXEMPLES

/*

(
Window.closeAll;

Pdefn(\degree, Pseq([0,1,2,3]));

a=~harmonisator.();
a.matrice.pattern=[0,7,4,5,1,2]
a.matrice.init;


)
*/
(

~harmonisator= {	| fenetre= ( ~fenetre.("harmonisator", 700, 700)) |

	// On set de la grosse fenêtre

	var largeurMatrice = fenetre.bounds.width;
	var hauteurMatrice = fenetre.bounds.height*0.7;
	var largeurBoutons = fenetre.bounds.width;
	var hauteurBoutons = fenetre.bounds.height*0.25;

	var	fenMatrice={
		var fen=
		CompositeView(fenetre, largeurMatrice @ hauteurMatrice )
		.background_(Color.rand);
		fen.addFlowLayout; fen;
	}.value;

	var	fenReglages= {
		var fen=
		CompositeView(fenetre, largeurBoutons @ hauteurBoutons )
		.background_(Color.rand);
		fen.addFlowLayout; fen;
	}.value;


	var matrice=~matrice.(fenetre: fenMatrice);
	var melodie=matrice.pattern;

	// on retourne le tout dans l'event
	var envir=(

		// on met la matrice

		matrice: matrice,
		melodie: melodie,
		fenetre: fenMatrice,
		player:Pdef(\a,
			Pbind(
				\type, \midi,
				\midiout, m,
				\amp, 0.8)
		),

		// TODO, il faudrait gérer le fait que le nom du player soit celui
		// du nom dans le textfield

		name: {|self, name|
			var textSize=name.size*10;
			TextField(fenReglages, textSize@30)
			.string_(name)
			.font_("Arial", 15)
			.action_({ |nom|
				self.melodie=(nom)
			})
		}

	);

	// on initialise

	envir.name("truc de ouf");
	envir.harmoniseur;
	envir.matrice.harmoniser;

	// on définit les boutons d'action

	envir.onOffHarmo= {
		// on choisit avec le hasard

		Button(fenReglages, 50@50)
		.states_([
			["OFF"],
			["en écoute", Color.red]
		])
		.action_({ |bouton|

			var basses=envir.matrice.basses.collect({ |i, index|
				i.wchoose(envir.matrice.sliders[index]
					.collect({ |i| i.value})
					.reject({ |i| i==0 }))
			});
			var couleurs=envir.matrice.couleurs.collect({ |i, index|
				i.wchoose(envir.matrice.sliders[index]
					.collect({ |i| i.value})
					.reject({ |i| i==0 }))
			});

			if (bouton.value==1,
				{
					"basses : ".post; basses.postln;
					"couleurs : ".post; couleurs.postln;

					envir.player=
					Pfset( {},
						Pbindef
						(\a,
							\degree, Pseq(basses) + Pseq(couleurs)),
						{
							{bouton.value_(0)}.defer
						}
					);

					envir.player.play
				},
				{envir.player.stop}
			)
		})
	}.value;

	envir.amp= {
		Slider(fenReglages)
		.value_(0.6)
		.step_(0.1)
		.action_({ |slider|
			Pbindef(\a, \amp, slider.value);
	})}.value;

	// et on renvoie le bidule

	envir;

}

)


