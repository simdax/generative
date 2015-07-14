(
// ~single ={ arg label, action, triggerOnMouseDown = false;
// 	this.states = [[label, GUI.skin.fontColor, GUI.skin.background]];
// 	if(triggerOnMouseDown) {
// 		this.mouseDownAction = action
// 	} {
// 		this.action = action
// 	}
// } ;
// ~dual ={ arg offLabel, onLabel, onAction, offAction;
// 	this.states = [
// 		[offLabel,GUI.skin.fontColor,GUI.skin.offColor],
// 		[onLabel,GUI.skin.fontColor,GUI.skin.onColor]
// 	];
// 	this.action = { |b|
// 		if(b.value == 1) { onAction.value(b) } { offAction.value(b) }
// 	};
// } ;


/*
~fenetre.("bliop", 120, 456)
*/

~fenetre={ |name="tchiop niou fenaitre", sizex=500, sizey=500, posx=0, posy=0|
	var fen=Window.new(name, Rect(posx,posy, sizex, sizey))
	.front
	.alwaysOnTop_(true);

	fen.addFlowLayout;
	fen;
};

// pour faire une vue qui s'adapte de tant au parent
~view={ |parent, indiceReductionLargeur=2.1, indiceReductionHauteur=2.1|
	var a=CompositeView(parent, (parent.bounds.width/indiceReductionLargeur)@(parent.bounds.height/indiceReductionHauteur))
	.background_(Color.rand);
	a.addFlowLayout;
	a;
};

//pour mettre du texte automatiquement
~texte={ |fen, content|
	StaticText(fen, fen.bounds.width@30)
	.string_(content);
	fen.decorator.nextLine;
};

// petit délire pour table de mixage rapide
~tableMix={ |nbSliders=4|

var a=~fenetre.("table de Mixage", nbSliders*120,120, 1100, 500);
var b= Array.fill(nbSliders, {
	CompositeView(a, 100@100).background=Color.rand;
	}
);
nbSliders.collect{ |i| Slider(b[i], 20@100) };
};

// demande TabbedView
/*
~mainView={ |fen =(~fenetre.())|

w=Window.new("timeline", Rect(0,0,1000, 1000));
a=CompositeView(w, Rect(50, 500, 300, 110)).background_(Color.rand);
a.addFlowLayout;
~sequencator.(a);
w.front;

	t=TabbedView2.newTall(w, Rect(5,5,1000,500));
4.collect{ |i|
var v=t.add("test"++i.asString, scroll:true);
~balancerMel.(v)
}
}
*/
)

