(

/*
(
var notes=Array.rand(4, 10.1, 8.1).postln;
var durees=Array.rand(4, 1.1, 4.1).postln;
a=~score.(notes, durees);

// on peut updater
a.notes=Array.rand(4, 1, 8).postln;
a.durees=Array.rand(4, 1, 4).postln;
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
	notes=(0!1), durees=(0!1),
	topFen=(~fenetre.()),
	echelle=(notes.maxItem + 4);

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


			var partoche, durees, notes,
			offsetX=0, offsetY=(self.fenetre.bounds.height)/self.echelle;


			//on update la grille
			self.grille.resoX=self.echelle;
			self.grille.resoY=self.durees.size-1;

			// on normalize pour la largeur
			durees=([0]++self.durees.integrate).normalize(0+offsetX, self.fenetre.bounds.width-offsetX);
			// on normalise à l'envers pour la hauteur
			notes=self.notes.linlin(0, self.echelle, self.echelle, 0).linlin(0, self.echelle, 0, self.fenetre.bounds.height-offsetY);
			// et on match le tout
			partoche= notes+++ durees;
			partoche;

			// self.fenetre.background_(Color.white);
			self.fenetre.drawFunc = FunctionList.addFunc (
				// on fout une grille
				self.grille.func,
				// on dessine les carrées dessus
				    {
					partoche.do{ arg i, index;
					var hauteurCarre=offsetY;
					var longueurCarre=0;
					        Pen.color = Color.blue;
					        Pen.addRect(
						            Rect(i[1], i[0], hauteurCarre, hauteurCarre)
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