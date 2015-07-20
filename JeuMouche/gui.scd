(

var tsInter=0; // pour la classe


//setup
Window.closeAll;
"jeumouche.scd".loadRelative;
"helpers.scd".loadRelative;

//window
w=Window.new.alwaysOnTop_(true).front;
w.addFlowLayout;

//Pdef(\a).play

// background melody


// IP informations
StaticText(w, 200@100)
.string_("l'IP à laquelle se connecter :\n"+~broadcastIP.()+" \n et le port :\n "+NetAddr.langPort)
;
w.view.decorator.nextLine;

// frequency informations
StaticText(w, 100@50)
.string_("toi");
~boxFreqUser=NumberBox(w)
.value_(69);
w.view.decorator.nextLine;
StaticText(w, 100@50)
.string_("cantus firmus");
~boxFreqMel=NumberBox(w);
w.view.decorator.nextLine;

StaticText(w, 100@50)
.string_("intervalle actuel : ")
;
~boxResult=StaticText(w, 100@50)
.string_("...")
.background_(Color.grey)
;

(0).wrap(1,12);



/////////////


// start sound device (iphone, mouse)

CheckBox(w)
.string_( "jouer ?")
.action_({ |self|
	if( self.value,
		{
			var symbol=\mouse;
			(~iphone.isNil).if {~iphone=69};
			~run.(symbol);
			TempoClock.sched(0.1, {
				r{ loop{
					var freqMel=~event[\freq].cpsmidi.ceil.asInt;
					var freqIphone=~iphoneGyr;
					var stringResult=(freqIphone-freqMel).asInt
					.wrap(0,12);
					var intervalle=
					switch(stringResult,
						0, "unisson",
						1, "demi-ton",
						2, "ton",
						3, "tierce mineure",
						4, "tierce majeure",
						5, "quarte",
						6, "triton",
						7, "quinte",
						8, "sixte mineure",
						9, "sixte",
						10, "septième",
						11, "sensible",
						12, "octave"
					);

					// actualisation des boxes
					{
						// petites boxes du haut
						~boxFreqMel.value_(freqMel);
						~boxResult
						.string_(intervalle);
						{
							var couleur = (
								if(c.object.includesEqual(intervalle))
									{Color.white}
									{Color.red};
							);
							var st=~boxResult.string;
							~boxResult.stringColor_(	couleur	)
						}.value;


					// le slider

					~sliderSouris.value_(
						if (symbol == 'mouse')
						{~souris.linlin(0, 800, 0,1)}
						{"pas la souris".postln}
					);

					// les points

						if (c.object.includesEqual(intervalle))
						{tsInter=tsInter+1; }
						;
						d.string_(tsInter);

					}.defer;

					0.2.wait;
				}}.play
			});
		},
		{
			Pdef(\a).stop;
			CmdPeriod.run;
		}
	);

});

///////


f=
{
	var notes, dur;
	notes=Array.rand( (1..5).choose, 0,6);
	dur= {(2, 2.5..5).choose} !  notes.size ;

	//ici on augmente la vitesse selon le nombre de points
	dur=dur.linlin(0, 5, 0, 5-(tsInter/100));
	dur.postln;

	a.score.notes=notes;
	a.score.durees=dur; // pour l'instant on se complique pas la vie
	a.score.grille.resoY=0;
	a.score.grille.rafraichir;
	a.score.rafraichir;
	a.run;
};

a=~animatedScore.(/*[0], [0]*/);
b=Button(w, 150@50)
.states_([
	["mettre en marche?"],
	["stop ?"]
])
.action_({ |self|
	switch(self.value,
		1, {
	{
		loop
		{
			f.value;
			c.object_({
				arg stringResult;
				stringResult.collect(
				switch( _ ,
					0, "unisson",
					1, "demi-ton",
					2, "ton",
					3, "tierce mineure",
					4, "tierce majeure",
					5, "quarte",
					6, "triton",
					7, "quinte",
					8, "sixte mineure",
					9, "sixte",
					10, "septième",
					11, "sensible",
					12, "octave"
				)
				)
			}.([0, 7, 12]));
			a.score.durees.integrate.last.wait;
		}
	}.fork(AppClock)
		},
		0,
		{a.arret}
	);
});

~sliderSouris=Slider(w, 20 @ 150);


///// infos joueurs


StaticText(w, 120@50)
.string_("intervalle(s) possible(s)")
;

c=StaticText(w, 100@100)
.string_("...")
.background_(Color.grey)
;

d=StaticText(w, 50@50)
.string_(tsInter);

)

