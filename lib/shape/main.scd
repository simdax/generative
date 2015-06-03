(
var paths=["generer.scd", "filtres.scd"];
paths=paths.collect(
	_.resolveRelative
);
paths.collect(
	this.executeFile(_);
);

)
