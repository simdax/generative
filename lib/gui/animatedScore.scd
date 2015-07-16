/*
~animatedScore.()

*/
(
~animatedScore={ |vue|

var matrix = [1, 0, 0, 1, 0, 0];

	if (vue.isNil)
{w=Window.new
.layout_(
	VLayout(
		UserView(),
		UserView()
	)
)
		.front;}
	{w=vue};

a=~score.([0,1,2,3], [1,1,2,1], topFen:w.view.children[0]);
b=w.view.children[1];
b.drawFunc= {
	Pen.matrix = matrix;
	Pen.strokeColor=Color.red;
	Pen.line(0@0, 0@b.bounds.height);
	Pen.stroke
};


CheckBox(w, 50@50)
.string_("go ??")
.action_({ |self|
	{
		var largeur=w.bounds.width;
		var temps=a.durees.integrate.last;
		var refreshTime=(temps/largeur).postln;

		largeur.do{ |i|
			matrix.put(4, i);
			b.refresh;
			refreshTime.wait
		}
	}.fork(AppClock);

	Pfset( {},
		Pbind(
		\degree, Pseq(a.notes),
		\dur, Pseq(a.durees)
		),
		{
			{self.value_(false)}.defer
		}

	).play
});
}

)

