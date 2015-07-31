(
// function for extract pitch from name
// the name should be instName-noteOctave
// a.k.a   cello-c2    or  soubassophone-f#5   etc.

g = { arg a;
	var oct=(a.last.asString.asInt +1) *12;
	var note=a.drop(-1);
	switch(note,
		"c", 0,
		"c#", 1,
		"d", 2,
		"d#", 3,
		"e", 4,
		"f", 5,
		"f#", 6,
		"g", 7,
		"g#", 8,
		"a", 9,
		"a#", 10,
		"b", 11, )
	+oct;
};

)

(
// function for getting a list of Buffers from a folders filled
// with notes Samples.
// like /Cello/cello-a5.wav,cello-c6.wav etc.

// it returns a dictionary such as
// (midiPitch -> buffer)

f= { arg path;

	var p=("~/freesou*/sam*/"++path).pathMatch.unbubble;
	var files=PathName(p).entries;

	// sorting by function g, i.e. by pitch
	var pitches=files.collect({ |j|
		var a= j.fileNameWithoutExtension
		.split($-)[1];
		g.(a)
	});
	//load Buffers
	var buffersPath= files.atAll(pitches.order).collect(_.absolutePath);
	// cannot use allocConsecutive since I don't know the numframe...
	var sounds=Dictionary.new;
	pitches.sort;
	buffersPath.size.do({ |k|
		sounds.add(
			pitches[k] -> Buffer.read(s, buffersPath[k])
		)
	});
	sounds
};
a=f.("Cello")
)

(
// function for evaluating best distribution
// between buffers ???

h={ arg dic=a, noteMin=2, noteMax= 130; // is that reasonnable ? ;)

	// check the values between each value
	var keys=dic.keys.asSortedList;
	var sortedKeys=keys.differentiate.drop(-1)-1;

	// partition this "holes" in two
	var distrib=sortedKeys.collect(_.partition(2));

	// create an Array with midinote distributed
	var result= (1..keys.size-2).collect({ |i|
	[
		keys[i] - (1 ! distrib[i-1][1]),
		keys[i] + (1 ! distrib[i][0])
	].insert(1, keys[i]).unbubble(1);
});

	// we introduce the extreme values
	result=[(noteMin..keys.first)] ++ result ++ [(keys.last .. noteMax)];

	//and output an array of form:
	// [ notes, bufferToUse, OriginalPitch]
	dic.atAll(a.keys.asSortedList)
	.collect({ |buf, index|
		[ result[index], buf, dic.findKeyForValue(buf) ]
	})

};
b=h.()
)

(
// function for creating a Synth who plays according to samples
// dic is the output of h

SynthDef(\warp, {arg buffer, dur=1, midinote=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env([0.01, 1, 1, 0.01], [0.1, dur, 0.3], 'exp'), doneAction: 2);
	sig = Warp0.ar(2, buffer, dur, 1*midinote.midiratio, 0.1, -1, 8, 0.05, 4);
	Out.ar(out, sig*env);
}).add;

Pdef(\Cello, { arg midinote;

	var dic=b;

	//evaluate better sample buffer to pick up :
	var index=dic.detectIndex({ |i|
	i[0].includes(midinote);
	});
	var buffer=dic[index][1];
	var midi=dic[index][2]-midinote;

	Pbind(
		\instrument, \warp,
		\buffer, buffer.postln,
		\midinote, midi.postln,
	);

});

)

Synth(\warp, [\buffer, 0, \midinote, 0 ])
(
Pbind(
	\type, \phrase,
	\instrument, \Cello,
	\midinote, Pseq([51, 20, 61, 35]),
	\dur, Pseq([1,0.5,1,1.2])
).play
)

