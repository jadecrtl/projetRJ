USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_ajouter_ami;

DELIMITER #

CREATE PROCEDURE ps_ajouter_ami (IN p_pseudonyme_demandeur VARCHAR(40), IN p_pseudonyme_repondant VARCHAR(40))
BEGIN  

    DECLARE l_pouvoir_repondant ENUM("admin", "prive", "public");

    SET @l_pouvoir_repondant = (SELECT pouvoir FROM t_utilisateur WHERE pseudonyme = p_pseudonyme_repondant);

    IF (@l_pouvoir_repondant = "prive") THEN
        CALL ps_creer_demande_ami(p_pseudonyme_demandeur, p_pseudonyme_repondant);
    END IF;

    IF (@l_pouvoir_repondant = "public") THEN
        CALL ps_creer_abonnement(p_pseudonyme_demandeur, p_pseudonyme_repondant);
    END IF;

END#

DELIMITER ;