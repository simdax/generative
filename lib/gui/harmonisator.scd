(
~deplier={|array|
    array.collect({ |i|
        switch(i,
            -3, 4,
            -2, 5,
            -1, 6,
            i
        )
    })
};
)

(


Window.closeAll;

b=~analyseHarmonique.(
 Pdefn(\deg).source.list,
    ~troisAccords.().choose);

w=Window.new("harmonisator", Rect(800,800,500,500)).front.alwaysOnTop_(true);
a=CompositeView(w, 800@800);
a.addFlowLayout(5@5,5@5);

c=["do", "re", "mi", "fa", "sol", "la", "si"].collect{ |i|
    var x;
    Button(a)
    .states_([
        [i.asString, Color.red, Color.black]
    ]);
    x=Array.fill(b.size,{
        Button(a)
        .states_([
            ['O', Color.green, Color.white],
            ['X', Color.yellow, Color.red]
        ]);
    });
    a.decorator.nextLine;
    x;
};

c=c.flop;
b=b.collect(~deplier.(_));
// c[0][0].value=1;
// c[1][0].value=1;
// c[2][1,2].value=1;
// c[3][1].value=1;
// c[4][1].value=1;

b.collect({ |item, index|
    item.collect({ |i|
        c[index][i].value=1;
    })
});

)

