
(
a=~fenetre.();
~tchiop=CompositeView(a, a.bounds.width@a.bounds.height-50)
.layout_(VLayout.new)
.background_(Color.rand);


~tchiop.layout.add(
// le slider
	e=MultiSliderView(a)/*.minHeight_(100)*/
	.elasticMode_(1)
	.showIndex_(true)
.step_(1/g.value)
	.value_(d.normalize)
.action_({ |self|
	e.value.postln;
	Pdefn(\formule, Pseq(self.value.normalize(0, g.value).round, inf));
	Pbindef(\a, \compteur, Pseries() % z.value); // on remet à 0

})
);
~tchiop.layout.add(CompositeView);
e.value.do{ |item, index|
~tchiop.layout.add(
		Slider.new.orientation_(\horizontal).value_(index/e.size)
)
};
)

