(

// faire un petit grillage configurable
// resoX (nombre de carrés à l'horizontal)
// 	resoY (nombre de carrés à la vertical)
//
/* 	(
a=~grille.();

// on change les reso
a.resoX=20.rand;
a.resoY=20.rand;

a.rafraichir;

// on la met dans une userView
w=~fenetre.("prout", 200, 249, 100, 87);
x=UserView(w);
a.fen=x;
a.rafraichir;

)
*/

~grille={

	arg resoX=10,
	resoY=10,
	fen=(~fenetre.());

	var envir= (
		resoX:resoX,
		resoY:resoY,
		fen:fen,

		rafraichir:
		{ |self|

			self.fen.drawFunc={

				var longCarre=self.fen.bounds.width/self.resoX;
				var hautCarre=self.fen.bounds.height/self.resoY;

				var horizontal={
					arg nbIter;
					(longCarre*nbIter);
					Pen.moveTo(0@longCarre*nbIter);
					Pen.lineTo(self.fen.bounds.width@longCarre*nbIter);
					Pen.stroke;
				};


				var vertical={
					arg nbIter;
					(longCarre*nbIter);
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

			};
			self.fen.refresh;
		}
	);

	envir.rafraichir;
	envir;

}
)
