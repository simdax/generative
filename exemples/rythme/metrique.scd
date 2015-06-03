(

var mel =~melBienFormee.();
var melH=mel[0];
var melR=mel[1];

var indicesBasse=~selectSize.(~detectMesure.(mel[1], 4));
var schema=indicesBasse.add(melR.size-2).differentiate+1; // ça c'est moche oui

var basses= [
	melH.atAll(indicesBasse),
	~schemaR.(melR, schema).postln
];

("on trouve "++indicesBasse.size++" points de régularité à "++indicesBasse).postln;

~genMel.(mel);
~genContinuo.(basses);

~morceauBasique.();

Pn(( Pdef(\morceau) <> (type: \midi, midiout: m) ), inf).play

)


