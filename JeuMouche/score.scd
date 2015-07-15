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

// on peut le coller à une fenêtre dans une UserView
var notes=Array.rand(4, 1, 8).postln;
var durees=Array.rand(4, 1, 4).postln;
w=~fenetre.("prout", 200, 249, 100, 87);
x=UserView(w);
~score.(notes, durees, x);


)
*/

~score={

	arg
	notes, durees,
	fenetre=(~fenetre.()),
	echelle=(notes.maxItem + 4);

	var grille=~grille.(echelle.size, durees.integrate.size, fenetre);

	var envir=(

		notes:notes,
		durees: durees,
		fenetre: fenetre,
		echelle: echelle,
		grille: grille,
		rafraichir: { arg self;


			var partoche, durees, notes,
			offsetX=0, offsetY=(self.fenetre.bounds.height)/self.echelle;

			self.fenetre.clearOnRefresh_(false);
			//on update la grille
			// self.grille~grill;

			// on normalize pour la largeur
			durees=([0]++self.durees.integrate).normalize(0+offsetX, self.fenetre.bounds.width-offsetX);
			// on normalise à l'envers pour la hauteur
			notes=self.notes.linlin(0, self.echelle, self.echelle, 0).linlin(0, self.echelle, 0, self.fenetre.bounds.height-offsetY);
			// et on match le tout
			partoche= notes+++ durees;
			partoche.postln;

			self.fenetre.background_(Color.white);
			self.fenetre.drawFunc = {
				// on fout une grille
				self.grille.rafraichir;
				// on dessine les carrées dessus
				    partoche.do{ arg i, index;
					var hauteurCarre=offsetY;
					var longueurCarre=0;
					        Pen.color = Color.blue;
					        Pen.addRect(
						            Rect(i[1], i[0], hauteurCarre, hauteurCarre)
					        );
					        Pen.perform( \fill);
				    }
			};

			self.fenetre.refresh;
		}
	);

	envir.rafraichir;
	envir;
}
)
a=~score.()
(
				// on fout une grille
				a.grille.rafraichir;
a.fenetre.drawFunc={
	Pen.addRect(
		Rect(20,20,20,20)
	);
	Pen.fill;
	a.grille.rafraichir;
}
a.fenetre.refresh
				// on dessine les carrées dessus
				    partoche.do{ arg i, index;
					var hauteurCarre=offsetY;
					var longueurCarre=0;
					        Pen.color = Color.blue;
					        Pen.addRect(
						            Rect(i[1], i[0], hauteurCarre, hauteurCarre)
					        );
					        Pen.perform( \fill);
				    }