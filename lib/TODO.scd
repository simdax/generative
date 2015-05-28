(

~hasGateOrNot={ |mel|
	mel.differentiate.drop(1).abs
	.collect({ |i|
		if (i.isStrictlyPositive)
		{true}
		{false}
});
}
)

(

var mel=[0,2,2,3,1];
var gate=~hasGateOrNot.(mel);

Pbind(
	'amp', 1,
	'type', 'midi',
	'midiout', m,
	\degree, Pseq(mel),
	'hasGate', Pseq( gate),
	// 'hasGate', Pseq([false])
).trace.play

)
Pbind(\degree, Pseries(0, 1, inf), \dur, Pseq([2, [1, [1, [2, 1, 1, -1]]], 2].convertRhythm)).play;

(
MIDIClient.init;
m=MIDIOut(0);
m.connect(37)
)

// ////////////////


(

~lecteur={ | forme|
	forme collect: {|x|
		(x.size >1).if
		{
			desPbinds <> ('chan':
			Ppar(x)}
		{
			x.value}
	}

};

~lecteur.([[0,1],1])
)

(

[
0->["mel", mel],
1->[nil, acc]
]

)