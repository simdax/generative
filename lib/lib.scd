
(

var listeFichiers=["analyse", "polyphonie", "mel", "grilleHarmonique", "midiConnect",  "lisibilite", "vecteur", "rythme", "formes", "niou"];
var root="/home/simdax/Musique/generative/lib/";
var paths=listeFichiers.collect({ |i|
	root++i++".scd"
});
paths.collect(
this.executeFile(_);
);



~startMIDI.();
 m.connect(~detect.());

)





