/*

(
~animatedScore.()

w=~fenetre.();
a=~animatedScore.(w);
a.peuplerScore([1,2,3], [1,2,3,1]);
a.run
a.arret
)

*/

(
~animatedScore={ |vue=(~fenetre.())|

	var matrix, a, b, envir;

	vue.layout_(
			VLayout(
				UserView(),
				UserView()
			)
		);


	matrix= [1, 0, 0, 1, 0, 0];
	 b=vue.view.children[1];
	a=~score.([0], [0], topFen:vue.view.children[0]);


	b.drawFunc= {
		Pen.matrix = matrix;
		Pen.strokeColor=Color.red;
		Pen.line(0@0, 0@b.bounds.height);
		Pen.stroke
	};


	envir=(
		matrix: matrix,

		score:a,
		peuplerScore: {|self, notes, durees|
			self.score.notes=notes;
			self.score.durees=durees;
			self.score.rafraichir;
		},


		barre:b,

		box:
		CheckBox(vue, 50@50)
		.string_("go ??")
		.action_({ |self|
			switch(self.value,
				true, {
					{
				var largeur=vue.bounds.width;
				var temps=a.durees.integrate.last;
				var refreshTime=(temps/largeur).postln;

				largeur.do{ |i|
					matrix.put(4, i);
					b.refresh;
					refreshTime.wait
				}
			}.fork(AppClock);

			Pfset( {},
				Pbindef(\patAScore,
					\degree, Pseq(a.notes),
					\dur, Pseq(a.durees),
				),
				{
					{self.value_(false)}.defer
				}

			).collect({ arg ev;
						~event = ev;
					})
					.play;
				},
				false, {
					CmdPeriod.run;
					AppClock.clear;
					envir.matrix[4]=1;
				}
			);
		}),

		run: { |self|
			self.box.valueAction_(true)
		},

		arret: { |self|
			self.box.valueAction_(0)
		}


	);
	envir;
}

)
