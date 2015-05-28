(
~trouverPattern={ |mel|
	var a=mel;
	all {
		: [rangeUn, rangeDeux],
		drop <- (a.size/2).round(-1).asInt,
		taille <- (a.size/2).round(-1).asInt,
		increment <- (a.size) - (taille*2) -1 -drop,

		var rangeUn=(0+drop..taille+drop),
		var rangeDeux=( (taille+1+drop+increment)..( (taille*2)+1+drop+increment) ),
/*
		::(a[rangeUn]).postln,
		::(a[rangeDeux]).postln,
		::",".postln,*/

		a[rangeUn] == a[rangeDeux]
	};/*
	("trouvé "+b.size+" patterns").postln;
	b.postln;*/
};

// ~trouverPattern.([3,3,3,3,3])

~reduireHarmo = { |n, modulo=7|
	var note=n%7;
	(note < (modulo/2)).if ({note}, { note - modulo });
};
~convertirMel={ |mels|
	var temp;
	temp=mels.flatten(mels.rank);
	temp=temp.collect(
		~reduireHarmo.(_)
	);
	temp.reshapeLike(mels);
};

~melodieLaMoinsBougeante={ |mels|
mels.at(mels.collect({ |i|
		i.differentiate.abs.drop(1).sum
	}).minIndex)
};

~verifierRepetitions= { |mel, nbRepeAutorisees=2|
// petite feinte avec le +1
	var m=mel.differentiate.drop(1);
	var ar = 0 ! nbRepeAutorisees;
	{m.find(ar).isNil.not}.while
		{
			m.removeAt(m.find(ar)+ar.size-1)
	 };

	(m.addFirst(mel.first)).integrate;
	};

~visualiserAnalyse= { |analyse, r=((0..6)) |
	var roots=~sortSolfege.(r);
	roots.collect({|x|
		analyse.collect(_.includes(x)) })
	.deepCollect(2, {|x| if(x) {'o'}{'x'} })
	.collect({ |i, index|
		((~convertirNotes.(roots[index])).asString+" = "+i).postln
	});
};

~detecterDuplicates={ |array|
	var result=List.new;
array.doAdjacentPairs({ |a, b|
		if (
			a==b,
			{result.add(true)},
			{result.add(false)}
		)
	});
	result;
};
~removeDuplicates={ |array|
	var y=~detecterDuplicates.(array);
	[array[0]]++array.at(
		y.indicesOfEqual(false)+1
	)
};
~detectOccurences={ |array|
	var y=~detecterDuplicates.(array);
	var debut=List[1];
	y.collect({ |x|
		switch (x,
			true, {debut.put(debut.size-1, debut.last+1)},
			false, {debut.add(1)}
		)
	});
	debut
}
)

