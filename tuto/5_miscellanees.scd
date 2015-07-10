// Très vite, tu vas sentir une certaine limite au son tout moche du truc par defaut

// Il y a plusieurs choses à faire pour lutter contre cela !!
//
// Un premier truc, c'est PmonoArtic
// C'est sympa, ça permet de faire des articulations plus intéressantes.

(
PmonoArtic( \default,
	\degree, Pseq([0,1,0,0,1,2,2,1,3,5,4,1], inf),
	\legato, 1, //permet de créer des notes liées
	\dur, Pwhite(0.25,0.75)
).play
)


///// MIDI ////


// Le deuxième truc, c'est d'installer un bind avec un sampler MIDI
// c'est très très facile avec SC
// (même si ça peut varier selon les OS, donc quand même regarde la doc à MIDI)

MIDIClient.init
m=MIDIOut(0)
m.connectAll // devrait le faire

// ensuite tu gères

// tes pbind en leur donnant le type midi et ton MIDIOut
// tu gères tes channels via \chan

(
Pbind(

	\type, \midi,
	\midiout, m, // qu'on a défini plus haut
	\chan, Pseq( (0..15), inf ),
	\amp, 0.7, // je mets toujours un peu plus fort pour le MIDI
	\degree, Pwhite(0,6),
	\dur, 0.2
).play
)


// tu peux même assigner très facilement un channel différent à chaque note !
(
Pbind(
	'type', 'midi',
	'midiout', m,
	'degree', [0, 2],
	'chan', [0, 1]
).play

)

// je te propose ce petit truc en méga bonus (permet de simuler une "panic" :
(
g = { 16.do({ |i| m.allNotesOff(i) }) };
CmdPeriod.add(g);
)

///// Quarks /////

// Pleins d'extensions sont présentes car SC est un logiciel libre

// On les voit via
Quarks.gui

// Je mettrai régulièrement des trucs trouvés sur sccode (recherche google) dans le fichier ressources.




//// VOILÀ, maintenant POIEIN /////