(
//permet de retourner un int quand le résultat est rond
// ce qui n'est pas le cas de base avec '/'
// code emprunté à daniel Meyer

// ~myDiv.(5, 5).class   ==> Integer

~myDiv = { |a, b, prec = 1e-10|
	var q = a/b;
	var qR = q.round;
	q.equalWithPrecision(qR, prec).if { qR.asInteger }{ q }
};


// surcharge de comportements
// ~myDivAr.([5,4,1,2], 3)

~myDivAr = { |a, b, prec = 1e-10|
		a.collect({ |x|
		~myDiv.(x, b, prec)
	})

};

~myGCD={ |u, v|

	var t;
        u = abs(u);
        v = abs(v);
        if (u <= 1 || (v <= 1)) { 1 } {
                while { u > 0 } {
                        if (u < v) { t=u; u=v; v=t; };
                        u = u % v;
                }
        };
        v
};


)