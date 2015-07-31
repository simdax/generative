//
//EXEMPLE super basique de reglage rythmique
//

(

a=Pbind(
	\dur, Pseq([0.75, 0.75, 0.5], inf)
).play(quant:1)
)

Pdef(\b, Pbind(\degree, 2)).quant_([2, 0]).play
Pdef(\b).stop
Pdef(\b).play(quant:[2,0.5])

//test avec un synth maison qui marche bof...
(
r{
	var a=Pseq([0.75,0.75,0.5], inf).iter;
	loop{
		play {
			LFSaw.ar(150)+SinOsc.ar(1000, SinOsc.kr(15))
			*EnvGen.kr(Env.perc, doneAction:2)*0.5};
		a.next.wait;
	}
}.play(quant:2)
)

s.plotTree

play {	Blip.ar ( 400 ! 2, (EnvGen.ar(Env.perc(10, 10))*30).poll ) }