// maintenant on va rentrer un peu plus dans la forme d'un morceau


////// RETOUR SUR LES ENVIR ////////////

// si tu te souviens, un Event ==> ().superclasses est en fait un 'environnement'
// un environnement est en fait une sorte d'objet dans le langage client SC.
// ça permet de setuper des variables et de les utiliser comme valeurs dans les différentes fonctions qui vont appeler à l'intérieur de l'environnement via le message "use"

//j'ai pris ça dans la doc, c'est suffisament clair
(
var f;

// define a function
f = { arg x, y, z; [x, y, z].postln; };

Environment.use({
    ~x = 7;
    ~y = 8;
    ~z = 9;

    f.valueEnvir(1, 2, 3);    // all values supplied
    f.valueEnvir(1, 2);    // z is looked up in the current Environment
    f.valueEnvir(1);    // y and z are looked up in the current Environment
    f.valueEnvir;        // all arguments are looked up in the current Environment
    f.valueEnvir(z: 1);    // x and y are looked up in the current Environment
});
)

// tte petite rq : les ~var sont en fait juste ThisEnvir.put(var)

/*
un pbind c'est ça tout simplement:
un environnement par défaut, possiblement réécrit, dans lequel les valeurs ont un comportement prédéfini, ou bien par l'event, ou bien par le synth qu'on lui donne*/
//on peut transformer l'exemple précédent de cette manière

(
var f, e;

f = { arg x, y, z; [x, y, z].postln; };
e= (x:7, y:8, z:9); //dictionnaire de variables

e.use ({ // on dit que par la suite, toutes les fonctions vont piocher dedans
    f.valueEnvir(1, 2, 3);
    f.valueEnvir(1, 2);
    f.valueEnvir(1);
    f.valueEnvir;
    f.valueEnvir(z: 1);
});
)

// l'exemple plus musical ça donne ça

(
var  template= { arg x, y, z;
	( SinOsc.ar(x)+SinOsc.ar(y)+SinOsc.ar(z) ) * 0.3 // un synthé absurde
};

~event= (x:440, y:880, z:1500); // des valeurs absurdes
~play={
	~event.use ({
	template.valueEnvir
}) // un player qui dit de regarder dans le dico ~event pour jouer mon synthé
};
)

a=~play.play // il faut bien assigner ça a une variable sinon ça s'envole
a.free // on l'arrête
~event= (x:4000, y:200, z:1500); // on redéfinit
a=~play.play; // et voilà
a.free
~event[\x] = ~event[\y]*2; //etc.
a=~play.play;
a.free

////////// FORME MUSICALE //////////////

// pour faire un morceau, l'idée est de décrire une forme basique de manière similaire. On définit des modèles dans des patterns, et on les assemble :

(
var motifs = (
	a: Pbind(\dur, Pwhite(0.5,1), \degree, Pseq([0, 5, 4, 3, 2])),
    b: Pbind(\dur, 0.3, \degree, Pseq([7, 8, 7, 8])),
    c: Pbind(\dur, 0.8, \degree, Pseq([0, 1, 2], 2))
);
// environnement regroupant plusieurs pbind, ( donc des suites d'events, des motifs musicaux en somme )
// RQ : (pwhite trouve une valeur random entre ses deux values) et dans 'c', le motif est répété 2 fois

var morceau =
Pdict(motifs, Pseq([
        \a, \b,
        Prand([\a, \c])
        ], 4)
    );
// le morceau en soi. Pdict va chercher les definitions dans motifs, puis joue a, puis b, et choisit entre a et c, tout ça 4 fois.

morceau.play;
)

/*

les patterns permettent donc de créer des données, qui vont ensuite être lues dans des events, qui ensuite vont être à nouveau re-séquencées dans d'autres patterns !


Tout ça c'est bien, mais au fond, on sent venir la galère auto-référentialo-récursive de bâtard...

Surtout que la, on n'est pas encore temps réel, puisqu'il faut à chaque fois redéfinir une forme en dur, alors qu'on aimerait juste avoir à évaluer les morceaux comme on the fly

on va utiliser un concept plutôt pratique de SC, ce sont les proxys.

//////// LES PROXYS /////////////

Les proxys sont juste des "placeholders", qui vont permettre la manipulation temps réel des patterns

Cette apparition des proxys va créer une sorte de méta-langage dans SC, dans lesquels les variables vont être définies à nouveau d'un nouveau mot :

//////////////////  PDEF //////////////

qui définit un motif dans un proxy,

*/

//petite rq
// 'var' == \var pour nommer les choses
// on peut choisir ;)

// on définit nos pbind via pdef
(

	Pdef('a', Pbind(\dur, Pwhite(0.5,1), \degree, Pseq([0, 5, 4, 3, 2])));
	Pdef(\b, Pbind(\dur, 0.3, \degree, Pseq([7, 8, 7, 8])));
	Pdef(\c, Pbind(\dur, 0.8, \degree, Pseq([0, 1, 2], 2)));

// on voit qu'on ne définit plus de variable dans le langage directement, mais via la construction
// Pdef (name, contenu)
)

// Et on créé une forme musical, c'est-à-dire qu'on définit une séquence de patterns grâce à notre bon vieux Pseq

(

// On remarque ici qu'on a remplacé

Pseq([
	Pdef(\a), Pdef(\b),
	Prand([Pdef(\a), Pdef(\c)]),
	Pdef(\b), Pdef(\b),
	Ppar([Pdef(\a), Pdef(\b), Pdef(\c)]), // Ppar joue les choses de manières simultanées
        ], 2)
    .play;
)

// Pdef sert aussi bien à définir qu'à déréférencer
// Pdef (nom, value) créé
// et
// Pdef (nom) déréférence

//Pour le côté pratique, on va utiliser Psym, qui interprète directement un sym ('var' ou \var) comme un Pdef

(
Pdef( \morceau,   // je déclare mon morceau lui-même dans un Pdef pour le réutiliser plus tard
Psym( Pseq([
        \a, \b,
	    Prand([\a, \c]),
	\b, \b,
	    [\a, \b, \c], // remarque ici qu'on peut jouer des choses simultanément. Ça créé un tout, la durée est celle du motif le plus long ==> pas de polyrythmie
        ], inf)
)
).play;
)
//////////////////////// TEMPS REEL ET FONCTIONS ////////////////

// maintenant on peut changer en temps réel les trucs

Pdef('a', Pbind(\dur, Pwhite(0.15, 1), \degree, Pseq([0,5,1,4])));
Pdef('a', Pbind(\dur, Pwhite(1, 2), \degree, Pseq([0,5,1,4])));

//Encore une fois, on a un peu de sucre syntaxique

//pour modifier plus simplement une seule valeur
Pbindef(\b,	\octave, 7)
// ou pareil
Pdef(\b).set(\dur, Pseq([0.1,0.4,1,2,0.5]))


// Il est possible de synchroniser les changements apportés à la clock avec la fonction "quant"

==> Pdef('a', Pbind(\dur, Pwhite(0.15, 1), \degree, Pseq([0,5,1,4]))).quant=5;

/*
Mais c'est plutôt des problématique de live coding plus que de génération de musique, donc je laisse ça
de côté */

////////////// un peu de math sur les patterns/////

/*
Bon maintenant on veut commencer les choses sérieuses.
Harmonisation toute simple d'un thème ===> */

//au clair de la lune :)
(
~mel=[0,0,0,1,2,1,0,2,1,1,0];
var dur=[1,1,1,1,2,2,1,1,1,1,4];

Pdef(\mel,
Pbind(
	\degree, Pseq(mel),
	\dur, Pseq([1,1,1,1,2,2,1,1,1,1,4]),
	\stretch, 0.3
	)
);
Pdef(\harmo,
	Pbind(
		\degree, Pcollect({ |ev| ev[\degree]+3 }, Pdef(\mel)),
		\dur, Pseq(dur),
		\stretch, 0.3
	)
);
/*Pbindef(\harmo,
	\octave, 5
)*/
)

(
Psym(
	Pseq([
	\mel,
	[\mel, \harmo]
	], inf)
).play
)

// pendant le workflow, on change le type d'harmo
Pdef(\harmo).play

(
Pbindef(\harmo,
		\degree, Pcollect({ |ev| ev[\degree]+2 }, Pdef(\mel)),
)
)
(
Pbindef(\mel,
	\degree, Pseq([0,1,2,3]))
)

