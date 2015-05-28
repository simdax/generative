(
~allPerm={ |array|
	(array.size*(array.size-1)).collect({ |i|
		array.permute(i)
	})
};
~differencierVoix={ |accords|
	accords.collect( ~allPerm.(_))
	.allTuples
	.collect(_.flop);
};
/*~equilibrer={ |voix|
	var nbVoix = voix.shape[1];
	voix.collect({ |i|
		// ~melodieLaMoinsBougeante.(
		voix.slice((0..voix.size-1), i)
		// )
	})
}*/
~resoudreAccords= { |accords|
	var voix=~differencierVoix.(accords).choose;
	"les accords sont : "+voix.postln;
	voix=voix.collect({ |i, index|
		Pbind
		(\degree, Pseq(i),
		\type, 'midi',
		'midiout', m,
		'chan', index,
		\dur, 1,
		\legato, 1,
	/*	 \dur, Pseq( { [ [1, 0.5, 0.5], [0.5,1,0.5], [0.5 ,0.5, 1] ].choose}.value, inf),*/
			\amp, (0.3, 0.31 .. 0.6).choose
		)/*.trace*/
	});
Ppar(voix.collect(_.value));
}
)
