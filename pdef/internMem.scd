(

~ze=List();

a=Pbind(
	\degree, Prand((0..4), inf) + [0,2,4, 7],
	\amp, 0.1
).collect(~a=_);

b=Pbind(
	\instrument, \pluck,
	\amp, 0.5,
	\degree, Pfuncn({
		~a.degree[3.rand]
	}, 4),
	\finish, Pfunc({ arg i;
		if (~ze.size < 4)
		{~ze.add(i.degree).postln}
		{"rien"}
	})
);


Ptpar([
	0, a,
	0.01, Pseq([
		b,
		Pn(Pbindf(b,
			\finish, 0, // replace finish function, a way to erase it ?
			\do, Plazy{ Pseq(~ze, inf)},
			\degree,
			Pfunc({
				arg ev;
				var arrayIn=~a.degree.wrap(0,6).sort,
				squelette=ev[\do].wrap(0,6);
				if (arrayIn.includes(squelette))
				{ev[\do]}
				{arrayIn.at(arrayIn.indexIn(squelette))};
			})
		))
	])
]).trace.play


)
