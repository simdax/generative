/// object-oriented

// "http://www.tmroyal.com/supercollider-pseudoclasses-with-events.html"

// la syntaxe objet de Super Collider est un tout petit surprenante.
// Il est possible de créer des classes, mais il faut les mettre dans un dossier particulier, les compiler etc.
// Tout cela n'est pas très responsive, c'est en fait plus des name space que des objets


// il y a moyen de prototyper simplement des objets sous la simple forme de dictionnaires, ou dans le langage SC, de "Event"

(

a=
(
a: 1, // un objet
b: { _ *2 } // une méthode
)

)

a.class
a.a // 1
a.b // a Function
a.b.value(5) //10


c=a
d=a
c.a=2
d.a // 2


// pour les getter c'est donc transparent
// Pour les setters, c'est un peu particulier
// implicitement, une fonction dans un event se passe lui-même en premier argument

// du coup on a la syntaxe suivante
// fonction = arg1(self) , ... les autres arg
///           {   arg1.use
////                { ta fonction avec les autres arg

(
a.f= { |self, unevalue|
	self.use{ ~a + unevalue  } // le ~a réfère le
}
)
a.f(4) //6

(
a.setter= { |self, value |
	self.use { ~a = value }  // ne pas oublier les tilde !!!
}
)

a.setter(5)
a.a // 5


// encore un petit exemple

(
a=(
	a: 0,
	add2: ( _ + 2 ),
	x: { |self| self.use { ~add2.(~a)} },
	ajouterVar: { |self| self.use { ~b=2} },
	uneFonctionQuiMarchePas: {|self| self.use{~a=3; ~x.value} },
	utiliserX: { |self| self.use{ ~a=3 ; ~c=self.x }; },

);
)
a.x // 2
a.ajouterVar
a // maintenant il y a un 'c' dans l'environnement
a.utiliserX.value


// Pour faire de l'auto-référence et de l'instantiation, on doit faire une fonction dans laquelle on met un event, et qu'on appelera pour faire une instantiation

(

a= { | new =0 |
	var a = new;
	(
		a: 0,
		b: a,
	encoreMieux: { |self| self.a + self.b },
	)
};

b=a.value; // "instantiation"
b.encoreMieux;

)

