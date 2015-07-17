// AU BESOIN INSTALLER LES DEPENDANCES
Quarks.gui

(

var listeQuarks = ["TabbedView2"];

a=listeQuarks.collect({ |i|
	(Quarks.isInstalled(i)).not.if
	{Quarks.install(i) ; true };
});

if (a.includes(true), {thisProcess.recompile});

)

// INSTALL CLASSES
(
var classes=PathName("../quark/".resolveRelative).files;
var extDir=PathName(Platform.userExtensionDir+/+"test/").absolutePath;


if ( File.exists(extDir) ) {} {File.mkdir(extDir)};
classes.collect({ arg i;
	j=extDir+/+(i.fileName.replace("scd", "sc")).postln;
	if(File.exists(j))
	{}
	{File.copy(i.absolutePath, (extDir+/+j).absolutePath)}
});

)


//ACTIVER LA LIB

(
var listeDossiers=["maths", "shape", "contrepoint", "harmonie", "rythme", "forme", "timbre", "gui"];
var root="./".resolveRelative;
var paths=listeDossiers.collect({ |i|
	root++i++"/main.scd"
});

var result=paths.collect(
this.executeFile(_);
);

result=result.select({ arg i;
	i.isNil
}).postln;

("il y a "+result.size+"probleme(s)").postln;
if(result.size > 0) {
	"c'est dans".post ;
	listeDossiers.atAll(result.select({ |i| i.isNil}))
} {"tchiop"};

)
//ACTIVER LE MIDI
// par defaut, il détecte "fluid synth"
(

 ~startMIDI.();
 m.connect(~detectMIDIDevice.());

)


// pour MAC (PC ?), apparement ça fonctionne
(

MIDIClient.init;
m=MIDIOut(0);

//test
~no.()
)

(
Window.closeAll;

~mainView.();
)


