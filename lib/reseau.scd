~trouverIP.()
(
~trouverIP={ // UNIX only
var a="ifconfig | grep -A1 eth0 | tail -n 1 ".unixCmdGetStdOut;
var posDep=(a.findRegexp("adr:"))[0][0];
a[ posDep+4 .. posDep+16]

}
)


OSCFunc.trace(false)

(

OSCdef.newMatching(\test,
	{
		arg msg, time, r, v;
		[msg.drop, time, r, v].postln;
	},
	'test')
)

