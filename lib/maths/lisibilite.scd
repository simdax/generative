(

///////////////////////////
///////////////
/// simple helpers pour la lisibilité


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

// TODO : pour plusieurs melodies

~enNotes= { |mels|
	~convertirMel.(mels)
	// .flatten(mels.rank)
	.collect(
		~convertirNotes.(_)
	)
	// .reshapeLike(mels.shape[1]+1);
};

)