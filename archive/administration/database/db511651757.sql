-- phpMyAdmin SQL Dump
-- version 2.6.4-pl3
-- http://www.phpmyadmin.net
-- 
-- Serveur: db511651757.db.1and1.com
-- Généré le : Mercredi 05 Mars 2014 à 12:48
-- Version du serveur: 5.1.73
-- Version de PHP: 5.3.3-7+squeeze19
-- 
-- Base de données: `db511651757`
-- 

-- --------------------------------------------------------

-- 
-- Structure de la table `localisation`
-- 

CREATE TABLE `localisation` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `long` float NOT NULL,
  `lat` float NOT NULL,
  `vitesse` float NOT NULL,
  `altitude` float NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idtrajet` int(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idtrajet` (`idtrajet`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

-- 
-- Contenu de la table `localisation`
-- 

INSERT INTO `localisation` VALUES (1, 48, 1, 5, 200, '2014-03-02 19:44:44', 1);
INSERT INTO `localisation` VALUES (2, 48, -1, 5, 200, '2014-03-02 19:45:04', 1);
INSERT INTO `localisation` VALUES (3, 30, 4, 60, 100, '2014-03-02 19:50:58', 3);
INSERT INTO `localisation` VALUES (4, 30, 4, 60, 100, '2014-03-02 19:52:20', 3);

-- --------------------------------------------------------

-- 
-- Structure de la table `trajet`
-- 

CREATE TABLE `trajet` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `id_user` int(255) NOT NULL,
  `debut` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fin` time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=21 ;

-- 
-- Contenu de la table `trajet`
-- 

INSERT INTO `trajet` VALUES (1, 2, '2014-03-02 00:04:13', '00:00:00');
INSERT INTO `trajet` VALUES (2, 2, '2014-03-02 00:04:52', '00:00:00');
INSERT INTO `trajet` VALUES (3, 2, '2014-03-02 19:21:33', '00:00:00');
INSERT INTO `trajet` VALUES (4, 1, '2014-03-02 23:35:25', '00:00:00');
INSERT INTO `trajet` VALUES (5, 1, '2014-03-02 23:36:24', '00:00:00');
INSERT INTO `trajet` VALUES (6, 1, '2014-03-03 23:56:37', '00:00:00');
INSERT INTO `trajet` VALUES (7, 1, '2014-03-04 00:01:55', '00:00:00');
INSERT INTO `trajet` VALUES (8, 1, '2014-03-04 12:13:16', '16:39:12');
INSERT INTO `trajet` VALUES (9, 1, '2014-03-04 13:19:20', '00:00:00');
INSERT INTO `trajet` VALUES (10, 1, '2014-03-04 14:26:57', '17:40:38');
INSERT INTO `trajet` VALUES (11, 1, '2014-03-04 14:31:48', '17:25:51');
INSERT INTO `trajet` VALUES (12, 1, '2014-03-04 14:56:36', '17:25:51');
INSERT INTO `trajet` VALUES (13, 1, '2014-03-04 14:57:00', '17:25:51');
INSERT INTO `trajet` VALUES (14, 1, '2014-03-04 14:57:12', '00:00:00');
INSERT INTO `trajet` VALUES (15, 2, '2014-03-04 17:41:23', '00:00:00');
INSERT INTO `trajet` VALUES (16, 1, '2014-03-04 17:51:42', '17:51:58');
INSERT INTO `trajet` VALUES (17, 1, '2014-03-04 18:03:09', '00:00:00');
INSERT INTO `trajet` VALUES (18, 1, '2014-03-04 18:03:17', '18:03:24');
INSERT INTO `trajet` VALUES (19, 1, '2014-03-04 18:04:33', '18:04:50');
INSERT INTO `trajet` VALUES (20, 1, '2014-03-04 20:09:09', '00:00:00');

-- --------------------------------------------------------

-- 
-- Structure de la table `user`
-- 

CREATE TABLE `user` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `prenom` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `login` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `mdp` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

-- 
-- Contenu de la table `user`
-- 

INSERT INTO `user` VALUES (1, 'Alex', 'root', 'root');
INSERT INTO `user` VALUES (2, 'marcel', 'admin', 'admin');

-- 
-- Contraintes pour les tables exportées
-- 

-- 
-- Contraintes pour la table `localisation`
-- 
ALTER TABLE `localisation`
  ADD CONSTRAINT `localisation_ibfk_1` FOREIGN KEY (`idtrajet`) REFERENCES `trajet` (`id`) ON DELETE CASCADE;

-- 
-- Contraintes pour la table `trajet`
-- 
ALTER TABLE `trajet`
  ADD CONSTRAINT `trajet_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);
