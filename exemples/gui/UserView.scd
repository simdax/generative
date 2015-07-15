// template basique pour dessiner des trucs cools

(

w=~fenetre.();
x=UserView(w);

// fonction au pif pour dessiner des bidules
f={
	Pen.addRect(Rect(0,0,20,20));
	Pen.stroke;
};
g={
	Pen.addRect(Rect(30,30,20,20));
	Pen.stroke
};


x.drawFunc=FunctionList.addFunc(f,g);
x.refresh

)
