USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_censurer_publication_admin;

DELIMITER #
CREATE PROCEDURE ps_censurer_publication_admin(IN p_pseudonyme VARCHAR(40), IN p_id_publication INT)
BEGIN 
    DECLARE l_id_utilisateur INT;
    DECLARE l_id_publication INT;

    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme AND (pouvoir = 'admin') );

    SET @l_id_publication = (SELECT id_publication FROM t_publication WHERE id_publication = p_id_publication AND statut_publication = 'publiee');

    IF (@l_id_utilisateur IS NOT NULL AND @l_id_publication IS NOT NULL) THEN    
    UPDATE t_publication
    SET statut_publication = 'censuree'
    AND id_publication = @l_id_publication;
    END IF;

END#
DELIMITER ;