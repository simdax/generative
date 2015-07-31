(
// Needed by the quark
Quarks.install("WarpExt");

// you have to wait enough time
// look at the right bottom
Server.local.waitForBoot({

	//init
	a=SonatinaSampler(); // <== path where you put sonatina samples
	a.init;

	// instruments available
	a.list;
})
)
// some random music :)

(
Ppar([
	Pbind(
		\type, \phrase,
		\instrument, \sonatinaPiccolo,
		\degree, Pseq([0,1,2,8,6,4,1,2,0]),
		\dur, 1.2,
		\amp, 0.6
	)
	,
	Pbind(
		\type, \phrase,
		\instrument, 'sonatinaHarp',
		\degree, Pseq([0 ,2 ,2 ,2 ,1, 0, 4, 3, 2 ,2, 2, 2, 1, 0, 4, 3, 2, 2, 3, 4, 3, 1, -3, ]),
		\dur, Pseq([ 1,1,1,0.5,0.5,2,0.5,0.5,1,1,1,0.5,0.5,2]),
		\amp, 0.4
	)
]).trace.play

)



