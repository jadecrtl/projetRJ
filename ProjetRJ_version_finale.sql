-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : Dim 23 mai 2021 à 18:22
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

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `ps_ajouter_ami`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_ajouter_ami` (IN `p_pseudonyme_demandeur` VARCHAR(40), IN `p_pseudonyme_repondant` VARCHAR(40))  BEGIN  

    DECLARE l_pouvoir_repondant ENUM("admin", "prive", "public");

    SET @l_pouvoir_repondant = (SELECT pouvoir FROM t_utilisateur WHERE pseudonyme = p_pseudonyme_repondant);

    IF (@l_pouvoir_repondant = "prive") THEN
        CALL ps_creer_demande_ami(p_pseudonyme_demandeur, p_pseudonyme_repondant);
    END IF;

    IF (@l_pouvoir_repondant = "public") THEN
        CALL ps_creer_abonnement(p_pseudonyme_demandeur, p_pseudonyme_repondant);
    END IF;

END$$

DROP PROCEDURE IF EXISTS `ps_censurer_publication_admin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_censurer_publication_admin` (IN `p_pseudonyme` VARCHAR(40), IN `p_id_publication` INT)  BEGIN 
    DECLARE l_id_utilisateur INT;
    DECLARE l_id_publication INT;

    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme AND (pouvoir = 'admin') );

    SET @l_id_publication = (SELECT id_publication FROM t_publication WHERE id_publication = p_id_publication AND statut_publication = 'publiee');

    IF (@l_id_utilisateur IS NOT NULL AND @l_id_publication IS NOT NULL) THEN    
    UPDATE t_publication
    SET statut_publication = 'censuree'
    WHERE id_publication = @l_id_publication;
    END IF;

END$$

DROP PROCEDURE IF EXISTS `ps_creer_abonnement`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_creer_abonnement` (IN `p_pseudonyme_demandeur` VARCHAR(40), IN `p_pseudonyme_influenceur` VARCHAR(40))  BEGIN
    DECLARE l_id_influenceur INT;
    DECLARE l_id_demandeur INT;
    DECLARE l_relation_existante INT;

    SET @l_id_influenceur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme_influenceur AND pouvoir = 'public');

    SET @l_id_demandeur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme_demandeur);

    SET @l_relation_existante = (SELECT COUNT(*) FROM t_utilisateur_relation WHERE id_utilisateur_demandeur = l_id_demandeur AND id_utilisateur_repondant = l_id_influenceur);

    IF (@l_id_influenceur IS NOT NULL AND @l_id_demandeur IS NOT NULL AND @l_relation_existante = 0 AND @l_id_demandeur <> @l_id_influenceur) THEN    
        INSERT INTO t_utilisateur_relation (id_utilisateur_demandeur, id_utilisateur_repondant, relation)
        VALUES (@l_id_demandeur, @l_id_influenceur, 'ami');
    END IF;
END$$

DROP PROCEDURE IF EXISTS `ps_creer_acceptation_ami`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_creer_acceptation_ami` (IN `p_pseudonyme_demandeur` VARCHAR(40), IN `p_pseudonyme_repondant` VARCHAR(40))  BEGIN
    DECLARE l_id_repondant INT;
    DECLARE l_id_demandeur INT;

    SET @l_id_demandeur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme_demandeur);

    SET @l_id_repondant = (
        SELECT r.id_utilisateur_repondant
        FROM t_utilisateur_relation r
        JOIN t_utilisateur u ON (r.id_utilisateur_repondant = u.id_utilisateur)
        WHERE u.pseudonyme = p_pseudonyme_repondant 
        AND r.id_utilisateur_demandeur = @l_id_demandeur
        AND r.relation = 'attente' 
        AND u.pouvoir = 'prive');
    
    IF (@l_id_repondant IS NOT NULL AND @l_id_demandeur IS NOT NULL AND @l_id_demandeur <> @l_id_repondant) THEN    
        UPDATE t_utilisateur_relation
        SET relation = 'ami'
        WHERE id_utilisateur_demandeur = @l_id_demandeur AND id_utilisateur_repondant = @l_id_repondant;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `ps_creer_commentaire`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_creer_commentaire` (IN `p_pseudonyme` VARCHAR(40), IN `p_id_publication` INT, IN `p_texte_commentaire` TEXT)  BEGIN

    DECLARE l_id_commentateur INT;
    DECLARE l_date_commentaire_creation TIMESTAMP;
    DECLARE l_id_publicateur INT;
    DECLARE l_relation_existante INT;
    
    SET @l_id_commentateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    SET @l_date_commentaire_creation = (SELECT NOW());

    SET @l_id_publicateur = (SELECT id_utilisateur FROM t_publication WHERE id_publication = p_id_publication);
    
    SET @l_relation_existante = (SELECT COUNT(*) FROM t_utilisateur_relation WHERE ((id_utilisateur_demandeur = l_id_commentateur AND id_utilisateur_repondant = l_id_publicateur) OR (id_utilisateur_demandeur = l_id_publicateur AND id_utilisateur_repondant = l_id_commentateur)) AND relation = 'ami');

    IF (@l_id_commentateur IS NOT NULL AND @l_id_publicateur IS NOT NULL AND @l_relation_existante >= 1) THEN
        INSERT INTO t_commentaire (id_publication, id_utilisateur, texte_commentaire, date_commentaire)
        VALUES (@l_id_commentateur, p_id_publication, p_texte_commentaire, @l_date_commentaire_creation);
    END IF;

END$$

DROP PROCEDURE IF EXISTS `ps_creer_demande_ami`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_creer_demande_ami` (IN `p_pseudonyme_demandeur` VARCHAR(40), IN `p_pseudonyme_repondant` VARCHAR(40))  BEGIN
    DECLARE l_id_demandeur INT;
    DECLARE l_id_repondant INT;
    DECLARE l_relation_existante INT;

    SET @l_id_demandeur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme_demandeur);

    SET @l_id_repondant = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme_repondant AND pouvoir = 'prive');

    SET @l_relation_existante = (SELECT COUNT(*) FROM t_utilisateur_relation WHERE id_utilisateur_demandeur = l_id_demandeur AND id_utilisateur_repondant = l_id_repondant);

    IF (@l_id_demandeur IS NOT NULL AND @l_id_repondant IS NOT NULL AND @l_relation_existante = 0 AND @l_id_demandeur <> @l_id_repondant) THEN    
        INSERT INTO t_utilisateur_relation (id_utilisateur_demandeur, id_utilisateur_repondant, relation)
        VALUES (@l_id_demandeur, @l_id_repondant, 'attente');
    END IF;
END$$

DROP PROCEDURE IF EXISTS `ps_creer_publication`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_creer_publication` (IN `p_pseudonyme` VARCHAR(40), IN `p_texte_publication` TEXT)  BEGIN
    DECLARE l_id_utilisateur INT;
    DECLARE l_date_creation TIMESTAMP;
    
    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    SET @l_date_creation = (SELECT NOW());

    INSERT INTO t_publication (id_utilisateur, date_creation, texte_publication, statut_publication) 
    VALUES (@l_id_utilisateur, @l_date_creation, p_texte_publication, 'publiee');

END$$

DROP PROCEDURE IF EXISTS `ps_retirer_de_mes_amis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_retirer_de_mes_amis` (IN `p_pseudonyme_a_retirer` VARCHAR(40), IN `p_pseudonyme` VARCHAR(40))  BEGIN
    DECLARE l_id_a_retirer INT;
    DECLARE l_id_utilisateur INT;

    SET @l_id_utilisateur = (
        SELECT id_utilisateur 
        FROM t_utilisateur
        WHERE pseudonyme = p_pseudonyme);

    SET @l_id_a_retirer = (
        SELECT id_utilisateur 
        FROM t_utilisateur
        WHERE pseudonyme = p_pseudonyme_a_retirer);

    IF (@l_id_utilisateur IS NOT NULL AND @l_id_a_retirer IS NOT NULL AND @l_id_a_retirer <> @l_id_utilisateur) THEN    
        UPDATE t_utilisateur_relation
        SET relation = 'refus'
        WHERE (id_utilisateur_demandeur = @l_id_a_retirer AND id_utilisateur_repondant = @l_id_utilisateur)
        OR
        (id_utilisateur_demandeur = @l_id_utilisateur AND id_utilisateur_repondant = @l_id_a_retirer);
    END IF;
END$$

DROP PROCEDURE IF EXISTS `ps_supprimer_demande_ami`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_supprimer_demande_ami` (IN `p_pseudonyme_demandeur` VARCHAR(40), IN `p_pseudonyme_repondant` VARCHAR(40))  BEGIN
    DECLARE l_id_repondant INT;
    DECLARE l_id_demandeur INT;

    SET @l_id_demandeur = (
        SELECT id_utilisateur 
        FROM t_utilisateur
        WHERE pseudonyme = p_pseudonyme_demandeur);

    SET @l_id_repondant = (
        SELECT r.id_utilisateur_repondant 
        FROM t_utilisateur_relation r
        JOIN t_utilisateur u ON (u.id_utilisateur = r.id_utilisateur_repondant)
        WHERE u.pseudonyme = p_pseudonyme_repondant 
        AND r.id_utilisateur_demandeur = @l_id_demandeur
        AND r.relation = 'attente' 
        AND u.pouvoir = 'prive');

    IF (@l_id_repondant IS NOT NULL AND @l_id_demandeur IS NOT NULL AND @l_id_demandeur <> @l_id_repondant) THEN    
        UPDATE t_utilisateur_relation
        SET relation = 'refus'
        WHERE id_utilisateur_demandeur = @l_id_demandeur
        AND id_utilisateur_repondant = @l_id_repondant;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `ps_supprimer_publication`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_supprimer_publication` (IN `p_pseudonyme` VARCHAR(40), IN `p_id_publication` INT)  BEGIN  

    DECLARE l_pouvoir ENUM("admin", "prive", "public");

    SET @l_pouvoir = (SELECT pouvoir FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    IF (@l_pouvoir = "prive" OR @l_pouvoir = "public") THEN
        CALL ps_supprimer_publication_prive_public(p_pseudonyme, p_id_publication);
    END IF;

    IF (@l_pouvoir = "admin") THEN
        CALL ps_censurer_publication_admin(p_pseudonyme, p_id_publication);
    END IF;

END$$

DROP PROCEDURE IF EXISTS `ps_supprimer_publications`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_supprimer_publications` (IN `p_pseudonyme` VARCHAR(40), IN `p_id_publication` INT)  BEGIN  

    DECLARE l_pouvoir ENUM("admin", "prive", "public");

    SET @l_pouvoir = (SELECT pouvoir FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    IF (@l_pouvoir = "prive" OR @l_pouvoir = "public") THEN
        CALL ps_supprimer_publication_prive_public(p_pseudonyme, p_id_publication);
    END IF;

    IF (@l_pouvoir = "admin") THEN
        CALL ps_censurer_publications_admin(p_pseudonyme, p_id_publication);
    END IF;

END$$

DROP PROCEDURE IF EXISTS `ps_supprimer_publication_prive_public`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_supprimer_publication_prive_public` (IN `p_pseudonyme` VARCHAR(40), IN `p_id_publication` INT)  BEGIN 
    DECLARE l_id_utilisateur INT;
    DECLARE l_id_publication INT;

    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme AND ((pouvoir = 'public') OR (pouvoir ='prive')) );

    SET @l_id_publication = (SELECT id_publication FROM t_publication WHERE id_publication = p_id_publication AND statut_publication = 'publiee');

    IF (@l_id_utilisateur IS NOT NULL AND @l_id_publication IS NOT NULL) THEN    
    UPDATE t_publication
    SET statut_publication = 'supprimee'
    WHERE id_utilisateur = @l_id_utilisateur
    AND id_publication = @l_id_publication;
    END IF;

END$$

DROP PROCEDURE IF EXISTS `ps_voir_amis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_voir_amis` (IN `p_pseudonyme` VARCHAR(40))  BEGIN

    DECLARE l_id_utilisateur INT;

    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    SELECT id_utilisateur_ami, pseudonyme, 'ami' relation
    FROM vue_amis
    WHERE id_utilisateur = @l_id_utilisateur
    ORDER BY pseudonyme ASC;

END$$

DROP PROCEDURE IF EXISTS `ps_voir_attentes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_voir_attentes` (IN `p_pseudonyme_repondant` VARCHAR(40))  BEGIN

    DECLARE l_id_utilisateur_repondant INT;
    SET @l_id_utilisateur_repondant = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme_repondant);

    SELECT r.id_utilisateur_demandeur, u.pseudonyme, r.relation
    FROM t_utilisateur_relation r
    JOIN t_utilisateur u ON (u.id_utilisateur = r.id_utilisateur_demandeur) 
    WHERE r.id_utilisateur_repondant = @l_id_utilisateur_repondant
    AND r.relation = 'attente'
    ORDER BY u.pseudonyme ASC;


END$$

DROP PROCEDURE IF EXISTS `ps_voir_commentaires`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_voir_commentaires` (IN `p_pseudonyme` VARCHAR(40), IN `p_texte_commentaire` TEXT)  BEGIN
    DECLARE l_id_utilisateur INT;
    DECLARE l_id_publication INT;
    DECLARE l_id_commentaire INT;

    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    SET @l_id_publication = (SELECT id_publication FROM t_publication WHERE id_publication = p_id_publication);

    SELECT @l_id_commentaire := l_id_commentaire
    FROM t_commentaire
    WHERE texte_commentaire = p_texte_commentaire;

END$$

DROP PROCEDURE IF EXISTS `ps_voir_fiche_adresse_mail`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_voir_fiche_adresse_mail` (IN `p_adresse_mail` VARCHAR(255))  BEGIN
    
    SELECT pseudonyme, adresse_mail, mot_de_passe, pouvoir 
    FROM t_utilisateur
    WHERE adresse_mail = p_adresse_mail;

END$$

DROP PROCEDURE IF EXISTS `ps_voir_mes_publications`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_voir_mes_publications` (IN `p_pseudonyme` VARCHAR(40))  BEGIN
    DECLARE l_id_utilisateur INT;
    
    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    SELECT u.pseudonyme, p.texte_publication, p.date_creation, p.id_publication
    FROM t_publication p
    JOIN t_utilisateur u ON (p.id_utilisateur = u.id_utilisateur)
    WHERE u.id_utilisateur = @l_id_utilisateur
    AND statut_publication = 'publiee'
    ORDER BY date_creation DESC;

END$$

DROP PROCEDURE IF EXISTS `ps_voir_mon_profil`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_voir_mon_profil` (IN `p_pseudonyme` VARCHAR(40))  BEGIN
    DECLARE l_id_utilisateur INT;
    
    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    SELECT id_utilisateur, pseudonyme, adresse_mail, pouvoir
    FROM t_utilisateur
    WHERE id_utilisateur = @l_id_utilisateur;

END$$

DROP PROCEDURE IF EXISTS `ps_voir_nombre_amis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_voir_nombre_amis` (IN `p_pseudonyme` VARCHAR(40))  BEGIN 
    SELECT count(*) AS nb_abonnee
	FROM vue_amis a
	JOIN t_utilisateur u ON (a.id_utilisateur = u.id_utilisateur)
	WHERE u.pseudonyme = p_pseudonyme;
END$$

DROP PROCEDURE IF EXISTS `ps_voir_notifications`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_voir_notifications` (IN `p_pseudonyme` VARCHAR(255))  BEGIN
    
    SELECT count(*) AS nb_notif
    FROM t_utilisateur_relation r
    JOIN t_utilisateur u ON (r.id_utilisateur_repondant = u.id_utilisateur)
    WHERE u.pseudonyme = p_pseudonyme
    AND r.relation = 'attente';
    
END$$

DROP PROCEDURE IF EXISTS `ps_voir_nouveaux_amis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_voir_nouveaux_amis` (IN `p_pseudonyme` VARCHAR(40), IN `p_critere_recherche` VARCHAR(40))  BEGIN

    DECLARE l_id_utilisateur INT;
    DECLARE l_critere_recherche VARCHAR(42);

    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    SET @l_critere_recherche = CONCAT('%', p_critere_recherche, '%');

    SELECT id_utilisateur, pseudonyme
    FROM t_utilisateur
    WHERE id_utilisateur NOT IN
        (
        SELECT r.id_utilisateur_repondant id_utilisateur
        FROM t_utilisateur_relation r, t_utilisateur u
        WHERE r.id_utilisateur_demandeur = @l_id_utilisateur
        AND r.relation IN('ami', 'attente', 'refus')
        AND r.id_utilisateur_repondant = u.id_utilisateur
        UNION
        SELECT r.id_utilisateur_demandeur id_utilisateur
        FROM t_utilisateur_relation r, t_utilisateur u
        WHERE r.id_utilisateur_repondant = @l_id_utilisateur
        AND r.relation IN('ami', 'attente', 'refus')
        AND r.id_utilisateur_demandeur = u.id_utilisateur
        )
    AND id_utilisateur <> @l_id_utilisateur
    AND pseudonyme LIKE @l_critere_recherche
    AND pouvoir NOT IN ('admin')
    ORDER BY pseudonyme ASC;

END$$

DROP PROCEDURE IF EXISTS `ps_voir_publications`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_voir_publications` (IN `p_pseudonyme` VARCHAR(40))  BEGIN  

    DECLARE l_pouvoir ENUM("admin", "prive", "public");

    SET @l_pouvoir = (SELECT pouvoir FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    IF (@l_pouvoir = "prive" OR @l_pouvoir = "public") THEN
        CALL ps_voir_publications_prive_public(p_pseudonyme);
    END IF;

    IF (@l_pouvoir = "admin") THEN
        CALL ps_voir_publications_admin(p_pseudonyme);
    END IF;

END$$

DROP PROCEDURE IF EXISTS `ps_voir_publications_admin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_voir_publications_admin` (IN `p_pseudonyme` VARCHAR(40))  BEGIN
    DECLARE l_id_utilisateur INT;
    
    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme AND pouvoir = 'admin');

    SELECT u.pseudonyme, p.texte_publication, p.date_creation, p.id_publication
    FROM t_publication p
    JOIN t_utilisateur u ON (p.id_utilisateur = u.id_utilisateur)
    WHERE statut_publication = 'publiee'
    ORDER BY p.date_creation DESC;

END$$

DROP PROCEDURE IF EXISTS `ps_voir_publications_prive_public`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_voir_publications_prive_public` (IN `p_pseudonyme` VARCHAR(40))  BEGIN
    DECLARE l_id_utilisateur INT;
    
    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    SELECT u.pseudonyme, p.texte_publication, p.date_creation
    FROM t_publication p
    JOIN t_utilisateur u ON (p.id_utilisateur = u.id_utilisateur)
    WHERE p.id_utilisateur IN (SELECT id_utilisateur_ami FROM vue_amis WHERE id_utilisateur = @l_id_utilisateur)
    AND p.statut_publication = 'publiee'
    ORDER BY p.date_creation DESC;

END$$

DROP PROCEDURE IF EXISTS `ps_voir_publications_profil`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_voir_publications_profil` (IN `p_pseudonyme` VARCHAR(40))  BEGIN  

    DECLARE l_pouvoir ENUM("admin", "prive", "public");

    SET @l_pouvoir = (SELECT pouvoir FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    IF (@l_pouvoir = "prive" OR @l_pouvoir = "public") THEN
        CALL ps_voir_mes_publications(p_pseudonyme);
    END IF;
    
    IF (@l_pouvoir = "admin") THEN
        CALL ps_voir_publications_admin(p_pseudonyme);
    END IF;

END$$

DROP PROCEDURE IF EXISTS `ps_voir_publications_visiteur`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_voir_publications_visiteur` ()  BEGIN

    SELECT u.pseudonyme, p.texte_publication, p.date_creation
    FROM t_publication p
    JOIN t_utilisateur u ON (u.id_utilisateur = p.id_utilisateur)
    WHERE u.pouvoir = 'public'
    AND p.statut_publication = 'publiee'
    ORDER BY p.date_creation DESC;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_commentaire`
--

DROP TABLE IF EXISTS `t_commentaire`;
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

DROP TABLE IF EXISTS `t_publication`;
CREATE TABLE `t_publication` (
  `id_publication` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `date_creation` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `texte_publication` text NOT NULL,
  `statut_publication` enum('publiee','supprimee','censuree') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `t_publication`
--

INSERT INTO `t_publication` (`id_publication`, `id_utilisateur`, `date_creation`, `texte_publication`, `statut_publication`) VALUES
(14, 10, '2021-05-18 10:47:01', 'Je suis influe1 et bienvenu sur mon premier post!', 'publiee'),
(15, 10, '2021-05-18 10:47:01', 'En visualisant mon mur de publications je vous présenterai au fur et à mesure des références modes et makeup.', 'publiee'),
(16, 11, '2021-05-18 10:47:01', 'Hey je suis influe2 je suis nouveau sur ce réseau.', 'publiee'),
(17, 13, '2021-05-18 10:47:01', 'J\'aime beaucoup le maquillage!', 'publiee'),
(18, 14, '2021-05-18 10:47:01', 'Une boutique à me conseiller pour un style rock sur Paris?', 'publiee'),
(19, 14, '2021-05-18 10:47:01', 'J\'ai trouvé une boutique super sympa elle s\'appelle & other stories je vous la conseille!', 'publiee'),
(20, 14, '2021-05-18 10:47:01', 'Vivement que le confinement se finisse on en peut plus!', 'publiee'),
(21, 15, '2021-05-23 16:04:01', 'Nouvelle publication pour Jade3.', 'censuree');

-- --------------------------------------------------------

--
-- Structure de la table `t_utilisateur`
--

DROP TABLE IF EXISTS `t_utilisateur`;
CREATE TABLE `t_utilisateur` (
  `id_utilisateur` int(11) NOT NULL COMMENT 'identifiant unique de l''utilisateur',
  `pseudonyme` varchar(40) NOT NULL,
  `adresse_mail` varchar(255) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `pouvoir` enum('admin','prive','public') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `t_utilisateur`
--

INSERT INTO `t_utilisateur` (`id_utilisateur`, `pseudonyme`, `adresse_mail`, `mot_de_passe`, `pouvoir`) VALUES
(8, 'admin1', 'admin1@gmail.com', '$2y$10$d9JEHe2euz6eym7P1EPc/.JRHPkCX0hYEcJ.UbMMh4i1Tj58n6QTe', 'admin'),
(9, 'admin2', 'admin2@gmail.com', '$2y$10$jxauFqeQ7x.0GI/11mlWue1XB6PikNFNxqJ1pwH611oMauqjKcSDy', 'admin'),
(10, 'influe1', 'influe1@gmail.com', '$2y$10$OxdJrXdYdxnCFwDnkbYQl.n9prXVsonfvXn/hfsJWrsxvfgcQGLji', 'public'),
(11, 'influe2', 'influe2@gmail.com', '$2y$10$vMNZVmC1NBQ1B3dpC25ODO8cCyv4TogplqfdkyUs/WABa6VYi4YWu', 'public'),
(12, 'influe3', 'influe3@gmail.com', '$2y$10$vMNZVmC1NBQ1B3dpC25ODO8cCyv4TogplqfdkyUs/WABa6VYi4YWu', 'public'),
(13, 'jade1', 'jade1@gmail.com', '$2y$10$wNQynQZ/cF9XbEr0oHhvR.XNjs/wMr7kpr8P5BboOMenIwU.29.XG', 'prive'),
(14, 'jade2', 'jade2@gmail.com', '$2y$10$/3NanE0KL7eQ8wOXKhncreBLTrFMmCDN1nWp5ap0.S3q8h3uiupqq', 'prive'),
(15, 'jade3', 'jade3@gmail.com', '$2y$10$XAP35UhSH.2ZwNOYFcEiwOXAYCZpfKhOYIsf3r86qYGTi4L.pKUHi', 'prive'),
(22, 'rayana1', 'rayana1@gmail.com', '$2y$10$Zgdjn9dBC4p3M4Q9YFplduOv3gYYtZymkgV9tgtkrZrssRCd3Jkau', 'prive'),
(23, 'rayana2', 'rayana2@gmail.com', '$2y$10$B1JpEy5TGIMBbxmR5MiR2eRIXrlSjQeqlzhuhJjUx3vvOPxJ8.q0G', 'prive'),
(25, 'rayana3', 'rayana3@gmail.com', '$2y$10$RkmiCEh.WwLJExgS.ObgHeC4nHwrFNr4DtW36PRfZ1rmyhejRkqhe', 'prive'),
(26, 'jade4', 'jade4@gmail.com', '$2y$10$JKzuLbREZ1Oh5ZL8S8BEoO7KQ36vbODuzcL4gCXnNrKFxtIL2Xt7i', 'prive');

-- --------------------------------------------------------

--
-- Structure de la table `t_utilisateur_relation`
--

DROP TABLE IF EXISTS `t_utilisateur_relation`;
CREATE TABLE `t_utilisateur_relation` (
  `id_utilisateur_demandeur` int(11) NOT NULL,
  `id_utilisateur_repondant` int(11) NOT NULL,
  `relation` enum('ami','attente','refus') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `t_utilisateur_relation`
--

INSERT INTO `t_utilisateur_relation` (`id_utilisateur_demandeur`, `id_utilisateur_repondant`, `relation`) VALUES
(10, 12, 'ami'),
(10, 22, 'ami'),
(10, 23, 'refus'),
(11, 10, 'ami'),
(11, 13, 'attente'),
(13, 10, 'ami'),
(13, 25, 'attente'),
(14, 10, 'ami'),
(14, 11, 'ami'),
(14, 25, 'attente'),
(15, 10, 'ami'),
(15, 13, 'attente'),
(15, 14, 'ami'),
(15, 25, 'ami');

DROP VIEW IF EXISTS vue_amis;


CREATE VIEW vue_amis AS 
    SELECT r.id_utilisateur_demandeur id_utilisateur, r.id_utilisateur_repondant id_utilisateur_ami, u.pseudonyme
    FROM t_utilisateur_relation r, t_utilisateur u
    WHERE r.relation = 'ami'
    AND r.id_utilisateur_repondant = u.id_utilisateur
    UNION
    SELECT r.id_utilisateur_repondant id_utilisateur, r.id_utilisateur_demandeur id_utilisateur_ami, u.pseudonyme
    FROM t_utilisateur_relation r, t_utilisateur u
    WHERE r.relation = 'ami'
    AND r.id_utilisateur_demandeur = u.id_utilisateur;

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
  MODIFY `id_publication` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pour la table `t_utilisateur`
--
ALTER TABLE `t_utilisateur`
  MODIFY `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT COMMENT 'identifiant unique de l''utilisateur', AUTO_INCREMENT=27;

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
