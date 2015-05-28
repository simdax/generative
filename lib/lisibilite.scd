(
~convertirNotes={ |x|
	switch (x,
		-3, {"so"},
		-2, {"la"},
		-1, {"si"},
		0, {"do"},
		1, {"ré"},
		2, {"mi"},
		3, {"fa"}
	)
};

~enNotes= { |mels|

	~convertirMel.(mels)
	// .flatten(mels.rank)
	.collect(
		~convertirNotes.(_)
	)
	// .reshapeLike(mels.shape[1]+1);
};

~sortSolfege={ |mel, ordreGrandeur=#[0,1, 2, 3, -3, -2, -1]|
	~convertirMel.(mel).sort({ |a, b|
		ordreGrandeur.indexOf(a)
		< 		ordreGrandeur.indexOf(b)
	})
};

)

// ~enNotes.([6, [4]])
// ~sortSolfege.(~genererMel.())