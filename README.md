
La construction de la lib, telle que je la vois, est entièrement
Pyramidale.

La base de tout est la librairie mathématique, et le « top » est
la forme

(au-dessus, dans le ciel, se trouve l'instrumentation et
l'arrangement stylistique, pour plus tard)

toute les marches au-dessus sont une application concrète de la
librairie mathématique selon la sacro-sainte trilogie :
« production aléatoire/containte intérieure → analyse →
transformation/contrainte extérieure )

1) Math ====> Le but essentiel est de faire du pattern matching

: faire des fonctions pour trouver des patterns

EX : on a une grille d'accord avec potentiellement telle et
telle harmo, rythmiquement parlant :

x=SOL, o=DO (pur exemple)

On veut trouver toutes les combinaisons d'une ligne de type

x x o o x o x o x x x

on aura par exemple des groupes de taille 2 2 1 0 1 0 3

qu'on peut ensuite reclasser en A (2 2) B (1 0 1 0) C (3)

Cette lib a pour but de produire du pattern matching, considérée
comme la première branche de la perception (style probleme de
Bongard http://en.wikipedia.org/wiki/Bongard_problem)

2) UNE mélodie ====> Le but essentiel est de produire une ligne
mélodique qu'on considère « viable »

Trois idées principales :

produire plusieurs mélodies ressemblantes par rapport à une
« enveloppe » commune (exemple à la con env = ↗↗↘→↗ )

classer les différentes mélodies obtenues ( taux de mouvement,
types d'intervalles) / tenter d'en tirer des « accents »

créer des transformations «  renver, retrog, transpo », mais
aussi plus compliqué, du style « transposition tonale », mais
aussi encore mieux du style gestions du motif de tête et de la
cadence (sur la tonique, la dominante etc.)

==> rythme

la 1. c'est de la production brute,

la 2. c'est du pattern matching (set theory, il y a tant/tant
d'intervalles, tant/tant de retour de tel/tel note etc.)

et la 3. c'est de la transformation

2) 2 mélodies ====> Le but essentiel est de générer
une--plusieurs mélodie(s) par rapport à une autre

Trois idées principales :

1. créer du canon. Trouver dans une mélodie toutes les
itérations d'elle-même obéissant à un certain set de règles
(essentiellement le type d'intervalle harmonique + un contour
mélodique (parallèle, contraire etc.) )

2. pattern matching, classer les mélodies possibles en classant
les « meilleurs » aka celle qui correspond le plus à certains
critères

=> +/- bougeante, +/- proche de l'originale au niveau motivique

3. créer du rôle ou de la rhétorique en transformant la seconde
voix en changeant

certains intervalles,

la densité harmonique

au final, on aura créé possiblement

1. harmonisation tout simple

un contre-chant +/- contrastant

un « altus » (présence de motifs répétitifs et/ou « saillants »)
ou un « bassus » au contraire le plus effacé possible

3) N mélodies ====> règles harmoniques générant non plus une,
mais un ensemble cohérent de mélodies dans le temps

Trois idées principales :

vecteurs harmoniques

conduite des voix( croisement, etc.)

type de cadence

4) FORME ====> toutes les autres fonctions d'avant avec des
règles de cheminement style markov entre les différents sets
de mélodies obtenues

5) arrangement ====> coder des arpégiatteurs, jouer sur la
densité harmonique

6) timbre ====> classifier les timbres et leur donner des rôles

Je vais vite pour la fin parce qu'on y est encore loin.

