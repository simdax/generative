

/// timbre ??
~melange={ |array, nbVoix=2|
	array.powerset
	.select(_.includes(array.first))
	.reject({ |i| i.size!=nbVoix}).postln
	.deepCollect(2, { |i, index|
			i <> (\chan : index,
			// \amp: 0.5*index
		)
		})
};