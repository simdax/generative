(
var paths=["helpers.scd", "aleatoire.scd"];
paths=paths.collect(
	_.resolveRelative
);
paths.collect(
	this.executeFile(_);
);

)

