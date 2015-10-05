SFViewPlus {

	var <>fenetre, <>dir,
	<>sf, <>playEvent,
	t;

	*new{
		arg fen=Window.new.alwaysOnTop_(true).front,
		dir=Platform.resourceDir;
		^super.newCopyArgs(fen, dir).init;
	}
	init{
		var path=Platform.userHomeDir+/+dir;
		var layout;
		var rootPath, filePath, gridRes, gridResNUMBERBOX, gridResSLIDER, jesaispas, boutonPlay, offsetBox, amp;
		var isPlaying;
		var getWAV={
			arg path;
			PathName(path).files
			.select({arg i;i.extension=="wav"}).collect(_.fullPath)
		};

		playEvent=();

		t=Task ({
			inf.do({
				arg i;
				sf.soundfile !? {
					if (i != 0) {
						AppClock.sched(0,
							{
								sf.timeCursorPosition =
								sf.timeCursorPosition + (sf.soundfile.sampleRate * TempoClock.beatDur);
								offsetBox.value=sf.timeCursorPosition;
							};
						)
				}};
				1.wait
			})
		});

		offsetBox=NumberBox().value_(0);
		amp=Knob().value_(0.5);

		rootPath=Button()
		.states_([
			[path]
		])
		.action_{
			FileDialog({
				arg p;
				// on change le path
				path=p[0];
				// on actualise les paths
				rootPath.states_([
					[path]
				]);
				filePath.items_(
					getWAV.(path)
				)
			}, {}, 2,0, false )
		};

		filePath=PopUpMenu()
		.items_(getWAV.(path))
		.action_{ arg self;
			var path=self.item;
			path.postln;
			sf.soundfile_(
				SoundFile.openRead(path)
			);
			sf.soundfile.postln;
			sf.readWithTask
		};

		sf=SoundFileView()
		.timeCursorOn_(true)
		.gridOn_(true)
		.action_{
			var frame=sf.timeCursorPosition;
		}
		.keyDownAction_{
			arg self, char, mod, unicode;
			var ev;
			switch(unicode,
				32,
				{
					self.soundfile !? {
						switch(playEvent[\isPlaying],
							nil, {
								playEvent=self.soundfile.cue(
									(firstFrame:self.timeCursorPosition), true);
							},
							false, {
								playEvent=self.soundfile.cue(
									(firstFrame:self.timeCursorPosition), true);
							},
							true, {
								playEvent.stop
							}
						)
					}
				}
			);
		}
		.mouseUpAction_{
			arg self, xpos, ypos, modif;

			var frame=sf.timeCursorPosition;
			var file=sf.soundfile;
			var amp=amp.value;

			var firstFrame, pos;

			if (file.isNil.not and: modif==0) {
				var total=sf.soundfile.numFrames,

				nbFen=(file.duration / sf.gridResolution),
				firstFrame=(sf.numFrames-sf.viewFrames)*sf.scrollPos,
				pos =ControlSpec(firstFrame, firstFrame+sf.viewFrames);

				frame=frame.quantize(total / nbFen, total / nbFen, 1);  // stick to grid
				sf.timeCursorPosition=frame;
				jesaispas.valueAction_(
					pos.unmap(sf.timeCursorPosition)
				); // stick to slider

				// info boxes
				offsetBox.value=frame;

				// music
				self.soundfile !? {
					switch(playEvent[\isPlaying],
						true, {
							//stop and play
							playEvent.stop;
							playEvent=self.soundfile.cue(
								(firstFrame:self.timeCursorPosition), true);
						}
					)
				}
			};
		}.minHeight_(100);


		gridResNUMBERBOX=NumberBox()
		.value_(0)
		.maxWidth_(20)
		;

		gridResSLIDER=Slider()
		.value_(0.5)
		.action_{
			arg self;
			var firstFrame=(sf.numFrames-sf.viewFrames)*sf.scrollPos;
			var pos =ControlSpec(firstFrame, firstFrame+sf.viewFrames).map(self.value);
			var resolution=ControlSpec(0.3, 10, 'exp').map(self.value);

			//on change
			// le tempo
			TempoClock.tempo=resolution.reciprocal;
			// la resolution
			sf.soundfile !? {
				sf.gridResolution_(resolution);
				jesaispas.valueAction_(pos.unmap(sf.timeCursorPosition))
			};
			// on actualise la numberBox
			gridResNUMBERBOX.value=resolution;
		}
		.maxWidth_(20)
		;

		jesaispas=Slider()
		.value_(0)
		.orientation_(\horizontal)
		.action_{
			arg self;
			var baseFrame, resolution, offset;
			var firstFrame=(sf.numFrames-sf.viewFrames)*sf.scrollPos;
			var pos =ControlSpec(firstFrame, firstFrame+sf.viewFrames);

			if(playEvent[\isPlaying].asBoolean) {
			var frame=pos.map(self.value);

			sf.timeCursorPosition_(frame);
			offsetBox.value_(frame);

			baseFrame=sf.timeCursorPosition/s.sampleRate;
			resolution=sf.gridResolution;

			offset=baseFrame-resolution;
			sf.gridOffset_(offset);
			}
		}
		.fixedWidth_(sf.bounds.width);

		boutonPlay=Button()
		.states_([
			[""],
			["", Color.red]
		])
		;

		layout=(VLayout(
			HLayout(rootPath, filePath),
			VLayout(
				HLayout(
					sf,
					VLayout(gridResNUMBERBOX, gridResSLIDER)
				),
				HLayout(jesaispas, boutonPlay, offsetBox, amp)
			)
		));
		fenetre.layout_(layout);

	}
}


