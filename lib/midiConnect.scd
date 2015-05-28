(
~detect={ |name="FLUID Synth"|
	MIDIClient.destinations.collect( _.name).detectIndex(_.contains(name) );
};

~startMIDI={
MIDIClient.init;
	m = MIDIOut(0);
	// m.connect(~detect.());

g = { 16.do({ |i| m.allNotesOff(i) }) };
CmdPeriod.add(g);
};

~midi= { |chan , trans=0|
Pbind(
		\type, \midi,
		\midiout, m,
		\chan, chan,
		\gtranspose, trans
	)
};


// [ parties à jouer, channel]
~enMidi = { |seq, chan, prg=0, trans=0|
	// m.program(chan, prg);
//	sleep
	(seq <> ~midi.value(chan, trans));
};

~panic= (
		\type: \midi,
		\midicmd: \allNotesOff,
		\midiout: m,
		\chan: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
);

~midiOff={ |deg |
	(\type:  \midi,
		\midiout: m,
		\midicmd: \noteOff,
		\degree: deg).play
};


~midiOn= {|deg, chan, prBank=0|

	m.program(chan, prBank);

	(
		\type:  \midi,
		\midiout: m,
		\midicmd: \noteOn,
		\chan: chan,
		\degree: deg,
		\hasGate: false,
	).play;
};

~midicool={|ancienneNote, noteNouvelle|
	Pfunc({ |ev|
		~midiOn.value(noteNouvelle, 0, 7);
			if((ancienneNote.notNil),
				{
					if(
					(ancienneNote != noteNouvelle),
					{~midiOff.value(ancienneNote);},
					{0})
				},
				{0}
			);
		});
}

)
// ~panic.play
// (
// var test;
// test=Pbind(\dur, 0.5);
// ~jouerZik.value(test, 0, 0);
// )
// (
// b=PS(
// 	Pbind(
// 		\amp, 0.0,
// 		\degree, Pseq([0,0,1,2,3], inf),
// 		\dur, 0.2,
// 		\do, ~midicool.value
// 	)
// );
//
// b.play
// )
//
//
// (
//
// ~jouerZik.value(Pbind
// 	(
// 		\midicmd, Pseq([\noteOn, \noteOff], inf),
// 		\dur, 4,
// 		\hasGate, false,
// ), 0,7,0);
//
// )
//
//
//
