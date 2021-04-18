-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : Dim 18 avr. 2021 à 16:50
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
CREATE DATABASE IF NOT EXISTS `ProjetRJ` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `ProjetRJ`;

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
-- Structure de la table `t_pouvoir`
--

CREATE TABLE `t_pouvoir` (
  `id_pouvoir` int(11) NOT NULL,
  `libelle_pouvoir` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `t_publication`
--

CREATE TABLE `t_publication` (
  `id_publication` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `date_creation` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `texte_publication` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `t_relation`
--

CREATE TABLE `t_relation` (
  `id_relation` int(11) NOT NULL,
  `libelle_relation` varchar(255) NOT NULL
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
  `id_pouvoir` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `t_utilisateur_relation`
--

CREATE TABLE `t_utilisateur_relation` (
  `id_utilisateur_demandeur` int(11) NOT NULL,
  `id_utilisateur_repondant` int(11) NOT NULL,
  `id_relation` int(11) NOT NULL
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
-- Index pour la table `t_pouvoir`
--
ALTER TABLE `t_pouvoir`
  ADD PRIMARY KEY (`id_pouvoir`),
  ADD UNIQUE KEY `libelle_pouvoir_unique` (`libelle_pouvoir`);

--
-- Index pour la table `t_publication`
--
ALTER TABLE `t_publication`
  ADD PRIMARY KEY (`id_publication`),
  ADD KEY `fk_utilisateur_publication` (`id_utilisateur`) USING BTREE;

--
-- Index pour la table `t_relation`
--
ALTER TABLE `t_relation`
  ADD PRIMARY KEY (`id_relation`),
  ADD UNIQUE KEY `libelle_relation_unique` (`libelle_relation`);

--
-- Index pour la table `t_utilisateur`
--
ALTER TABLE `t_utilisateur`
  ADD PRIMARY KEY (`id_utilisateur`),
  ADD UNIQUE KEY `pseudonyme_unique` (`pseudonyme`),
  ADD UNIQUE KEY `adresse_mail_unique` (`adresse_mail`),
  ADD KEY `fk_pouvoir_utilisateur` (`id_pouvoir`) USING BTREE;

--
-- Index pour la table `t_utilisateur_relation`
--
ALTER TABLE `t_utilisateur_relation`
  ADD PRIMARY KEY (`id_utilisateur_demandeur`,`id_utilisateur_repondant`,`id_relation`),
  ADD KEY `fk_utilisateur_repondant` (`id_utilisateur_repondant`),
  ADD KEY `fk_utilisateur_relation_relation` (`id_relation`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `t_commentaire`
--
ALTER TABLE `t_commentaire`
  MODIFY `id_commentaire` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `t_pouvoir`
--
ALTER TABLE `t_pouvoir`
  MODIFY `id_pouvoir` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `t_publication`
--
ALTER TABLE `t_publication`
  MODIFY `id_publication` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `t_relation`
--
ALTER TABLE `t_relation`
  MODIFY `id_relation` int(11) NOT NULL AUTO_INCREMENT;

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
-- Contraintes pour la table `t_utilisateur`
--
ALTER TABLE `t_utilisateur`
  ADD CONSTRAINT `fk_pouvoir` FOREIGN KEY (`id_pouvoir`) REFERENCES `t_pouvoir` (`id_pouvoir`);

--
-- Contraintes pour la table `t_utilisateur_relation`
--
ALTER TABLE `t_utilisateur_relation`
  ADD CONSTRAINT `fk_utilisateur_demandeur` FOREIGN KEY (`id_utilisateur_demandeur`) REFERENCES `t_utilisateur` (`id_utilisateur`),
  ADD CONSTRAINT `fk_utilisateur_relation_relation` FOREIGN KEY (`id_relation`) REFERENCES `t_relation` (`id_relation`),
  ADD CONSTRAINT `fk_utilisateur_repondant` FOREIGN KEY (`id_utilisateur_repondant`) REFERENCES `t_utilisateur` (`id_utilisateur`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
