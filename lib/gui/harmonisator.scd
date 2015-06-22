(

var player;

~deplier={|array|
    array.collect({ |i|
        switch(i,
            0,6,
            1,5,
            2,4,
            3,3,
            -3,2,
            -2,1,
            -1,0
        )
    })
};

Window.closeAll;

b=~analyseHarmonique.(
    [0,4,10,1,2,4],
    // Pdefn(\deg).source.list,
    ~troisAccords.().choose);
b.postln;
w=Window.new("harmonisator", Rect(800,800,500,500)).front.alwaysOnTop_(true);

a=CompositeView(w, Rect(0,0,800,800));
z=CompositeView(w, Rect(20, 300, 100, 100))
.background_(Color.red);

a.addFlowLayout(15@15,5@5);

c=["do", "re", "mi", "fa", "sol", "la", "si"].reverse.collect{ |i|
    var x;
    Button(a)
    .states_([
        [i.asString, Color.red, Color.black]
    ]);
    x=Array.fill(b.size,{
        Button(a)
        .states_([
            ['O', Color.green, Color.white],

        ]);
    });
    a.decorator.nextLine;
    x;
};

c=c.flop;
b=b.collect(~deplier.(_));

d=b.collect({ |item, index|
    item.collect({ |i|
        c[index][i]
        .states_([
            ['5', Color.yellow, Color.red],
            ['6', Color.yellow, Color.red],
            ['7', Color.yellow, Color.red]
        ]);
    })
});
d=d.collect({ |i| i.choose.value.postln });
Pdefn (\basses, Pseq(b) );
Pdefn (\couleurs, Pseq(d.collect({ |i|
    switch(i.value,
        0, [0,2,4],
        1, [0,2,5],
        2, [0,2,4,6]
    )
    })
));

Pdefn(\couleurs).source.postcs;

player=Pdef(\accompagnement,
    Pbind(
        \degree, Pdefn(\basses) + Pdefn(\couleurs)
    )
).stop;

Button(z)
.states_([
    ["OFF"],
    ["ON"]
])
.action_(
player.play
);

)
(
Pbind(
    \degree,    Pseq([0,1,[2,3]]) + Pseq([ [0,2,4] ], inf)
).trace.play
)
