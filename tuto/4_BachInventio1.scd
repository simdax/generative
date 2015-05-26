//un dernier petit exemple l'invention numéro un de Bach

// ce morceau ne repose que sur un court motif
// On va pas faire tout le morceau, mais se concentrer sur le début

(
~motif=[0,1,2,3,1,2,0].addFirst(\rest);

~sujet={ |sujet, dur=(1/4)|
	Pbind(
		\degree, Pseq(sujet),
		\dur, dur
	);
};

// On commence par exposer le thème, qui passe de la voix Une à la voix Deux. Quand le thème est à la voix Deux on fait du remplissage.
// puis quand le thème est passé à la voix deux on rappelle le thème à la quinte

// on visualise vite fait ce que ça peut donner
Pseq([
	~sujet.(~motif),
	~sujet.(~motif+4), // transposition
	~sujet.(~motif.neg) // et renversement
]).play;

// c'est un bon début
)
//mais ça va un peu vite peut-être ==>
TempoClock.tempo=0.35


////// LE REMPLISSAGE ///////

// pour le remplissage, on va faire du contrepoint très basique
// on va créer une fonction pour harmoniser
// une mélodie quelconque toutes les deux notes
(
Pdef( \remplissage, { |mel, dur|
	(mel==\rest).if {mel=0};
	// la présence du silence va être gênante, pour l'instant on s'en préoccupe pas plus que ça
	Pbind(
		\degree, mel + [-2, 2].choose, // on harmonise au hasard la note entre la tierce et la sixte
		\dur, dur
	)
});
)

// et on définit, dans une fonction, un pbind qui va piloter
// la fonction de remplissage
(
~harm={ |motif, dureeNotes,
	nbNotes=((motif.size/2).asInt) // ce '2' est arbitraire, il faudrait gérer le type de contrepoint etc. Pour l'instant, on dit que c'est du une note contre deux notes
	|

	Pbind(
		\type, \phrase,
		\instrument, \remplissage,
		\mel, Pseq(motif.atAll(Array.series(nbNotes, 0, 2))),
		// ici on découpe la mélodie pour n'harmoniser qu'une note sur deux
		\dur, dureeNotes
	)
};
)
//on peut tester le bouzin si on veut

Ppar([~sujet.(~motif), ~harm.(~motif.removing(\rest),1/2) ]).play

// OK devrait y avoir d'autres règles dans notre harmonisation bourrine...
// ... mais pour l'instant voyons voir ça comme ça


////// LA FORME ///////

// on n'a plus qu'à définir nos différentes voix
(
var marche=[5,3,1,-1].collect({ |i| ~sujet.(~motif.neg + i , 1/8)});
var marcheN=[5,3,1,-1].collect({ |i| ~motif.neg + i });
// Ici, ces marches permettent de gérer des motifs qui se répètent
// le premier génère la suite d'events (pbind), et la seconde uniquement les notes
// on aurait pu remplace "marche" par "~sujet.(marcheN)", mais bon...

Pdef( \voixUne,
	Pseq( [
		~sujet.(~motif, 1/8),
		~harm.(~motif.removing(\rest), 1/4),
		~sujet.(~motif+4, 1/8),
		~harm.( ~motif.removing(\rest) +4, 1/4),
		marche.()
	].flat)
);
Pdef( \voixDeux,
	Pseq( [
		Pbind(\degree, \rest, \dur, Pseq([1])), // on rajoute un gros silence avant de partir
		~sujet.(~motif, 1/8),
		~harm.(~motif.removing(\rest), 1/4),
		~sujet.(~motif+4, 1/8),
		~harm.( marcheN.().flat, 1/4, 16),
	].flat)
)
)

(
Ppar([
		( Pdef(\voixUne) ),
		( Pdef(\voixDeux) ),
	]).play
)
// et voilà on est partis pour le grand n'importe quoi ...
/////////// DES TRANSFORMATIONS ///////////////

//On va utiliser la composition de fonction, (opérateur <>)
// pour modifier quelques paramètres de notre Event
// ici uniquement la hauteur et la

(
Pdef(\morceau,
Pxrand([     // Pxrand ne répète jamais deux fois la même chose
	Ppar([
		( Pdef(\voixUne) <> (octave:6)),
		( Pdef(\voixDeux) <> (octave:5)),
	]),
	Ppar([
		( Pdef(\voixUne) <> (octave:5, scale:Scale.phrygian)),
		( Pdef(\voixDeux) <> (octave:6, scale:Scale.phrygian)),
	]),
	Ppar([
		( Pdef(\voixUne) <> (octave:7, scale:Scale.majorPentatonic)),
		( Pdef(\voixDeux) <> (octave:4, scale:Scale.majorPentatonic)),
	]),
],inf)
).trace.play
)

/// Voilà, maintenant, il me semble que la méthode à adopter est la suivante. Il ne reste plus qu'à :
// 1. régler les trucs qui ne vont pas
// 2. trouver la forme algorithmique la plus élégante
// 3. changer le thème pour écouter ce que ça donne et voir si il y a encore d'autres règles

//==>
~motif=[0,1,2,3,1,2,0].scramble.addFirst(\rest);

//remonte un peu plus loin dans le code pour réévaluer voixUne et voixDeux
// (pour ne pas à avoir à faire ce truc fastidieux il aurait fallu définir le motif dans un Pdefn ... mais bon là c'est un peu tard)

Pdef(\morceau).play
