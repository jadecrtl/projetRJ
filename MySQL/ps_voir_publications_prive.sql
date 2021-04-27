USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_publications_prive

DELIMITER #

CREATE PROCEDURE ps_voir_publications_prive (IN p_pseudonyme VARCHAR(40), IN p_id_publication INT)

BEGIN
    DECLARE l_id_utilisateur INT;
    DECLARE l_id_publication INT;
    
    SELECT @l_id_utilisateur := id_utilisateur 
    FROM t_utilisateur 
    WHERE pseudonyme = p_pseudonyme
    AND relation = 'ami';
    

    SELECT @l_id_publication := id_publication
    FROM t_publication
    WHERE id_publication = p_id_publicationAND relation = 'ami';

    

END#

DELIMITER ;