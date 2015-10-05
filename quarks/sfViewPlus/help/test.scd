Quarks.install("~/Dropbox/generative/quarks/sfViewPlus")

(
Platform().recompile;
)
(
s.waitForBoot(
{
		a=SFViewPlus(dir:"Musique/remix/instrumentals")
});
)
a=();
b=();
a.isPlaying
if(a[\a], {0}, {1})
(
w=Window().front;
a=Slider(w, Rect(0,0,60,60))
.background_(Color.red)
.keyDownAction_{
	|a, b, c, d, e, f, g, h|
	"hjk".postln;
	[a, b, c, d, e, f, g, h].postln
}
)
a.playEvent.play
a.sf.soundfile.cue((), true)
(
var w=Window().front;
var un, deux, trois;
var layout;
un=Slider();
deux=Slider();
trois=Slider();
layout=VLayout(
        HLayout(un, deux),
        trois
);
w.layout_(layout)
)
) 