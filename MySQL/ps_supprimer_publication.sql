USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_supprimer_publication;

DELIMITER #

CREATE PROCEDURE ps_supprimer_publication (IN p_pseudonyme VARCHAR(40), IN p_id_publication INT)
BEGIN  

    DECLARE l_pouvoir ENUM("admin", "prive", "public");

    SET @l_pouvoir = (SELECT pouvoir FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    IF (@l_pouvoir = "prive" OR @l_pouvoir = "public") THEN
        CALL ps_supprimer_publication_prive_public(p_pseudonyme, p_id_publication);
    END IF;

    IF (@l_pouvoir = "admin") THEN
        CALL ps_censurer_publications_admin(p_pseudonyme, p_id_publication);
    END IF;

END#

DELIMITER ;