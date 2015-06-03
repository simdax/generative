(

~plusPetitMvt = { |n, modulo=7|
	var note=n%7;
	(note < (modulo/2)).if ({note}, { note - modulo });
};



~conditionsHarmo = { | note, intervalle, monte, descend, pareil, intervalleMax, intervallesInterdits, mouvementOblige=( (6:1) ), mouvementInterdit=#[nil], plafondImpossible=#[-10,12], tolerance, post=false |

var resultats=List.new;


	/*liste toutes les interdictions
	Si une interdiction est relevée, la condition est mise à "faux".
	il faut que toutes les interdictions soient évitées pour que soit rendu un jugement qui valide l'intervalle
	*/


/*0*/	resultats.add(monte.if(true, (not(intervalle.isPositive))));
/*1*/	resultats.add(descend.if(true, (not(intervalle.isNegative))));
/*2*/	resultats.add((intervalle==0).if(pareil, true));
/*3*/	resultats.add(not(intervalle.abs > intervalleMax ));
/*4*/	resultats.add(intervallesInterdits.collect {|y|
		intervalle != y}
	);
/*5*/	resultats.add(
		if(
			(mouvementOblige.at(note%7).notNil), {
				mouvementOblige.at(note%7) == intervalle}, {true})
	);
/*6*/	resultats.add(
		if( ((note-intervalle <= plafondImpossible[0]) || (note+intervalle >= plafondImpossible[1])), {false}, {true} )
	);

	resultats=resultats.flatten;


	resultats.collect{|i, index|
		post.if
		(
		{"infos sur l'obeissance à la Règle : ".postln;
	"nb de fautes commises : ".post; (resultats.reject{|i| i}.size).postln;
		case
		{i == false && index==0}{("est positif").postln}
		{i == false && index==1}{("est negatif").postln}
		{i == false && index==2}{("est répété").postln}
		{i == false && index==3}{("intervalle trop grand").postln}
		{i == false && index==4}{("est un intervalle interdit").postln}
		{i == false && index==5}{("est un mouvement obligé").postln}
			{i == false && index==6}{("PLAFOND INTERDIT !").postln};
		});

		if(tolerance.notNil) {case
			{ (i == false && tolerance.includes(index)) } { resultats[index]=true;};}
	};


	post.if({
		"les tolerances sont : ".post;
	tolerance.postln;
	"test de conditions : ".post;
	resultats.postln;
	"\n".postln;
	});

	((resultats.reject{|i| i}.size) > 0).if(
		{false},
		{true}
	);

};

~harmoniserHasard = {
	| noteHarmoniser, patternHarmonisation, lastV, post = false |

	var harmo, noteArrivee, diff, valeur;

	harmo=patternHarmonisation.choose;
	noteArrivee=(noteHarmoniser+harmo)%7;

	diff=( noteArrivee - (lastV%7) );
	valeur=~plusPetitMvt.value(diff);

	post.if ({
		//infos
		"INFOS SUR LE DUPLUM : ".postln;
		"lastV : ".post; lastV.postln;
		"note a harmo : ".post; noteHarmoniser.postln;
		"val choisi pour harmoniser : ".post; harmo.postln;
		"resultat : ".post; noteArrivee.postln;
		"d'où un intervalle de : ".post; diff.postln;
		"ce qui fait un intervalle réduit de : ".post; valeur.postln;
		"".postln;
	});

	valeur;

};

~validerRecursif = { |noteHarmoniser, patternHarmonisation, conditions|

	var intervalle, foncRec, nbRecursions=0, i;

	foncRec={
		intervalle=~harmoniserHasard.value(noteHarmoniser, patternHarmonisation, conditions['note'], false);
		conditions['intervalle']=intervalle;
		(~conditionsHarmo.valueWithEnvir(conditions)).if
		(
			{   // REUSSITE !
				conditions['tolerance']=nil;
				conditions[\note]=intervalle+conditions[\note];
				conditions[\note];
			},
			{ // ECHEC :(
				nbRecursions=nbRecursions+1;
				// "grosse recursion : ".post;	nbRecursions.postln;
				i=nbRecursions/30;
				case
				{i < 5} {
					// "GROOOOOOOS ECHEC".postln;
					conditions['tolerance']=conditions['tolerances'].at((0..(i.asInt)));
					foncRec.value;}
				{i==5}{
					// "tant pis! \n".postln;
					conditions['tolerance']=nil;
					conditions[\note]; //tant pis, on laisse comme ça !
				}
		});
	};
	foncRec.value;
};

h = { | a, patternHarmonisation, monte=true, descend=true, pareil=false, intervalleMax=2, interdit=#[nil],tolerance=#[0] |

	var b, conditions;
	a[\degree].postln;
	conditions= (
		note: nil,
		intervalle: nil,
		monte:monte,
		descend:descend,
		pareil:pareil,
		intervalleMax:intervalleMax,
		intervallesInterdits:interdit,
		mouvementOblige:nil,
		tolerances:tolerance,
		tolerance:nil,
		post:false,
	);

	b=PS(
		Pbind(
		// \default,
			\amp, 0.05,
			\harmonisation, Pseq(patternHarmonisation, inf),
			\degree, Pfunc({ arg ev;
				var noteHarmoniser, pHarmonisation, temp;
				noteHarmoniser=a[\degree];
				pHarmonisation=ev[\harmonisation];

				if(conditions[\note].isNil,
					{conditions[\note]=noteHarmoniser},
					{});
				~validerRecursif.value(noteHarmoniser, pHarmonisation, conditions, false);
			}),
			\plafondGlobal, Pfunc({ arg ev;
				(conditions[\note] > 5).if(
					{conditions['monte']=false ;
					},
					{(conditions[\note] < -5).if({
						conditions['descend']=false ;
						},
						{conditions['descend']=true;
							conditions['monte']=true
				})});
			}),
			\dur, Pfunc({a[\dur]/2;}),
			\legato, 1,

		),
	bufSize:10);

};
)

(
a=PmonoArtic(\default,
	\degree, Pseries(0,Pwhite(-2,2),inf).fold(-7,7),
	\dur, Pwrand([0.25, 0.5, 1], [0.5, 1, 0.3].normalizeSum, inf),
	\legato, 1
).collect{|ev| x=ev}.play;



TempoClock.default.tempo=0.5;

y=h.value(x, [[2, -2],[2, -2],[2, -2],[3, -3]]).play;

)




