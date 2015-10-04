(

f=(Platform.resourceDir+/+"sounds/*").pathMatch[0];

b=SoundFile.openRead(f);

w=CompositeView(Window().front.alwaysOnTop_(true), Rect(0,0,300,300)).layout_(VLayout());

w.layout.add(
	VLayout(
		a=SoundFileView()
		.soundfile_(b)
		.read()
		.timeCursorOn_(true)
		.gridResolution_(0.5)
		.mouseUpAction_{
			// un peu de casse-couillerie ici parce qu'il faut setter soi-même la position du curseur
			// par rapport à la position x détectée par "mouseDownAction"

			arg self, xpos, ypos, modifiers;

			// siouxerie mathématique incroyable


			var firstFrame=(a.numFrames-a.viewFrames)*a.scrollPos;
			var pos =ControlSpec(firstFrame, firstFrame+a.viewFrames);
			if(modifiers == 0) {
			a.timeCursorPosition_(
				pos.map(xpos/self.bounds.width)
			);
			c.valueAction_(
				pos.unmap(a.timeCursorPosition)
			)
			}
		}

	)

);

w.layout.add(
	Slider()
	.value_(0.5)
	.orientation_(\horizontal)
	.action_{
		arg self;
		a.gridResolution_(self.value);
		c.doAction
	}
);

w.layout.add(
	c=Slider()
	.value_(0)
	.orientation_(\horizontal)
	.action_{
		arg self;
		var baseFrame, resolution, offset;
		var firstFrame=(a.numFrames-a.viewFrames)*a.scrollPos;
		var pos =ControlSpec(firstFrame, firstFrame+a.viewFrames);

		a.timeCursorPosition_(
			pos.map(self.value)
		);

		baseFrame=a.timeCursorPosition/44100;
		resolution=a.gridResolution;

		offset=baseFrame-resolution;
		a.gridOffset_(offset);
	}
)
)
