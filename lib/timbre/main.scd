(
var paths=["midiConnect.scd"];
paths=paths.collect(
	_.resolveRelative
);
paths.collect(
	this.executeFile(_);
);

)

