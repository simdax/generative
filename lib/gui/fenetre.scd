

(
~fenetre={ |name, sizex=500, sizey=500, posx=0, posy=0|
	var fen=Window.new(name, Rect(posx,posy, sizex, sizey))
	.front
	.alwaysOnTop_(true);

	fen.view.decorator_(FlowLayout(fen.bounds));
	fen;
};

~texte={ |fen, content|
	StaticText(fen, fen.bounds.width@30)
	.string_(content);
	fen.view.decorator.nextLine;
}
)