
(


var path, root="/home/simdax/Musique/";
var file, durFile, sfView, playEvent;
var offsetBox, anacrouse;
var musique;

s.waitForBoot;

//synth

SynthDef(\a, {
	arg freq, dur, amp,
	gate=1, atk=0.05, rel=0.1, sust=1,
	out=0, pan=0;

	var sig=
	//	BPF.ar(
	MdaPiano.ar(freq, sustain:sust)
	/*	LFNoise1.ar(0.5).exprange(700, 1200),
	LFNoise1.ar(1).exprange(0.2,0.7)
	)*/
	;

	var env=EnvGen.kr(Env.adsr(atk, 0.1, 1, rel), gate, amp, doneAction:2);

	Out.ar(
		out,
		Pan2.ar(sig*amp, pan)
	)
}).add;

SynthDef(\buf, { arg out=0, bufnum, offset=0, amp=0.3;
	Out.ar(out, PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum), 1, s.sampleRate*offset) * amp)
}).add;

/// window

Window.closeAll;
w=Window().front.alwaysOnTop_(true);
q=w.addFlowLayout;

// adresse
StaticText(w, 165@20)
.string_(root);
path=PopUpMenu(w, "un looooooooooooong teeeeeeeexte".bounds)
.items_(
	PathName(Platform.userHomeDir+/+"Musique").entries.select({ |i| i.extension=="wav" }).collect(_.fileName);
);

Button(w, 20@20)
.background_(Color.red)
.states_([
	["", nil, nil],
	[nil, Color.red, nil]
])
.action_({
	var p=root+/+path.item;
	file !? {file.close};
	file=SoundFile.openRead(p);
	("ok").postln;
	sfView.soundfile_(file);
	sfView.read(0, file.numFrames);
	sfView.refresh;
	playEvent=file.cue;
	durFile.string_(" durée : "++file.duration.postln)
});

q.nextLine;

Button(w, 50@50)
.states_([
	["play?"],
	["stop?"]
])
.action_({
	arg self;
	switch( self.value,
		1, {playEvent.play},
		0, {playEvent.stop}
	);
});

durFile=StaticText(w, "duration = 556464456555555555555555555555555".bounds);


sfView=SoundFileView(w, (w.bounds.width - 30)@(w.bounds.width/2) )
.timeCursorOn_(true)
.mouseDownAction_({
	var frame=sfView.selections[0][0];
	playEvent=file.cue((firstFrame:frame));
	offsetBox.value=frame;
	playEvent.postln
});
q.nextLine;

StaticText(w, "offset : ".bounds).string_("offset : ");
offsetBox=NumberBox(w, "500000000".bounds);
offsetBox.value_(0);
offsetBox.action({arg self;
	playEvent.firstFrame=self.value
});
StaticText(w, "anacrouse".bounds).string_("anacrouse");
anacrouse=NumberBox(w, "500000000".bounds);
anacrouse.value_(0);



2.do({q.nextLine});

/////////////////////////

musique=(
	tempo: TempoClock.tempo=(67/60),

	// forme de l'accompagnement
	grillePrincipale:[
		Prand([0,2, -2]),
		Prand([5,3, 1]),
		Prand([4,2, 0]),
		Prand([3,1])
	],
	grille: { arg self; self.use{
		[
			4b,
			self.grillePrincipale ! 4,
			4b,
			self.grillePrincipale.rotate(1) ! 4
		].flat
		}
	},
	dur: [
		4,
		4 ! 16,
		2,
		4 ! 16
	].flat,

	formuleAcc:Pseq([0,1,2,3,1, 2, 4,5].reshape(8), inf),
);

musique.grillePrincipale.do({ |accord|
	var degree= switch(accord.list[0],
		0, {"Tonique"},
		5, {"Tonique"},
		3, {"ss-Dominante"},
		4, {"dominante"}
	);
	Button(w, 85@50).
	states_([
		[degree]
	])
});


Pdef(\mDroite,
	Pbind(
		\instrument, \a,

		\root, 9,
		\amp, 0.05,
		\legato, 0.95,
		\sust, 1,


		\grille, Pstep(
			Pseq(musique.grille.value) +[0,2,4],
			Pseq(musique.dur)
		),

		\arpeggiator, musique.formuleAcc,
		\octave, Pif(Pkey(\arpeggiator) < 2, 3, 4),
		\degree, Pfunc({ |ev|
			var accord=ev.grille;
			var index=ev.arpeggiator %3;
			accord.at(index)
		}),

		\dur, Pstep(
			1/4,
			Pseq(musique.dur)
		),
	).trace(\grille, prefix:"accord")
).quant([0,0]);

Pdef(\mGauche,

	Pbind(
		\instrument, \a,
		\legato, 1,
		\root, 9,

		\octave, [2,3],
		\amp, 0.08,


		\degree, Pseq(musique.grille.value),
		\dur, Pseq(musique.dur)

	).trace(\degree, prefix:"basse")
).quant([0,0]);

Button(w, "GOOOOOOOOOOOOOOOO".bounds)
.states_([
	["go?"],
	["stop?"]
])
.action_({
	arg self;
	switch(self.value,
		1, {
			Ptpar([
				0, Pn(Pdef(\mDroite)),
				0, Pn(Pdef(\mGauche)),
			])
			.play;
			musique.tempo.sched(anacrouse.value,
				{playEvent.play}
			);
		},
		0, {CmdPeriod.run}
	)
})
)

