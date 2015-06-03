(
~mel = ~genererMel.();
~basses=~analyseHarmonique.(~mel, ~troisAccords.().choose);
~basses=~trouverGrille.(~basses);

)
(

var dur1= ~rythmeIntervalliques.(mel );
var dur2= ~rythmeIntervalliques.(mel, type: 'linexp');
var dur3= ~rythmeIntervalliques.(mel, type: 'lincurve');



Pseq([
	Pbind('degree', Pseq(mel)),
Pbind('degree', Pseq(mel), 'dur', Pseq(dur1)),
Pbind('degree', Pseq(mel), 'dur', Pseq(dur2)),
Pbind('degree', Pseq(mel), 'dur', Pseq(dur3)),
]).trace.play

)
