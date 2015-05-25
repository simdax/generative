/*SUPERCollider fournit un IDE plutôt sympa

1 on évalue les expressions avec CTRL+ENTER
=>
. une ligne par rapport au curseur
. un région en noircissant
. ou par rapport à des parenthèses ( ... bla bla ...)

2 on allume le serveur son en faisant CTRL + B
tant que c'est pas ouvert, y a pas de son
le bouton "panic" est CTRL + '.' (un point)

3 SC est fourni avec une doc sympa
on met le curseur sur un mot et on fait CTRL+D et on voit a droite la doc

SimpleNumber
Patterns
SinOsc
J Concepts

on peut faire aussi CTRL+MAJ+D et on tape un sujet pour faire une recherche dans la doc

*/

//Petite intro basique

2 // va renvoyer 2 en console

1+9*8 //80

// avec des parenthèses et des ";" on peut former une grosse expression.
// "postln" poste en console avec retour chariot

//on ouvre les parentheses pour évaluer une grosse expression
// chaque instruction est délimitée par ";"
(
var a;
a=5;
(a+7).postln; // 12
)

(
var tonNom="robert";
("bonjour "++tonNom).postln;
)
// les lettres seules sont des variables globales

a=50;
a.value()
alpha=50 //pas content
// seule exception 's', qui retourne le serveur, à ne pas overrider a part grosse necessité

s

//sinon il faut un '~'

hello // erreur
~hello //nil ==> nouvelle variable vide
~hello =60
~hello //60
~s //nil
s // localhost

//////////////// ARRAYS ////////////////

// exemple de manipulation golri d'array
// voir doc a Array, sequenceable collection et "j concept"


a=[0,4,1,2, [4,21,1], [[0]] ]

a.reshape(2,3)
a.flatten(1) //degonfle d'un cran
a.flat //degonfle total
a.shape //6 elements

a.bubble(1) // chope les values
a.reshapeLike((0..10))

//adverbs sur les opérateurs, voir la doc "adverb operator"

[0,1,2] +.t [0,2] //appplique les values de a à b
[0,1,2] +++ [0,2] //interlace les arrays

// + ttes les itérations et manip classiques
// surligne au fur et à mesure pour les transformations
// qui sont ici chainées sous forme
// objet
// .message
// .message
// etc.

[0,1,2,3, 0, 4]
.reject(_ >= 3) // enleve ce qui est sup ou egal a 3
.maxItem // 2
.scramble //melange
.asSet // enleve les doublons
.asArray.sort // et revient dans l'ordre
.choose //choisit une valeur

/// creation d'ARRAYS

(..10) //range
Array.series(10,0,2) == (0, 2 .. 18) // true
Array.fib (5).plot //tu peux visualiser avec "plot"
b=Array.geom(10,1,3).plot //geom
c=Array.fill(20, { |x| x**2}).plot //exp

3 ! 3 //créé un array par répétition

// expr lambda

f = { |x| x+2 }
//ou
f= _ + 2
f.value(1)
//ou
f.(1)

// possibilité arg par def

f = { |x=5| x+2 }
f.()
f = { |x=#[0,1]| x+2 } // note l'astérique pour les arrays
f.()
f = { |x=(0+2)| x+2 } // tu peux donner des expr par def
f.()
f = { arg x=([0,1]); x+2 } // du coups marche aussi pour arrays + autre type d'écriture avec mot-clef arg
f.()


// attention, écriture avec '_' (= partial) pouvant pas être imbriqué dans d'autre fonc !!

d={|x, y=5| Array.series(x+1, 2,y) } //OK (note l'arg par def)
d.(8)
d= Array.series(_, 4, _)  // OK, même avec multiple arg
d.(12, 6)
d= Array.series(_*3, 2,3)  // mais la NO car c'est double opération avec le '*' et ça SC aime pas :(

//dernier chose pratique

c=[0,45,1,2,4,1,5,1,5]
c.differentiate // les intervalles de valeurs
c.integrate // les additions de valeurs

c == c.differentiate.integrate // true

c.collect( _ *2)
c.select ( _ > 7)

// je te propose maintenant de lire le tuto et ensuite d'aller voir la doc qui est bien foutue

// NEXT 0_intro
