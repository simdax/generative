
(

var listeFichiers=["analyse", "polyphonie", "mel", "grilleHarmonique", "midiConnect",  "lisibilite", "vecteur", "rythme", "formes" ];
var root="/home/simdax/Dropbox/generatif/";
var paths=listeFichiers.collect({ |i|
	root++i++".scd"
});
paths.collect(
this.executeFile(_);
);



~startMIDI.();
m.connect(~detect.());

)

(




var changerAcc=
{
	Pseq([
	voixPrincipale,
	melodieAccompagnee.value
	]);
};
var toutChanger=
{
	var a=~grosdVaud.();
	var voixPrincipale=a[0];
	var voixSecondaire=a[1];

		Ppar(
			[
				voixPrincipale,
				voixSecondaire.value
		])
	};


Pseq([Pn(Plazy({changerAcc.value}), 2), Plazy({toutChanger.value})], inf).play
)

[(Plazy({3}) ! 3).flatten, Plazy({4})]
