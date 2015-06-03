(
var paths=["vecteur.scd", "structure.scd", "polyphonie.scd", "analyse.scd"];
paths=paths.collect(
	_.resolveRelative
);
paths.collect(
	this.executeFile(_);
);

)

