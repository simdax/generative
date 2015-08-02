
a=MP3.readToBuffer(s, "C:/Users/zob/Documents/GitHub/generative/generative/ressources/Nouveau dossier/Beach Boys - God Only Knows ( Vocals Only - Pet Sounds Sessions ).mp3")

s.plotTree"C:/Users/zob/Documents/GitHub/generative/generative/ressources/Nouveau dossier/Beach_Boys_-_God_Only_Knows_Vocals_Only_-_Pet_Soun.wav"

a.play

(
TempoClock.tempo=1.929;

a=Pdef(\grille2).trace.play(quant:0);
b=Pdef(\play).play(quant:0);
//
TempoClock.sched( 2 + 0.1 ,
	{Synth(\god)}
	);


)

