(
var update={
	v=a.collect(_.value).normalizeSum(1);
v.collect({ |i, index|
	a[index].value_(i)
})
};

var get={
	v.postln
};

w=~fenetre.();

a=4.collect({
	Slider(w, 100@100)
	.action_({ |self|
		update.();
		get.();
	});
});



)

