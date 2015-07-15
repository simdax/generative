(


var listeFichiers=["fenetre.scd", "grid.scd", "score.scd", "boutons.scd", "melodisator/melodisator.scd", "harmonisator/harmonisator.scd","harmonisator/matrice.scd", "sequencator/sequencator.scd" ];
var root="./".resolveRelative;
var paths=listeFichiers.collect({ |i|
	root++i
});

paths.collect(
this.executeFile(_);
)

)
