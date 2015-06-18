(
~detectMIDIDevice={ |name="FLUID Synth"|
	MIDIClient.destinations.collect( _.name).detectIndex(_.contains(name) );
};

~startMIDI={
var g;
MIDIClient.init;
m = MIDIOut(0);
g = { 16.do({ |i| m.allNotesOff(i) }) };
CmdPeriod.add(g);
};


// [ parties à jouer, channel]
// joue vite fait une melodie

/*
~enMidi.([0,1,2]).trace.play
*/

~midi = { |mel=#[0], dur=#[1], chan=0, prg=0|

m.program(chan, prg);

	Pdef(\midi,
Pbind(
		\type, \midi,
		\midiout, m,
		\degree, Pseq(mel),
		\dur, Pseq(dur, inf),
		\amp, 1,
		\legato, 1
	)
	);
};
~enMidi={ |seq|
	(Pbind() <> seq <> (type: 'midi', midiout: m));
};
~panic= (
		\type: \midi,
		\midicmd: \allNotesOff,
		\midiout: m,
		\chan: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
);

~no={
	m.noteOn(0, 60, 60)
};

)