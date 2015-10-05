(
Platform().recompile;
s.waitForBoot(
{
		a=SFViewPlus(dir:"Musique/instrumentals")
});
)

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