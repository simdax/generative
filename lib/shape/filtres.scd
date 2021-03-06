(


// enlève les répétitions supérieures à nbRepeAutorisees
// ~verifierRepetitions.([0,1,2,4, 4, 4,1,5,4,1,2], 1) ==> [ 0, 1, 2, 4, 1, 5, 4, 1, 2 ]
// ~verifierRepetitions.([0,1,2,4, 4, 4,1,5,4,1,2], 2) ==> [ 0, 1, 2, 4, 4, 1, 5, 4, 1, 2 ]

~verifierRepetitions= { |mel, nbRepeAutorisees=2|

	var m=mel.differentiate.drop(1);
	var ar = 0 ! nbRepeAutorisees;
	{m.find(ar).isNil.not}.while
		{
			m.removeAt(m.find(ar)+ar.size-1)
	 };
	(m.addFirst(mel.first)).integrate;
	};

// ~intervallesMax.([0,3,5,8,-7,10,1,2]) => [ 0, 3, 5, 8, 7, 10, 8, 9 ]

~intervalleMax={ |mel, intervalleMax=5|

	var result=mel.differentiate;
	result.collect({ |x|

		if (
			(x.abs > intervalleMax),
		{~reduireHarmo.(x)},
			{x})
	})
	.integrate

};


)

