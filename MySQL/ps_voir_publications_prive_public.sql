USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_publications_prive_public;

DELIMITER #

CREATE PROCEDURE ps_voir_publications_prive_public (IN p_pseudonyme VARCHAR(40))
BEGIN
    DECLARE l_id_utilisateur INT;
    
    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    SELECT u.pseudonyme, p.texte_publication, p.date_creation
    FROM t_publication p
    JOIN t_utilisateur u ON (p.id_utilisateur = u.id_utilisateur)
    WHERE p.id_utilisateur IN (SELECT id_utilisateur_ami FROM vue_amis WHERE id_utilisateur = @l_id_utilisateur)
    AND p.statut_publication = 'publiee'
    ORDER BY p.date_creation DESC;

END#

DELIMITER ;