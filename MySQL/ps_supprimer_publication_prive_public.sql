USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_supprimer_publication_prive_public;

DELIMITER #
CREATE PROCEDURE ps_supprimer_publication_prive_public(IN p_pseudonyme VARCHAR(40), IN p_id_publication INT)
BEGIN 
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

END#
DELIMITER ;