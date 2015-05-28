(
~tetracorde=[0, 1, 2, 3];
~arpege=[0, 2, 4];


~creerMeldepuisEnv={ arg ambitus, enveloppe=Env(), nbNotes=20, modulo=7;
	b= enveloppe.discretize(nbNotes);
c = b.linlin(b.minItem, b.maxItem, 0, ambitus)
.nearestInScale(~tetracorde, modulo)
}

)

(
a=~creerMeldepuisEnv.(3).postln;
Pbind(\degree, Pseq([Pfunc({a})].flatten)).stretch(0.4). play
)
