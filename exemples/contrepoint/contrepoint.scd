
(
b=Array.new;
while(
	{b.size<(7..10).choose},
	{a=[0]++Array.fill((8..10).choose, {(0..5).choose});
		b=~analyse.(a)
		.flatten
		.reject({ |i| i.size==0})
		.unbubble(1)
	;}
);
c=~melange.(b.collect({ |i, index|
	Pbind(
		\type, \midi,
		\midiout, m,
		\degree, Pseq(i),
		\octave, rrand(4,5),
		/*\dur, Pseq(
		Array.fill(5, {(1.0.rand).round(0.2)}), inf
		)*/
	)
}), 2).collect(Ppar(_)).postln;

Pseq(c, inf).trace.play
)

