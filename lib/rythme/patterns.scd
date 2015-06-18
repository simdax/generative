(

// détecte à partir de plusieurs accents un diviseur commun

~patternR= {|durs|

	var reference=durs.maxItem;
	~myDivAr.(durs ,reference)

};

// en le combinant avec un detectMesure c'est
/*
(
var rythme=[4,4,3,4,1,2];
var analyse= ~detectMesure.(rythme, 5).postln;

analyse.collect( _ !? ~patternR.(_))


)
*/
)

[2,4,1,2,4,1].doAdjacentPairs({ |a,b|
	~myGCD.(a,b).postln
})
