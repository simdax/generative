//catch souris

(
r{
	loop{
		{~io=Platform.getMouseCoords.x}.defer;
		// "jk".postln;
		0.1.wait
	}
}.play
)

(
// version mappée
r{
	loop{
		defer { ~io=Platform.getMouseCoords.x
			.linlin(0, 1300, 0,1) }	;
		0.2.wait;
	}
}.play
)

~io