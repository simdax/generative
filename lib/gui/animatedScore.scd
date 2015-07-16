~animatedScore

a.fenetre

//surcharge de score pour faire une petite barre qui défile
(

var obj={
var tempo=TempoClock.tempo;

var envir=(
tempo: tempo,

		barreQuiBouge: {arg self;
			self.notes.postln
		}

	);

envir.parent=~score.();
};

a=obj.();


)


(

var matrix = [1, 0, 0, 1, 0, 0];


w=~fenetre.();


x=UserView(w, Rect(0,0,w.bounds.width,w.bounds.height/2));
z=UserView(w, w.bounds);
~score.([0,1,2,3], [1,1,2,1], topFen:x);



z.drawFunc= {
	Pen.matrix = matrix;
	Pen.strokeColor=Color.red;
	Pen.line(0@0, 0@z.bounds.height);
	Pen.stroke
};

 {
	var largeur=w.bounds.width;
	var temps=15000; // ça met environ 10 secondes
	var refreshTime=(largeur/temps).postln;

 	largeur.do{ |i|
 		matrix.put(4, i);

 		z.refresh;
 		refreshTime.wait
 	}
 }.fork(AppClock);


)

