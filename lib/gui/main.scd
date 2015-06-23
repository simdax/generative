(


var listeFichiers=["fenetre", "melodisator", "harmonisator", "sequencator" ];
var root="./".resolveRelative;
var paths=listeFichiers.collect({ |i|
	root++i++".scd"
});

paths.collect(
this.executeFile(_);
)

)
