
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
.string_("intervalle : ")
;
~boxResult=StaticText(w, 100@50)
.string_("...")
.background_(Color.grey)
;

(0).wrap(1,12);

// start sound
CheckBox(w)
.string_( "jouer ?")
.action_({ |self|
	if( self.value,
		{
			(~iphone.isNil).if {~iphone=69};
			~run.();
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
						~boxFreqMel.value_(freqMel);
						~boxResult
						.string_(intervalle);
						{
							var st=~boxResult.string;
							case
							{["quinte", "quarte", "unisson", "octave"].includesEqual(st)}
							{~boxResult.stringColor_(Color.yellow)}
							{["tierce majeure", "sixte"].includesEqual(st)}
							{~boxResult.stringColor_(Color.red)}
							{["tierce mineure", "sixte mineure"].includesEqual(st)}
							{~boxResult.stringColor_(Color.blue)}
							{["sensible", "demi-ton"].includesEqual(st)}
							{~boxResult.stringColor_(Color.black)}
							{["ton", "septième"].includesEqual(st)}
							{~boxResult.stringColor_(Color.green)};
						}.value;
					}.defer;

					{
						if ((intervalle == c.string))
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

f=
{
	var notes, dur;
	notes=Array.rand( (1..5).choose, 0,6).postln;
	dur= {(2, 2.5..5).choose} !  notes.size ;
	a.score.notes=notes;
	a.score.durees=dur; // pour l'instant on se complique pas la vie
	a.score.rafraichir;
	a.run;
};

a=~animatedScore.();
b=Button(w, 50@50)
.action_({
	// run=run.if {false} {true};
	{
		loop
		{

			f.value;
			c.string_({
				arg stringResult;
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
				)
			}.(().choose));
			a.score.durees.integrate.last.wait;
		}
	}.fork(AppClock)
});


StaticText(w, 120@50)
.string_("intervalle à atteindre")
;

c=StaticText(w, 100@100)
.string_("...")
.background_(Color.grey)
;

d=StaticText(w, 50@50)
.string_(tsInter);

)

