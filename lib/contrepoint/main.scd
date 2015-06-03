(
var paths=["generer.scd", "paralleles.scd", "analyse.scd"];
paths=paths.collect(
	_.resolveRelative
);
paths.collect(
	this.executeFile(_);
);

)
