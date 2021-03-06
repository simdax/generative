(
var nbJoueurs=1;
var nbDim=1;

var dimensions=
['x', 'y', 'z'][0..nbDim-1];


nbJoueurs.do({ |i|
	thisProcess.openUDPPort(57120+i)
});

~run={ |symbol='iphone'| // choix avec iphone et mouse

	~accords=nbJoueurs.collect({
		dimensions.collect({
			Synth.new('default')
		})
	});

	['x'].do({ arg pos, indexPos;
		nbJoueurs.do ({ arg joueur;

			// note de base
			var freqBase=(60).midicps;

			switch(symbol,

				'iphone', {



					/*		OSCdef.newMatching(("joueur"++joueur++"accelerometre"++pos).asSymbol,
					{
					arg msg;

					var freqBase=(60).midicps;
					// on change la freq avec la position
					var modulation=

					Scale.major.degreeToFreq(
					(msg[1]).round(0.5)*2,
					freqBase,
					1)
					;
					//	~accords[joueur][indexPos].set(\freq, modulation);
					~iphoneAcc=modulation.cpsmidi.ceil.asInt;
					// update BOX
					{
					~boxFreqUser.value_(~iphoneAcc);
					}.defer;


					},
					("/aOSC/acc/"++pos).asSymbol, recvPort:( 57120 + joueur)
					);*/

					OSCdef.newMatching(("joueur"++joueur++"gyroscope"++pos).asSymbol,
						{
							arg msg;


							// on change la freq avec la position
							// ici tout dépend de l'échelle qu'on va utiliser
							// en l'occurence l'échelle majeure, c'est bien, mais
							// on pourrait imaginer que quelqu'un change d'échelle
							// avec un coup à droite


							var modulation=

							Scale.major.degreeToFreq(
								(msg[1]).round(2)/10,
								freqBase,
								1)
							;

							~accords[joueur][indexPos].set(\freq, modulation);
							~iphoneGyr=modulation.cpsmidi.ceil.asInt;
							// update BOX
							{
								~boxFreqUser.value_(~iphoneGyr);
							}.defer;

						},
						("/aOSC/gyro/"++pos).asSymbol, recvPort:( 57120 + joueur)


					);

				},


				'mouse', {
					var modulation;

					r{
						loop{
							{~souris=Platform.getMouseCoords.y.postln}.defer;
							modulation=Scale.major.degreeToFreq(
								~souris/100,
								freqBase,
								1);
							~accords[joueur][indexPos].set(\freq, modulation);
							~iphoneGyr=modulation.cpsmidi.ceil.asInt;
							{
								~boxFreqUser.value_(~iphoneGyr);
							}.defer;
							0.1.wait
						}
					}.play;
				}
			)
		});
	});
};
)
