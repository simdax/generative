(

~eachSub={ |arr, taille|
	(arr.size - taille+1 ).collect({ |i|
		arr[0+i..taille+i-1]
	})
};

~comparer={ |melUn, melDeux, tolerance=2|
(melUn.absdif(melDeux).sum) <= tolerance
};

~eachHarmos={ |mel, cons=#[0, 2,-2]|
	(mel +.t cons).allTuples
};

~notesEnCommun={ |mels|
	//TODO resteindre à la mélodie la plus courte
	mels.flop
	.collect({ |x, index|
		x.as(IdentityBag).contents
		.select({|y| y>1})
	})
};

~detectComplementaires={ |arrays, nbVoix=2|
	var x= arrays.powerset.select({ |x| x.size==nbVoix });

	 x.select({
	 	|x| ~notesEnCommun.(x).every(_.isEmpty)
	 })
};
)