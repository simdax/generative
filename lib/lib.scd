// AU BESOIN INSTALLER LES DEPENDANCES
Quarks.gui


// INSTALL CLASSES
/*
~install.("init.scd")
*/

(
~install={ arg p;

	var path=p.[0..p.find(".")-1].postln,
	classes=("../quark/".resolveRelative +/+ p).postln,
	extDir=(Platform.userExtensionDir+/+path).absolutePath.postln;
	if ( File.exists(extDir) )
	{"existe deja".postln;}
	{File.mkdir(extDir)};
	{
		var	j=(extDir+/+path++".sc").postln;
		if(File.exists(j))
		{File.delete(j)} {"preums".postln;};
		File.copy(classes.asString, j);
	}.value;
};

~uninstall={ arg path;



};
)


//ACTIVER LA LIB

(
var listeDossiers=["maths", "shape", "contrepoint", "harmonie", "rythme", "forme", "timbre", "gui"];
var root="./".resolveRelative;
var paths=listeDossiers.collect({ |i|
	root++i++"/main.scd"
});

var result=paths.collect({ |i|
this.executeFile(i);
});

result=result.select({ arg i;
	i.isNil
}).postln;

("il y a "+result.size+"probleme(s)").postln;
if(result.size > 0) {
	"c'est dans".post ;
	listeDossiers.atAll(result.select({ |i| i.isNil}))
} {"tchiop"};

)

//~listFonctions
(
topEnvironment.getPairs.select({ |i, ind| ind.even }).collect(_.postln)
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


