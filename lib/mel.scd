(

////// génère une mel "à peu près" logique, pas trop de sensible
/// TODO, enlever des écarts nuls style 'fa-si'


~genererMel={ |nbNotes =((6..10).choose)|
	var mel=~verifierRepetitions.(
	Array.fill(nbNotes, { [0,1,2,3,4,5,6]
		.wchoose([0.4,0.25 ,0.25 ,0.35 ,0.4 ,0.25 ,0.15 ].collect(_/(1/0.5)))})
 );
	("mel généré = " ++mel).postln;
	mel
};


/////
///// ensemble de fonctions pour générer à partir d'un thème
///// les transformations contrapuntiques qui peuvent s'harmoniser
///// avec l'original

~ttesPossibilites={ |x|
	x.size.collect(x.rotate(_))
};
~analyserIntervalles={ |mel ... hypotheses|
	~ttesPossibilites.(mel).collect({ |x|
		hypotheses.size.collect(
			x absdif: hypotheses[_]
		)
	})
};

~laTotale={ |mel|
	~convertirMel.(
		(0..6).collect({ |i, index|
			~analyserIntervalles.(mel-i, mel, mel.neg, mel.reverse, mel.reverse.neg)
		})
	)
};
~analyse={ |mel, notesInterdites=#[3,-3,1,-1]|
	var temp= ~laTotale.(mel);
	("melodie : "++ mel).postln;
	("nb de notes : "++ mel.size).postln;
	temp.collect({ |h, hauteur|
		h.collect({ |d, indexDeca|
		  d.collect({ |i, index|
				(i.includesAny(notesInterdites)).if(
					nil, {case
						{index==0}{("soi-même, décalé de "++indexDeca++" et transposé de "++hauteur).postln; (hauteur+mel).rotate(indexDeca.neg)}
						{index==1}{("inverse, décalé de "++indexDeca++" et transposé de "++hauteur).postln;   (hauteur+mel.neg).rotate(indexDeca.neg)}
						{index==2}{("retrograde, décalé de "++indexDeca++" et transposé de "++hauteur).postln;  (hauteur+mel.reverse).rotate(indexDeca.neg)}
						{index==3}{("inverse retro, décalé de "++indexDeca++" et transposé de "++hauteur).postln;  (hauteur+mel.reverse.neg).rotate(indexDeca.neg)};
				})
			})
		})
	}).deepCollect(2, _.reject(_.isNil));

};


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
)



(
b=Array.new;
while(
	{b.size<(7..10).choose},
	{a=[0]++Array.fill((8..10).choose, {(0..5).choose});
		b=~analyse.(a)
		.flatten
		.reject({ |i| i.size==0})
		.unbubble(1)
	;}
);
c=~melange.(b.collect({ |i, index|
	Pbind(
		\type, \midi,
		\midiout, m,
		\degree, Pseq(i),
		\octave, rrand(4,5),
		/*\dur, Pseq(
		Array.fill(5, {(1.0.rand).round(0.2)}), inf
		)*/
	)
}), 2).collect(Ppar(_)).postln;

Pseq(c, inf).trace.play
)

