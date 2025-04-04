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

SELECT *
FROM membres
WHERE CONCAT(nom, prenom) IN (SELECT CONCAT(nom, prenom) AS nomcomplet
	FROM membres
	GROUP BY nomcomplet
	HAVING COUNT(CONCAT(nom, prenom)) > 1)

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
WHERE abonnements.date_fin >= '2025-03-15' AND membres.adresse LIKE '%Chambly%'

-- 14.

SELECT nom, prenom, minimum, maximum
FROM (SELECT entraineurs.nom, entraineurs.prenom, MIN(abonnements.date_debut) AS minimum, MAX(abonnements.date_fin) AS maximum
FROM entraineurs
INNER JOIN cours ON entraineurs.id = cours.fk_entraineur
INNER JOIN reservations ON cours.id = reservations.fk_cours
INNER JOIN membres ON reservations.fk_membre = membres.id
INNER JOIN abonnements ON membres.id = abonnements.fk_membre
GROUP BY entraineurs.id) AS tableau
HAVING DATEDIFF(minimum, maximum) <= MAX(DATEDIFF(minimum,maximum))

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

-- 24.

UPDATE abonnements
SET abonnements.prix = 56
WHERE YEAR(abonnements.date_debut) = 2015 AND abonnements.`type` = 'mensuelle';

UPDATE abonnements
SET abonnements.prix = 58
WHERE YEAR(abonnements.date_debut) = 2016 AND abonnements.`type` = 'mensuelle';

UPDATE abonnements
SET abonnements.prix = 60
WHERE YEAR(abonnements.date_debut) = 2017 AND abonnements.`type` = 'mensuelle';

UPDATE abonnements
SET abonnements.prix = 62
WHERE YEAR(abonnements.date_debut) = 2018 AND abonnements.`type` = 'mensuelle';

UPDATE abonnements
SET abonnements.prix = 64
WHERE YEAR(abonnements.date_debut) = 2019 AND abonnements.`type` = 'mensuelle';

UPDATE abonnements
SET abonnements.prix = 67
WHERE YEAR(abonnements.date_debut) = 2020 AND abonnements.`type` = 'mensuelle';

UPDATE abonnements
SET abonnements.prix = 70
WHERE YEAR(abonnements.date_debut) = 2021 AND abonnements.`type` = 'mensuelle';

UPDATE abonnements
SET abonnements.prix = 73
WHERE YEAR(abonnements.date_debut) = 2022 AND abonnements.`type` = 'mensuelle';

UPDATE abonnements
SET abonnements.prix = 76
WHERE YEAR(abonnements.date_debut) = 2023 AND abonnements.`type` = 'mensuelle';

UPDATE abonnements
SET abonnements.prix = 79
WHERE YEAR(abonnements.date_debut) = 2024 AND abonnements.`type` = 'mensuelle';

UPDATE abonnements
SET abonnements.prix = 82
WHERE YEAR(abonnements.date_debut) = 2025 AND abonnements.`type` = 'mensuelle';
        
-- 25.

UPDATE membres
SET membres.date_naissance = '2007-03-02'
WHERE membres.date_naissance = (SELECT membres.date_naissance
	FROM membres
	WHERE nom = 'Martel' AND prenom = 'Olivier' AND YEAR(date_naissance) = 2007)

-- 26.

UPDATE entraineurs
SET entraineurs.nom = 'Drop Database mysql;'
WHERE entraineurs.prenom = 'Gabrielle' AND entraineurs.nom = 'Nadeau'

-- 27.

DELETE FROM cours
WHERE cours.id = (SELECT cours.id
FROM cours
JOIN entraineurs ON cours.fk_entraineur = entraineurs.id
WHERE entraineurs.nom = 'Caron' AND entraineurs.prenom = 'Jérôme' AND cours.nom = 'Nutrition Sportive' AND cours.date_entrainement = '2025-03-15')

-- 28.

DELETE FROM reservations
WHERE reservations.id IN (SELECT reservations.id
FROM reservations
INNER JOIN cours ON reservations.fk_cours = cours.id
INNER JOIN entraineurs ON cours.fk_entraineur = entraineurs.id
WHERE entraineurs.prenom = 'Jacob' AND entraineurs.nom = 'Leduc');

DELETE FROM cours
WHERE cours.id IN (SELECT cours.id
FROM cours
INNER JOIN entraineurs ON cours.fk_entraineur = entraineurs.id
WHERE entraineurs.prenom = 'Jacob' AND entraineurs.nom = 'Leduc');

DELETE FROM entraineurs
WHERE entraineurs.prenom = 'Jacob' AND entraineurs.nom = 'Leduc';

-- 29. 

INSERT entraineurs (entraineurs.nom, entraineurs.prenom, entraineurs.specialite, entraineurs.adresse, entraineurs.telephone, entraineurs.courriel)
VALUES ('Mélissa','Diallo','Instructeur de CrossFit','200 rue Manx Carignan J0X 7X8 Québec Canada','438-123-8587','medallo@gmail.com')

-- 30. 

INSERT cours (cours.nom, cours.date_entrainement, cours.horaire, cours.fk_entraineur) VALUES 
('CrossFit Intense','2025-04-07','18:00:00',(SELECT entraineurs.id
FROM entraineurs
WHERE entraineurs.nom = 'Diallo' AND entraineurs.prenom = 'Mélissa')),
('CrossFit Intense','2025-04-08','18:00:00',(SELECT entraineurs.id
FROM entraineurs
WHERE entraineurs.nom = 'Diallo' AND entraineurs.prenom = 'Mélissa')),
('CrossFit Intense','2025-04-09','18:00:00',(SELECT entraineurs.id
FROM entraineurs
WHERE entraineurs.nom = 'Diallo' AND entraineurs.prenom = 'Mélissa')),
('CrossFit Intense','2025-04-10','18:00:00',(SELECT entraineurs.id
FROM entraineurs
WHERE entraineurs.nom = 'Diallo' AND entraineurs.prenom = 'Mélissa')),
('CrossFit Intense','2025-04-11','18:00:00',(SELECT entraineurs.id
FROM entraineurs
WHERE entraineurs.nom = 'Diallo' AND entraineurs.prenom = 'Mélissa'));