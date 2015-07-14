(
var notes=Array.rand(4, 0, echelle).postln;
var durees=Array.rand(4, 1, 3).postln;
var echelle=10;
var offsetX=0, offsetY=20;

w = Window.new.front;

// on normalize pour la largeur
durees=[0]++durees.integrate;
durees=durees.normalize(0+offsetX, w.bounds.width-offsetX);
// on normalise à l'envers pour la hauteur
notes=notes.linlin(0, echelle, echelle, 0).postln;
notes=notes.linlin(0, echelle, 0, w.bounds.height-offsetY);
// et on match le tout
p= notes+++ durees;
p.postln;



w.view.background_(Color.white);
w.drawFunc = {
    p.do{ arg i, index;

        Pen.color = Color.blue;
        Pen.addRect(
			            Rect(i[1], i[0], 20, 20)
        );
        Pen.perform( \fill);
    }
};

w.refresh;
)