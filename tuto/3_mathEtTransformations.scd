/*
Bon maintenant on veut commencer les choses sérieuses.
Harmonisation toute simple d'une grille ===> */


// Un truc assez chouette avec Pdef, c'est qu'on peut déclarer plus qu'un simple pattern
// On va pouvoir déclarer une fonction qui va nous permettre d'avoir des patterns avec des
// comportements un peu plus intéressants que des simples routines qui servent le couvert

( // dans ce pdef , je déclare un pbind auquel je fournis des arguments par défaut. Dans le Pbind, je fais de la mathesis universalis pour simuler habilement la notion d'harmonisation :)

Pdef(\a, { | basse=(Pseq((..12))), harmo=(Pseq([2, 4], inf)) |
	Pbind(
		\degree, Pn(basse + harmo),  // Pn est une manière plus de faire Pseq([UneSeuleValeur], inf)
	)
})
)
Pdef(\a).play // tu remarques en passant qu'en ne fournissant aucune durée on a une durée d'une seconde par défaut
//si on analyse, notre melodie est une montée ascendante de 0 à 12 (de do à la douzième de do = sol si je ne m'abuse)
// mais en même une note sur deux est harmonisée soit par la tierce soit par la quinte, ce qui fait un zouli dessin mélodique.


// à la base de ça, il y a un objet un object s'appellant PlazyEnvirN
// je te montre ça pour le plaisir
(
a = PlazyEnvirN({ | basse=0, harmo=(Pseq([2, 4], inf)) |
	Pbind(
		\degree, Pn(basse + harmo),  // Pn est une manière plus simple de faire Pseq([UneSeuleValeur], inf)
	)
})
)

( a <> (basse: (Pseq([3, 2, 6, 5, 2], inf)) )).trace.play
// le signe <> est un opérateur de composition. On prend les valeurs à droite pour nourrir l'opérande de gauche.
// Ici je mélange ma fonction a avec un environnement, dans lequel je ne précise qu'une seule valeur, les autres étant prises par défaut.


//maintenant, au lieu d'utiliser un environnement
// cette chose-là peut se faire avec le 'type' phrase

(
Pdef(\test,
	Pbind(
		\type, \phrase,
		\instrument, \a,
		\basse, 0,
		\harmo, Prand([0,1,2,3,4,5,6], inf)
	)
).trace.play; // attention à où tu le mets le 'trace'. Si tu le mets sur le pbind au lieu du pdef, ça risque de faire des bugs plus tard...
)

// Ce module agit exactement comme une sorte d'improvisateur un peu naz qui joue 6 notes par rapport
// à une basse donnée

//On peut maintenant régler la basse

Pbindef(\test, \basse, 3b) // en passant tu vois une notation particulière pour les bémols

// et on peut même faire une sorte de 'grille'

(
Pbindef(\test,
	\basse, Pseq ([ (0!4), (5!4), (1!4), (4!4)].flat, inf),	 //la construction est remarquable. Si tu te souviens l'opérateur ! permet de créer un array avec la valeur répété. A la fin, pour pas me retrouver avec des arrays d'arrays, je lui dis flat et du coup j'ai cet array
	// [ 0, 0, 0, 0, 5, 5, 5, 5, 1, 1, 1, 1, 4, 4, 4, 4 ]
	\harmo, Prand([0,2,4], inf), // ici je lui dis de jouer que l'accord parfait
)
)

// Pour faire sentir la basse on va rajouter une doublure avec un Pbind
// Il faut choper une des valeurs du pattern qui nous intéresse
// Pour ça Pcollect est bien utile
// il fournit en argument par défaut l'événement le plus récent du pattern choisit
// Cela permet donc de copier des valeurs qui nous intéressent.

~doublure=Pbind (\degree, Plazy( { Pcollect({ |ev| ev[\basse]}, Pdef(\test)) }) ) <> (octave: 3, amp: 1)
~doublure.trace(\degree, prefix:"grosse basse").play(quant:1)
~doublure.stop

// Et on fait un truc un peu feinteux pour faire un rythme un peu plus convaincant (enfin bon, c'est à l'arrache, il risque d'y avoir un certain nombre de notes bofs !) + certainement un certain décalage
//il faudrait régler le truc avec des quantifications, ça je sais pas encore trop faire

(
Pbindef(\test,
		 \dur, Prand([1, 0.5, 0.5, 2], inf),
	// ici on choisit on remue une suite de valeur possible, alias
).quant=1
)


// Et voilà, on vient de recoder improvisator en 50 lignes :)

(
Pdefn( \auClairLuneN, Pseq([0,0,0,1,2,1,0,2,1,1,0]);
Pdefn( \auClairLuneR, Pseq([1,1,1,1,2,2,1,1,1,1,4]);

	)

		Pdef(\a).play

