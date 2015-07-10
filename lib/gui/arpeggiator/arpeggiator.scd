// ARPEGGIATOR

// définit des accents métriques et tout et tout
// et surtout une manière de jouer des accords !

(

var nbNotesActu=10;

Window.closeAll;

w=~fenetre.("", 400, 400, 800, 700);

a=~view.(w, 2.1);
b=~view.(w, 2.1);

// une suite d'accords
c=		Array.fill(3, {(0..6).choose}).asSet.asArray.sort.postln;
// une suite d'indices
d=Array.rand(nbNotesActu, 0, c.size-1).postln;
Pdefn(\formule,
	Pseq(d, inf)
);
// pour les octaviations
f=Array.fill(d.size, {0});


// horizontal
z=NumberBox(a, 30@30)
.value_(nbNotesActu)
.action_({ |self|
	if (self.value > nbNotesActu)
	{ e.value=e.value++[0];
		Pdefn(\formule, Pseq(e.value.normalize(0, c.size-1).round, inf))
	}
	{ e.value=e.value.[0..e.size-2];
		Pdefn(\formule, Pseq(e.value.normalize(0, c.size-1).round, inf))
	};
	nbNotesActu=self.value;
});


// vertical
g=NumberBox(a, 20@20)
.clipLo_(c.size)
.clipHi_(9)
.value_(c.size-1)
.action_({ |self|
	e.valueAction_(e.value.normalize(0, self.value).normalize.postln) ;
	e.step_(1/self.value)
});

//random
h=Button(a, 20@20)
.action_({
	e.valueAction_(Array.rand(nbNotesActu, 0, g.value).normalize.postln);
});

// le slider
e=MultiSliderView(a, 150@150)
.elasticMode_(1)
.step_(1/g.value)
.value_(d.normalize)
.action_({ |self|
	e.value.postln;
	Pdefn(\formule, Pseq(self.value.normalize(0, g.value).round, inf));
});

//onOff
Button(b, 50@50)
.states_([
	["STOP"],
	["en marche"]
])
.action_({ |self|
	switch(self.value,
		1,	{Pbind(
			\seq, Pdefn(\formule),
			\accord, c,
			\modulo, Pdefn(\formule) div: c.size,
			\octave, 4+Pkey(\modulo),
			\degree, Pindex( Pn(c), Pdefn(\formule)),
			\dur, Pdefn(\dur),
		).trace.play(quant:1)},
		0, CmdPeriod.run
	)
});

Slider(b, 100@40)
.valueAction_(0.5)
.action_({ |self|
	Pdefn(\dur, self.value)
});
)
map
