
(
Pdefn(\motif, Pseq([0,1,2,3,1,2,0].addFirst(\rest));

~sujet={ |sujet, dur=(1/4)|
	Pbind(
		\degree, Pdefn(\motif),
		\dur, dur
	);
});

TempoClock.tempo=0.35;

	Pdef( \remplissage,
	{ |mel, dur, consonnance=(Prand([-2, 2], inf))|
	(mel==\rest).if {mel=0};
	Pbind(
		\degree, mel + consonnance,
		\dur, dur
	)
});
)
(
h=PlazyEnvir( { |note, typeCtrp=2, dur, consonnance |

Pbind(
	\degree, note + Prand([2,2], inf),
)}
)
)
h <> (note:)
)

Pbind().play
Ppar([~sujet.(~motif), ~harm.(~motif.removing(\rest),1/2) ]).play

(
var marche=[5,3,1,-1].collect({ |i| ~sujet.(~motif.neg + i , 1/8)});
var marcheN=[5,3,1,-1].collect({ |i| ~motif.neg + i });


Pdef( \voixUne,
	Pseq( [
		~sujet.(~motif, 1/8),
		~harm.(~motif.removing(\rest), 1/4),
		~sujet.(~motif+4, 1/8),
		~harm.( ~motif.removing(\rest) +4, 1/4),
		marche.()
	].flat)
);
Pdef( \voixDeux,
	Pseq( [
		Pbind(\degree, \rest, \dur, Pseq([1])),
		~sujet.(~motif, 1/8),
		~harm.(~motif.removing(\rest), 1/4),
		~sujet.(~motif+4, 1/8),
		~harm.( marcheN.().flat, 1/4, 16),
	].flat)
)
)

(
Ppar([
		( Pdef(\voixUne) ),
		( Pdef(\voixDeux) ),
	]).play
)


(
Pdef(\morceau,
Pxrand([     // Pxrand ne répète jamais deux fois la même chose
	Ppar([
		( Pdef(\voixUne) <> (octave:6)),
		( Pdef(\voixDeux) <> (octave:5)),
	]),
	Ppar([
		( Pdef(\voixUne) <> (octave:5, scale:Scale.phrygian)),
		( Pdef(\voixDeux) <> (octave:6, scale:Scale.phrygian)),
	]),
	Ppar([
		( Pdef(\voixUne) <> (octave:7, scale:Scale.majorPentatonic)),
		( Pdef(\voixDeux) <> (octave:4, scale:Scale.majorPentatonic)),
	]),
],inf)
).trace.play
)

[4, 6, 3, 5
4 thème
4, 6, 3, 5
	2 marche(thème)]

5, 2, 2, 2,
5, 2, 2, 2
5, 2, 2, 2,
1, 4 ~ 3, 3,
6, 3 ~ 4,
5, 2, 2, 2,
2 ,2, 2, 5,
2 5 4
0
