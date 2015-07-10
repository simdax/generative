(

// petit fichier pour générer une matrice de boutons
// qui représente une suite d'accords

/*
TODO

0. bug pour une mélodie de 1 note

1. rendre non editable les boutons mis à zero

2. harmoniser selon d'autres règles

3. rendre automatique le changement, sans repasser par un appel de init

*/
/*

(
w=Window.new.front;
// on créée
a=~matrice.();

// on peut setter les boutons manuellement

a.boutons[0][1].value.postln;
a.boutons[0][2].value_(2);

// on peut définir de nouveaux arrays

a.pattern=Array.rand(2, 0,12);
a.init;

// on peut harmoniser

a.harmoniser;

// on a acces aux basses et couleurs, ainsi qu'aux values des sliders

a.basses;
a.couleurs;
a.sliders[0] //premièreRangee
a.sliders[0].collect({ |i| i.value })
a.sliders.deepCollect(2, { |i| i.value}) // toutes les valeurs
)

*/


~matrice={ |pattern=#[0,0], fenetre=(~fenetre.()) |

	var fenMatrice=CompositeView(fenetre, fenetre.bounds.width*1.25 @ fenetre.bounds.height*0.8)
	.background_(Color.rand);
	var fenBoutons=CompositeView(fenetre, fenetre.bounds.width @ fenetre.bounds.height*0.15)
	.background_(Color.rand);

	fenMatrice.addFlowLayout;


	// on définit l'interface de la matrice dans un environement, OO SC style
	e=
	(

		pattern: pattern,

		/////////////////
		////////////////


		init:	{
			arg self;

			// on nettoie tout

			fenMatrice.removeAll;
			fenMatrice.decorator.reset;

			self.use{

				var tailleMelodie=~pattern.size;

				//// variables graphiques


				var largeurPrincipale= fenMatrice.bounds.width;

				var tailleBoutons=((
					 (largeurPrincipale)  / (tailleMelodie+1) / 2
					// le 1 correspond aux noms de notes en rouge sur noir
					// et le * 2 au fait qu'il y ait aussi les sliders
				) - 4 @ 50) ;

				/// fonction pour updater les sliders

				var updateSlider={ |a|
					var v=a.collect(_.value).normalizeSum(1);
					v.collect({ |i, index|
						a[index].value_(i)
					})
				};

				/// setting des boutons

				var boutons=["do", "re", "mi", "fa", "sol", "la", "si"].reverse
				.collect({ |i|
					var x;

					// les premiers boutons pour les notes
					Button(fenMatrice, tailleBoutons)
					.states_([
						[i.asString, Color.red, Color.black]
					]);

					x=Array.fill(tailleMelodie, { |index|
						[
							Button(fenMatrice, tailleBoutons)
							.states_([
								['0', Color.green, Color.yellow],
								['5', Color.yellow, Color.red],
								['6', Color.yellow, Color.red],
								['7', Color.yellow, Color.red]
							])
							.action_({
								self.update;
							})
							,
							Slider(fenMatrice, tailleBoutons)
							.orientation_(\vertical)
						]
					});
					fenMatrice.decorator.nextLine;
					x.flop;
				}).unbubble(2);

				// on sépare les sliders et les boutons

				~sliders=
				tailleMelodie.collect({ |i|
					boutons.collect({ |j|
						j[1][i]
					})
				});
				~boutons=
				tailleMelodie.collect({ |i|
					boutons.collect({ |j|
						j[0][i]
					})
				});

				// on rajoute une fonction aux sliders :

				~sliders.do({ |i|
					i.collect({ |j|
						j.action_({
							updateSlider.(i)
						})
					})
				})

			}
		},

		reinit: { |self, value=0|
			self.use{
				// on remet les boutons à 0
				~boutons.deepCollect(2, { |i|
					i.value_(value)
				});
				// on remet les sliders à 0
				~sliders.deepCollect(2, { |i|
					i.value_(0)
				})
			};
		},



		/////////// ANALYSE

		analyserMel: { |self|

			// TODO, phénomène étrange, topEnvironment ne fonctionne pas dans un use...

			var structure=topEnvironment[\troisAccords].();

				// on chope la mélodie via Pattern proxy
				var melodie= self.pattern;


			topEnvironment[\analyseHarmonique].value(
				melodie,
				structure.choose,
				false);
		},

		// fonction pour changer ce qui doit être harmonisé par rapport à la melodie

		harmoniser: { |self|

			var basses=self.analyserMel;
			self.use {
				// on change les valeurs pour inverser le truc
				~basses= basses.deepCollect(2,{ |i|
					switch(i,
						0,6,
						1,5,
						2,4,
						3,3,
						-3,2,
						-2,1,
						-1,0
					)
				});

				self.reinit(0);

				// on change les boutons comme il faut
				~basses.collect({ |item, index|
					item.collect({ |i|
						~boutons[index][i]
						.value_(1)
					})
				});
				// on change les sliders
				~basses.collect({ |item, index|
					item.collect({ |i|
						~sliders[index][i]
						.valueAction_(0.5)
					})
				});

				//on définit la variable couleur
				~couleurs=~basses.collect({ |i, index|
					i.collect({ |j|
					switch(~boutons[index][j].value,
			0, [0,2,4],
			1, [0,2,5],
			2, [0,2,4,6]
			)
					})
			});

			};
		}
	);

	Button(fenBoutons, 50@50)
	.states_([
		["harmoniser"]
	])
	.action_({
		e.harmoniser
	});

	e.init;
	e;
}

)





