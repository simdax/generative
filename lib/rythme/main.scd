(
var paths=["generer.scd", "analyse.scd", "ornementations.scd"];
paths=paths.collect(
	_.resolveRelative
);
paths.collect(
	this.executeFile(_);
);

)

