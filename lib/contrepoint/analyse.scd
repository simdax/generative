(
~comparer={ |melUn, melDeux, tolerance=2|
(melUn.absdif(melDeux).sum) <= tolerance
};



~notesEnCommun={ |mels|
	//TODO resteindre à la mélodie la plus courte
	mels.flop
	.collect({ |x, index|
		x.as(IdentityBag).contents
		.select({|y| y>1})
	})
};

~pasDeNotesEnCommun={ |arrays, nbVoix=2|
	var x= arrays.powerset.select({ |x| x.size==nbVoix });

	 x.select({
	 	|x| ~notesEnCommun.(x).every(_.isEmpty)
	 })
};
)