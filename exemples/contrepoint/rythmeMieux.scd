(

var melUn=~genererMel.();
var melDeux=~genererMel.();

var pattern=['x', 'o', 'o'].asSymbol;

var analyses= ~analyserIntervalles.(melUn, melDeux)[0].postln;
var res=~patterns.(analyses).postln;
var pat=~trouverPatterns.(res).postln;
// ~selectSize.(pat);
~detectNbOccurences.(res).postln;


~enMidi.(
	Pbind(
		\melUn, Pseq(melUn),
		\melDeux, Pseq(melDeux),

		\degree, Ppar([ Pkey(\melUn) , Pkey(\melDeux) ])

)).play
)

(

// patterns par rapport à cons/dis
~patterns= { | intervalles, cons=#[0,2,-3,-2], dis=#[1,3,-1] |

	~convertirMel.(intervalles).collect({ |x|

		case
		{cons.includes(x)} {\o}
		{dis.includes(x)} {\x}

	})

};
)
