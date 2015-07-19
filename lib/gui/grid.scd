(

// faire un petit grillage configurable
// resoX (nombre de carrés à l'horizontal)
// 	resoY (nombre de carrés à la vertical)
//
/* 	(
a=~grille.();
// on change les reso
a.resoX=20.rand;
a.resoY=0;
a.postln;
a.rafraichir;

// on la met dans une userView
w=~fenetre.("prout", 350, 200, 100, 87);
a.topFen(w)

// on peut aussi créer directement une grille dans une UserView pre-existante
x=UserView(w, w.view.bounds).background_(Color.rand)
b=~grille.(topFen:x)

)
*/

~grille={

	arg resoX=5,
	resoY=5,
	topFen=(~fenetre.());

	var fen, envir;
	if (topFen.class==Window)
	{	fen	=(UserView(topFen, Rect(0, 0, topFen.view.bounds.width, topFen.view.bounds.height)))}
	{ fen=topFen};

	envir= (

		resoX:resoX,
		resoY:resoY,
		fen:fen,
		longueurCarre:{|self|
			self.fen.bounds.height/self.resoX;
		},
		hauteurCarre:{|self|
			self.fen.bounds.width/self.resoY;
		},


		topFen:{ arg self, top;
			self.fen=UserView(top, Rect(0, 0, top.bounds.width, top.bounds.height));
			self.rafraichir;
		},

		func: {arg self;
			{
			var longCarre=self.longueurCarre;
			var hautCarre=self.hauteurCarre;

			var horizontal={
				arg nbIter;
				Pen.moveTo(0@longCarre*nbIter);
				Pen.lineTo(self.fen.bounds.width@longCarre*nbIter);
				Pen.stroke;
			};

			var vertical={
				arg nbIter;
				Pen.moveTo(hautCarre*nbIter@0);
				Pen.lineTo(hautCarre*nbIter@self.fen.bounds.height);
				Pen.stroke;
			};


			// et on trace
			self.resoX.do({|i|
				horizontal.value(i)
			});
			// et on trace
			self.resoY.do({|i|
				vertical.value(i)
			});
			}
		},
		rafraichir:
		{ |self|
			// on init le gros bouzin
			self.fen.drawFunc=self.func;
			self.fen.refresh;
		}
	);

	envir.rafraichir;
	envir;

}
)
