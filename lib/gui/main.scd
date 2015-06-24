(


var listeFichiers=["fenetre.scd", "melodisator/melodisator.scd", "harmonisator/harmonisator.scd", "sequencator/sequencator.scd" ];
var root="./".resolveRelative;
var paths=listeFichiers.collect({ |i|
	root++i
});

paths.collect(
this.executeFile(_);
)

)
