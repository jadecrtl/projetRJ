USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_publications_admin

DELIMITER #

CREATE PROCEDURE ps_voir_publications_admin (IN p_pseudonyme VARCHAR(40), IN p_id_publication INT, IN p_id_commentaire INT)
BEGIN
    DECLARE l_id_utilisateur INT;
    DECLARE l_id_publication INT;
    
    SELECT *
    FROM t_utilisateur;

    SELECT *
    FROM t_publication;

    SELECT *
    FROM t_commentaire;



END#

DELIMITER ;