
// EXEMPLE de mélodie accompagnée selon un schéma particulier
//
(
~mel= [0, 4, 2, 3,4,5,1,3,7,5,4];
~schemaCons=[2, 1, 2];
a=~accompagnement.(~mel, ~schemaCons).allTuples;

a.postln
)

p=~direction.(a).select( _.isPositive);
("les positives: "+p.size).postln;
n=~direction.(a).select( _.isNegative);
("les negatives: "+n.size).postln;

~res=~mel+++(n.choose).postln;

~enMidi.(
	(
		Pbind(

		\degree,

		Pseq([0, 1, 2, 3]) +.x
		Pseq(~res, inf),

		\dur, 1)
	)
).play
)
