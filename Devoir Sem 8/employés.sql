-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           11.7.1-MariaDB - mariadb.org binary distribution
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour employes
DROP DATABASE IF EXISTS `employes`;
CREATE DATABASE IF NOT EXISTS `employes` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `employes`;

-- Listage de la structure de table employes. departements
DROP TABLE IF EXISTS `departements`;
CREATE TABLE IF NOT EXISTS `departements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) DEFAULT NULL,
  `ville` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Listage des données de la table employes.departements : ~5 rows (environ)
INSERT INTO `departements` (`id`, `nom`, `ville`) VALUES
	(1, 'Informatique', 'Montréal'),
	(2, 'Administration', 'Montréal'),
	(3, 'Comptabilité', 'Québec'),
	(4, 'Recherche', 'Toronto'),
	(5, 'Marketing', 'Toronto');

-- Listage de la structure de table employes. employes
DROP TABLE IF EXISTS `employes`;
CREATE TABLE IF NOT EXISTS `employes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` smallint(6) DEFAULT NULL,
  `nom` varchar(25) DEFAULT NULL,
  `prenom` varchar(25) DEFAULT NULL,
  `emploi` varchar(25) DEFAULT NULL,
  `no_chef` int(11) DEFAULT NULL,
  `date_embauche` date DEFAULT NULL,
  `salaire` int(11) DEFAULT NULL,
  `commission` float DEFAULT NULL,
  `departement_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_employes_departement_id` (`departement_id`),
  CONSTRAINT `FK_employes_departement_id` FOREIGN KEY (`departement_id`) REFERENCES `departements` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Listage des données de la table employes.employes : ~17 rows (environ)
INSERT INTO `employes` (`id`, `numero`, `nom`, `prenom`, `emploi`, `no_chef`, `date_embauche`, `salaire`, `commission`, `departement_id`) VALUES
	(1, 7, 'Noir', 'Dominique', 'PRÉSIDENT', 7, '2013-03-01', 125000, 0.03, 2),
	(2, 21, 'Lepage', 'Robert', 'PROGRAMMEUR', 207, '2017-03-11', 62000, 0.015, 1),
	(3, 95, 'Lemay', 'Céline', 'ANALYSTE', 207, '2015-06-06', 76000, 0.02, 1),
	(4, 101, 'Tremblay', 'Jean-Pierre', 'PROGRAMMEUR', 207, '2024-02-14', 65000, 0.05, 1),
	(5, 171, 'Ricard', 'Paul', 'VENDEUR', 211, '2016-02-06', 55000, NULL, 5),
	(6, 201, 'Lavallée', 'Michel', 'PROGRAMMEUR', 207, '2014-08-25', 81000, NULL, 1),
	(7, 207, 'Caron', 'Sandra', 'CHEF DEPT', 7, '1999-12-07', 94000, NULL, 1),
	(8, 211, 'Généreux', 'Luc', 'CHEF DEPT', 7, '2008-05-05', 90000, 0, 5),
	(9, 212, 'Neveu', 'Richard', 'CHEF DEPT', 7, '2014-05-15', 92000, 0, 3),
	(10, 233, 'Lafleur', 'Marc', 'PROGRAMMEUR', 212, '2014-12-22', 65000, NULL, 3),
	(11, 1211, 'Paré', 'Denis', 'VENDEUR', 211, '2013-05-29', 45000, 0, 5),
	(12, 1212, 'Lamrani', 'Karim', 'VENDEUR', 211, '2016-11-11', 54000, 0, 5),
	(13, 1221, 'Cordeau', 'Lise', 'VENDEUR', 211, '2016-04-15', 59000, 0, 5),
	(14, 3111, 'Caron', 'Louise', 'SECRÉTAIRE', 7, '2015-08-14', 50000, 0, 2),
	(15, 3211, 'Pelletier', 'Claire', 'SECRÉTAIRE', 7, '2021-03-03', 50000, 0, 2),
	(16, 3221, 'Kennedy', 'Greg', 'SECRÉTAIRE', 7, '2014-03-06', 52000, 0, 2),
	(17, 3771, 'Langlois', 'Catherine', 'SECRÉTAIRE', 7, '2023-02-01', 35000, 0, 2);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
