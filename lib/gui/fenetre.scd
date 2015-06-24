

(
~fenetre={ |name, sizex=500, sizey=500, posx=0, posy=0|
	var fen=Window.new(name, Rect(posx,posy, sizex, sizey))
	.front
	.alwaysOnTop_(true);

	fen.addFlowLayout;
	fen;
};

~texte={ |fen, content|
	StaticText(fen, fen.bounds.width@30)
	.string_(content);
	fen.decorator.nextLine;
};

~tableMix={ |nbSliders=4|

var a=~fenetre.("table de Mixage", nbSliders*120,120, 1100, 500);
var b= Array.fill(nbSliders, {
	CompositeView(a, 100@100).background=Color.rand;
	}
);
nbSliders.collect{ |i| Slider(b[i], 20@100) };
}
)

