//transform line in scale

(

var taille=50;
var nbFen=20;
var tailleFen=5;


Window.closeAll;
(0..taille).collect(_.quantize(nbFen,tailleFen)).postln.plot

)

// GUI

(

var quant=0.5, tol=0.5, strenght=0.5;

Window.closeAll;
w=Window.new.alwaysOnTop_(true).front;

f={
	b.value=a.value.collect(_.quantize(quant, tol, strenght))
};
g= {
	("quant : "+quant+"tol : "+tol+"stren :"+strenght).postln
};

w.layout_(
	VLayout([
		HLayout(
			StaticText().string_("quantum"),
			Slider().value_(quant).action_({arg self;
				quant=self.value*2;
				f.(); g.()}),
			StaticText().string_("tolerance"),
			Slider().value_(tol).action_({arg self; tol=self.value; f.(); g.()}),
			StaticText().string_("strength"),
			Slider().value_(strenght).action_({arg self; strenght=self.value; f.(); g.()})
		),stretch:1],
		[VLayout(
			HLayout(
				a=MultiSliderView()
				.elasticMode_(true)
				.value_((0..100)/100)
				.action_(f),
				Button().action_({
					a.value=(0..100)/100;
					f.();
				})
			),
			b=MultiSliderView()
			.editable_(false)
			.elasticMode_(true)
			.value_(a.value)
		),stretch:1]
	)
);
)

