(
w=Window.new.front.alwaysOnTop_(true);
a=CompositeView(w, Rect(0,0,200,200)).layout_(
	HLayout(

	)
).front

)
(
b=(
fenetre:a,
nbBoutons: 10,
up:
	{ |self|
		self.fenetre.children.collect(_.remove);
		self.nbBoutons.do {
	self.fenetre.layout.add(Button())
}
	},
);

Button(w, Rect(200, 0, 100, 100))
.action_({
	b.nbBoutons=b.nbBoutons+1;
	b.up;
})
)
(
	b.nbBoutons=b.nbBoutons+1;
b.up;
)
