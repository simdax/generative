//ACTIVER LA LIB

(

var listeFichiers=["maths", "shape", "contrepoint", "harmonie", "rythme", "forme", "timbre"];
var root="./".resolveRelative;
var paths=listeFichiers.collect({ |i|
	root++i++"/main.scd"
});

paths.collect(
this.executeFile(_);
);

)
//ACTIVER LE MIDI
// par defaut, il détecte "fluid synth"
(

 ~startMIDI.();
 m.connect(~detectMIDIDevice.());

)

// pour MAC, apparement ça fonctionne

(

MIDIClient.init;
m=MIDIOut(0);

//test
m.noteOn(0, 60, 60)
)

