
(

var listeFichiers=["math", "shape", "contrepoint", "harmonie", "rythme", "forme", "timbre"];
var root="/home/simdax/Musique/generative/lib/";
var paths=listeFichiers.collect({ |i|
	root++i++"/main.scd"
});

paths.collect(
this.executeFile(_);
);



~startMIDI.();
 m.connect(~detect.());

)





