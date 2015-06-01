/// créer une harmonisation parallèle

~eachHarmos={ |mel, cons=#[0, 2,-2]|
	(mel +.t cons).allTuples
};