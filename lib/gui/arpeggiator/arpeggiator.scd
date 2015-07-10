(

// ARPEGGIATOR

// définit des accents métriques et tout et tout
// et surtout une manière de jouer des accords !

/*

~arpeggiator.()

*/

~arpeggiator={

var nbNotesActu=5;


w=~fenetre.("", 400, 400, 1000, 1000);

a=~view.(w, 2.09, 1);
b=~view.(w, 2.09, 1);


	// une suite d'accords
c=		Array.fill(3, {(0..6).choose}).asSet.asArray.sort.postln;

	// une suite d'indices
d=Array.rand(nbNotesActu, 0, c.size-1).postln;
Pdefn(\formule,
	Pseq(d, inf)
);
	// les durées des notes
	Pdefn(\durNote, Pseq( 1!d.size, inf));


// horizontal
z=NumberBox(a, 30@30)
.clipLo_(1)
.clipHi_(20)
.value_(nbNotesActu)
.action_({ |self|
	if (self.value > nbNotesActu)
	{ e.valueAction=e.value++[0];
		Pdefn(\formule, Pseq(e.value.normalize(0, c.size-1).round, inf))
	}
	{ e.valueAction=e.value.[0..e.size-2];
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


~tchiop=CompositeView(a, a.bounds.width@a.bounds.height-50)
.layout_(VLayout.new)
.background_(Color.rand);


~tchiop.layout.add(
// le slider
	e=MultiSliderView(a)
	.elasticMode_(1)
	.showIndex_(true)
.step_(1/g.value)
	.value_(d.normalize)
.action_({ |self|
	self.value.postln;
	a=self.value.normalize(0, g.value).round;
	Pdefn(\formule, Pseq(a, inf));
	Pbindef(\a, \compteur, Pseries() % z.value); // on remet à 0
})
);
e.value.do{ |item, index|
~tchiop.layout.add(
			HLayout(
			Button.new
				.states_([
					3.collect({ |i| // TODO => PENSER cette value
						[ i+1, Color.black, Color(*(0.5+(i*0.2)!2)) ]
					})
				].flatten(1))
				.action_({ |self|
					var a=Pdefn(\formule).source.list;
					var b=if(a[index].class==Array) {a[index][0]} {a[index]};
					self.value.postln;
					b.postln;
					a[index]=Array.series(self.value+1, b).flatten.postln
				}),
		Slider.new.orientation_(\horizontal).value_(0.5)
				.action_({ |self|
					a=Pdefn(\durNote).source.list;
					a[index]=self.value*2;
				}),
			)
		)
};
	// ~tchiop.layout.children
// e.mouse
	/*
	~arpeggiator.()
*/
//////////////// 2eme partie //////////


//onOff
Button(b, 50@50)
.states_([
	["mettre ON ?"],
	["arrêter ?"]
])
.action_({ |self|
	switch(self.value,
		1,	{
			Pdef(\a,
				Pbind(
					\compteur, Pseries() % z.value,
					\seq, Pdefn(\formule),
					\accord, c,
					\modulo, Pdefn(\formule) div: c.size,
					\octave, 4+Pkey(\modulo),
					\degree, Pindex( Pn(c), Pdefn(\formule)),
							\dur, Pdefn(\durNote)*Pdefn(\dur),
					\finish, Pfunc({ |ev|
						var compteur=ev[\compteur];
						AppClock.sched(0,
							{ e.index_(compteur) }
						)
					})
				),
		).trace.play(quant:0.2)},
		0, CmdPeriod.run
	)
});

Slider(b, 100@40)
.action_({ |self|
	Pdefn(\dur, self.value)
})
.valueAction_(0.5);

Button(b, 50@50)
.states_([
	["synthese"],
	["MIDI"]
])
.action_({ |self|
	switch(self.value,
		1, {
			Pbindef(\a, \type, \midi, \midiout, m, \amp, 0.8)
		},
		0, {
			Pbindef(\a, \type, \note)
	})
});

NumberBox(b, 30@30)
.clipLo_(0)
.clipHi_(16)
.value_(0)
.action_({ |self|
	Pbindef(\a, \chan, self.value)
});

x=CompositeView(b, 150@50)
.layout_(HLayout.new);
c.do{ |i, index|
	x.layout.add(
		NumberBox.new
		.value_(i)
		.action_({ |self|
			c[index]=self.value
		})
	)
};

}
)
