
(
b=Array.new;
while(
	{b.size<(7..10).choose},
	{
		a=[0]++~genererMel.(9);
		b=~trouverTransformations.(a)
		.flatten
		.reject({ |i| i.size==0})
		.unbubble(1)
	;}
);

b.postln;
c=~formePyramidale.(b);

 ~enMidi.(Pdef(\playPyramide)).trace.play

)
