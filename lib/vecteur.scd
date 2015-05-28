(
//retourne l'index d'une note prises entre deux valeurs similaires
~trouverMvtPendulaire={ |array|
	var nbNiveau=array.size-1;
	var inter={ |x| x.differentiate.drop(1) };
	var x=inter.(array) ;
	var arr=List.new;
	x.doAdjacentPairs({ arg a, b;
		(arr).add(a+b)
	});
	arr.collect({ |i, index|
		(i==0).if (
			index+1)
	})
	.reject(_.isNil)
	.select({ |x|
		array[x] != array[x+1]
	})
};


~ignorerPendules={ |vecteurs|
	var x=~trouverMvtPendulaire.(vecteurs);
	var y=(x++(x+1));
	vecteurs.reject({ |i, index|
		y
		.includes(index)
	})
};
~vecteurs={  |basses, tolerance=1|
	~convertirMel.(
		basses
		.collect({ |x|
			var y=~trouverMvtPendulaire.(x);
			x
			.differentiate
			.drop(1);
		})
	);
};


~nbVecteur= { |vecteurs, tendance=1|
	var dom =~ignorerPendules.(vecteurs).sign.occurrencesOf(tendance);
	dom.size;
};

~filtrerVecteur= { |basses|
basses.at(
		~vecteurs.(basses)
		.maxIndex( ~nbVecteur.(_) )
	)
};

)