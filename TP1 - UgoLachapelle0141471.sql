-- SQL - TP 1 (BD Gym)

-- NOM : Ugo Lachapelle 0141471

-- 1.

SELECT COUNT(membres.id)
FROM membres

-- 2.

SELECT membres.nom, membres.prenom, membres.date_naissance
FROM membres
WHERE DATEDIFF(CURDATE(), membres.date_naissance) < 18 * 365

-- 3.

SELECT cours.nom, cours.date_entrainement, cours.horaire
FROM cours
WHERE date_entrainement BETWEEN '2025-03-05' AND '2025-03-08'

-- 4.

SELECT cours.id, cours.nom, COUNT(reservations.fk_membre)
FROM cours
JOIN reservations ON reservations.fk_cours = cours.id
GROUP BY reservations.fk_membre

-- 5. 

SELECT SUM(abonnements.prix)
FROM abonnements

-- 6.

SELECT SUM(abonnements.prix), YEAR(abonnements.date_debut) AS annee
FROM abonnements
GROUP BY annee

-- 7.

???? Pas clair.

-- 8. 

SELECT *
FROM membres
WHERE membres.adresse LIKE '%J1D 4E7%'

-- 9.

SELECT entraineurs.specialite, COUNT(entraineurs.id)
FROM entraineurs
GROUP BY entraineurs.specialite

-- 10.

SELECT entraineurs.specialite, COUNT(membres.id) AS decompte
FROM entraineurs
JOIN cours ON cours.fk_entraineur = entraineurs.id
JOIN reservations ON reservations.fk_cours = cours.fk_entraineur
JOIN membres ON reservations.fk_membre = membres.id
GROUP BY entraineurs.specialite
ORDER BY decompte DESC

-- 11.

SELECT horaire, MIN(decompte)
FROM (SELECT cours.horaire, COUNT(reservations.fk_cours) AS decompte
FROM cours
JOIN reservations ON cours.id = reservations.fk_cours
GROUP BY cours.horaire) AS selection

-- 12.

SELECT *
FROM cours
LEFT JOIN reservations ON reservations.fk_cours = cours.id
WHERE reservations.fk_cours IS NULL

-- 13.

SELECT membres.nom, membres.prenom
FROM membres
JOIN abonnements ON abonnements.fk_membre = membres.id
WHERE abonnements.date_fin >= '2025-03-15'

-- 14.

??? Pas clair.

-- 15.

SELECT membres.nom, membres.prenom, COUNT(reservations.fk_cours) decompte
FROM membres
JOIN reservations ON reservations.fk_membre = membres.id
GROUP BY membres.id
HAVING decompte > 20

-- 16.

SELECT membres.*, SUM(abonnements.prix) depenses
FROM membres
JOIN abonnements ON abonnements.fk_membre = membres.id
GROUP BY membres.id
ORDER BY depenses DESC

-- 17. 

SELECT COUNT(membres.id)
FROM membres
LEFT JOIN abonnements ON abonnements.fk_membre = membres.id
WHERE abonnements.fk_membre IS NULL

-- 18.

SELECT cours.date_entrainement, cours.horaire, entraineurs.nom, entraineurs.prenom, (SELECT GROUP_CONCAT(membres.prenom,' ', membres.nom)
FROM membres) AS membres 
FROM cours
JOIN entraineurs ON entraineurs.id = cours.fk_entraineur
JOIN reservations ON reservations.fk_cours = cours.id
JOIN membres ON membres.id = reservations.fk_membre
GROUP BY cours.id

-- 19.

SELECT membres.nom, membres.prenom, cours.date_entrainement
FROM membres
JOIN reservations ON reservations.fk_membre = membres.id
JOIN cours ON cours.id = reservations.fk_cours
JOIN abonnements ON abonnements.fk_membre = membres.id
GROUP BY membres.id
HAVING MAX(abonnements.date_fin) <= cours.date_entrainement

-- 20. 

SELECT membres.nom, membres.prenom
FROM membres
WHERE membres.id IN (SELECT reservations.fk_membre
	FROM  reservations
	GROUP  BY reservations.fk_membre
	HAVING COUNT(reservations.id) >= ALL (SELECT COUNT(id) 
		FROM reservations
		GROUP BY reservations.fk_membre));

-- 21. 

SELECT UNIQUE membres.*
FROM membres
JOIN abonnements ON abonnements.fk_membre = membres.id
WHERE abonnements.`type` = 'annuelle'

-- 22.

SELECT membres.*
FROM reservations
JOIN membres ON reservations.fk_membre = membres.id
GROUP BY membres.id
HAVING COUNT(reservations.id) >= ALL (SELECT COUNT(reservations.id)
FROM reservations
JOIN membres ON reservations.fk_membre = membres.id
GROUP BY membres.id)

-- 23.

SELECT entraineurs.*, COUNT(cours.id)
FROM cours
JOIN entraineurs ON entraineurs.id = cours.fk_entraineur
GROUP BY entraineurs.id
HAVING COUNT(cours.id) >= ALL (SELECT COUNT(cours.id)
FROM cours
JOIN entraineurs ON entraineurs.id = cours.fk_entraineur
GROUP BY entraineurs.id)

        





