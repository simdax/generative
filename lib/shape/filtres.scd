(
~melodieLaMoinsBougeante={ |mels|
mels.at(mels.collect({ |i|
		i.differentiate.abs.drop(1).sum
	}).minIndex)
};


)