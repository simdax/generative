(
var paths=["array.scd", "calcul.scd", "patternMatching.scd", "lisibilite.scd"];
paths=paths.collect(
	_.resolveRelative
);
paths.collect(
	this.executeFile(_);
);

)
