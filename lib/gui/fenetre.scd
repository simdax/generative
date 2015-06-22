

(
~fenetre={ |name, sizex, sizey|
	var fen=Window.new(name, Rect(0,0, sizex, sizey))
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