(
var paths=["midiConnect.scd", "separer.scd", "buffer.scd"];
paths=paths.collect(
	_.resolveRelative
);
paths.collect(
	this.executeFile(_);
);

)

