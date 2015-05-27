(

MIDIClient.init;
m=MIDIOut(0)

)

m.noteOn(0, 60, 60)
// jouerMIDI <-
MEL
pas depasser tel ambitus <-
petitsInter,
convertir tel ENV en mel
DUR
activer/desactiver slurs
HARMO
harmo tel mel avec tel rythme harmo et possibilite dis/cons
GRILLE
deduire grille de telle mel
FORME
repeter tel theme, plan harmonique

pbind(
	tel mel


<- themes tt ça



(
Pdef ( 'jouerMIDI', { arg mel, dur=1, amp=0.8;
Pbind(
	'type', 'midi' ,
	'midiout', m,
	'degree', mel,
	'amp', amp,
	'dur', dur
)
});
		Pdef('cheminPlusDroit', {arg mel;

			[mel[0]]++~convertirMel(mel.differentiate.drop(1)).integrate

Pdef('harmoniser', { arg mel, cons, default=2 ;

}
)
)
(
var modulo=7;
Pdefn ('mel', Pseq ( [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] ));

Pbind(
	'type', 'phrase',
			'instrument', 'cheminPlusDroit',
				'mel', Pdefn('mel'),
			'recursionLevel', 3
).trace.play
)

		1++[0, 4]