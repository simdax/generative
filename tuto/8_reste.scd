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

