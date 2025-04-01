-- SQL - Sous-requêtes (BD employes)

-- Votre nom : Ugo Lachapelle 0141471

-- À partir de la Base de données employes, produire les requêtes suivantes:


-- 1. Faire afficher le salaire moyen des employés par département (ayant des employés) en 
-- affichant aussi le nom du département (indice: requiert un sous-select pour afficher le 
-- nom du département)

SELECT AVG(employes.salaire) AS salaire_moyen, (SELECT departements.nom
	FROM departements
	WHERE departements.id = employes.departement_id) AS nom_departement
FROM employes
GROUP BY departement_id

-- OU --

SELECT departements.nom, (SELECT AVG(employes.salaire) 
	FROM employes 
	WHERE employes.departement_id = departements.id) AS salaire_moyen
FROM departements
HAVING salaire_moyen IS NOT NULL

-- 2. Afficher la même chose, mais en affichant aussi les départements n'ayant pas d'employé 
-- (dans leur cas, la moyenne salariale sera null)
		 
SELECT departements.nom, (SELECT AVG(employes.salaire) 
	FROM employes 
	WHERE employes.departement_id = departements.id) AS salaire_moyen
FROM departements


-- 3. Faire afficher le nom du PROGRAMMEUR ayant le plus petit salaire.

SELECT employes.nom
FROM employes
WHERE employes.emploi = 'Programmeur' AND employes.salaire = (SELECT MIN(employes.salaire)
	FROM employes
	WHERE employes.emploi = 'Programmeur')

-- 4. Faire afficher toutes les personnes travaillant dans le(s) département(s) de la (des) personne (s) 
-- ayant le plus gros salaire.

SELECT CONCAT(employes.prenom, ' ', employes.nom) AS employe
FROM employes
WHERE employes.departement_id = (SELECT employes.departement_id
	FROM employes
	WHERE employes.salaire = (SELECT MAX(employes.salaire) AS salaire_maximum
		FROM employes))

-- 5. Trouver le numéro de département qui a la plus petite moyenne de salaire de tous les départements.

SELECT AVG(employes.salaire) AS salaire_moyen, employes.departement_id
FROM employes
GROUP BY departement_id
HAVING salaire_moyen <= ALL (SELECT AVG(employes.salaire) AS salaire_moyen
    FROM employes
    GROUP BY departement_id)

-- 6. Trouver les nom et prénom de tous les collègues de Lepage (collègues = qui travaillent dans le même département.)

SELECT nom, prenom
FROM employes
WHERE departement_id = (SELECT departement_id
	FROM employes
	WHERE nom = 'Lepage') AND nom <> 'Lepage'

-- 7. Trouver le nom des départements ayant le plus grand nombre d’employés. 

/* SELECT nom
FROM departements


SELECT nom
FROM departements;

SELECT COUNT(employes.id), departement_id
FROM employes
WHERE MAX(nombre_employes)
		FROM (SELECT COUNT(id) AS nombre_employes
			FROM employes
			GROUP BY departement_id) AS decompte) */
