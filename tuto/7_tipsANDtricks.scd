/*techniques avancées

On peut jouer avec la hauteur de manière à faire de la mélodie en plusieurs
parties.

*/
(
Pbind(
	\degree, Pseq((0..12)++(11..1), inf), // manière de faire monter et descendre la mélodie
	\octave, Prand([4,5,6], inf) // on répartit au hasard les octaves de chaque note
).play
)

/*

comment créer de la marche harmonique uniquement avec deux deux patterns*/

(
Pbind(
	\degree, Pseq([0,1,2], inf),
	\mtranspose, Pstutter(3, (Pseq([0,1,2,3], inf)))
).play
)

// wrap permet de faire un modulo, et donc d'établir un ambitus à une mélodie

(
var melodie=Array.rand(10, 0, 25).postln;
// génère une mélodie aléatoire de 10 nombres entre 0 et 25

melodie.wrap(0,5)
)

/* on peut donc jouer facilement dans un pattern entre plusieurs niveaux

niveau squelette
niveau "ambité"

*/

(

Pbind(

	\original, Pseq([5,2,7], inf), // il faut préciser inf
	\ambitee, Pfunc({ |ev|
		ev[\original].wrap(0,1)
	}),

	\degree, Pkey(\ambitee)

	).play

)


//// ARPEGGIATOR

// Pindex permet de lire un array de valeur selon l'ordre donné par les indices

// l'idée c'est de prendre un array de tant de valeur
// et de faire un "lecteur" plus ou moins aléatoire de ces valeurs

(
a=Pbind(

	\accord, [0,2,4],
	\arpeggiator, Pseq([0,0,1,0,2,0,1,0]),

	\degree, Pindex(Pkey(\accord), Pkey(\arpeggiator))

).play;

)

// remarque que le pattern wrappe automatiquement

(
a=Pbind(

	\accord, [0,2,4],
	\arpeggiator, Pseq([3,4,5]),
	\degree, Pindex(Pkey(\accord), Pkey(\arpeggiator))

).play;

)

// on peut avec une règle simple, octavier ce qui dépasse

(
a=Pbind(

	\accord, [0,2,4],
	\arpeggiator, Pseq([0,1,2,3,4,5], inf),
	\octave, Pif(Pkey(\arpeggiator) < 2, 5, 6),

	\degree, Pindex(Pkey(\accord), Pkey(\arpeggiator))

).trace.play;

)

/// ENVELOPPE

// on peut appliquer une enveloppe à un pattern

(
Pbind(
	\degree, Pseq([0,1,2,3,4,5,6,7,6,5,4,3,2,1,0]),
	    \amp,  Pseg( Pseq([0.1, 0.5, 0.1],inf), Pseq([7, 7],inf))
).play;
)


// POLYPHONIE

(
// petit exemple montrant comment faire de la polyphonie avec Ptuple

var a=[9, 5, 4, 5, 3, 4]; // on établit une première mélodie
var b=a.scramble; // une deuxième, venant de la première

Pdef(\morceau,

	Pbind(

		\melUn, Pseq((a ! 2).flat), /*on la fait deux fois*/
		\melDeux, Pseq([ \rest ! a.size, b].flat), // on la joue à la deuxième apparition

		\degree, Ptuple( [Pkey(\melUn), Pkey(\melDeux)])
	)
);


Pdef(\morceau).trace.play
)

// à noter le petit bug étrange au niveau du premier accord...

(degree:  [9, \rest] ).play // ??

// REMPLACEMENT ON THE FLY


(
a = [0, 3, 5, 7, 9, 11];
Pdefn(\x, Pseq(a, inf));

p = Pbind(
	\note, Pdefn(\x),
	\dur, 0.3
).play;
)

// remplacement d'un objet de la liste
a[0] = 1;