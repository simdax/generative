(
/*
(
~score.();

var notes=Array.rand(4, 1, 8).postln;
var durees=Array.rand(4, 1, 4).postln;
a=~score.(notes, durees);

// on peut updater
a.notes=Array.rand(4, 0, 8).postln;
a.durees=Array.rand(4, 1.1, 4.1).postln;
a.rafraichir

//on peut changer la grille en Y

a.grille.resoY=0;
a.rafraichir

// on peut le coller à une fenêtre dans une autre Fenetre
var notes=Array.rand(4, 1, 8).postln;
var durees=Array.rand(4, 1, 4).postln;
w=~fenetre.("prout", 200, 249, 100, 87);
x=UserView(w, w.bounds);
~score.(notes, durees, x);


)
*/

~score={

	arg
	notes=Array.rand(5, 0, 7),
	durees=(2! notes.size),
	topFen=(~fenetre.()),
	echelle=10;

	var fen, envir, grille;
	if (topFen.class==Window)
	{	fen	=(UserView(topFen, Rect(0, 0, topFen.view.bounds.width, topFen.view.bounds.height)))}
	{ fen=topFen};

	grille=~grille.(echelle, durees.size-1, fen);

	 envir=(

		notes:notes,
		durees: durees,
		fenetre: fen,
		echelle: echelle,
		grille: grille,
		rafraichir: { arg self;


			var partoche, points, durees, notes,
			//hauteurCarre=20, longueurCarre=20,
			offsetX=0, offsetY=0;
			//(self.fenetre.bounds.height)/self.echelle;

			//on update la grille
			self.grille.resoX=self.echelle;
			// self.grille.resoY=self.durees.size-1;

			// on normalize pour la largeur
			points=([0]++self.durees.integrate)
			.normalize(0+offsetX, self.fenetre.bounds.width-offsetX)
			//.postln
			;

			durees=(points.size-1).collect({|i|
				points[i+1]-points[i]
			})
			//.postln
			;

			// on normalise à l'envers pour la hauteur
			notes=self.notes
			.linlin(0, self.echelle-1, self.echelle-1, 0) // on renverse
			.linlin(0, self.echelle-1, 0, (self.fenetre.bounds.height-self.grille.longueurCarre).postln)
			//.postln
			;

			// et on match le tout
			partoche= notes+++ points +++durees;
			partoche;

			// ON DESSINE
			// self.fenetre.background_(Color.white);
			self.fenetre.drawFunc = FunctionList.addFunc (
				// on fout une grille
				self.grille.func,
				// on dessine les carrées dessus
				    {
					partoche.do{ arg i, index;
					var hauteurCarre=self.grille.longueurCarre;
					        Pen.color = Color.rand;
					        Pen.addRect(
							Rect(i[1], i[0], i[2], hauteurCarre)
					        );
					        Pen.fill;
				}},
			);
			self.fenetre.refresh;
		}
	);

	envir.rafraichir;
	envir;
}
)


