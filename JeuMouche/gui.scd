(
//setup
Window.closeAll;
"jeumouche.scd".loadRelative;
"helpers.scd".loadRelative;

//window
w=Window.new.alwaysOnTop_(true).front;
w.addFlowLayout;

// background melody
Pdef(\a,
	Pbind(
		\degree, Prand([0,1,2,4,5], inf),
		\dur, Prand([1,3,5,7], inf),
));

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
			Pdef(\a)
			.collect({ |ev|
				~event=ev
			})
			.play(quant:[0, 0, 0]);
			~run.();
			TempoClock.sched(0.1, {
			r{ loop{
				var freqMel=~event[\freq].cpsmidi.ceil.asInt;
				var freqIphone=~iphone.postln;
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
				0.2.wait;
			}}.play
			});
		},
		{
			Pdef(\a).stop;
			CmdPeriod.run;
		}
	)
});

z=UserView(w, w.bounds.width@w.bounds.height/5);
~score.([0, 2, 3],[1, 1, 1],z)


)

