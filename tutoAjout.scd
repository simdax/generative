(

var a=[9, 5, 4, 5, 3, 4];
var b=a.scramble;

Pdef(\morceau,

	Pbind(

		\melUn, Pseq((a ! 2).flat),
		\melDeux, Pseq([ \rest ! a.size, b].flat),

		\degree, Ptuple( [Pkey(\melUn), Pkey(\melDeux)])
	)
);

Pdef(\morceau).trace.play
)

(degree:  [9, \rest] ).play