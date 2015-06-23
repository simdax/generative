// AU BESOIN INSTALLER LES DEPENDANCES

(
File.copy("../ressource/lib/Grid/Grid.sc".resolveRelative,
	Platform.userExtensionDir++"/Grid/");
thisProcess.recompile
)

//ACTIVER LA LIB

(
var listeDossiers=["maths", "shape", "contrepoint", "harmonie", "rythme", "forme", "timbre", "gui"];
var root="./".resolveRelative;
var paths=listeDossiers.collect({ |i|
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


(
Window.closeAll;

~sequencator.();
)

// pour MAC, apparement ça fonctionne

(

MIDIClient.init;
m=MIDIOut(0);

//test
m.noteOn(0, 60, 60)
)



