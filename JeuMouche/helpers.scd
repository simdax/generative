// helpers
/*

Quarks.gui
Quarks.install("/Users/dallas/Downloads/SCUtils-0.11")

Platform.resourceDir

OSCFunc.trace(true)
OSCFunc.trace(false)
thisProcess.openPorts

OSCdef.all.collect(_.path)



NetAddr.broadcastIP
s.plotTree
(Pdef.all.collect({ |i|
	i.source.postcs
}))
Pdef.removeAll

Pbind().play

*/

// code volé à NetLib
(
~broadcastIP ={ arg prefix = "", device = "";

	var ifconfigPath={
	|prefix=""|
		if ( prefix == "" ){
			Platform.case(
				\linux, { prefix = "/sbin/"}
			);
		};
		if ( prefix == "" ){
			"ifconfig";
			}{
			(prefix+/+"ifconfig");
		};
	};

		Platform.case(
			\linux, {
				var  res,k,delimiter=$ ;
				res = Pipe.findValuesForKey( ifconfigPath.(prefix)+device, "broadcast");
				res = res ++ Pipe.findValuesForKey( ifconfigPath.(prefix)+device, "Bcast", $:);

				if(res.size > 1) { postln("the first of those devices were chosen: " ++ res) };
				res.do{ |it,i|
					k = it.find(delimiter.asString) ?? { it.size } - 1;
					res[i] = (it[0..k]);
				};
				res.first
			},
			\osx, {
				var line, pipe;
				pipe = Pipe( (ifconfigPath.(prefix)+"% | grep broadcast | awk '{print $NF}'")
					.format(device),
					"r"
				);
				{ line = pipe.getLine }.protect { pipe.close };
				line
			}
		)
	}
)


