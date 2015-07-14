(

/*
(
var notes=Array.rand(4, 1, 8).postln;
var durees=Array.rand(4, 1, 4).postln;
a=~score.(notes, durees);

// on peut updater
a.notes=Array.rand(4, 1, 8).postln;
a.durees=Array.rand(4, 1, 4).postln;
a.rafraichir


var notes=Array.rand(4, 1, 8).postln;
var durees=Array.rand(4, 1, 4).postln;
w=~fenetre.("prout", 200, 249, 100, 87);

~makeScore.(notes, durees, w);


)
*/

~score={

	arg
	notes, durees,
	fenetre=(~fenetre.()),
	echelle=(notes.maxItem + 4);

	var envir=(

		notes:notes,
		durees: durees,
		fenetre: fenetre,
		echelle: echelle,
		rafraichir: { arg self;

			var partoche, durees, notes,
			offsetX=0, offsetY=(self.fenetre.bounds.height)/self.echelle;

			// on normalize pour la largeur
			durees=([0]++self.durees.integrate).normalize(0+offsetX, self.fenetre.bounds.width-offsetX);
			// on normalise à l'envers pour la hauteur
			notes=self.notes.linlin(0, self.echelle, self.echelle, 0).linlin(0, self.echelle, 0, self.fenetre.bounds.height-offsetY);
			// et on match le tout
			partoche= notes+++ durees;
			partoche.postln;

			self.fenetre.view.background_(Color.white);
			self.fenetre.drawFunc = {
				    partoche.do{ arg i, index;

					        Pen.color = Color.blue;
					        Pen.addRect(
						            Rect(i[1], i[0], offsetY, offsetY)
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