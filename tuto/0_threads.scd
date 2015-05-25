// RAPPEL: Pour évaluer du code en SC, CTRL+ENTER devant une ligne




// Supercollider gère des threads pour faire de la musique en temps réel. Il hiérarchise ses Threads en 3 manières

/* 1. les routines

ce sont des fonctions qu'ont lit séquentiellement pour choper les valeurs de retour au fur et à mesure par l'instruction 'yield'.

ça permet d'itérer parmi une liste de données, instruction par instruction*/

(
r =Routine( {
1.yield ; //donne moi 1
2.yield ; // donne moi 2
3.rand.yield ; // donne un truc au pif entre 0 et 3
(2**4 -6).yield ; //donne un calcul
})
)
//  tout ça définit une routine. Rien ne se passe encore

// evalue chaque ligne les unes après les autres
r.next
r.next
r.next
r.next // chaque ligne correspond aux instructions

// (tu pourrais aussi réévaluer à chaque fois la même ligne.)

//quand on a fini on obtient 'nil', du coup il faut « reset »

r.next // =nil
r.reset
r.next //here we go again, évalue a chaque fois la ligne jusqu'à nil

/* 2. les player

On peut schedulder ces routines à une horloge en appelant « play ». ça devient des sortes de metronomes à données.

La syntaxe change un peu. Les chiffres renvoyés deviennent des temps d'attente, signifié par « wait » (== "yield").

on appelle plus les "next" manuellement. Pour obtenir quelque chose,  va se servir de side effect, style ici juste « postln » (poster en console)*/

(
r = Routine( {
	1.postln; //on poste 1 (side effect)
	1.wait ; // et on attend
2.postln; //etc.
	2.wait ;
3.rand.postln;
	0.05.wait ; // temps très court
(2**4 -6).postln ;
}); // on définit...

r.play // ... et on joue la routine
)

// 3. les patterns

// on en arrive aux "patterns" qui simplifient tout ça :
// comme tu as pu le voir, au fond, une routine n'est qu'un array, à la limite un array de fonctions.
// les patterns vont être des templates de routine, avec des comportements précis en terme d'itération.

// par exemple, le plus simple "Pseq", renvoie simplement la liste des
// données de la liste

a=[0,1,2,3] //array
b=Pseq(a).asStream // 'stream' est un autre nom pour routine
b=Pseq(a).iter // iter transforme une fonction ou un pattern en Routine. pareil que asStream

(
4.do ({
	b.next.postln
})
)  // en console toutes les données s'affichent par le message "postln"


// pour faire du temps réel il faut rajouter des temps d'attente.
// Pour ça on met dans une boucle
// ça nous donne donc

b.reset; // on re-remplit le stream
(
c=
Routine({
4.do ({
	b.next.postln; //side effect
	1.wait; // tps d'attente
})
});
c.play(quant:4) //et on joue (j"ai rajouté vite fait une notion de temps : quant attent le 4eme temps dans l'horloge interne ce qui créé un temps d'attente avant de partir

)
// je survole les notions de tempo, on y reviendra.
// comme 'c' est une routine qui contient une autre routine 'b', pour les rappeller, il faut reseter la routine externe et si on veut d'autres données que 'nil', on doit aussi reseter la routine interne
(
c.reset;
b.reset;
c.play(TempoClock(120/60)) // on peut donner une autre horloge à une tâche (ici 120 bpm), qui est donc égal à 2. Si tu joues avec le numérateur ça changera le tempo
)

//CONCLUSION
// pour résumer, les threads en SC sont des routines ou des patterns qui sont des listes évaluées avec un temps d'attente précis à chaque fois.
// on a pleins d'autres patterns, qui permettent de refaire tout un langage, mais cette fois-ci temps réel

//petit exemple
d=Prand([0,1], 6) // 6 fois une chance sur deux d'avoir 1 ou 0
d.asStream.nextN(6) // tu peux réévaluer le truc plusieurs fois

(
Routine({
	loop ({
		d.iter.next.postln;
	1.wait;
		})
}).play             // flux infini
)

/*pleins d'autre encore
noircis la ligne en dessous et fais CTRL+D

Pattern Guide 02: Basic Vocabulary

//on va passer à l'utilisation de ces trucs dans du son

//NEXT 1_son

*/
