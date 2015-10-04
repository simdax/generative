
(
181.32/2

var path, root="/home/simdax/Musique/remix/vocals/";
var w, w2, l1, l2, l3;
var file, durFile, sfView, playEvent, jouer=false, onOff, ampBuf;
var offsetBox, anacrouse, formuleAcc=(Array.rand(8, 0, 10)), grille=Array.fill(4, {[0,0,0,0]}), repe=[1,1,1,1];
var musique, tempo, indicTempo, metronome, metronomeOffset;
var amp, tonalite;

~save={
	var tempo, tona, grill, frame;
	var p=root+/+path.item.splitext[0]+".mix";

	tempo=TempoClock.tempo;
	tona=tonalite.value;
	grill=grille;
	frame=~frame;

	File.use(p, "w+", {
		arg self;
		self.write(
			[tempo, tona, grill].asString
		)
	});
	~jk.stringColor_(Color.rand)
};

~load={
	var p=root+/+path.item.splitext[0]+".mix";
	var data;

	File.use(p, "r", {
		arg f;
		if (f.isOpen) {
			var temp;

			~kj.string_("trouvé !");
			data=f.readAllString.interpret;
			TempoClock.tempo=data[0];
			metronome.value_(TempoClock.tempo*60);
			~controls[\root].value=data[1];
			temp = data[2];
			grille.do{ arg j, ind;
				grille[ind].size.do{
					arg i;
					grille[ind][i]=temp[ind][i]
				}
			};
			grille.do({
				arg gh, indexG;
				gh.do({arg i, index;
					a.children.postln;
					a.children[4+(2*indexG)+index+(4*indexG)].valueAction_(
						switch(i,
							0, 0,
							3, 1,
							4, 2,
							5, 3
					))
				})
			});
			sfView.timeCursorPosition_(~frame);

		} {
			~kj.string_("rien du tout!")
		};

	});
	data.postln;
};


s.waitForBoot( {

	//synth
	var b = Buffer.alloc(s,1024,1);
	var buf;

	SynthDef(\help_beattrack,{arg vol=1.0, beepvol=1.0, lock=0, bufnum, startFrame;
		var in, fft, resample;
		var trackb,trackh,trackq,tempo;
		var bsound,hsound,qsound, beep;

		in= PlayBuf.ar(1,bufnum,BufRateScale.kr(bufnum),1,startFrame,1);
		fft = FFT(b, in);
		#trackb,trackh,trackq,tempo=BeatTrack.kr(fft, lock);
		SendTrig.kr(SinOsc.kr(1), 0, tempo*60);
	}).add;

	OSCFunc({ arg msg, time;
		AppClock.sched(0.1,
			{indicTempo.string_(
				"tempo =~ " + [msg][0][3]
				)
			}
		);
	},'/tr', s.addr);


	SynthDef(\click, { |freq, click_out=0, amp|
		var snd = SinOsc.ar(freq, 0.5pi, amp) * EnvGen.ar(Env.perc(0.001,0.05), doneAction:2);
		OffsetOut.ar(click_out, snd!2);
	}).add;



	SynthDef(\a, {
		arg freq, dur, amp,
		gate=1, atk=0.05, rel=0.1,
		out=0, pan=0;

		var sig=MdaPiano.ar(freq);

		var env=EnvGen.kr(Env.adsr(atk, 0.1, 1, rel), gate, amp, doneAction:2);

		Out.ar(
			out,
			Pan2.ar(sig*amp, pan)
		)
	}).add;

	SynthDef(\buf, { arg out=0, bufnum, offset=0, amp=0.3, gate=1;
		Out.ar(out,
			PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum), gate, offset, doneAction:2) * amp)
	}).add;


	/////////// LES PDEF /////////


	/// les pdefn  ///


	Pdefn(\grille,
		Pn(Plazy({
			var x=repe.collect({ |i, index|
				Pseq(grille[index],i)
			});
			Pseq(x)
		}))
	);

	Pdefn(\formuleAcc,
		Pseq(formuleAcc, inf)
	);

	Pdefn(\dur, Pseq([
		( 4 ! 4 ) ! 4
		].flat)
	);
	Pdefn(\root, 5);
	Pdefn(\amp, 0.02);



	//// les gros pdef


	Pdef(\metronome,
		Pbind(
			\instrument, \click,
			\amp, 0.3,
			\freq, Pseq([1000, Pn(500,3)], inf),
	)).quant_([4,0,0]);

	Pdef(\mDroite,
		Pn
		(Pbind(
			\instrument, \a,

			\root, Pdefn(\root),
			\amp, Pdefn(\amp),
			\legato, 0.95,

			\grille, Pstep(
				Pdefn(\grille) +[0,2,4],
				Pdefn(\dur)
			),

			\arpeggiator, Pdefn(\formuleAcc),
			\octave, 3 + (Pkey(\arpeggiator) div: 3),
			\degree, Pfunc({ |ev|
				var accord=ev.grille;
				var index=ev.arpeggiator %3;
				accord.at(index)
			}),

			\dur, 1/4,
			)
		)
	);

	Pdef(\mGauche,
		Pn(
			Pbind(
				\instrument, \a,
				\legato, 1,
				\root, Pdefn(\root),

				\octave, [2,3],
				\amp, Pdefn(\amp)-0.03,

				\degree, Pdefn(\grille) + Prand([2,-2, 0, 0, 0, 0, 0], inf),
				\dur, Pdefn(\dur),
			)
		)
	);


	/// the task

	t=Task ({
		inf.do({
			arg i;
			file !? {
				if (i != 0) {
					AppClock.sched(0,
						{
							sfView.timeCursorPosition =
							sfView.timeCursorPosition + (file.sampleRate * TempoClock.beatDur);
							offsetBox.value=sfView.timeCursorPosition;
						};
					)
			}};
			1.wait
		})
	});

	/// window


	Window.closeAll;
	w=Window("guiHarmo", 1000@500).front.alwaysOnTop_(true);
	w.addFlowLayout;
	w.view.keyUpAction_({
		|self, char, mod, unicode, keycode, key|
		switch(unicode,
			32, {
				switch(onOff.value,
					1, {onOff.valueAction_(0)},
					0, {onOff.valueAction_(1)},
				)
			}
		)

	});

	// layout principal

	w.layout_(
		HLayout(
			[l1=CompositeView().layout_(VLayout()), stretch:4],
			[l2=CompositeView().layout_(VLayout()), stretch:5],
			[l3=CompositeView(), stretch:1]
		)
	);

	// l1
	l1.layout.add(
		VLayout(
			StaticText()
			.string_(root),
			path=PopUpMenu()
			.items_(
				PathName(Platform.userHomeDir+/+"Musique/remix/vocals").entries
				.select({ |i| i.extension=="wav" }).collect(_.fileName);
			)
			.action_{
				var p=root+/+path.item;

				{buf=Buffer.read(s, p)}.defer(0.5);

				file !? {file.close} ??	file=SoundFile.new;
				file.openRead(p);

				sfView.soundfile_(file);
				sfView.read(0, file.numFrames);
				sfView.refresh;

				durFile.string_(" durée : "++file.duration.asTimeStringLJP)
			}
		)
	);

	l1.layout.add(
		w2=CompositeView().background_(Color.rand)
		.layout_(
			VLayout(
				onOff=Button()
				.states_([
					["play?"],
					["stop?", nil, Color.red]
				])
				.action_{
					arg self;

					var firstFrame=(sfView.numFrames-sfView.viewFrames)*sfView.scrollPos;
					var pos =ControlSpec(firstFrame, firstFrame+sfView.viewFrames);

					switch( self.value,
						1, {
							var frame=sfView.timeCursorPosition;
							var amp=ampBuf.value;
							var metronom=metronome.value;

							~frame=frame;
							jouer=true;

							file !?
							{
								var schedFunc;
								if (metronom.asBoolean)
								{schedFunc=\playNextBar}
								{schedFunc=\play };
								TempoClock.perform(schedFunc, {
									if (jouer) {
										y=Synth(\buf, [bufnum: buf, offset:frame, amp: amp]);
										x=Synth(\help_beattrack, [bufnum: buf, startFrame:frame]);
										t.play;
									}
								})
							} ??
							{ self.value_(0) }
						},
						0, {
							var total=file.numFrames,
							nbFen=(file.duration / sfView.gridResolution);

							y.free;
							x.free;
							t.stop; t.reset;
							jouer=false;
							c.valueAction_(pos.unmap(~frame))

						}
					);
				},

				durFile=StaticText(),


				sfView=SoundFileView()
				.timeCursorOn_(true)
				.gridOn_(true)
				.gridResolution_(TempoClock)
				.action_{
					var frame=sfView.timeCursorPosition;
					var amp=ampBuf.value;
					(jouer).if {
						y.free; x.free;
						y=Synth(\buf, [bufnum: buf, offset:frame, amp: amp]);
						x=Synth(\help_beattrack, [bufnum: buf, startFrame:frame]);
					};
				}
				.mouseUpAction_{

					arg self, xpos, ypos, modif;

					var frame=sfView.timeCursorPosition;
					var amp=ampBuf.value;

					var firstFrame, pos;

					if (file.isNil.not and: modif==0) {
						var total=file.numFrames,

						nbFen=(file.duration / sfView.gridResolution),
						firstFrame=(sfView.numFrames-sfView.viewFrames)*sfView.scrollPos,
						pos =ControlSpec(firstFrame, firstFrame+sfView.viewFrames);

						frame=frame.quantize(total / nbFen, total / nbFen, 1);  // stick to grid
						sfView.timeCursorPosition=frame;
						c.valueAction_(
							pos.unmap(sfView.timeCursorPosition)
						); // stick to slider

						// info boxes
						offsetBox.value=frame;
						~frame=frame;

						// music
						(jouer).if {
							y.free; x.free;
							y=Synth(\buf, [bufnum: buf, offset:frame, amp: amp]);
							x=Synth(\help_beattrack, [bufnum: buf, startFrame:frame]);
						};
					};
				}
				.keyDownAction_{
					|a, b, c, d, e|
					if (e==110)
					{
						a.timeCursorPosition_(0);
						a.doAction;
					}
				}.minHeight_(200),

				~d=Slider()
				.value_(0.5)
				.orientation_(\horizontal)
				.action_{
					arg self;
					var firstFrame=(sfView.numFrames-sfView.viewFrames)*sfView.scrollPos;
					var pos =ControlSpec(firstFrame, firstFrame+sfView.viewFrames);

					var frame=pos.map(self.value);
					var resolution=ControlSpec(0.3, 10, 'exp').map(self.value);

					TempoClock.tempo=resolution.reciprocal;
					tempo.value_(TempoClock.tempo*60);

					file !? {
						sfView.gridResolution_(resolution);
						c.valueAction_(pos.unmap(sfView.timeCursorPosition))
					}
				},
				c=Slider()
				.value_(0)
				.orientation_(\horizontal)
				.action_{
					arg self;
					var baseFrame, resolution, offset;
					var firstFrame=(sfView.numFrames-sfView.viewFrames)*sfView.scrollPos;
					var pos =ControlSpec(firstFrame, firstFrame+sfView.viewFrames);

					if (jouer.not) {
						var frame=pos.map(self.value);

						sfView.timeCursorPosition_(frame);
						offsetBox.value_(frame);

						baseFrame=sfView.timeCursorPosition/44100;
						resolution=sfView.gridResolution;

						offset=baseFrame-resolution;
						sfView.gridOffset_(offset);
					}
				}

			)
	));





	///////////////////////// LES BOUTONS D'HARMONISATION ////////


	///// LA GRILLE ////

	l2.layout.add(
		a=CompositeView().layout_(VLayout())
		.background_(Color.rand)
	);


	a.layout.add(
		HLayout(
			StaticText().string_("frame : "),
			offsetBox=NumberBox().value_(0),
			StaticText().string_("anacrouse"),
			anacrouse=NumberBox().value_(4)
		)
	);



	grille.reverse.collect
	({ |gril, index|
		var h=HLayout();
		~arrayValueRepe=Array.fill(repe.size,0);
		a.layout.insert(h);
		gril.collect({ |item, index|
			h.add(
				Button(a)
				.states_([
					["tonique",nil, nil],
					["ss-dominante", nil, Color.yellow],
					["dominante", nil, Color.red],
					["relatif", nil, Color.blue]
				])
				.canFocus_(false)
				.action_({ arg self;
					gril[index]= switch(self.value,
						0, 0,
						1, 3,
						2, 4,
						3, 5
					);
				});
			)
		});
		h.add(
			~e=NumberBox()
			.value_(repe[repe.size-1-index])
			.clipLo_(1)
			.action_({|self|
				if (~checkBox.value)
				{
					repe[repe.size-1-index]=self.value;
					~arrayValueRepe[repe.size-1-index]=self.value;
					~arrayValueRepe.postln
				}
				{ self.value_(0) }
			});
		);
		h.add(
			~checkBox=CheckBox()
			.value_(true)
			.action_({
				arg self;
				e.postln;
				if (self.value.postln) {e.value_(~arrayValueRepe.reverse[index])}
				{e.clipLo_(0) ; e.value_(0)}
			})
		);
	});


	a.layout.add(
		Button()
		.canFocus_(false)
		.states_([
			["au hasard ?"],
			["tout tonique ?"]
		])
		.action_({
			arg self;
			grille.do{ arg j, ind;
				grille[ind].size.do{
					arg i;
					switch(self.value,
						1, {grille[ind][i]=[0,3,4,5].choose},
						0, {grille[ind][i]=0}
					)
				}
			};
			grille.do({
				arg gh, indexG;
				gh.do({arg i, index;
					a.children.postln;
					a.children[4+(2*indexG)+index+(4*indexG)].valueAction_(
						switch(i,
							0, 0,
							3, 1,
							4, 2,
							5, 3
					))
				})
			});
			grille=grille.reverse;
			grille.postln;
		})
	);


	//// BOUTONS DE ON Y VA !!! //////


	// METRONOME

	{
		var ctlSpec, ctlSpecTempoFin, ctlSpecOffset;
		var view=CompositeView()
		.background_(Color.rand);
		ctlSpec=ControlSpec(0.1, 220, \lin);

		l2.layout.add(view);

		view.layout_(
			HLayout(
				VLayout(
					metronome=Button()
					.states_([
						["metronome OFF"],
						["metronome ON", nil, Color.red]
					])
					.canFocus_(false)
					.action_({
						arg self;
						switch(self.value,
							1, {
								Pdef(\metronome).play;
							},
							0, {
								Pdef(\metronome).stop;
							}
						)
					}),
					Slider()
					.value_(0.5)
					.orientation_(\horizontal)
					.action_({
						arg self;
						Pbindef(\metronome, \amp, self.value)
					})
				),
				VLayout(
					tempo=NumberBox()
					.value_(TempoClock.tempo*60)
					.action_({
						arg self;
						TempoClock.tempo=self.value/60;
						~d.valueAction_(ControlSpec(200,6, 'exp').unmap(TempoClock.tempo*60).postln)
					}),
					Slider()
					.value_(0.5)
					.orientation_(\vertical)
					.action_({
						arg self;
						var ctlSpecTempoFin=ControlSpec(-0.25, 0.25, \lin);
						var niouTempo=(ctlSpecTempoFin.map(self.value())/60);
						TempoClock.tempo=TempoClock.tempo+ niouTempo;
						sfView.gridResolution_(TempoClock.beatDur);
						tempo.value=TempoClock.tempo*60;
					})
					.mouseUpAction_({
						arg self;
						self.value=0.5
					})
				),
				indicTempo=StaticText()
				.string_("estimation de tempo : "),
				Slider()
				.value_(ctlSpec.unmap(TempoClock.tempo*60))
				.action_{ |self|
					var val=ctlSpec.map(self.value);
					tempo.value=val;
					TempoClock.tempo=val/60;
					sfView.gridResolution_(TempoClock.beatDur);
				}.maxWidth_(30),
				metronomeOffset=Slider()
				.value_(0.5)
				.mouseUpAction_({
					arg self;
					var val= ControlSpec(-1,1, \lin).map(self.value);
					sfView.gridOffset_(sfView.gridOffset + val);
					sfView.timeCursorPosition_(
						sfView.timeCursorPosition + (file.sampleRate * val)
					);
					offsetBox.value_(sfView.timeCursorPosition);
					self.value=0.5
				})
			)
		);

	}.value;




	///// LES BOUTONS pour LA GRILLE ///
	{
		var ctlSpec;
		var view=CompositeView()
		.background_(Color.rand);
		l2.layout.add(view);
		ctlSpec=ControlSpec(0, 10, 'lin', 1);

		view.layout_(
			HLayout(
				ampBuf=Slider()
				.value_(0.5)
				// .orientation_(\vertical)
				.action_{ arg self;
					(jouer).if { x.set(\amp, self.value) } ;
				},

				Button()
				.states_([
					["go?"],
					["stop?", nil, Color.red]
				])
				.action_({

					arg self;
					var  frame=sfView.timeCursorPosition;
					var amp=ampBuf.value;

					switch(self.value,
						1, {

							switch(onOff.value,
								1, {onOff.valueAction_(0)},
								0, {~frame=frame}
							);

							Pdef(\metronome).stop;


							Pdef(\mDroite).play(quant:1);
							Pdef(\mGauche).play(quant:1);
							Pdef(\metronome).play(quant:1);

							TempoClock.sched(anacrouse.value,
								{
									x=Synth(\buf, [bufnum: buf, offset:frame, amp: amp]);
									y=Synth(\help_beattrack, [bufnum: buf, startFrame:frame]);
									jouer=true;
									t.play(quant:0);
								}
							);
							metronome.value_(1);
							file !? {onOff.value_(1)};
						},
						0, {
							var total=file.numFrames,
							nbFen=(file.duration / sfView.gridResolution);

							metronome.valueAction_(0);
							onOff.value_(0);
							x.free; y.free;
							Pdef(\mDroite).stop;
							Pdef(\mGauche).stop;
							t.reset; t.stop;
							jouer=false;
							// ~frame.postln=~frame.quantize(total / nbFen, total / nbFen, 1).postln;  // stick to grid
							sfView.timeCursorPosition_(~frame)
						}
					)
				}),


				MultiSliderView()
				.elasticMode_(true)
				.value_( ctlSpec.unmap(
					Pdefn(\formuleAcc).source.list
					)
				)
				.action_{ arg self;
					var val=ctlSpec.map(self.value);
					val.do({ |i, index|
						formuleAcc[index]=i
					})
				}
			)
		);


		~controls=Dictionary.newFrom([
			\amp,   ControlSpec(0.2, 0.6, \exp),
			\root, ControlSpec(-6,6, \lin, 1),
		])
		.keysValuesChange({ |k, v|
			var slider, text;
			view.layout.add(
				HLayout(
					slider=Slider()
					.value_(0.5)
					.action_{ arg self;
						var val= v.map(self.value);
						Pdefn(k, val);
						text.string_(val);
					},
					text=StaticText()
					.string_(v.map(slider.value))
					.maxSize_(20),
				),
			);
			slider;
		});


	}.value;

	/////////////// SAUVEGARDER //////


	l3.layout_(
		VLayout(
			Button()
			.states_([
				["sauvegarder?"]
			])
			.action_{
				~save.();
			}
			,
			~jk=StaticText().string_("done")
			,
			Button()
			.states_([
				["loader?"]
			])
			.action_{
				~load.();
			}
			,
			~kj=StaticText()
		)
	);


	//// ON CLOSE ///////

	w.onClose_{
		// ~save.();
		jouer=false;
		x !? { x.free; y.free};
		Buffer.freeAll;
		CmdPeriod.removeAll
	}; // clean up when window is closed

})
)


