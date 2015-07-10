(

// met à jour le mode du pattern sélectionner

~modes= { |pattern, fen|

	PopUpMenu(fen, 150@40)
	.items_( [
		"diatonique majeur",
		"diatonique mineur",
		"pentatonique majeure",
		"pentatonique mineure",
		"chromatique"
	])
	.action_({ |b|
		b.value.postln;
		switch(b.value,
			0, {Pbindef( pattern, \scale, Scale.major)},
			1, {Pbindef( pattern, \scale, Scale.minor)},
			2, {Pbindef( pattern, \scale, Scale.majorPentatonic)},
			3, {Pbindef( pattern, \scale, Scale.minorPentatonic)},
			4, {Pbindef( pattern, \scale, Scale.chromatic)},
		);
	});
};
)