///// EXORDIUM

// comme tu t'en doutes, ces données vont nous servir à manipuler du son
// néanmoins la syntaxe qu'on a vue tout à l'heure peut paraître parfois un peu lourde

// peut-on trouver plus simple ?

///// un petit problème /////

// Par exemple, on voudrait synchroniser directement nos patterns à l'horloge
// on peut schedulder un pattern à l'horloge via une routine, mais il faut être un peu finaud

a = Pseq([1, 2, 3], inf);
a.iter.play // se passe rien

//en effet, la routine donne 1, puis 2, puis 3, mais ça ne créé aucun side effect

// pour créer du side effect, il faut évaluer une fonction. (cherche pas pour plazy évalue une fonction en temsp réel)

(
a = Pseq([
	Plazy({0.2.postln}), //très court
	Plazy({1.postln}), //court
	Plazy({2.postln}), //moyen
	Plazy({3.postln}),//looong
	Plazy({4.postln}),
], inf);
a.play
)

// MAIS, tu constates sur la console qu'a chaque fois le tempo est modifié

// il va falloir trouver une technique pour séparer tous ces critères différents, les infos chiffrées d'un côté, la durée de l'autre.
//Et en soi ça correspondra aussi à notre manière de faire la musique, les hauteurs, les rythmes, les nuances, tout séparé !


//////////// UN ////////////////


// la plus simple pour arriver à faire est, dans SC, d'utiliser un "event"
// un event est un dictionnaire d'évenement, un hash tout bête

().class // <--- un event vide
('entreeUn' : 0 , 'entreeDeux': 1) // un event rempli
('entreeUn' : 0 , 'entreeDeux': 1).class.superclasses //un event est un dictionnaire

//si j'envoie à mon event le message "play", il se passe un truc magique dans SC.
// en effet, un "default Event" apparait : (CTRL + B pour booter le server) EEEEEEEEEEEEEEET

().play // un son !

//que se passe-t-il ?!!


//il se passe qu'un event vide qui reçoit play se fournit automatiquement en pleins d'infos

/*En fait il n'est pas vide, il se remplit du style

(telnote : truc, telleduree: machin, telHarmonique:bidule)

etc.*/

//ses infos viennent d' "events parents"

Event.parentEvents; //un hash bordelique
Event.parentEvents.keys // celui qui nous interesse s'appelle default
Event.parentEvents.default.keys // on voit qu'il y a plein de trucs par defaut

//le default event implémente des bouts de "partial event"

Event.partialEvents.keys // amplitude, durée, pitch et autres joyeusetés
Event.partialEvents.pitchEvent.scale //une gamme majeure par defaut
Event.partialEvents.pitchEvent.scale == Event.parentEvents.default.scale // c'est pareil
Event.partialEvents.pitchEvent.scale === Event.parentEvents.default.scale // non seulement en égalité mais aussi en identité




/////////////// DEUX //////////////



//tu peux changer les comportements en tripatouillant tout ça.
// ça marche comme dans un hash
// (name : value)

//Autant te dire que les plus importants sont simples :

(

(midinote: [60, 68, 50], //hauteur
dur: 0.6, //temps
amp: [0.5, 0.2, 0.8]) // volume
.play

) // c'est moche ! :)


//ici on voit qu'on a eu un accord
//en effet, un array de note fait un accord

//pour faire une seule note, on va faire la même chose avec juste une seule valeur

(
(freq: 440, //on a freq qui remplace midinote
sustain: 0.6, //on peut calculer juste le sustain, en pourcentage de note
db: 0.51) // db remplace amp. le volume ici est un peu fort :)
.play
)
// ici j'illustre qu'il y a plein de variables possible dans notre event,
// ET
// qu'elles sont plus ou moins equivalentes
// on verra ça plus tard


///////////// TROIS //////////////


//comment faire une mélodie ???
//il faudrait lire non plus un event, car un event n'est qu'une seule chose (donc note ou accord), mais une suite d'events !

//pour ça pas mal de choses changent.

// il faut utiliser un objet cool, un EventStreamPlayer, qui stream des event (comme nos ancienne routines) et non des donnees en soi contrairement aux routines et patterns. SC parle de 'event patterns' (patterns qui vont fournir des event en soi ) et 'non-event patterns' (routines qui 'yield' des simples values, chiffres) (ou aussi stream events)

// comment donner des suite de valeurs à nos events ??? On va mettre des routines
// ou mieux encore
// ==> il faut utiliser des patterns qu'on mets dans des events !

(

// nos patterns

var notes=Pseq([60, 68, 50], inf).asStream;
var durees=Pseq([1,2,0.5], inf).asStream;
// NB : l'arg 'inf' permet de boucler le truc et streamer les mêmes values qui se wrappent (bravo le franglais)


// notre routine

x=Routine ({
loop ({ // du coup on peut utiliser une loop comme un batard
(midinote: notes.next, //hauteur
dur: durees.next //temps
		).yield //on fournit l'event
	})
})
.asEventStreamPlayer //et notre player qui
.play; // lit. Les valeurs 'dur' (1,2,0.5) font office de 'wait'

)
// c'est magnifiquement moche

// CTRL + '.' pour stopper le son
// ou juste:
x.stop

// NB : attention de bien assigner la routine à une variable, sinon 'play' donné à une fonction anonyme joue le son 'dans l'air' et on peut plus le retrouver
// n'hésite pas à utiliser  ctrl+'.') !


//////////////// QUATRE ///////

// tout ça est bien complexe,
// on aimerait pouvoir faire juste ça

EventStreamPlayer({1.wait; "des trucs".postln}).play

// ce sucre syntaxique existe dans super collider
//C'est un
///////////// "PBIND"////// !!!!!

// le 'pattern binding" rassemble des patterns ensemble.
// des values, des 'event pattern' voire d'autres pbind dans un gros gros event.

//On peut résumer la fonction d'avant ==>
//Routine({ loop { ().yield } }).asESP.play
// en une écriture plus simple

a=Pbind();
a.play;

// qui fournit un default event en boucle, ou plutôt une liste infinie d'events vides, rempli par l'event par default (cf. plus haut)
a.stop;

//un Pbind peut naturellement être fourni en informations, parce que l'event vide est peu intéressant
(
Pbind(

	\degree, Pseq([0,1,2,4,1,5]), // les notes
	\dur, Pseq([0.8,0.4,1]) // leurs durées

).trace.play // le mot "trace" permet d'afficher et faciliter le debuggage du pbind
)

/// OH ! c'était bien, mais c'était court !

// ==> oui ; le pbind s'est arrêté tout seul, car on a pas mis le 'inf' à nos patterns Pseq.
// si tu te souviens, quand un stream a tout donné, il retourne nil.
// Or, dans un Pbind, dès qu'une information reçoit 'nil', c'est la panique à bord et on arrête tout !

// ICI donc, après nos 3 notes, la key 'dur' a fourni un 'nil' et ça a arrêté la lecture.

// Les patterns ont souvent un critère de répétitions. Un inf itère à l'infini.
(
Pbind(
	\degree, Pseq([0,1,2,4,1,5],inf),
	\dur, Pseq([0.8,0.4,1],inf),
).trace.play
)
// le même Pbind avec une value qui fournit un 'nil' tout de suite ne produit rien :
(
Pbind(
	\degree, Pseq([0,1,2,4,1,5],inf),
	\dur, Pseq([0.8,4,1],inf),
	\caca, Pseq([true, nil]) // au bout d'une note ça va s'arrêter
).trace.play
)



///// CINQ //////

// on voit donc en fait que les pbind ne sont que des sortes de controles
// Ces controles contrôlent des instruments, en leur fournissant en continu (ou non) des value via des "patterns" aka des fonctions threadées (=routine) avec un comportement prédéfini

//ces values elles mêmes sont linkées à des clefs, ici \degree, \dur etc.
// a quoi correspondent exactement ces clefs ??
// ces clefs sont en fait des inputs d'un instrument, un synth,
// mais quand on précise pas d'instrument et bien c'est le synthé par défaut qui est utilisé

(\instrument: \default).play // pareil que ().play
(\instrument: \uneGrosseBlague).play //il va pas être content, il va rien jouer du tout

// tu vois qu'on peut utiliser un synthé défini par nous-même

//Dans SC, un synth n'est qu'une fonction avec des args

(
SynthDef( 'synthNiou', { arg trucdeOuf=1, freq=440;
	var son = SinOsc.ar(freq*SinOsc.kr(trucdeOuf));
	var env= EnvGen.ar(Env.perc, doneAction:2);
	Out.ar(0, son*env)
}).add ;
// bon je rentre pas dans les détails du truc, ce n'est pas le point. C'est un son avec une freq modulée par un oscillateur. Remarque juste l'arg 'trucdeouf' qui donne la valeur de modulation
)

// dans le synth 'synthniou' on voit qu'on utilise des arguments
// et bien, sache que ces arguments sont modifiables dans notre Pbind
// wouahou !

(

(
a=Pbind(
	\instrument, 'synthNiou', // on dit d'utiliser notre synthé
	\freq, Pseq([400, 300, 800], inf), //les freq
	\delta, Pseq([0.8,2,1], inf), // les durées (qu'on appelle ici delta)
	\trucdeOuf, Pwhite(2, 10) // et ici notre nouvelle value. on trouve ici Pwhite qui choisit aléatoirement une valeur entre 2 et 10
).trace.play
)
)

a.stop // quand tu en as marre ou CTRL + '.'


//// SIX ////

//un pbind est donc juste un gros controleur à synthé.
// les tags \freq, \dur sont des choses qui fournissent en fait des valeurs aux arguments de notre synth.
// il n'existe donc pas de valeur par default.
// Le synthé par defaut qu'on utilise utilise juste bêtement la valeur freq et amp, mais d'autres pourraient ne pas les utiliser





//mais on pourrait s'amuser à appeler ça autrement :

(
// ici j'ai remplacé freq par hauteur, amp par volume et trucdeouf par modul

SynthDef( 'synthNiou2', { arg modul=1, hauteur=440, volume=1;
	var son = SinOsc.ar(hauteur*SinOsc.kr(modul));
	var env= EnvGen.ar(Env.triangle, doneAction:2); //changé l'enveloppe pour varier un peu
	Out.ar(0, son*env*volume)
}).add ;


(
a=Pbind(
	\instrument, 'synthNiou2', // on utilise notre synthé
	\hauteur, Pseq([400, 300, 800], inf), //les notes appellées ici hauteur car c'est defini comme ça dans synthNiou2,
\volume, 0.5, //pareil pour volume
	\modul, Pwhite(20, 100) //changé ça aussi
).trace.play
)
)



// tout ça c'est parce qu'on fait des "note event"
// chaque Pbind reçoit un 'type', et en l'occurence le type par defaut est jouer une note (il s'appelle donc note)
// il fournit donc certaines fonctions pour utiliser les clefs qu'il reçoit

// ====>
//les valeurs degree, db, dur sont en fait des valeurs utilisées pas le default event qui fait des calculs qui aboutissent aux trois valeurs fondamentales du synth par default => freq, amp et delta
// il est donc plutôt conseillé d'utiliser ces variables dans ses propres synth

// toutes les conversions de values et les différentes options dans les event sont trouvables ICI : ( noircir + ctrl D)
/*
EVENT types and parameters
*/

(
a=Pbind(
	\instrument, 'synthNiou',

	\degree, Pseq([0,1,2,4,1,2,4,0], inf), //les freq
	// degree convertit par rapport à une scale (definie par defaut cf. plus haut) pour fournir une freq

	\legato, Pseq([0.8,2,1], inf), //encore autre chose. Calcul un pourcentage de sustains entre 0 et 1 par rapport à une durée MAIS
	// le dur n'étant ici pas fourni, il est pris dans le default event AKA 1 seconde

	\trucdeOuf, Pwhite(2, 10), // la même chose qu'au dessus

		\amp, 2000, // t'inquiète pas on l'a pas défini dans notre synth, donc il est dans l'event mais il n'a aucun effet

).trace.play
)


(
a=Pbind(
	\type, \bus,  // à cause de cette ligne, il ne comprend plus rien !!
	\instrument, 'synthNiou',

	\degree, Pseq([0,1,2,4,1,2,4,0], inf), //les freq
	// degree convertit par rapport à une scale (definie par defaut cf. plus haut) pour fournir une freq

	\legato, Pseq([0.8,2,1], inf), //encore autre chose. Calcul un pourcentage de sustains entre 0 et 1 par rapport à une durée MAIS
	// le dur n'étant ici pas fourni, il est pris dans le default event AKA 1 seconde

	\trucdeOuf, Pwhite(2, 10) // la même chose qu'au dessus

		\amp, 2000, // t'inquiète pas on l'a pas défini dans notre synth, donc il est dans l'event mais il n'a aucun effet

).trace.play
)

// VOILA
//pour résumer, on controle des synthés par des dictionnaires qui symbolisent des événements, qui sont prédéfinis par defaut, sauf ce qu'on change :)


//maintenant on va rentrer dans le vrai truc qui nous intéresse
// le calcul des notes :)