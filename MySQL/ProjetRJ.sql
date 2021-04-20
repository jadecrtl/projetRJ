-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mar. 20 avr. 2021 à 12:06
-- Version du serveur :  10.4.17-MariaDB
-- Version de PHP : 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ProjetRJ`
--

-- --------------------------------------------------------

--
-- Structure de la table `t_commentaire`
--

CREATE TABLE `t_commentaire` (
  `id_commentaire` int(11) NOT NULL,
  `id_publication` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `texte_commentaire` text NOT NULL,
  `date_commentaire` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `t_publication`
--

CREATE TABLE `t_publication` (
  `id_publication` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `date_creation` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `texte_publication` text NOT NULL,
  `statut_publication` enum('publiee','supprimee','censuree') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `t_utilisateur`
--

CREATE TABLE `t_utilisateur` (
  `id_utilisateur` int(11) NOT NULL COMMENT 'identifiant unique de l''utilisateur',
  `pseudonyme` varchar(40) NOT NULL,
  `adresse_mail` varchar(255) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `pouvoir` enum('admin','prive','public') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `t_utilisateur_relation`
--

CREATE TABLE `t_utilisateur_relation` (
  `id_utilisateur_demandeur` int(11) NOT NULL,
  `id_utilisateur_repondant` int(11) NOT NULL,
  `relation` enum('ami','attente','refus') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `t_commentaire`
--
ALTER TABLE `t_commentaire`
  ADD PRIMARY KEY (`id_commentaire`),
  ADD KEY `fk_utilisateur_commentaire` (`id_utilisateur`),
  ADD KEY `fk_publication_commentaire` (`id_publication`) USING BTREE;

--
-- Index pour la table `t_publication`
--
ALTER TABLE `t_publication`
  ADD PRIMARY KEY (`id_publication`),
  ADD KEY `fk_utilisateur_publication` (`id_utilisateur`) USING BTREE;

--
-- Index pour la table `t_utilisateur`
--
ALTER TABLE `t_utilisateur`
  ADD PRIMARY KEY (`id_utilisateur`),
  ADD UNIQUE KEY `pseudonyme_unique` (`pseudonyme`),
  ADD UNIQUE KEY `adresse_mail_unique` (`adresse_mail`);

--
-- Index pour la table `t_utilisateur_relation`
--
ALTER TABLE `t_utilisateur_relation`
  ADD PRIMARY KEY (`id_utilisateur_demandeur`,`id_utilisateur_repondant`) USING BTREE,
  ADD KEY `fk_utilisateur_repondant` (`id_utilisateur_repondant`),
  ADD KEY `fk_utilisateur_demandeur` (`id_utilisateur_demandeur`) USING BTREE;

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `t_commentaire`
--
ALTER TABLE `t_commentaire`
  MODIFY `id_commentaire` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `t_publication`
--
ALTER TABLE `t_publication`
  MODIFY `id_publication` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `t_utilisateur`
--
ALTER TABLE `t_utilisateur`
  MODIFY `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT COMMENT 'identifiant unique de l''utilisateur';

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `t_commentaire`
--
ALTER TABLE `t_commentaire`
  ADD CONSTRAINT `fk_publication` FOREIGN KEY (`id_publication`) REFERENCES `t_publication` (`id_publication`),
  ADD CONSTRAINT `fk_utilisateur_commentaire` FOREIGN KEY (`id_utilisateur`) REFERENCES `t_utilisateur` (`id_utilisateur`);

--
-- Contraintes pour la table `t_publication`
--
ALTER TABLE `t_publication`
  ADD CONSTRAINT `fk_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `t_utilisateur` (`id_utilisateur`);

--
-- Contraintes pour la table `t_utilisateur_relation`
--
ALTER TABLE `t_utilisateur_relation`
  ADD CONSTRAINT `fk_utilisateur_demandeur` FOREIGN KEY (`id_utilisateur_demandeur`) REFERENCES `t_utilisateur` (`id_utilisateur`),
  ADD CONSTRAINT `fk_utilisateur_repondant` FOREIGN KEY (`id_utilisateur_repondant`) REFERENCES `t_utilisateur` (`id_utilisateur`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
