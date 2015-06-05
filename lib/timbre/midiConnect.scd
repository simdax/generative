(
~detectMIDIDevice={ |name="FLUID Synth"|
	MIDIClient.destinations.collect( _.name).detectIndex(_.contains(name) );
};

~startMIDI={
MIDIClient.init;
	m = MIDIOut(0);
	// m.connect(~detect.());

g = { 16.do({ |i| m.allNotesOff(i) }) };
CmdPeriod.add(g);
};


// [ parties à jouer, channel]

~enMidi = { |seq, chan=0, prg=0, trans=0|


	// m.program(chan, prg);
//	sleep~midi= { |chan=0 , trans=0|

var midi = Pbind(
		\type, \midi,
		\midiout, m,
		/*
		\chan, chan,
		\gtranspose, trans
		*/
	);
	(seq <> midi.value(chan, trans));
};

~panic= (
		\type: \midi,
		\midicmd: \allNotesOff,
		\midiout: m,
		\chan: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
);

~nO={
	m.noteOn(0, 60, 60)
};

)