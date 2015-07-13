(
var nbJoueurs=1;
var nbDim=1;

var dimensions=
['x', 'y', 'z'][0..nbDim-1];


nbJoueurs.do({ |i|
	thisProcess.openUDPPort(57120+i)
});

~run={

	~accords=nbJoueurs.collect({
		dimensions.collect({
			Synth.new('default')
		})
	});

	['x'].do({ arg pos, indexPos;
		nbJoueurs.do ({ arg joueur;

			OSCdef.newMatching(("joueur"++joueur++"accelerometre"++pos).asSymbol,
				{
					arg msg;

					// note de base
					var freqBase=(60).midicps;
					// on change la freq avec la position
					var modulation=
					Scale.major.degreeToFreq(
						(msg[1]).round(0.5)*2,
						freqBase,
						1)
					;
					~accords[joueur][indexPos].set(\freq, modulation);
					~iphone=modulation.cpsmidi.ceil.asInt;
					// update BOX
					{
						~boxFreqUser.value_(~iphone);
					}.defer;


				},
				("/aOSC/acc/"++pos).asSymbol, recvPort:( 57120 + joueur)
			);
		})

	});
};
)

