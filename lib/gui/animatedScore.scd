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

w=~fenetre.();
z=UserView(w, w.bounds);

z.drawFunc= {
	    Pen.matrix = # 0, 0, 0, 0, 0, 0;

	Pen.line(0@0, 0@w.bounds.height);
	Pen.stroke
};

{
	z.refresh; 0.4.wait;
}.fork(AppClock)

)

