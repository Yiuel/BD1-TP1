-- SQL - Opérateurs ensemblistes

-- Votre nom : Ugo Lachapelle 0141471

-- À partir de la Base de données forums, produire les requêtes suivantes.


-- 1.	Faire afficher les descriptions de tous les forums et sujets dans la même colonne. (Utiliser obligatoirement un UNION)

SELECT sujets.`description`
FROM sujets
UNION
SELECT forums.`description`
FROM forums

-- 2.	Faire afficher le contenu des messages qui n'ont pas été écrits par l'utilisateur "leprof". (utiliser obligatoirement un EXCEPT)

SELECT messages.contenu
FROM messages
EXCEPT
SELECT messages.contenu
FROM messages
INNER JOIN utilisateurs ON utilisateurs.id = messages.utilisateur_id
WHERE utilisateurs.pseudonyme = 'leprof'

-- 3.	Faire afficher le contenu des messages qui ont été écrits par l'utilisateur "leprof" et qui sont à l'intérieur d'un sujet créé par l'utilisateur 'leprof'.  (Utiliser obligatoirement un INTERSECT)

FROM messages
INNER JOIN utilisateurs ON utilisateurs.id = messages.utilisateur_id
WHERE utilisateurs.pseudonyme = 'le prof'
INTERSECT
SELECT messages.contenu
FROM messages
INNER JOIN sujets ON sujets.id = messages.sujet_id
INNER JOIN utilisateurs ON utilisateurs.id = sujets.utilisateur_id
WHERE utilisateurs.pseudonyme = 'le prof'