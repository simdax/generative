(
	var contextMenu;

	w= Window.new().front;
	b= Button(w, Rect(100, 100, 200, 200))
	.states_([["black", Color.black, Color.white], ["white", Color.white, Color.black]]);

	contextMenu= {|view, x, y, mod, butNum|
		var menu;
		if(butNum==1, {
			menu= ListView(view.parent, Rect(x+view.bounds.left, y+view.bounds.top, 150, 80))
			.focusLostAction_({menu.remove; })
			.background_(Color.white)
			.items_(["remove", "cancel", "something"])
			.mouseUpAction_({|menu, x, y|
				case {menu.value == 0} { view.remove }
				{menu.value == 1} { "cancelled".postln; }
				{menu.value == 2} { "something".postln; };
				menu.remove;
			});
			menu.focus;
		});
		if(butNum==0, { menu.remove });
	};

	b.mouseDownAction = contextMenu;

)
