(

var mel =~melBienFormee.();
var melH=mel[0].postln;
var melR=mel[1].postln;

var indicesBasse=~selectSize.(~detectMesure.(mel[1], 4));
var schema=indicesBasse.add(melR.size-2).differentiate+1; // ça c'est moche oui

var basses= [
	melH.atAll(indicesBasse), // les basses
	~shapeR.(melR, schema).postln // Le rythme
];

("on trouve "++indicesBasse.size++" points de régularité à "++indicesBasse).postln;
mel.postln;

~genMel.(mel);
~genContinuo.(basses[0], basses[1]);

~morceauBasique.();

 Pn(( Pdef(\morceau) <> (type: \midi, midiout: m) ), inf).play

)


