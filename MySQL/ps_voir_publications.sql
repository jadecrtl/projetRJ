USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_publications;

DELIMITER #

CREATE PROCEDURE ps_voir_publications (IN p_pseudonyme VARCHAR(40))
BEGIN  

    DECLARE l_pouvoir ENUM("admin", "prive", "public");

    SET @l_pouvoir = (SELECT pouvoir FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    IF (@l_pouvoir = "prive" OR @l_pouvoir = "public") THEN
        CALL ps_voir_publications_prive_public(p_pseudonyme);
    END IF;

    IF (@l_pouvoir = "admin") THEN
        CALL ps_voir_publications_admin(p_pseudonyme);
    END IF;

END#

DELIMITER ;